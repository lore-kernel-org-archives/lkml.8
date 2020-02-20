Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3D2C11D15
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A77208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpD+X4Qo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgBTRo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:44:56 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45093 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgBTRoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:44:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id e18so5079478ljn.12;
        Thu, 20 Feb 2020 09:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rV1XEtpZtytxn3w6ko1TLTaLmkmnSDIr9qXrTQZTYWE=;
        b=BpD+X4QoLKjyH6kvt/7+xt+hQM+Ik/EsvrfGiMB2TLbJwOalDuNR5oRZFE+j+0ZbA2
         Ul1QzmJldYkEI2kww6ZJJjN4xHRpQHpfHZ/fPHAAsoDGfwXn8+AE1Rg+8Sc6gXudomGU
         n9brCHReIYWA4PgsgfqflEVuZ4GJ6lWaF052D2aNHg/q0u28XvUgp2wdvdojQoPPl1Z9
         BH/Vw66ZTsAqQBX6bVdWAdXvL+dQA7tIormQDbudqqY8Bi4AXJB1IZshFyY/N7xJNvQs
         f9BFgyJKpYJxdLacpwYj1tI9DJa7n3YJ6Vnk/y2gAygvGdvJQtunhVU6JRTITS2gpMMG
         XidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rV1XEtpZtytxn3w6ko1TLTaLmkmnSDIr9qXrTQZTYWE=;
        b=r0/nKeTqLnD5ijKZEPov4Xrd5bGeo7JmhUwYdwq/klG30a7GzVYCxhh9t+4voT5b9M
         vsVCSgCFBj0zciWLCKfL4sABN7CakYTwDfIzHvAZ7HA8vqsSTITm+dZAWTgSnbbL2YBX
         pdxRFA4RX2vcqCyHeStt4FSi+i9fTl8YwsHjY7rS3N7aryvk/+b2ZcDsY40InHg+kvt+
         xV1uO+xlhaRjKec8DnpwTYgCOwEOyNYc+TNnB+wV9ETfTTtyVstOPdde8QcJwL0XWP8C
         +ETbtw/7AtR7mMCFXoryJOEAY1v4W6r97Jn7Y9GdKvLBafXDn0dwvFXDfgBE8o08a4xr
         KLig==
X-Gm-Message-State: APjAAAX/e35XaUa/vBwbtRVoCd5SReDxk5zr17mbrnk6SbU1hxprlT77
        gNidEw5diEZ+VxzaPBKRhKM=
X-Google-Smtp-Source: APXvYqw/tdEvgcTCzHUJeaGUS3Ai//UQlxfJJSIRykk/sUvdVtE3Xu/NJzzTIgnkC6/5Y8gKf4u+jw==
X-Received: by 2002:a2e:b044:: with SMTP id d4mr18994708ljl.159.1582220693627;
        Thu, 20 Feb 2020 09:44:53 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id v26sm74501ljh.90.2020.02.20.09.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Feb 2020 09:44:52 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Oleg Ivanov <balbes-150@yandex.ru>
Subject: [PATCH v2] arm64: dts: meson-gxbb-vega-s95: fix bluetooth node
Date:   Thu, 20 Feb 2020 21:44:02 +0400
Message-Id: <1582220642-14133-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was missed from the previous fix.

Fixes: b07a11dbdfeb ("arm64: dts: meson-gxbb-vega-s95: fix WiFi/BT module support")

Suggested-by: Oleg Ivanov <balbes-150@yandex.ru>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 5eab3df..45cb836 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -245,6 +245,9 @@
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		shutdown-gpios = <&gpio GPIOX_20 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
+		clocks = <&wifi32k>;
+		clock-names = "lpo";
 	};
 };
 
-- 
2.7.4

