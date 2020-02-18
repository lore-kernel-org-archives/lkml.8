Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98570C34022
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 03:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6538A214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 03:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3oSrPHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgBRDNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 22:13:41 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35175 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgBRDNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 22:13:35 -0500
Received: by mail-pg1-f194.google.com with SMTP id v23so6823853pgk.2;
        Mon, 17 Feb 2020 19:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZFyQEdWxvwBxjLzrFGGVsFOAAPD8i2AvVgwQpt25K/U=;
        b=X3oSrPHwn3fmMokFFba0Psbe8GMZM/aNgleo0TXOkMdoeXtWOcmIUiaN48N9xLIRgN
         +/7TJndN0fzeZchT0RC+V9+oiVP9gQxJZaj8sB1/lY9Z7P/Uj9u6q/nH+saF+TlS1j1m
         4f1j9YqXpQMqpy5y1jtLa0Z9/NkHgGFCVacAgly/rkKjCfwxQttJhYIxLF6oNRZkGJbz
         anpuUKGGk6JhsH1q+WNWDfxlSheexwjId/xd214r1gc75NKJnPRlzKtu8BgqC7PkXz4b
         hQVv48DPxDYLBG4Hed5/t7aSZmawvUEF2PmbUPHWjoHl4q3WlcozknmU4M3PE6cS8kXJ
         tVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZFyQEdWxvwBxjLzrFGGVsFOAAPD8i2AvVgwQpt25K/U=;
        b=kgo465OKQHbWwlJUCeIKRHCCeKsUobjBbSsr16MSi9OKsL5xTG2lJ6FwHcKxWi+oCH
         MXijQIfXjhkp9Ok21oUkd2RKWeqzhtEbfYNOY9WsZ9eCIvO0W40pJgrZA9YB1J8+NRDf
         0m+iTzWoneCaGbcgY6sxB51WM+s1qt+PhyHIl9VpkPVDImaBT0Z3XnYJ6j5/wsmf1Q6Y
         Z9I+2auimBbHaVZ1h8SPuULXiaNnvPvdb6Fnv2UWTvUCbR0D5LXL1jsYNvAkzevPFkLA
         bnIsGNZD0NoZKujh/FrUDs2GWrDbKxwlxdSi4ObE3g1GvSU1LW3qoa4o/Cp7N53/PE3/
         FecQ==
X-Gm-Message-State: APjAAAXdsJnDQDY4OjHEqNDJAxzu0VlI4AxaIbJd98fxMf2SUvmv/4hT
        gm1aGnExzzL6q+pdOIVLtVY=
X-Google-Smtp-Source: APXvYqx5X191Us6wKiAbBYcJ+hEwCRwb0WAXLxgCTj5dGYTmWJiFy9sNG10WQKcON5Vp5efq+phbkQ==
X-Received: by 2002:a63:ae0a:: with SMTP id q10mr20715662pgf.178.1581995613715;
        Mon, 17 Feb 2020 19:13:33 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:180::6f94])
        by smtp.gmail.com with ESMTPSA id b18sm1812595pfd.63.2020.02.17.19.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 19:13:33 -0800 (PST)
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
Subject: [PATCH v3 5/5] ARM: dts: aspeed-g4: add vhub port and endpoint properties
Date:   Mon, 17 Feb 2020 19:13:15 -0800
Message-Id: <20200218031315.562-6-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200218031315.562-1-rentao.bupt@gmail.com>
References: <20200218031315.562-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add "aspeed,vhub-downstream-ports" and "aspeed,vhub-generic-endpoints"
properties to describe supported number of vhub ports and endpoints.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 No changes in v2/v3.
   - It's given v3 to align with the version of the patch series.

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

