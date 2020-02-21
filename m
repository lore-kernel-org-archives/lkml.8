Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A4CC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775402073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="cor2Oqa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgBUQOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:14:43 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9660 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728690AbgBUQOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:14:41 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LGE84i009869;
        Fri, 21 Feb 2020 17:14:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=jpGwlIt47yPIpufPaalWQk8BJYpMwbVfmtKu9t8gwX0=;
 b=cor2Oqa4ltmaZl03XBXb8L+HZ9hrqUyyxN1KHuPJS8hGisZUrbVyUzRbofyTNWCPf7SI
 4qwhUCi95v1oK4M4REnYYpQ4SWaE7wMU0UE6gUyKr6fKEmaOjC3b4JRYfJkvTEDzFmLP
 9VwM/SvthDuQEv/U9U+rt46bK7CFBVUymM0BiivfCiE4YcEZZgPcj+OuadqEjop3rOvH
 GUkqnYS9cifBYZM3CLYMEvHkMfh5mrYZXKJmy3Gd7IEa2vMUirwdLP+fXS5GSQVAiufF
 jhYrvPIyK6YOieSCWapxGy0Vm2B/ICCNlYBGu65rnLCSRnZLvXo/eRbQcEqy5dEsit2y RQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y8ub0g6bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 17:14:27 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9E87F100039;
        Fri, 21 Feb 2020 17:14:22 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8FF052BE258;
        Fri, 21 Feb 2020 17:14:22 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 21 Feb 2020 17:14:21
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
Subject: [RFC PATCH v2 3/4] ARM: dts: stm32: Add dtb build information entry for stm32mp157c-dk2
Date:   Fri, 21 Feb 2020 17:14:17 +0100
Message-ID: <20200221161418.20225-4-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200221161418.20225-1-alexandre.torgue@st.com>
References: <20200221161418.20225-1-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_05:2020-02-21,2020-02-21 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtb-build.txt is a file containing device tree build information (date,
source version ...). This file is used to fill "build-info" entry which
will be displayed during kernel boot.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32mp157c-dk2.dts b/arch/arm/boot/dts/stm32mp157c-dk2.dts
index 7985b80967ca..387d3bcf5fa3 100644
--- a/arch/arm/boot/dts/stm32mp157c-dk2.dts
+++ b/arch/arm/boot/dts/stm32mp157c-dk2.dts
@@ -15,6 +15,7 @@
 / {
 	model = "STMicroelectronics STM32MP157C-DK2 Discovery Board";
 	compatible = "st,stm32mp157c-dk2", "st,stm32mp157";
+	build-info = /incbin/("dtb-build.txt");
 
 	aliases {
 		ethernet0 = &ethernet0;
-- 
2.17.1

