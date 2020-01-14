Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2D3C33CB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5717C24672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yypA3/Yt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgANPDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:03:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46490 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbgANPC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:02:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so12444774wrl.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 07:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6LAbyGaoFYSB2hS3RB04QPR84/joXRhaPCO8uxP4pE=;
        b=yypA3/Yt6NwfSjqWhyf3Jb6/xwjB3nRZy6kf5pa4e5vJG8GQ/Gr8UFuHitY4IBDHxK
         vXFqyCmasFsFnkY9/fUKFqCB8w3gM9zBnTAc112usZLSj0hkBGeBgQaixg/J42qEtVCG
         abW3xSersQukLzV+AEICe/CzIoa71rcWJ6q0+WaFfZmzEv6TkGPrdmAtnIjnyckjsRzY
         X25Rci4pChALLj7IfGArH1mFmh/lGphnQY/dDh3CgrEHI/wg73v06o6nGeOWrFF0Rolq
         qYyOwkA1F+8ZWRPuXuBY2O5Xzwd2GXuEu5zfgiZz6KqAYoY49sE/aAa4jo/WeLlrRy+m
         HqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6LAbyGaoFYSB2hS3RB04QPR84/joXRhaPCO8uxP4pE=;
        b=c3CgwoSaT7mjtXdsEeGGJXG+XWynZBoQeYBoenhF33nmr2qfVfhulTIlPgY2I9FQf2
         dvFLdsyqt0fjWnjYF4qRDDqrtbzpsNU4/Rfb+dgpQixqdxLUJUwYQWeHmi7Zwaz9O7zQ
         cVTkIL+mIZizAqTgRLHm+OQ5YK3xIlRgTL2L5lB/hpXGvR0Rdc1E4A5noIqgLC0sxGKC
         3uZhANeTShlxH7l1OD1+pCYC4jW0nlKmbgMuNxPQPOVsDhigNu8W5dsbIRXXRRUPAxiN
         X3Ei8YYP7E1EplIwsXsgodAB6S0Rgca7gya7pKO9d1WKI/Gvw+NKkYAVCmnAaVuMvMJC
         J+KQ==
X-Gm-Message-State: APjAAAXMLzgmTARjfcvAPJTbjFOIboXzfMIB9OW/1YHchVSsprKw445Z
        9jkFwXSnWexzq2cE02ZHZkVvhg==
X-Google-Smtp-Source: APXvYqzZLiViCo7T7+acf5XtL/yvIoFaiY3H/CoCyXj0mdB9mUcN5NaNC74MsabsS2K8m+urEhMSWA==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr24649491wrj.325.1579014177579;
        Tue, 14 Jan 2020 07:02:57 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id i10sm20311539wru.16.2020.01.14.07.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:02:57 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/2] gpio: mockup: update the license tag
Date:   Tue, 14 Jan 2020 16:02:52 +0100
Message-Id: <20200114150253.28716-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200114150253.28716-1-brgl@bgdev.pl>
References: <20200114150253.28716-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The current GPL v2.0 or later SPDX tag is 'GPL-2.0-or-later' as defined
at https://spdx.org/licenses/.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 94b8d3ae27bc..5f81f087103f 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * GPIO Testing Device Driver
  *
-- 
2.23.0

