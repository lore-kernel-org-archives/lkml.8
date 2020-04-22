Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F30DC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E616420656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551721;
	bh=VyOZnvDN6v7p/4EWitshi6AaubiDqI05pzbnVO4r8mA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bWzF6xKNSwt76pEVaemvz4jRu3m0v5dgJxSwf9WAWKUHUJJMjsEs30Wqu+fNAQrCO
	 yb9LbrKZQKgjEkHpfZrRi4ZZsNMl//QFWxdA1PERgPhh/CHLy+Bm49uz8TYMxKKpLS
	 tv/OsVBK8pRGBv3tUI6k188dtT12vb46kggHd5eA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbgDVKfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730355AbgDVKXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:23:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBD482076B;
        Wed, 22 Apr 2020 10:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551017;
        bh=VyOZnvDN6v7p/4EWitshi6AaubiDqI05pzbnVO4r8mA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UltxrXb/Si+Mf9aSmJubONQvwQgstDGrO/Lpn4Qj+rh2VnpDbJfNHCKs3tOT2mqNZ
         bEKqJYNo80XljeWpci718vHnRR/Gh/3PFRODiFQCIOXlFxQ8h9YFq557gCGHZURKpm
         kSVM8+N5V7SUut18ioTz9tjgUkLaInrQgGVR1G1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 065/166] arm64: dts: marvell: espressobin: add ethernet alias
Date:   Wed, 22 Apr 2020 11:56:32 +0200
Message-Id: <20200422095055.844059869@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Maciej Nowak <tmn505@gmail.com>

[ Upstream commit 5253cb8c00a6f4356760efb38bca0e0393aa06de ]

The maker of this board and its variants, stores MAC address in U-Boot
environment. Add alias for bootloader to recognise, to which ethernet
node inject the factory MAC address.

Signed-off-by: Tomasz Maciej Nowak <tmn505@gmail.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index 53b8ac55a7f3d..e5262dab28f58 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -13,6 +13,12 @@
 #include "armada-372x.dtsi"
 
 / {
+	aliases {
+		ethernet0 = &eth0;
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
-- 
2.20.1



