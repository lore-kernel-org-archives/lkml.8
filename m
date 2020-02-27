Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE43EC3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F5F24699
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QutkKvm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgB0XFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:05:30 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37212 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730333AbgB0XF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:05:27 -0500
Received: by mail-pj1-f68.google.com with SMTP id m13so431679pjb.2;
        Thu, 27 Feb 2020 15:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VMrpm+GBoFpUrGbFK1mApjxlqzffVTj/tMTENO9WLbo=;
        b=QutkKvm5robSH6hAa5Xt7Hj7Zcy6P3FiZ8FYe/QIWDo9zihshyynnmsHT6Ca9ZjOeU
         tfEh1iXGgwjmh4B6z5ThkuglNDNVJ0wI9KIq3xBN+7khYZeNQEYc5Jrd4PYyRkVI7cWM
         ZhOJsUe+OPCchh4fSbR4W34FjpAjhLi2zLyDHSIj3CxkGIcVyndH5XaGZmd2zPUZ1Vwo
         StJ2lR1GEtrJPUVx4q5L02E7Zf2s+/r2bIh+TbVi5Ca9jd+bxX/xWPxQJy2pHMaLdzxv
         DySMOwi3yIoDNH/PexCONhd6epK6+wuuve6KfXhJ/oHdEEyM7O8Oi45laz/JXO19Nh1J
         Jfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VMrpm+GBoFpUrGbFK1mApjxlqzffVTj/tMTENO9WLbo=;
        b=bsuVQiV3p//OSbAfLjFnn/kBMleodDREd3xcMe0furqlaZOUo7koKfNpX3azyrSYHu
         LEsH979ybEJkXrWLIg0hjtC8XWOinJYH2aH2Djql0huS7ertccs+Ec/0JEUjI4CaHVmh
         FIR2s+YLja1QKGd/c40ChzN22GSbBKgJ2w5/LxQAEak0aYwgxQSk7eZdVOvYdlL6vhay
         y+7KoxIuTldpLO9M3YRWN7PxbUqPTn3r+IVajRQr/CXpNEvRjuf3VGe0NkTADdhK0qRX
         zDNEcE7Z9vmGf1xOiJRG8YoeUnARRQo4wsnCUwnUL7qUSTzT04t5GkMjybOScAWP94oO
         Zs3Q==
X-Gm-Message-State: APjAAAWY0Q++AagcJjlV4cOUt4Tl9DeKokxcdzvVDHLXwOf77TxF9XXs
        GNBSHUqhcIP7uuN7EVggaUA=
X-Google-Smtp-Source: APXvYqwgWS/gVih7kVY03mopBRkpenOgLxxgiUgs0jIPy2qu7PEK3PIFGXT2xwolufGS4P55SEUsgA==
X-Received: by 2002:a17:90a:5d18:: with SMTP id s24mr1244304pji.141.1582844725992;
        Thu, 27 Feb 2020 15:05:25 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:500::4:d8f5])
        by smtp.gmail.com with ESMTPSA id w2sm8275975pfw.43.2020.02.27.15.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 15:05:25 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v5 6/7] ARM: dts: aspeed-g4: add vhub port and endpoint properties
Date:   Thu, 27 Feb 2020 15:05:06 -0800
Message-Id: <20200227230507.8682-7-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200227230507.8682-1-rentao.bupt@gmail.com>
References: <20200227230507.8682-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add "aspeed,vhub-downstream-ports" and "aspeed,vhub-generic-endpoints"
properties to describe supported number of vhub ports and endpoints.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 No change in v2/v3/v4/v5.
   - It's given v5 to align with the version of the patch series.

 arch/arm/boot/dts/aspeed-g4.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 807a0fc20670..8e04303e8514 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -164,6 +164,8 @@
 			reg = <0x1e6a0000 0x300>;
 			interrupts = <5>;
 			clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
+			aspeed,vhub-downstream-ports = <5>;
+			aspeed,vhub-generic-endpoints = <15>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb2d_default>;
 			status = "disabled";
-- 
2.17.1

