Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DC5C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5B932080C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0cDyc8RC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgD0IIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:08:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41568 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgD0IIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:08:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03R84Var053345;
        Mon, 27 Apr 2020 08:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=eibm6tEh7qd61BAbNPr7TVs9dtNk45qBSvc+9ZYcnrg=;
 b=0cDyc8RCrY+Xh0V5/+0HR0gl2kgt35MyhXoDVLelHmqSYFTjPB74kiK7WdNrhaI6noD4
 C9sWMbG6CtUrCHknscHj7pzgbHLBishf2UwKWiFiXIMiiSrGNk14o9PLBE8bFd9Hq+lr
 xnsiDhZ4MXkI4wUqAcOGToWNwWSvD94mp5Xq/M43dabjdp50q8oGhVoSgGhQ4r7KfLwn
 /Z9hXm6ckY4boYS2hWL0aAqE3qOdxPjutqqoJ5aiNMNNy3bWOMdlty7/aUXgEoaqiAAk
 CrvuTu+UWuJLfj2fk+tasnJLcXlJx3tSV/CIgoayJ4lu9qTu60nALRW+z6HNXgthSjTv tQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30nucer2fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 08:08:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03R871d7172240;
        Mon, 27 Apr 2020 08:08:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30my08nbpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 08:08:27 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03R88J2H016894;
        Mon, 27 Apr 2020 08:08:19 GMT
Received: from mihai.localdomain (/10.153.73.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Apr 2020 01:08:19 -0700
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mihai Carabas <mihai.carabas@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH RFC 1/3] x86: microcode: intel: read microcode metadata file
Date:   Mon, 27 Apr 2020 10:27:57 +0300
Message-Id: <1587972479-10971-2-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1587972479-10971-1-git-send-email-mihai.carabas@oracle.com>
References: <1587972479-10971-1-git-send-email-mihai.carabas@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9603 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=1 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004270072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9603 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 suspectscore=1
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004270071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to read the microcode metadata file in order to see what features
are added or remove by the new microcode blob. If the metadata file
does not exists passthrough normal loading with a warning message.

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 6a99535..a54d5e6 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -970,10 +970,12 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
 					     bool refresh_fw)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
+	const struct firmware *meta_firmware;
 	const struct firmware *firmware;
 	struct iov_iter iter;
 	enum ucode_state ret;
 	struct kvec kvec;
+	char meta_name[40];
 	char name[30];
 
 	if (is_blacklisted(cpu))
@@ -982,11 +984,21 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
 	sprintf(name, "intel-ucode/%02x-%02x-%02x",
 		c->x86, c->x86_model, c->x86_stepping);
 
+	sprintf(meta_name, "intel-ucode/%02x-%02x-%02x.metadata",
+		c->x86, c->x86_model, c->x86_stepping);
+
 	if (request_firmware_direct(&firmware, name, device)) {
 		pr_debug("data file %s load failed\n", name);
 		return UCODE_NFOUND;
 	}
 
+	if (request_firmware_direct(&meta_firmware, meta_name, device)) {
+		pr_debug("metadata file %s load failed\n", name);
+		pr_debug("no feature check will be done pre-loading the microcode\n");
+	} else {
+		release_firmware(meta_firmware);
+	}
+
 	kvec.iov_base = (void *)firmware->data;
 	kvec.iov_len = firmware->size;
 	iov_iter_kvec(&iter, WRITE, &kvec, 1, firmware->size);
-- 
1.8.3.1

