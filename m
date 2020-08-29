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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A10C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 22:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B86E52076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 22:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zi25bgyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgH2WLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 18:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgH2WLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 18:11:16 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE53FC061573
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 15:11:15 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i10so2711725ljn.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 15:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iLvIY8B1YiCLMcHn5mqtdRBNAAO+YyWhrlR/haHmzlI=;
        b=Zi25bgyLrYyvshPRxUrPFYzhO3bbvNSYlsQnYpGTnOtz2CfdavfK6UgyzfXe7+mI25
         fn1EDJCN8elUCKnzFdVirTbK8AYP8f84F1hCktgvoMR1JU7TYk1TMH4kGFXQdNlmrtz+
         fYXMfUHCjT3TxfLUWVpxMvnRukY5NboQTxwQZ5Vw9QKzBn8b8M3DTA9h5yq/VLNdqMmt
         syHIiyu4LmSVZ7ioMhQKNRkLD3Gv5wNR0GeYn5KhTz4Zf0yZa7UgvVMXHvyYL4fo9oye
         6tyQUENx/rD0sfn7H3DkCqKKj49GD3Wu/3L09rRtRzAwcOcm/gIFTeJ9vCFSrzcCjRmu
         fIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iLvIY8B1YiCLMcHn5mqtdRBNAAO+YyWhrlR/haHmzlI=;
        b=Y5XR8RFZcSe9eOf1L3ZyUyXNsGDwyoA0kxrkvJvOeyPXxL2OobwjsZm9pOc8wAg9fW
         c1+eGXjc8KgNJA/pm/pMDW6MFV8hcikeQOrB3A8hmCraLk7BSik5OqhfLrDtKTKKdl8q
         1qipR+54wAK+l2pvJnkaCbaQSfQG2MMGJsJmWEmjRW2hhuEYTI++wWyRRRJKYeyl+uEV
         ulvFB5xSOI71Q/FAxU5bkz2ANvubzMe2uvWZ9o2babD+YXroBQ7vibNwq5pL892v14ev
         X7INPjfxlqKIg2H0iQ9JDqIlBpfL1L+FCyrtsrFD4kR0imnUB2ntt/FHd8IPVgR8LQX/
         +DPw==
X-Gm-Message-State: AOAM530R+t1tz6kVF5UTz2bLMZCTnVxb/dxEjhssnovnmczg/JAjgi8C
        yuWjSWqhQCPoji+XE4NJgXw=
X-Google-Smtp-Source: ABdhPJzcAv3XNyc169J76hTQv1H/pYYXKA+MvNuu6Ovnzs4Whp5MMxOwIusBuz+GkVCjmw0ldvhx2g==
X-Received: by 2002:a2e:9743:: with SMTP id f3mr2215239ljj.299.1598739074054;
        Sat, 29 Aug 2020 15:11:14 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id 4sm697546ljq.92.2020.08.29.15.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 15:11:13 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/8] regulator: tps51632: Constify tps51632_dcdc_ops
Date:   Sun, 30 Aug 2020 00:10:57 +0200
Message-Id: <20200829221104.20870-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200829221104.20870-1-rikard.falkeborn@gmail.com>
References: <20200829221104.20870-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of tps51632_dcdc_ops is to assign its address to the ops
field in the regulator_desc struct, which is a const pointer. Make it
const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/regulator/tps51632-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps51632-regulator.c b/drivers/regulator/tps51632-regulator.c
index c139890c1514..a15e415e61d5 100644
--- a/drivers/regulator/tps51632-regulator.c
+++ b/drivers/regulator/tps51632-regulator.c
@@ -108,7 +108,7 @@ static int tps51632_dcdc_set_ramp_delay(struct regulator_dev *rdev,
 	return ret;
 }
 
-static struct regulator_ops tps51632_dcdc_ops = {
+static const struct regulator_ops tps51632_dcdc_ops = {
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
-- 
2.28.0

