Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BA6C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9484207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="eCNF0WOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgAMSQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 13:16:58 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36658 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728923AbgAMSQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:16:54 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DICWgJ031805;
        Mon, 13 Jan 2020 19:16:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=FqG6RRGJ2qKprjOk0E+7QuGlz/uGedPc3JymgcduaQ4=;
 b=eCNF0WOg9K4tDw9RTmicRxS5A+zMzFcTwmsTg39uB7uSO69KAzpbUDOQY9V2NWhWP5Ol
 SGYVwg1xbvb61jKy8H3etrl75FA4eB0J4A7BNXk2SEJIo6LeVv/2hUqoOkx1+rFlzlmU
 mdII2AFjLmKRAreYf0SMtHhqhMERibztr++oSjyIMsMFEe+UBWt9HMXw5AC8rP9uduHV
 T9LrMraYDU8dEtAKsAtaYJO+HEWX82zfvMvwYaVsZRxTlN/ID+ko4SWnrf8KbxOkIIKj
 yBL846byoTHXE1x8Y1KCQTUva8XCz3cQWr1CU7KkzTNpztUTTQ06blaHuQEyI7sIkjDs cQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xf77ashdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 19:16:39 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C402610003A;
        Mon, 13 Jan 2020 19:16:30 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B51772B774E;
        Mon, 13 Jan 2020 19:16:30 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 13 Jan 2020 19:16:30
 +0100
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        <david@gibson.dropbear.id.au>, <sjg@chromium.org>
CC:     <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-kernel@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
        <devicetree-compiler@vger.kernel.org>
Subject: [RFC PATCH 3/3] scripts: Use -B dtc option to generate dtb build information.
Date:   Mon, 13 Jan 2020 19:16:25 +0100
Message-ID: <20200113181625.3130-4-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200113181625.3130-1-alexandre.torgue@st.com>
References: <20200113181625.3130-1-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_06:2020-01-13,2020-01-13 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a new script to create a string in tmp file with
some information (date, linux version, user). This file is then used by
dtc with -B option to append dts file with a new property.
During kernel boot it will then be possible to printout DTB build
information (date, linux version used, user).

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3fa32f83b2d7..6a98eac1e56d 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -235,6 +235,7 @@ quiet_cmd_gzip = GZIP    $@
 # DTC
 # ---------------------------------------------------------------------------
 DTC ?= $(objtree)/scripts/dtc/dtc
+DTB_GEN_INFO ?= $(objtree)/scripts/gen_dtb_build_info
 
 # Disable noisy checks by default
 ifeq ($(findstring 1,$(KBUILD_EXTRA_WARN)),)
@@ -275,11 +276,13 @@ $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
 
 quiet_cmd_dtc = DTC     $@
 cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
-	$(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
-	$(DTC) -O $(2) -o $@ -b 0 \
+       $(DTB_GEN_INFO) $(@).info ;\
+       $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
+       $(DTC) -O $(2) -o $@ -b 0 -B $(@).info\
 		$(addprefix -i,$(dir $<) $(DTC_INCLUDE)) $(DTC_FLAGS) \
-		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
-	cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
+               -d $(depfile).dtc.tmp $(dtc-tmp) ; \
+       rm $(@).info ; \
+       cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
 
 $(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
 	$(call if_changed_dep,dtc,dtb)
diff --git a/scripts/gen_dtb_build_info b/scripts/gen_dtb_build_info
new file mode 100755
index 000000000000..30cf7506b9d5
--- /dev/null
+++ b/scripts/gen_dtb_build_info
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+DTB_TARGET=$@
+COMPILE_BY=$(whoami | sed 's/\\/\\\\/')
+
+touch $DTB_TARGET
+
+{
+  echo From Linux $KERNELRELEASE by $COMPILE_BY the $(date).
+} > $DTB_TARGET
-- 
2.17.1

