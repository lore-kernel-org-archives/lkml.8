Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E26C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E52207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sxuSTfoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgGQNyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgGQNya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:54:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AC6C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:54:30 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so11219275wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+k3VcTxp8QDyMoYM0yDw+EEU9DorBAQ7cdSI3O9/bb8=;
        b=sxuSTfoC2hrZKKISGmaJt1ryNoM+Mb53vx2VqywQ2dm6pt4TZ3WpIxoolFr/96l5HI
         zgp/5o581dmdBiSgQH3SacRs4hO0s2WCDSNAoa/pJXkzvrtSt48cyV/mcy5I48v5N6uj
         xmXqic/H5aJT4crWkPnWZ3OyiIOkd6vfhc8jU3EPrcggEqC2+I1bjp0fuQRPhgEGivWK
         ha15AuG72HyS/oCVqOEXoBdq9Osq05Ti56BmkcMaSYnI4b8Yl6qBjBfxGW/MIAqK9BRQ
         48m14QnuLysn9zQoC8jLbQP5u+0EN6xO+0yHGeuvFjNT3LPCFTTjHa67pDCtydIvFQ9Q
         GIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+k3VcTxp8QDyMoYM0yDw+EEU9DorBAQ7cdSI3O9/bb8=;
        b=rsQnJFNAE0USc4JdqIylUbLf33VcMwK9ol3c52aV0S+AGaSLLUYPspCuxEqUqNgzPE
         r2Gk+UO7iTa4I/noaasILSHshcdv59YQZe59mdF5jg7u0P+jjsWl1jInPqwf/vdKepuf
         b67yn1V5o2HjcRjyo1aCj+mjhBiKEhtDfhggtm85QCES5stnOuZJ/goQuq2tCC5oFEu3
         9W9WyTEsj6RG/4lrE9fzvgwACQTF06wOYPq8Z9sFlCkEmCJpzHS0Xr2dL8u55EFOkiXh
         lqWvzjapTjSkd9e/o/gVf436YMCnqvIDyCTroK89YIgJsbTdToKku2rQA4LLRyf4FGlM
         HDpA==
X-Gm-Message-State: AOAM533p4loniw9jtF5MHz6i5EN0i9XepYSJymk2ts4CYEMlrWquO3Wy
        EKFvatQRTveRs4ivaiRhBe3C2g==
X-Google-Smtp-Source: ABdhPJxWtRjEu5h/VTCvkKtCbMutdB3KhIeOKshDePoFQqyehuXzpt7xnH4k4MXi+QlSEZd2V53Rcw==
X-Received: by 2002:a5d:5450:: with SMTP id w16mr3244734wrv.155.1594994069010;
        Fri, 17 Jul 2020 06:54:29 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w128sm16118356wmb.19.2020.07.17.06.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:54:28 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 02/14] spi: spi-bitbang: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Fri, 17 Jul 2020 14:54:12 +0100
Message-Id: <20200717135424.2442271-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717135424.2442271-1-lee.jones@linaro.org>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document any of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-bitbang.c:181: warning: Function parameter or member 'spi' not described in 'spi_bitbang_setup'
 drivers/spi/spi-bitbang.c:215: warning: Function parameter or member 'spi' not described in 'spi_bitbang_cleanup'
 drivers/spi/spi-bitbang.c:434: warning: Function parameter or member 'bitbang' not described in 'spi_bitbang_stop'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-bitbang.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index 68491a8bf7b5b..1a7352abd8786 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -174,7 +174,7 @@ int spi_bitbang_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 }
 EXPORT_SYMBOL_GPL(spi_bitbang_setup_transfer);
 
-/**
+/*
  * spi_bitbang_setup - default setup for per-word I/O loops
  */
 int spi_bitbang_setup(struct spi_device *spi)
@@ -208,7 +208,7 @@ int spi_bitbang_setup(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_bitbang_setup);
 
-/**
+/*
  * spi_bitbang_cleanup - default cleanup for per-word I/O loops
  */
 void spi_bitbang_cleanup(struct spi_device *spi)
@@ -427,7 +427,7 @@ int spi_bitbang_start(struct spi_bitbang *bitbang)
 }
 EXPORT_SYMBOL_GPL(spi_bitbang_start);
 
-/**
+/*
  * spi_bitbang_stop - stops the task providing spi communication
  */
 void spi_bitbang_stop(struct spi_bitbang *bitbang)
-- 
2.25.1

