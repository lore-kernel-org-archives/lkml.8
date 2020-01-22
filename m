Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B91CC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA132467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686433;
	bh=NN3XaH1oGHRZjvkiDqVdyrqgwihZbowjQ5VmMe5uonE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AreJCga3bqHJ/myX2bKmDwoQY5pkNRHv5xw7Z5dihNObp9OVKU2b3pNgmy0wzcM2f
	 Do3oc1OFGRwKlj0t8nBQL6nUSujqAKh/vQ6djH+D5FEwEQG81DIVpegkw5/kSGKMKh
	 BAIyHwloTzE7KgC+/fqUcSoe+ZEFteQA/K9L4IIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733220AbgAVJmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:42:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387713AbgAVJm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:42:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FDE624684;
        Wed, 22 Jan 2020 09:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686145;
        bh=NN3XaH1oGHRZjvkiDqVdyrqgwihZbowjQ5VmMe5uonE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qkx3GdpQh5tGZbvpLsyE5yDCjbh+VENAO3oM5/Iw7Kx2DeO+dULTcjnh2jSIIUv1F
         lCjeXkYbb6oPZq5mYBrYA4UXAvQIy5nRCQIhWDVnmkfqpeQCBDVFTwtpNe0bJMxb8z
         mwhL3OI223cQne5FRI2evNKbp/Ka2InVXwOVkuJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Mavrodiev <stefan@olimex.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH 4.19 026/103] arm64: dts: allwinner: a64: olinuxino: Fix SDIO supply regulator
Date:   Wed, 22 Jan 2020 10:28:42 +0100
Message-Id: <20200122092807.742932532@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
References: <20200122092803.587683021@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Mavrodiev <stefan@olimex.com>

commit 3d615c2fc2d111b51d2e20516b920138d4ae29a2 upstream.

A64-OLinuXino uses DCDC1 (VCC-IO) for MMC1 supply. In commit 916b68cfe4b5
("arm64: dts: a64-olinuxino: Enable RTL8723BS WiFi") ALDO2 is set, which is
VCC-PL. Since DCDC1 is always present, the boards are working without a
problem.

This patch sets the correct regulator.

Fixes: 916b68cfe4b5 ("arm64: dts: a64-olinuxino: Enable RTL8723BS WiFi")
Cc: stable@vger.kernel.org # v4.16+
Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -77,7 +77,7 @@
 &mmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
-	vmmc-supply = <&reg_aldo2>;
+	vmmc-supply = <&reg_dcdc1>;
 	vqmmc-supply = <&reg_dldo4>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;


