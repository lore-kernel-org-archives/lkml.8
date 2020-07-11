Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9ACC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 11:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99987206D9
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 11:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgOzISgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgGKLoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 07:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgGKLoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 07:44:30 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07326C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 04:44:30 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so9291825ljv.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 04:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yaksYBcXaU35BrWyqrbVOlpaXmypFAxOvxS4CIm38Eo=;
        b=UgOzISgwB+iq9LK3rjVylndJCiTmDXCP3ti/+oMkznveUyzcNPkkDtNYgNtk9LyPwr
         aL87zwaVWR1x2iEMa2lH/wXwJeLHqJxPgfcDFmSW29JF8/jQ+eHg9BcsbXT4KV/WBnCE
         XbWS8FW7jE3a1p3pOcrKUdTGf41rfhgyiul2xnEjCjlVTzq7n/FsJQMu1LzLvxX0TqPc
         NI3/ANM5whNYHJveeOobX2Ut+X3nkC5y+MlGjgvhKKZuI6z4QW/tVt3Ic2X6a7uNMWxe
         DhnctEzX2vz29ceNCKhXqnYgAgnJAHbPHIKNd4KnFiJhu8b7wzwCvw6JLeencoV/HnpV
         ADXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yaksYBcXaU35BrWyqrbVOlpaXmypFAxOvxS4CIm38Eo=;
        b=OXLu5VGvqkVOCAaFUTlqnO1VE5f/KdJmktpQ3tQIgwBDKKpjXSRuF5i0j5AK61DKyq
         IH2CvmTVRsyde24KAl2necdyGbt1lPzVrksRlFt1rOkt1rgth1C6uHEQ/zKkjrI0s1b5
         6KVj4gNzfJ/z8kn4rfLzoegzKhiHkIFDbjdz7TioAzao8yDOfY4u0Rj9zMosVftSnNqp
         j1ZZBYmjQPDekvNFdFOWMFuXFA7WP9ll/qHRUtvW7U8eFgQpzCueFBBFQILMZnurlyG/
         57VPvAHTgvr0slG2/MNGLCSfJwTaurm+xnHeSHFDpXoJ94H7rQ6MWJL+gRyw96ybxDTs
         6fSA==
X-Gm-Message-State: AOAM530+Vz8Pw2DlNoe4wnX9uBgpk2T4d++JeNl3SMag+y3AjV3gLCRl
        qxzoUMqyE87oq+4dPvYWl58=
X-Google-Smtp-Source: ABdhPJyrE3HbiP1To2RrFfr3NXJqFHhXPPtlwfqGM9v3UDGx1bOhiiVwhn62ptFs4aPYTAURd9QqUQ==
X-Received: by 2002:a2e:9dd6:: with SMTP id x22mr24354663ljj.199.1594467868560;
        Sat, 11 Jul 2020 04:44:28 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-147.NA.cust.bahnhof.se. [98.128.228.147])
        by smtp.gmail.com with ESMTPSA id j25sm3080020lfh.95.2020.07.11.04.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 04:44:27 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     pihsun@chromium.org, lgirdwood@gmail.com, broonie@kernel.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] regulator: cros-ec: Constify cros_ec_regulator_voltage_ops
Date:   Sat, 11 Jul 2020 13:44:09 +0200
Message-Id: <20200711114409.9911-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is never modified, so make it const to allow the compiler to put it
in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/regulator/cros-ec-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/cros-ec-regulator.c b/drivers/regulator/cros-ec-regulator.c
index 35f97246bc48..eeed5aac3f32 100644
--- a/drivers/regulator/cros-ec-regulator.c
+++ b/drivers/regulator/cros-ec-regulator.c
@@ -142,7 +142,7 @@ static int cros_ec_regulator_set_voltage(struct regulator_dev *dev, int min_uV,
 			   sizeof(cmd), NULL, 0);
 }
 
-static struct regulator_ops cros_ec_regulator_voltage_ops = {
+static const struct regulator_ops cros_ec_regulator_voltage_ops = {
 	.enable = cros_ec_regulator_enable,
 	.disable = cros_ec_regulator_disable,
 	.is_enabled = cros_ec_regulator_is_enabled,
-- 
2.27.0

