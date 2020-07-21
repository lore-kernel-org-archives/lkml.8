Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5677C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F9B2068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBF70gWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgGUOuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgGUOuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:50:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602EAC061794;
        Tue, 21 Jul 2020 07:50:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so3165111wml.3;
        Tue, 21 Jul 2020 07:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2jvq9FlI7o6al7hU8EUdIg9paAzP+PBPHlRfqRi6w1Y=;
        b=RBF70gWLPXsqqv76vGFtmcQeh6GucMxg5VYzF4jXuWum4Doiqpw/wQ9x4tffRbEUVl
         G2YMe+nWm/8+b/tiKxH0tggVmvo59QGbCJqpU46cW62kIoKRPtKsY/Kxsva5n5vXXPPi
         ViGBWMjvN26srjdybnuhvQhmL9Nv3tviLguWA1iorAEbOTwPQi3L9IBA61QqXu5PH+O8
         Jrq0QM9IDDp9MBlA2JchB4Hi5VSG3i4856uW0cxiAGsYsnX1xU/kKCgc4vcPTwQmdsAN
         puUX1RkBJVHyNv6hPRgpF3Je5mgEgyvC6MC4Vcj+FmD4RSMohh8OT7Ndt6qfwi2ILsUN
         2xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2jvq9FlI7o6al7hU8EUdIg9paAzP+PBPHlRfqRi6w1Y=;
        b=ULj99MIiwfRYo1DV61YwFKqKGC84Fc7PFAacNm4SvsiNRbcmo/yocQf24vUcQjIK1/
         +zY+25Fsv5tCrn/fNdl6Ec7vrdAiIdRvl4RBbGTJZgyfmN3fH1/+QMPe642Flc3XGf3R
         OsJFRDyjypjeBKE6u4s0+HgxSi6GD23unQFPOGvUO2Nb/jkKWjJFZRCFNwFpOoheUu+W
         DFJc7KxnSEbu0y4kR1NbAq58b8C+rlgUQkavxJh+CprwWSh87PklLY5jZ7oOnA54Pvi8
         IdMDpVhl4K6rtOC4MtiDcJZZkpGX+bioF5sOrOWANivfnitEmWCuO8fAp3Ij8NHhvnZk
         n9ZQ==
X-Gm-Message-State: AOAM532NJvSBn7S2R2XHg3g3oyPYA8XiqedirM4pZwF/7jxopPKdTxp3
        PTc8mVYttz9wkWoQfO++AGc=
X-Google-Smtp-Source: ABdhPJyQqu0IWAETiEuW9l6a3Jvb0jlAejO9q2crcSjo5oVGJTVo6Onjy9gcQumMvOWEh6MKiRbjpg==
X-Received: by 2002:a1c:286:: with SMTP id 128mr3758578wmc.37.1595343001183;
        Tue, 21 Jul 2020 07:50:01 -0700 (PDT)
Received: from localhost ([156.204.74.63])
        by smtp.gmail.com with ESMTPSA id e23sm3571741wme.35.2020.07.21.07.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:50:00 -0700 (PDT)
From:   Abanoub Sameh <abanoubsameh8@gmail.com>
X-Google-Original-From: Abanoub Sameh <abanoubsameh@protonmail.com>
To:     andy.shevchenko@gmail.com
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abanoub Sameh <abanoubsameh@protonmail.com>
Subject: [PATCH 2/3] gpio: gpio-intel-mid.c: fixed alignment of a block comment
Date:   Tue, 21 Jul 2020 16:49:41 +0200
Message-Id: <20200721144942.762495-2-abanoubsameh@protonmail.com>
X-Mailer: git-send-email 2.28.0.rc0
In-Reply-To: <20200721144942.762495-1-abanoubsameh@protonmail.com>
References: <20200721144942.762495-1-abanoubsameh@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A small to the coding style of a comment to make it compliant with the coding style.

Signed-off-by: Abanoub Sameh <abanoubsameh@protonmail.com>
---
 drivers/gpio/gpio-intel-mid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-intel-mid.c b/drivers/gpio/gpio-intel-mid.c
index 6487acab104c..a9cef06b813b 100644
--- a/drivers/gpio/gpio-intel-mid.c
+++ b/drivers/gpio/gpio-intel-mid.c
@@ -38,7 +38,7 @@
  * reg_addr = reg_base + GPDR * nreg * 4 + reg * 4;
  *
  * so the bit of reg_addr is to control pin offset's GPDR feature
-*/
+ */
 
 enum GPIO_REG {
 	GPLR = 0,	/* pin level read-only */
-- 
2.28.0.rc0

