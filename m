Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860F8C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B42C246A1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkDQqn4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgB1GOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:14:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34852 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgB1GOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:14:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id m3so1957137wmi.0;
        Thu, 27 Feb 2020 22:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K8JeMMhWRctus7267Io0iVJS6S3sXLRQ7sAyYhtTk6U=;
        b=PkDQqn4IfrkR95joYJSIQr1vwu7N4tEy3FTCOgp1MASfZ5B4eX42l22pSHvNDg4VbU
         Aol3iyfGZvpV8jVhb8BUxnoeo5XhB69R9gyJq+1yjs+ss8C7tx7C+vkU5ZNwCODxsF5y
         s4k3V5ilGwWxveBymFNnuY2EgK62sJwV9UCqmW53G3QjtHcw6ltNNQyHdrFl/xmSBmRY
         XbSL6R1tzE+YRAu8WzJJaLi5npTnknfmEnCy/zpf6XbZwskojtSS9rcbtF/AZlz3bCTu
         mi91W/HKUn2PJhK7IWj75/V9Zi7CXnnCCr8Wkk8MHy0Osh7sSbNW0ahbB7uC5PFjhO8Z
         NfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K8JeMMhWRctus7267Io0iVJS6S3sXLRQ7sAyYhtTk6U=;
        b=LJZVy7ZYi3kdMxvimNwfG7C7nxrXPc8kYxIJJL9R74N2We5OFfyCtdV5nxLhKEupU3
         wAHWH8igEel9l5qVCb2DcG1+VWroYk9p5VsYbrTgG81yFspudBfCnj/kZ7h5y/a1lr+9
         6gqXFp3RH0Zy4nDKSJCzd3NKTYv/Uhq3nAOgresQTLPoJKcFw40rPxHWUIUZ0GzovPEk
         iAQoO8rklNI+Y/aMBmoXyfJj8ZJLC3XSNKtDulI3nzqV9w7nPVQBeR87HiIX5Qb1aZwL
         XzoM7Zj3v4WuBpQ3zmyh8MoF9TzttX6u6a+8yR1miLUsc8Ud0MduKRvL4KaNzf5KAwBI
         Mldg==
X-Gm-Message-State: APjAAAUeAhg2g/WyMfJXtead4toP7KsJZqZmMuXUI8UfSDb09Uttg4Bp
        t8lMA9CoMI0qGSLcwD5UN8g=
X-Google-Smtp-Source: APXvYqws2FKIOQBYK5QacYbEvACBYX92jzAaAdc8ChQ3XWXBMBbvIC/43wn818U5yWZfpS4kmKMSKg==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr2876961wmc.145.1582870485825;
        Thu, 27 Feb 2020 22:14:45 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w7sm682554wmi.9.2020.02.27.22.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 22:14:45 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: rockchip: fix compatible property for Radxa ROCK Pi N10
Date:   Fri, 28 Feb 2020 07:14:36 +0100
Message-Id: <20200228061436.13506-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200228061436.13506-1-jbx6244@gmail.com>
References: <20200228061436.13506-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives this error:

arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dt.yaml: /: compatible:
['radxa,rockpi-n10', 'rockchip,rk3399pro']
is not valid under any of the given schemas

During the review process the binding was changed,
but the dts file was somehow not updated.
Fix this error by adding 'vamrs,rk3399pro-vmarc-som' to
the compatible property.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/rockchip.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts b/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts
index b42f94179..a1783e7f7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts
@@ -13,5 +13,6 @@
 
 / {
 	model = "Radxa ROCK Pi N10";
-	compatible = "radxa,rockpi-n10", "rockchip,rk3399pro";
+	compatible = "radxa,rockpi-n10", "vamrs,rk3399pro-vmarc-som",
+		     "rockchip,rk3399pro";
 };
-- 
2.11.0

