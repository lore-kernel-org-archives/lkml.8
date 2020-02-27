Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F79C3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7D7246A2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXDz9qkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbgB0XF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:05:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40830 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730324AbgB0XFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:05:25 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so415401plp.7;
        Thu, 27 Feb 2020 15:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6ZPTBc16gsRgOtb4TnzocOZ8irwL4eMbyH66vQS/GYA=;
        b=kXDz9qkp6qs92/X6p/L9WmMF6gPd5XAV+dtAGFDrOEy9BrsrFN3gdjeWoMBAfSsN5g
         rFjD+rXGU//RVwilhjvoVKaVw54OFUEJb7vPoeVeogqSnFtpo14Mv2FwW/tr3Kc4QhiS
         qSA3dkK+gn0cpIFRXeBqpQ+o7QpUbDFF8LsPg0Soyp+KeL+A88eeyOQ/Ejc1KQX/7zqA
         mxmWOTjyjEO+LbGyQjJqZ13AZ6cP0bg9vT5qU4RS+eBHIeGoaFSyJefheYkfWA+GC9o7
         k4bFt2X8UIKF8YA1FVZW5L+qk+LtfbA3dYqMKbp4XCcQuVNolALVXTSvDZYsMcqmNNrt
         574Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6ZPTBc16gsRgOtb4TnzocOZ8irwL4eMbyH66vQS/GYA=;
        b=mPfzlkIGzy0DGqke2F6caKcNTRfT+8JzmS/sL31QcPLH2bTPcl9i9u+/MzaS7A+nJX
         Omwa6cuTUZF46D1I8VnulffqXiZfnaqGucVwIQ653rQjm7ouo2qZ5o4ulRLL4wFy5ZuK
         Xmlet9YvmHEbVNeSub6v1yfpSObi0TeHLT4G93denOrGIlCBbChFS+saFMaZQcJ2jXR8
         aEjkhaZeFAmewIMB4PBSSe1wvVI4415KPChHqjdUf/1Udszz3i+113U0V3xizt9+Zmdw
         hnmisy1TjlPsjbYqiuN1eu11uEUUG7dwPwEHa+/1Rk87G0J9DaUg5+lkBwCfBVrOzpXy
         oWDQ==
X-Gm-Message-State: APjAAAVc96UHsGJ5NhlkUpOYpmT8vLI8v+MmO4py5FLH4+2sQ+r9YOzR
        ZVv2p/Doy+LgjgPuypxg9GA=
X-Google-Smtp-Source: APXvYqwaQgE0kh+k6ox6GjNUfuX9eBxyJlL/7uMbDKwkNIQDzt5x2XGvHBsGHIJPgCu9HrHuIlE2Sw==
X-Received: by 2002:a17:90a:8b82:: with SMTP id z2mr1395149pjn.59.1582844724422;
        Thu, 27 Feb 2020 15:05:24 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:500::4:d8f5])
        by smtp.gmail.com with ESMTPSA id w2sm8275975pfw.43.2020.02.27.15.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 15:05:24 -0800 (PST)
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
Subject: [PATCH v5 5/7] ARM: dts: aspeed-g5: add vhub port and endpoint properties
Date:   Thu, 27 Feb 2020 15:05:05 -0800
Message-Id: <20200227230507.8682-6-rentao.bupt@gmail.com>
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

 arch/arm/boot/dts/aspeed-g5.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index ebec0fa8baa7..f12ec04d3cbc 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -195,6 +195,8 @@
 			reg = <0x1e6a0000 0x300>;
 			interrupts = <5>;
 			clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
+			aspeed,vhub-downstream-ports = <5>;
+			aspeed,vhub-generic-endpoints = <15>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb2ad_default>;
 			status = "disabled";
-- 
2.17.1

