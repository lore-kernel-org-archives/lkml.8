Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D70C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF87120657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="NoaDH0jJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387941AbgERSZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731425AbgERSZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:25:21 -0400
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CDCC061A0C;
        Mon, 18 May 2020 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
         s=the; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:
        Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=jJIjBXlG7IUX19DcU/q8Cx0YzyqRNE0zmnPm1XRvWis=; b=NoaDH0jJOxZtDH2Lc2tVLtZBoU
        4g2DpdUFXRRiZNgfYcB3J/CDjStsP7Z6dk3oHi0DBa+r2Go8o/aBONUjT7Y1V8/2brOe8krLRQ8ig
        fMz7QeCm0aPRpPAnRKgFqLAHoxlW4oVsR4/WPvS4cmxAXmTEvDkrqNYIlNRQrDqinHp2IwawAuDQx
        fMOwwqCv9srkN2+kHuP44sFY5FwSfoYEwtkwm88+UZ4oyRKRQRRqCHFo5niukz3LY7UlO5XGu29xW
        /SsMv6YH25xpoeG5Vkvdhl4mHOVuiv0muHTnz4J0pnYazJXup59eo16t097JJUUF2HTXs2Z+z2Jqd
        HNhdM8KQ==;
Received: from [2001:4d48:ad59:1409:4::2] (helo=youmian.o362.us)
        by the.earth.li with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noodles@earth.li>)
        id 1jakCR-0008IU-A6; Mon, 18 May 2020 19:09:15 +0100
Date:   Mon, 18 May 2020 19:09:10 +0100
From:   Jonathan McDowell <noodles@earth.li>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add initial support for MikroTik RB3011
Message-ID: <cover.1589824955.git.noodles@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches do some prep (device tree vendor addition, missing ethernet
definitions for IPQ8064 dts) and then add an initial device tree for the
MikroTik RB3011 1U router, which is an IPQ8064 device with 1G RAM. They
are sufficient to boot with an initrd, the serial console and the first
5 switch ports fully functional (the second bank of 5 require some extra
patches to the QCA8K driver which will follow later). The bootloader NOR
is also supported, but the 128MB NAND is not yet enabled.

Jonathan McDowell (3):
  dt-bindings: vendor-prefixes: Add MikroTik
  ARM: dts: qcom: add ethernet definitions to ipq8064
  ARM: dts: qcom: Add MikroTik RB3011

 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/qcom-ipq8064-rb3011.dts     | 308 ++++++++++++++++++
 arch/arm/boot/dts/qcom-ipq8064.dtsi           | 108 ++++++
 4 files changed, 419 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq8064-rb3011.dts

-- 
2.20.1

