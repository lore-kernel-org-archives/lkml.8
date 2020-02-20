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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6680C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46132071E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWh6C6VJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgBTPi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:38:57 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36406 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbgBTPi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:38:57 -0500
Received: by mail-lf1-f67.google.com with SMTP id f24so3472503lfh.3;
        Thu, 20 Feb 2020 07:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LTSTcBgb9GGJQllk/olrBiwlUBbpPRVx+sqTluRMzLs=;
        b=SWh6C6VJobFRpWMlRyr9Ir9oQp9/szZB1jyFZRDk+ZrhKC2bkfTXQMYeQIARVZpm0r
         TOWj0G3U9aDhmnR+8o4jlbZcdL2sRDk4+lj+C5B+MRk9b8tnmMTQMtV1PxQJNzAw2pwT
         Tx8mSXkH5ETJp6KyFGAEpyirq/WzJa9B84AWRBKl4vLKKx2nbH+eLeA4m0mCJrZlAQsl
         1IQv8vu92Opd0LdrF68FanQmRXzvMFodiA3UufFAGiByXZEEJaZxOuPcMycNhsYyCumo
         SW2QQK8xcNAmu6vt4hwdcJcab+Dh+uqtqPa22KHYu/HBc7gGoyLNhnrKnFbGvgTvOxuj
         SM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LTSTcBgb9GGJQllk/olrBiwlUBbpPRVx+sqTluRMzLs=;
        b=cA15KiwvgcNJodkwAqXq3jmpYs4mXY7x2Q7aBh2LOFx3Hg3/Ojnn5hFwvsKnr3rCJn
         VaZUiztHrBS91R415hba7Qd5uRvsxdyuLjqGQKOrX+Bl/XpS7Yyd8Aw0+uF9Pt2aMLnP
         w5f3JlI52538ukvOIjsTWzvewyd2NixWl0+2oMPOEDc/lKHrkCqRHUqCeAom7mRrPMuS
         y5m/g5NVxum7qaaf8lvpczyWjAj61HUAkLwMkpKkAuIhdmYxb6LNkjDkMhz8BvTCCWUg
         074pfDPzLKvBaHme5fBnSBNZeRBL4G1ns/eL9aQeRUUAKhZ02Re08d7CkHr4g4dZZqpM
         CLkw==
X-Gm-Message-State: APjAAAUX8UfF9qbBeu+T8ocqbfqaCF7gnwshdO98DhG1wbTcJhzlmuHX
        wk4PjkcgOjuuwpoCzgqLF30=
X-Google-Smtp-Source: APXvYqyxn2s0jyOgdFy3o8g+SEhzmAWcmuIT+Q8DAV3EzVkzptKp/H9zuaGay43R3j85QjPRMaUAeQ==
X-Received: by 2002:a05:6512:6cb:: with SMTP id u11mr7885481lff.69.1582213135029;
        Thu, 20 Feb 2020 07:38:55 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id f26sm2000083ljn.104.2020.02.20.07.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Feb 2020 07:38:54 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson-gxbb-odroid-c2: add rc-odroid ir keymap
Date:   Thu, 20 Feb 2020 19:38:05 +0400
Message-Id: <1582213085-11656-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the rc-odroid keymap to the Odroid C2 device-tree.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 6ded279..b46ef98 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -248,6 +248,7 @@
 	status = "okay";
 	pinctrl-0 = <&remote_input_ao_pins>;
 	pinctrl-names = "default";
+	linux,rc-map-name = "rc-odroid";
 };
 
 &gpio_ao {
-- 
2.7.4

