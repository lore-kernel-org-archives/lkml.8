Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E63C4BA2D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCE524670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsV2z0nL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgBZXEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:04:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42421 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbgBZXEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:04:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id 15so123872pfo.9;
        Wed, 26 Feb 2020 15:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9+yo/IkGPp1qDak3+DSJKS9yrgwDO9MzyJ8Z/QdBbKU=;
        b=UsV2z0nLsIGEbKk+qJuR2AIBGe0jT686xaOz+Cdvr2brfJy3XufK6vafPNeTlqEdDl
         jQXw2AmzgODnhKY0gRDpSTptStvAi+JcsBoxZkWq5Cp5rvx2Cyw7811czn9lgPCXbPFr
         l+alMpaOh/okFgZ7gLwQv6l26KL/gowRdHaagnpBbBdHWLebr2mJeo5CBncYNgKg/YAw
         L1mFBx6WmF7goijaPGuUM3HEn4g2hGUT95JK1Szpov+Mq8r0xndMzl2W8rBpJV/R8D6U
         EYaC8FaSPglTWvv1uwucNOhFn/YiXahwfghkgOMgLRA8N/NfaixNngtZZGA6LFOVryUu
         BDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9+yo/IkGPp1qDak3+DSJKS9yrgwDO9MzyJ8Z/QdBbKU=;
        b=fwH6a5NiQFgXoymYRy7fHvQdWE3bEpAQi0Y5dw++A+uQc/nMKnlZ/pnkMXNFChngVc
         deLTHSSHo87J3G/tXDcCS7ifY0DY1rhC1iLpouZ+8EZZ21ay+SJ1m+08NARYOYranUAp
         E6s05+jHAPoGu5iP1Hg6u3wwpWtQHWbaRfGHUx4kxQDNmT2LoNPIg2KdEJYERJOVDw7w
         154wg+OO3/wp7bOPfD8XvY3ljwoF27HNcyiUaw6CE6iYdzXq7oGulcUMzUoH2rp48lIp
         HuFE6RreyBlX/gSYYQ813iap6jtsHNhWhDlL+GuqEjLNTDWAau2BpudRJjtIjDGeK4AU
         OvKA==
X-Gm-Message-State: APjAAAWZFqgaxCANGVAOnMrsDUvPP+U/qeCdN51o0igBkGmaMOTzZpF2
        KKoTHbHctUnaQjSYaWesFI4=
X-Google-Smtp-Source: APXvYqwtmuVHJUmsqUiAmU2eGpc2/nC9gueRZYlpT1/CdgW1IuN3362bQTc2e9PKgoTMIdnagaO9kw==
X-Received: by 2002:aa7:9aa5:: with SMTP id x5mr1028547pfi.131.1582758250273;
        Wed, 26 Feb 2020 15:04:10 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:500::7:5ebf])
        by smtp.gmail.com with ESMTPSA id 3sm3912621pjg.27.2020.02.26.15.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 15:04:09 -0800 (PST)
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
Subject: [PATCH v4 6/7] ARM: dts: aspeed-g4: add vhub port and endpoint properties
Date:   Wed, 26 Feb 2020 15:03:45 -0800
Message-Id: <20200226230346.672-7-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226230346.672-1-rentao.bupt@gmail.com>
References: <20200226230346.672-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add "aspeed,vhub-downstream-ports" and "aspeed,vhub-generic-endpoints"
properties to describe supported number of vhub ports and endpoints.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 No change in v2/v3/v4.
   - It's given v4 to align with the version of the patch series.

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

