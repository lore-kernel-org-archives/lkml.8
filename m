Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3B3C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E4B2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAYDCY7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgCCGX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 01:23:58 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39216 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbgCCGX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:23:56 -0500
Received: by mail-pj1-f68.google.com with SMTP id o5so863676pjs.4;
        Mon, 02 Mar 2020 22:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TI3Z8YY503FP0KWJnGcP8fCbF2AkQr8pkKXqhxZsBmc=;
        b=EAYDCY7S4bhB2WRC9nvVwFPyK5XgymtItdht/AXBXjWl4G4vRkAEs0a89EbW9UXGJK
         4AMHFHAVVrfXI6FGDnx3vHen7TN5/Bm2Nb0g3b3G83Dm5Yba+V9doMYTV2kSoU0LcqSV
         xcX2Os7LGLf/Um4io/wG7mTQVJVlazLWmGGyJIw5Yyk/N5LrLZ7QB1B4VGhb4lViumw3
         UZa0wiEtq3EuGyFUBCQ6rsGYCpdkivrV2VtUz+Uxkh47VVeKg7EwReRulojx6iBgrnb3
         pSrVqaGSdo5F0T7KirZrS113pbsX+uxXRBVqy0ZVgnqvKvY5B9RDlEJjcdfYJ2x7axJ0
         /2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TI3Z8YY503FP0KWJnGcP8fCbF2AkQr8pkKXqhxZsBmc=;
        b=IugeofG7XvzOj4U5OR81SQHwruPS7XRAj9e7YaT2qhZKMy4aAs0ArbohewL9n7EbIe
         RjJ122SQCGoZu4fOCYloq9ScWPkTErXgzJRXsrGDJVq+AzVCOXEVPN20Qc6tRmcAto/w
         9JTQxjKYMt896g2QhSEQCODI3Tv6adLH/N/Rvv0JM5QnWeuLZWxoNSHdOlYMY/PXIxN6
         TcEu0o5OgIHgfDjG3N4W/dGNf01TIVmEinA1WZdokanN6QqPE+YkQPlHvK3xheteYITc
         NLhxgY/a6Z5F1mgaQPFuMRQUdPLk2QnIdXPUzIHUvGcpaCPKo5vyDGMuwa3kjiPIemMU
         JQlQ==
X-Gm-Message-State: ANhLgQ1NizDGAeA1CgwHfD7Zuzxe4j+EdE1/0jPQLoojdfeYV+l6QloT
        fC5+SU071TcO8Eodr39n7XQ=
X-Google-Smtp-Source: ADFU+vt9tRuqC9HtMQlJWQEOzdX43o3XQH7276qTwTP1ViurSta8NASB80y6m5uKUP303TtRaWHTww==
X-Received: by 2002:a17:90a:f009:: with SMTP id bt9mr2411146pjb.150.1583216634072;
        Mon, 02 Mar 2020 22:23:54 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-24-4-25-55.hsd1.ca.comcast.net. [24.4.25.55])
        by smtp.gmail.com with ESMTPSA id k5sm7453526pfp.66.2020.03.02.22.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 22:23:53 -0800 (PST)
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
Subject: [PATCH v7 6/7] ARM: dts: aspeed-g4: add vhub port and endpoint properties
Date:   Mon,  2 Mar 2020 22:23:35 -0800
Message-Id: <20200303062336.7361-7-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303062336.7361-1-rentao.bupt@gmail.com>
References: <20200303062336.7361-1-rentao.bupt@gmail.com>
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
 No change in v2/v3/v4/v5/v6/v7.
   - It's given v7 to align with the version of the patch series.

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

