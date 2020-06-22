Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442BFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25649206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v+QT9yYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgFVIei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgFVIei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:34:38 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CE4C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 01:34:36 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l17so14018178wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 01:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iumTCPIQ5JgGRCUXbn3oWrglqPPjaXK37FVM57bSflI=;
        b=v+QT9yYRCkBvviTFtqwMM6R1p8xJCXCmU5EzRl2/Msz9xNSQiynSP58ZJxKiHqdLBl
         jy01IszLE6KSujR5GrL121LclHi8zO/zEVfqMJ3dimS8VV0ImQUrb4VlTL26KGyGoYHp
         SM3xUp0XJft9toVfWgGSrhZ83Kw1rGyFkY5DrWdEj/rEXGOeiJr/kdQb3bB79X8+jqCO
         0lR/imQOAg8a75RJrLck4HJ5aumvhzFaxouUV/VKBjYBjUj7c0nPg6o2TI7jRQmXNpeI
         BKXcPcUqfhcby73EdiXz1pX1DXxPU0qrYY1c9uyxMpnj3LU8lqZgl+Aj3DIHJUKti5nX
         SKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iumTCPIQ5JgGRCUXbn3oWrglqPPjaXK37FVM57bSflI=;
        b=p9aycxVNiDjxTP+nFvEN/NwWFsQgvaaRqpAFBKwfqUlp6MGSLjELEyyjhoCjjbO7q9
         xtwoyVFBEmBVR3n8qR304tJS5SblpUTMF4OV6vixmCgCSPh2ryrE5liogqWeiRaC1d0c
         xfd77ILIkmKbQ8DmO0NKzEg8qpXtFtVlkZ9F+C2UpbUJTqjNeOBK7AAE703hs8DN5+XK
         t1uy4CYL0Sl7YGfVRPOpK1IGm40/r/5jWD8dgss1oPhotxnRjse43Dm4/ewKwHOSbfq7
         UnkwgIzdLMyxfPGGA1DvZvt3QKQOgg3pUCTtO8ghNc+M6xckahET/eCp4vNehlkGmUMe
         BS/g==
X-Gm-Message-State: AOAM532V/I+aNOLfhdw1/q1ZEVmE9LqTVPmxdlWRU9HfPI8cAOSiQ84f
        epblccAevsMxh17K+mHnw10W3Q==
X-Google-Smtp-Source: ABdhPJy8EF0FGsP5udLRcNjPlqG9OY1hIfHKLNuaRTjiy8Jh4ufHvnQFqnkLAt+MaeylObvSEY79jw==
X-Received: by 2002:a1c:f714:: with SMTP id v20mr16932709wmh.81.1592814875416;
        Mon, 22 Jun 2020 01:34:35 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id w17sm17477224wra.42.2020.06.22.01.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 01:34:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/1] ARM: dts: ux500: Supply nodes for the other 2 AB8500 PWM devices
Date:   Mon, 22 Jun 2020 09:34:32 +0100
Message-Id: <20200622083432.1491715-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per 'struct mfd_cell ab8500_devs[]' there are not 1, but 3 PWM
devices on the AB8500.  Until now, each of them have referenced
the same Device Tree node.  This change ensures each device has
their own.

Due to recent `dtc` checks [0], nodes cannot share the same node
name, so we are forced to rename the affected nodes by appending
their associated numeric 'bank ID'.

[0] ste-ab8500.dtsi:210.16-214.7: ERROR (duplicate_node_names):
      /soc/prcmu@80157000/ab8500/ab8500-pwm: Duplicate node name

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/ste-ab8500.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-ab8500.dtsi b/arch/arm/boot/dts/ste-ab8500.dtsi
index 3cd6ee6d50e0e..aab5719cc1a93 100644
--- a/arch/arm/boot/dts/ste-ab8500.dtsi
+++ b/arch/arm/boot/dts/ste-ab8500.dtsi
@@ -201,7 +201,19 @@ ab8500-sysctrl {
 					compatible = "stericsson,ab8500-sysctrl";
 				};
 
-				ab8500-pwm {
+				ab8500-pwm-1 {
+					compatible = "stericsson,ab8500-pwm";
+					clocks = <&ab8500_clock AB8500_SYSCLK_INT>;
+					clock-names = "intclk";
+				};
+
+				ab8500-pwm-2 {
+					compatible = "stericsson,ab8500-pwm";
+					clocks = <&ab8500_clock AB8500_SYSCLK_INT>;
+					clock-names = "intclk";
+				};
+
+				ab8500-pwm-3 {
 					compatible = "stericsson,ab8500-pwm";
 					clocks = <&ab8500_clock AB8500_SYSCLK_INT>;
 					clock-names = "intclk";
-- 
2.25.1

