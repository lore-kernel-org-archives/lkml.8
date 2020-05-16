Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DB3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 08:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 461E52074D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 08:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjZJlPba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgEPIIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 04:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726264AbgEPIIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 04:08:19 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB616C061A0C;
        Sat, 16 May 2020 01:08:19 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id t3so3908066otp.3;
        Sat, 16 May 2020 01:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O65I1zmNTEDkuvl7Blq3pU8Ri7LhEzDZZNS97q+Lxi8=;
        b=FjZJlPbawLMM/ZnJkShIEUeOrq3GKC79i+Ha8DSCMNL0//k9tBNOU0sR3lhju/fJOO
         2DKQdMRwRr0WiTvH1iR2xKZtgbduQ8dQxIYrOhDDnnblzp2hyrH1OXugdle89NgYRb86
         2INYSLAME7HtuuW6QzdgeaFytIS7WGh4LAVTG2xtoSsmSPVm6p/TE2vPh4b6bmvb4/Ro
         O7aDpCAdhhTucTt4ayjJBqenIEOpqTmeYCbBxKkQEMMebFyfWsQQ2Q5jxIw4Pj/JsiKD
         IU143p2NZxRlWYkVx+tYqHDerYpGkNOaRNs312EOsk2KRgMVRew7ZXsyk8c4EbB6Xvbk
         DkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O65I1zmNTEDkuvl7Blq3pU8Ri7LhEzDZZNS97q+Lxi8=;
        b=p+O6Bv+vmMKEoANiQlA0pMC6yApUgBFfDLSnaV7e0RT0C6xCIgmZiRUcPMuVoYo6k+
         3/jqdrCyCArZmpdx9jN/ZOYMG4zEKXjSl5oO/XlYn749d2L5nECf4shtxCIIIZn6v3Nb
         9hU2hvjUzKkw9RlqUWELDFLg8mlTy3GaNnBynskXh1YK8XpNT695YfAnPTmPmFd7cWL5
         +64NOCSg9bzjAZeVqFr1r5hLowPZkZp1g6Jo2/7u5gEM/Le+aQlrGa+Kb6wDDDrMlOdb
         tbpiwAh5KgA7+lDJSHdLZPzfVTC8jLU05fAHAufpOcYxc8HK+OxjvjaWeAZ3LR2hd4QS
         swrw==
X-Gm-Message-State: AOAM532uItwfKvdBYViYWi+Nsn/kLZtsu1c+r1uMU9wte/eOXCTo7OBS
        Dek5Lv7QxQuC4hGW2Ku7PfQ=
X-Google-Smtp-Source: ABdhPJy9xrUAJUSrZGHz4rjNK3oxki+IlpWEmBm4DbMT7HduARzjVorHFCT1Vym5JNh1k3gyGNDlJQ==
X-Received: by 2002:a9d:7dd9:: with SMTP id k25mr5079985otn.328.1589616499102;
        Sat, 16 May 2020 01:08:19 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id n11sm1321064oij.21.2020.05.16.01.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 01:08:18 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 1/2] clk: bcm2835: Fix return type of bcm2835_register_gate
Date:   Sat, 16 May 2020 01:08:06 -0700
Message-Id: <20200516080806.1459784-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bcm2835_register_gate is used as a callback for the clk_register member
of bcm2835_clk_desc, which expects a struct clk_hw * return type but
bcm2835_register_gate returns a struct clk *.

This discrepancy is hidden by the fact that bcm2835_register_gate is
cast to the typedef bcm2835_clk_register by the _REGISTER macro. This
turns out to be a control flow integrity violation, which is how this
was noticed.

Change the return type of bcm2835_register_gate to be struct clk_hw *
and use clk_hw_register_gate to do so. This should be a non-functional
change as clk_register_gate calls clk_hw_register_gate anyways but this
is needed to avoid issues with further changes.

Fixes: b19f009d4510 ("clk: bcm2835: Migrate to clk_hw based registration and OF APIs")
Link: https://github.com/ClangBuiltLinux/linux/issues/1028
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/clk/bcm/clk-bcm2835.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index ded13ccf768e..7c845c293af0 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1448,13 +1448,13 @@ static struct clk_hw *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 	return &clock->hw;
 }
 
-static struct clk *bcm2835_register_gate(struct bcm2835_cprman *cprman,
+static struct clk_hw *bcm2835_register_gate(struct bcm2835_cprman *cprman,
 					 const struct bcm2835_gate_data *data)
 {
-	return clk_register_gate(cprman->dev, data->name, data->parent,
-				 CLK_IGNORE_UNUSED | CLK_SET_RATE_GATE,
-				 cprman->regs + data->ctl_reg,
-				 CM_GATE_BIT, 0, &cprman->regs_lock);
+	return clk_hw_register_gate(cprman->dev, data->name, data->parent,
+				    CLK_IGNORE_UNUSED | CLK_SET_RATE_GATE,
+				    cprman->regs + data->ctl_reg,
+				    CM_GATE_BIT, 0, &cprman->regs_lock);
 }
 
 typedef struct clk_hw *(*bcm2835_clk_register)(struct bcm2835_cprman *cprman,

base-commit: bdecf38f228bcca73b31ada98b5b7ba1215eb9c9
-- 
2.26.2

