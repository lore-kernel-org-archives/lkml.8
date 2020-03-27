Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B581C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D922E2071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgC0Ghf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 02:37:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23780 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727781AbgC0Ghe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 02:37:34 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02R6XZCD011132
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 02:37:33 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywdr9c3a2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 02:37:33 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kjain@linux.ibm.com>;
        Fri, 27 Mar 2020 06:37:30 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Mar 2020 06:37:24 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02R6bNrZ61800508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 06:37:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCF6652054;
        Fri, 27 Mar 2020 06:37:23 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.85.82])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EEF855204F;
        Fri, 27 Mar 2020 06:37:17 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de, kjain@linux.ibm.com
Subject: [PATCH v7 4/5] Documentation/ABI: Add ABI documentation for chips and sockets
Date:   Fri, 27 Mar 2020 12:06:41 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200327063642.26175-1-kjain@linux.ibm.com>
References: <20200327063642.26175-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20032706-0028-0000-0000-000003ECA6DE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032706-0029-0000-0000-000024B21DC5
Message-Id: <20200327063642.26175-5-kjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-26_14:2020-03-26,2020-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 malwarescore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxlogscore=600 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the following sysfs files:
/sys/devices/hv_24x7/interface/chips,
/sys/devices/hv_24x7/interface/sockets

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 .../testing/sysfs-bus-event_source-devices-hv_24x7 | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7 b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
index ec27c6c9e737..e17e5b444a1c 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
@@ -22,6 +22,20 @@ Description:
 		Exposes the "version" field of the 24x7 catalog. This is also
 		extractable from the provided binary "catalog" sysfs entry.
 
+What:		/sys/devices/hv_24x7/interface/sockets
+Date:		March 2020
+Contact:	Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
+Description:	read only
+		This sysfs interface exposes the number of sockets present in the
+		system.
+
+What:		/sys/devices/hv_24x7/interface/chips
+Date:		March 2020
+Contact:	Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
+Description:	read only
+		This sysfs interface exposes the number of chips per socket
+		present in the system.
+
 What:		/sys/bus/event_source/devices/hv_24x7/event_descs/<event-name>
 Date:		February 2014
 Contact:	Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
-- 
2.18.1

