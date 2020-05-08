Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB511C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88403214D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EkLLPV6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgEHWJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 18:09:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43194 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgEHWJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 18:09:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 048M3qiu161659;
        Fri, 8 May 2020 22:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=kRJKGgXEcBvkOnkZ00J/8oVZj7ZZskCjtSJZuvcjbbk=;
 b=EkLLPV6+6vDj7ywobWZNfkVpk42vo4sS6Wavr2iWASmCYK+NZexIWqJKpxtkhn63wQtc
 wg7wFDZVVRob2exoB5k+88R3KfzYN92b2An084ssEc7X+glnExqPHU36Czrwp6ErPhnG
 1kBnoJxXMoujtsoNJJGWGf89MgM8QihpfoSBJGWtZ+MzxfZTjRgn2yhP9/4EpbbAGfEV
 hGmeHbj5qaDkwFUH35qkoJD5I9IAz1FzgOrSmuK+4BnrT+y3blK7GcPryYxbQ72tTY8X
 +Q0qMMUAM5J5B7lWZs9C3YOfWClf705gbobq0U85IyCEy8JrbkDDr0PSS9lD+Tq59lv/ 7A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30vtewwe50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 22:09:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 048M5xSe011008;
        Fri, 8 May 2020 22:07:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30vte193h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 22:07:16 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 048M76d6019813;
        Fri, 8 May 2020 22:07:06 GMT
Received: from ovs104.us.oracle.com (/10.149.224.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 May 2020 15:07:06 -0700
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, sstabellini@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH] xen/cpuhotplug: Fix initial CPU offlining for PV(H) guests
Date:   Fri,  8 May 2020 18:28:43 -0400
Message-Id: <1588976923-3667-1-git-send-email-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9615 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080187
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9615 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005080187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a926f81d2f6c ("xen/cpuhotplug: Replace cpu_up/down() with
device_online/offline()") replaced cpu_down() with device_offline()
call which requires that the CPU has been registered before. This
registration, however, happens later from topology_init() which
is called as subsys_initcall(). setup_vcpu_hotplug_event(), on the
other hand, is invoked earlier, during arch_initcall().

As result, booting a PV(H) guest with vcpus < maxvcpus causes a crash.

Move setup_vcpu_hotplug_event() (and therefore setup_cpu_watcher()) to
late_initcall(). In addition, instead of performing all offlining steps
in setup_cpu_watcher() simply call disable_hotplug_cpu().

Fixes: a926f81d2f6c (xen/cpuhotplug: Replace cpu_up/down() with device_online/offline()"
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/xen/cpu_hotplug.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/cpu_hotplug.c b/drivers/xen/cpu_hotplug.c
index ec975de..b96b11e 100644
--- a/drivers/xen/cpu_hotplug.c
+++ b/drivers/xen/cpu_hotplug.c
@@ -93,10 +93,8 @@ static int setup_cpu_watcher(struct notifier_block *notifier,
 	(void)register_xenbus_watch(&cpu_watch);
 
 	for_each_possible_cpu(cpu) {
-		if (vcpu_online(cpu) == 0) {
-			device_offline(get_cpu_device(cpu));
-			set_cpu_present(cpu, false);
-		}
+		if (vcpu_online(cpu) == 0)
+			disable_hotplug_cpu(cpu);
 	}
 
 	return NOTIFY_DONE;
@@ -119,5 +117,5 @@ static int __init setup_vcpu_hotplug_event(void)
 	return 0;
 }
 
-arch_initcall(setup_vcpu_hotplug_event);
+late_initcall(setup_vcpu_hotplug_event);
 
-- 
1.8.3.1

