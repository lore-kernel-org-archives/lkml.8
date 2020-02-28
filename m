Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1F9C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E510A246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsXX5/OH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbgB1CIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 21:08:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33163 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730725AbgB1CIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 21:08:19 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so678809pgk.0;
        Thu, 27 Feb 2020 18:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KBdWDv5pYXspLR13NXBmBo0uH7q/9EYA/+sUUf6ZaRY=;
        b=SsXX5/OHRxtFZBMPk+LSluP8pZ7Y9dSJwSdFjdsQ80SwwOz3PxCnoxWVzleXsMoGxF
         gSI7TSegZgM1u3WdoU7qoJeuZfa3E2knlnq3WrQe9htu5pDCLsE1ehOgr49Y3HjHam/l
         WyOuABtyMjV7r3eKfkmamImeNnouIYocfrHMLmHbVcArYjEb7sXXfUPPH5TiKmYt/A3l
         tbSYDZ35yVJHYn2ywo2Ijzwe9w8I0uA7idDbvMiaZGhcK5ZRL/Mu5LCXxd0ubjKiMFqW
         mPu6b9SHKUnGOw2zymloTzshoKxgIqB9whnDUBoII0T59anuNb6UZmQ9W52UkGDBtJz0
         7foQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KBdWDv5pYXspLR13NXBmBo0uH7q/9EYA/+sUUf6ZaRY=;
        b=WTK4Iogaot3jBJ0boO/C6906gIHt8p+oczjX72CrRjA2jZAdaax94wWA8h61JBbFdy
         7LiZXwN9kfDG1rwhKZ4uyNlLRsvKyt965UesYx+pFfY6pxbJlgnvvEp5ljC7fDwLtqLG
         BXe/qgw9MPJ2UpGsYHiQKT16PvJYKksU0SxwdEn8JjT6yN6TfuUra89h6iKRx+YMG8hW
         wiWrvGcmgvcVP2EZgzN1dnTWy7Lghzyp9UswCGwYSU+xnvnX+wzsi/ABuzA6R6jRiSil
         MK/zaqM4oioE6cU4t8/qdO+Zl2yIlNSKJUjav9WS5AgXxNVZYpWhS4psgXtaWytVlb2L
         DkAw==
X-Gm-Message-State: APjAAAXqw1H9R47sVPxnombfQnFUJeiRgQ5i+fb+M/zssQ9G7Q1sYAL2
        iiCKWRGszHiq9e9DwQBcULQ=
X-Google-Smtp-Source: APXvYqwNeplEU5l3T+Bd+pYaCQcv8MrZ31vZLAMzGT+6bg15sdUb7fvXhnVpEI58PdviDIh3DOVyoA==
X-Received: by 2002:a63:505b:: with SMTP id q27mr2214730pgl.39.1582855696830;
        Thu, 27 Feb 2020 18:08:16 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:500::4:d8f5])
        by smtp.gmail.com with ESMTPSA id k24sm4931972pgm.61.2020.02.27.18.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 18:08:16 -0800 (PST)
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
Subject: [PATCH v6 6/7] ARM: dts: aspeed-g4: add vhub port and endpoint properties
Date:   Thu, 27 Feb 2020 18:07:56 -0800
Message-Id: <20200228020757.10513-7-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228020757.10513-1-rentao.bupt@gmail.com>
References: <20200228020757.10513-1-rentao.bupt@gmail.com>
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
 No change in v2/v3/v4/v5/v6.
   - It's given v6 to align with the version of the patch series.

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

