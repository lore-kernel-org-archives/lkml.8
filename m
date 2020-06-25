Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085B8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF85C206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GSc/LxSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406343AbgFYQgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406313AbgFYQgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:36:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B94AC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:33 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z13so6519161wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TC6ovm1MTdrPXtJ7RPNgE+kqgQ9elvNJFPlbxofiJ9w=;
        b=GSc/LxSAVa29kXTlsfWMyCLX/Yr2la9yDbQV029tu6huJwXsEThpfpX67gY5snQPRs
         9w17UHzz9qEJtm2vVVgSXslhm76xPE8MSFfy3n6T+YXK8Wf7rtUU39Dq8tnZE8JXoi8I
         ZilOALyMsEAlXNrlilnNNNP3SDexRspuU5i4duvqMaJ2+wfM+9u/eyWF+kj9glvP2Yca
         iqTVg6u+h4bB8yklv3g3unbra6xnMH1T6TdkVtXtvUs8LIQ7Ey/z0B3pcPSKlIjWwBEo
         AvNA5dWzG/iviUkBsJd3ERZh81VGimZna9c+DnXZXZIcPXc4fr7dHPNUEEGgk7AjiZwz
         tVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TC6ovm1MTdrPXtJ7RPNgE+kqgQ9elvNJFPlbxofiJ9w=;
        b=WK6lbYpEqnWAA/+GAIChfdExhgAZAwe11TmpFvmD+/nhBOOBEnctbNsnfLXX3cah1N
         kDvpj8sKILQpz3vf5jtQbQypgwFp6snbKTv9nAGaj+oFw0ZZjjdlfrEBOSbEuPYWc/XS
         zKlYmnd3GHsC9kkXF4+zCaC6cXh4nor0JTjFR8JU4GMi/FSAbz2TybSny+kHXQmkW3NX
         ZhyJS2SPgvfcXfCEGA22aAH/4/khkJvfEsg8MMMB8g1RpL+PI13r6IbfaScTWwTfhfYJ
         J2gWgGtilMyulC8r2EmaKOkwq/q9AlcbEjMrbXb1+gDMnUjwsm51ef3C8XUesJoq8U1F
         04hw==
X-Gm-Message-State: AOAM532elXcVO/PpPxMzGzmasCASKMxouvQbv3/+2z1ThSKRPGgVabOG
        zfV6baPiSTC/FJdK+10UPMLF5g==
X-Google-Smtp-Source: ABdhPJzhEYgPmTR4l1oHQcmaoYP7rMe39jztBc3C01yTdPLg527ej6688QjPkiAxzMTPtlCnn7Oe1A==
X-Received: by 2002:a5d:688c:: with SMTP id h12mr26136963wru.212.1593102992114;
        Thu, 25 Jun 2020 09:36:32 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id a15sm36729089wrh.54.2020.06.25.09.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:36:31 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 08/10] regulator: cpcap-regulator: Demote kerneldoc header to standard comment
Date:   Thu, 25 Jun 2020 17:36:12 +0100
Message-Id: <20200625163614.4001403-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625163614.4001403-1-lee.jones@linaro.org>
References: <20200625163614.4001403-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing about this comment identifies it as a kerneldoc header.
They're missing all of their struct's property descriptions and
the correct 'struct *' header.

Fixes the following W=1 warning(s):

 drivers/regulator/cpcap-regulator.c:99: warning: cannot understand function prototype: 'struct cpcap_regulator '
 drivers/regulator/cpcap-regulator.c:337: warning: cannot understand function prototype: 'const struct cpcap_regulator omap4_regulators[] = '

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/cpcap-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index fbf823b830308..221e8db358c9e 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -89,7 +89,7 @@
  */
 #define CPCAP_REG_OFF_MODE_SEC		BIT(15)
 
-/**
+/*
  * SoC specific configuration for CPCAP regulator. There are at least three
  * different SoCs each with their own parameters: omap3, omap4 and tegra2.
  *
@@ -325,7 +325,7 @@ static const unsigned int vvib_val_tbl[] = { 1300000, 1800000, 2000000,
 static const unsigned int vusb_val_tbl[] = { 0, 3300000, };
 static const unsigned int vaudio_val_tbl[] = { 0, 2775000, };
 
-/**
+/*
  * SoC specific configuration for omap4. The data below is comes from Motorola
  * Linux kernel tree. It's basically the values of cpcap_regltr_data,
  * cpcap_regulator_mode_values and cpcap_regulator_off_mode_values, see
-- 
2.25.1

