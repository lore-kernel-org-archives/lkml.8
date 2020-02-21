Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB35C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CD9222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ZgvvblOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgBUQM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:12:59 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:5856 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727312AbgBUQMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:12:50 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LG82qH008254;
        Fri, 21 Feb 2020 17:12:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=j0cy0mKA7cM8Tk6Z9M9zdWvIoHNs4Pm0R3aUHtmCHIs=;
 b=ZgvvblOR1TTNkCPnTK2ZYbzpoTDZHAs2urCgIi4n8hxRJniMckK0ED6dE2lOD7KV8l4n
 8wwaz6xOY/BevZurX+Sgl5DFTzz10sykb3fo+M8S4BVG7g9xt8UjLVnD9JUxOAsP5I9u
 ci55Yi/HblFgrlKcOVXFnlAzNpoGlRmMxf7WQq//BcuAZf/Y/tOXfNdpo5wyL0G/0MI0
 CEIMny1ZVLzoM8frv5pkSKKSJHAqWc21kQNUph+55/pMKhBPVI7OAj9rPKsTD8/titVf
 PyINOjdDh+uqJ1mJu/oxAPd6RaRRxLtOC4aw0L3rVrme9NbtlH8FR5GVsu8G8bBb2Rqp Tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y8ub1r643-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 17:12:24 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A2B5310003A;
        Fri, 21 Feb 2020 17:12:22 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 968672BE24A;
        Fri, 21 Feb 2020 17:12:22 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 21 Feb 2020 17:12:21
 +0100
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        <david@gibson.dropbear.id.au>, <sjg@chromium.org>
CC:     <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-kernel@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
        <devicetree-compiler@vger.kernel.org>, Ian Lepore <ian@freebsd.org>
Subject: [RFC PATCH v2 4/4] script: make automatic dtb build info generation
Date:   Fri, 21 Feb 2020 17:12:17 +0100
Message-ID: <20200221161217.20069-5-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200221161217.20069-1-alexandre.torgue@st.com>
References: <20200221161217.20069-1-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_05:2020-02-21,2020-02-21 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Append each "xxx.dtb.dts.tmp" file with "build-info" entry during dtb
build. It allows to get build information (date, source version, ...)
for each device tree without modify them manually.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index a5af84ef4ffc..f084e78267b2 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -289,6 +289,7 @@ quiet_cmd_dtc = DTC     $@
 cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 	$(DTB_GEN_INFO) $(src) ; \
 	$(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
+	$(DTB_GEN_INFO) $(src) $(dtc-tmp) ; \
 	$(DTC) -O $(2) -o $@ -b 0 \
 		$(addprefix -i,$(dir $<) $(DTC_INCLUDE)) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
diff --git a/scripts/gen_dtb_build_info.sh b/scripts/gen_dtb_build_info.sh
index 0cd8bd98e410..72f31e386787 100755
--- a/scripts/gen_dtb_build_info.sh
+++ b/scripts/gen_dtb_build_info.sh
@@ -6,5 +6,7 @@ set -o nounset
 DTB_DIR=$1
 DTB_COMPILE_BY=$(whoami | sed 's/\\/\\\\/')
 DTB_INFO="From Linux $KERNELRELEASE by $DTB_COMPILE_BY the $(date).\0"
+DTS_FILE=$2
 
-printf "$DTB_INFO" > "$DTB_DIR/dtb-build.txt"
+printf "$DTB_INFO" > "arch/arm/boot/dts/dtb-build.txt"
+echo "&{/} {build-info = /incbin/(\"dtb-build.txt\");};" >> $DTS_FILE
-- 
2.17.1

