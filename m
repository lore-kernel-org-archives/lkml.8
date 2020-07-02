Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C528C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0933C206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yILqCy1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbgGBPWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:22:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44850 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbgGBPWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:22:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062EwIfN146378;
        Thu, 2 Jul 2020 15:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=p1Z6YpvljZOEZ8dzTHbfnoDePnMd1KUV8Z1/BDsptOw=;
 b=yILqCy1zspUk7DgilbfkrCOnEcc1Od8LfzYD4jSj264E32YKA9N6CmtoqeaSzRl0U8gY
 uBil/g4xCTLZ2bCkUxSixRaTqWa+hpCgwgfcurVHZyCtuXfTH2LtdqFWKOxOX5yRZAHn
 t0F5bwJXx8MedZiJif2O/7ISkbH2QGe7SGDEVrA+yspTMPbiuRtYsBCx2FnK/9HCmzs+
 z29kQozSc5Qm0LqnIzn3qxenALryPCwcXZF7htjyACFHkAtCyuv3fd6toUcvc7iXW/dr
 wXX2rRp2XjkCQxPh5wkLagrgPuCaQneX76/kRNLwJNHJbs5NJmTypQN/DjKrSy/SRF/m +A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31wxrnh2h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 02 Jul 2020 15:21:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062EwoHa090066;
        Thu, 2 Jul 2020 15:21:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 31xg19j707-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jul 2020 15:21:45 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 062FLiDd001594;
        Thu, 2 Jul 2020 15:21:44 GMT
Received: from mihai.localdomain (/10.153.73.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jul 2020 15:20:52 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH RFC 2/7] x86: cpu: modify boot_command_line to saved_command_line
Date:   Thu,  2 Jul 2020 18:18:22 +0300
Message-Id: <1593703107-8852-3-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1593703107-8852-1-git-send-email-mihai.carabas@oracle.com>
References: <1593703107-8852-1-git-send-email-mihai.carabas@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=1 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007020106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=1 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007020106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

as boot_command_line has the __initdata attribute and cannot be
used after booting the kernel. command_line evaluation needs to
be used on microcode late loading in order to enforce the proper
mitigations for different CPU bugs.

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 arch/x86/kernel/cpu/bugs.c | 11 ++++++-----
 arch/x86/kernel/cpu/tsx.c  |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 7091947..1760598 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -684,7 +684,7 @@ static void spec_v2_user_print_cond(const char *reason, bool secure)
 		break;
 	}
 
-	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
+	ret = cmdline_find_option(saved_command_line, "spectre_v2_user",
 				  arg, sizeof(arg));
 	if (ret < 0)
 		return SPECTRE_V2_USER_CMD_AUTO;
@@ -822,11 +822,12 @@ static enum spectre_v2_mitigation_cmd spectre_v2_parse_cmdline(void)
 	char arg[20];
 	int ret, i;
 
-	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2") ||
+	if (cmdline_find_option_bool(saved_command_line, "nospectre_v2") ||
 	    cpu_mitigations_off())
 		return SPECTRE_V2_CMD_NONE;
 
-	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
+	ret = cmdline_find_option(saved_command_line, "spectre_v2", arg,
+	    sizeof(arg));
 	if (ret < 0)
 		return SPECTRE_V2_CMD_AUTO;
 
@@ -1096,11 +1097,11 @@ static enum ssb_mitigation_cmd ssb_parse_cmdline(void)
 	char arg[20];
 	int ret, i;
 
-	if (cmdline_find_option_bool(boot_command_line, "nospec_store_bypass_disable") ||
+	if (cmdline_find_option_bool(saved_command_line, "nospec_store_bypass_disable") ||
 	    cpu_mitigations_off()) {
 		return SPEC_STORE_BYPASS_CMD_NONE;
 	} else {
-		ret = cmdline_find_option(boot_command_line, "spec_store_bypass_disable",
+		ret = cmdline_find_option(saved_command_line, "spec_store_bypass_disable",
 					  arg, sizeof(arg));
 		if (ret < 0)
 			return SPEC_STORE_BYPASS_CMD_AUTO;
diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index 7c46581..436fa93 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -92,7 +92,7 @@ void tsx_init(void)
 	if (!tsx_ctrl_is_supported())
 		return;
 
-	ret = cmdline_find_option(boot_command_line, "tsx", arg, sizeof(arg));
+	ret = cmdline_find_option(saved_command_line, "tsx", arg, sizeof(arg));
 	if (ret >= 0) {
 		if (!strcmp(arg, "on")) {
 			tsx_ctrl_state = TSX_CTRL_ENABLE;
-- 
1.8.3.1

