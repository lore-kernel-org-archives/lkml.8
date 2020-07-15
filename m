Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8A3C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180812071B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o9rdZT8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgGOPHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgGOPGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:06:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85F6C08C5DD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:38 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 17so6165614wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+k3VcTxp8QDyMoYM0yDw+EEU9DorBAQ7cdSI3O9/bb8=;
        b=o9rdZT8Hx4ZSY0QyT7IkQ4ORw3I2KhdkBi8D9WD0aKlkOqwzLlsY+8wGm3MgZELZEZ
         eoxZGyF0WYg3vLxEQtGzR1mPRhYBeowAwZG5Q1ohDhRTF6B7aI/kDZ5zE1rHynHqdjwD
         Y54oXUrHFNGOjkRgk4fKPU/YwFrCG6KHOLta5pTY2GQOAgYV/hWW7p7fvAIj9huteoSQ
         oR5UJ1GnrJrbbh6QbH915oTx/e/2TW3Tlgbng7XupxpuplJjwr3xz7gWkoAfFDYwk3yU
         T/n29AgXpPcokXXb+lnNSy//o0npV250DhZ5HWTzVSajBjsCeZ+1+gxceNq9A5EviKhl
         XrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+k3VcTxp8QDyMoYM0yDw+EEU9DorBAQ7cdSI3O9/bb8=;
        b=ITSPn9EBYSs7Gb/uZakj5Nf3PuU2SO+In3TE5w3ZodrsWQu6WlTuGfgM8dC+l71sdL
         OpAMVJh9uR85PKEOprghQ0oiQo6GyGC4NafBe/rHDV6E4PNwrGWBr2UZZxC51FhyKyJl
         f9Y1e73PMhpF11AfR/RIBw4qmhqryVz+ARK1RWRiA3XpqR+0vScn6mZu9DpAg6tkZNXP
         02PAuhUkk+p4NeQ5hklGrMUC6U1fAnZQxXoPnBu1fopSEAhIs4U5JndvWGupxhh0rwNe
         ZVgIB0zsIkPe1fxUCTQvYNZb2J30UX7W0kFFzMmhHKi/TbAkVdoeAc0JouD5YPaf/kzM
         EElw==
X-Gm-Message-State: AOAM532mSgtR6OWRKWZFn0pbAY7mi9Bcy6uUwY2VxnWo025RZTRdg5ue
        oC2/afVWfobVQa23owS/ChLNKh75U50=
X-Google-Smtp-Source: ABdhPJx9OHW5pgfjAQYGs6oy+4+393KILVPwhdW2gMjyprB70ILbgU/eATaVe2aWskjv61M55Cm5OA==
X-Received: by 2002:a1c:7916:: with SMTP id l22mr9762032wme.91.1594825597387;
        Wed, 15 Jul 2020 08:06:37 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 02/14] spi: spi-bitbang: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Wed, 15 Jul 2020 16:06:20 +0100
Message-Id: <20200715150632.409077-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715150632.409077-1-lee.jones@linaro.org>
References: <20200715150632.409077-1-lee.jones@linaro.org>
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

