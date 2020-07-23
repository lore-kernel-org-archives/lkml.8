Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF453C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFEF420714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="L1DK8nWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgGWQZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:25:17 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:50440 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgGWQZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595521516; x=1627057516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=No7CI6pZaYc/VN/VbA4B7W3JcVHomQRk3i46YyNuSLI=;
  b=L1DK8nWKWnekSEGNxTdpmXij2zGFqujtDNs89swSupfRuPAhgm3RHiqj
   SFaxlwysIB8hN77fH0hh11kgBXEKo2UkkbSGpbv/qPaB7EZc5Ja+Z+Eu0
   /z6XN2pTOzlcQg0Wi2SFZCE5aOhot7As+DPet6F2954LdwY6zZxQhVbmm
   7KFq13FAUIr1OoPDUVi4nAOZtD94SJUv3/NxyJS3tGKlhPXa6StUBdufs
   b2altK7iDA3Y2LTPrO5PAR8bJOaFzzvs/O708DY1gdJp6EPxafadJLNOt
   KX8BVxceYqN677S+n6REZKNcv1WDtSyZY8FcHWq6W78xcZtfWgDbOYVkO
   Q==;
IronPort-SDR: Jmxlj7H6QquT5HS+ujnJk6HRY79Z/+f2seawOShA4oc3nsFZByH55fxbaZky3F2dm2BzGiK04k
 nOR5QeU2X2P53H/Hsbx9dDTRyxbBNtdbGG/Dun6DcVvSiJuwX1R/qg/dRcftVcviFsNGAWbW0S
 NQssW5P57/jZ9azPGLiFcMV2RqyDK85FEx/iDsvLn9xRj7a/jQy9QTB2N9UIk2TW7vBMxAhYGY
 9gUx/8qKXZKVSfedPtjLLKfRt6JcgTkKd+Yo49zkCsN1kUcZmdfyONGhXxzAZ+G6h/XOoYaeDB
 iC4=
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="83016658"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jul 2020 09:25:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 09:25:16 -0700
Received: from rob-ult-m19940.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 23 Jul 2020 09:25:12 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <cristian.birsan@microchip.com>,
        <nicolas.ferre@microchip.com>, <arnd@arndb.de>,
        <ludovic.desroches@microchip.com>,
        Razvan Stefanescu <razvan.stefanescu@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 2/3] ARM: configs: at91: sama5: enable bridge and VLAN filtering
Date:   Thu, 23 Jul 2020 19:24:33 +0300
Message-ID: <20200723162434.1983643-2-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723162434.1983643-1-codrin.ciubotariu@microchip.com>
References: <20200723162434.1983643-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Razvan Stefanescu <razvan.stefanescu@microchip.com>

These modules are needed to configure bridges in Linux, to take full
advantage of the KSZ switch capabilities.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/configs/sama5_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 123b95c1447a..f4d71ffcb6e9 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -49,7 +49,10 @@ CONFIG_IP_PNP_RARP=y
 # CONFIG_INET6_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET6_XFRM_MODE_BEET is not set
 CONFIG_IPV6_SIT_6RD=y
+CONFIG_BRIDGE=m
+CONFIG_BRIDGE_VLAN_FILTERING=y
 CONFIG_NET_DSA=m
+CONFIG_VLAN_8021Q=m
 CONFIG_CAN=y
 CONFIG_CAN_AT91=y
 CONFIG_CAN_M_CAN=y
-- 
2.25.1

