Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B788C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 22:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E916A2076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 22:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1BRRRTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgH2WLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 18:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgH2WLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 18:11:18 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4C0C061575
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 15:11:18 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w25so2640312ljo.12
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 15:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ogicnl1gleuOgZqLJi7vMlT0fGkrnPsLwcoujGcot4c=;
        b=R1BRRRTr/kBFXZnhwZ57cwF6n5ZjP0aWC5oDdGCr7vSKCSOzhnSHj0qZJvWp9R6S/k
         RGvZDlH+tHZ8NPwF/SkH8UVmsHcWzEuJ9lNBEkF9z1xMPyaDTVubiywI6u9aQ8jzYzgh
         BXDYIuTv4+Qx+P4uwSBo2RWvGHPeinfjZNOG64hFWJkU2ZsDqvfIPWNA6knfxTrd+g4b
         GKGju/PJPIQB/VkTBrd/dQ8wnIkL26cAterTGnSSpH349V8fRgl+Z13XMV8IxytJ87b8
         fMGWKxLCPYc2k2qkAyjexSRgA74ODjBuUdpqTEO3i4K+vtUEumIQXpUmV69S1SAbARqc
         SYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ogicnl1gleuOgZqLJi7vMlT0fGkrnPsLwcoujGcot4c=;
        b=UZN9O9A/qTE4w1VYfD3GdV63rHNCW/IinFGHyFXDMSAAvuprHxdhiyqBtT2LTsygdz
         rJcCw4qL27HMJgs8Xjbd5t6u/aFhAzZiuaXPPFiTAzYXMPkojWDWU/uDwajO1N0K/O3p
         6YrkV/o/cGkHl2OVrfsKOeMNAnB7TLhKf+a7FABiqgeKd5auHC54l32s1WbIpDLDGl91
         u3LNyLcLckjf3xNGS0/to/MgKH87YdyYm0KhYwc1VhD1RMlFBLQVonAtQADNjvOfi0kQ
         akGw89RNAXXcFfFpSgcE8tcaLwo1p/tz/ms8jSziwZn8bezUCPcZ1Wk0JJdnEQ7Ir9Gg
         nfbg==
X-Gm-Message-State: AOAM5314WTth8AGNIyuQAElvJe0VkJrZ30xVKpEMGZJbsccMWhqgRLpA
        DxT9qgMHquF8kgLP2d/x4vNl5iHwGbc=
X-Google-Smtp-Source: ABdhPJzVSATsBV4N6Ph+9odZvXPr5Zu5pR9Kp5T9ijKo1Qe7JX1ReOarFQH2NapMSYpqrAJV0UoFgA==
X-Received: by 2002:a2e:9557:: with SMTP id t23mr2122930ljh.193.1598739076977;
        Sat, 29 Aug 2020 15:11:16 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id 4sm697546ljq.92.2020.08.29.15.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 15:11:16 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 4/8] regulator: tps65086: Constify static regulator_ops
Date:   Sun, 30 Aug 2020 00:11:00 +0200
Message-Id: <20200829221104.20870-5-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200829221104.20870-1-rikard.falkeborn@gmail.com>
References: <20200829221104.20870-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of reg_ops and switch_ops is to assign their addresses to
the ops field in the regulator_desc struct, which is a const pointer.
Make them const to allow the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/regulator/tps65086-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/tps65086-regulator.c b/drivers/regulator/tps65086-regulator.c
index 23528475a962..070c956216b0 100644
--- a/drivers/regulator/tps65086-regulator.c
+++ b/drivers/regulator/tps65086-regulator.c
@@ -101,7 +101,7 @@ static const struct linear_range tps65086_ldoa23_ranges[] = {
 };
 
 /* Operations permitted on regulators */
-static struct regulator_ops reg_ops = {
+static const struct regulator_ops reg_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -112,7 +112,7 @@ static struct regulator_ops reg_ops = {
 };
 
 /* Operations permitted on load switches */
-static struct regulator_ops switch_ops = {
+static const struct regulator_ops switch_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
-- 
2.28.0

