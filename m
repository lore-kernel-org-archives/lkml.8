Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A206C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 02:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F134C2068D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 02:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRGyRvM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgIHCP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 22:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbgIHCLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 22:11:50 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D61C061796;
        Mon,  7 Sep 2020 19:11:46 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k25so17981521ljg.9;
        Mon, 07 Sep 2020 19:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hUUPRBULDiyvblMhx4V1F89haxR9rFzQ0ynZsEU3uxo=;
        b=nRGyRvM39J7Dc0NKd4+T9T4q9xmMp5RPRHo5+CUnrLdaLF7fTamBp89GlCu9bYtQPs
         ji7f3iu8HUO0Zap9c43X7AEtbNfdN2RBI3kOm9lBx0rVQZrEwN61rGD5GBur/ddYhTlq
         3ZaPxUMFiT5uKiKiLeJs3zbyzhudtNy2LsBeZ5i4O58uiFyTXM9KLfkHYoKjb61+hqI4
         vKcePjfmvfinzbQ6vctR11ihcoTaPl2lqwCSDPPXoOK6Mk6W66JRIE0MPuAKuFZSh3hR
         JwD/loQLHdRhi4dB0v6Jr7Jr6cXuXS0O2lU/fan8TRJxgpttTCFO9t2Fx9QzmXLv5wC1
         WDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hUUPRBULDiyvblMhx4V1F89haxR9rFzQ0ynZsEU3uxo=;
        b=LHN18FKWii0b7BiIVNzt2ynYslejPrEKPvp3WvDFuJK6IZIMaDSoatWQPPoJf4nq0n
         xHn21dJk3lr6WyR0/wHfFm5TV0dHLmB+O7UK9GNvyJE9t4mpfou+fni7iq+2c2VaxQhm
         nf+cwQfLE6sAdJUW2o2pWczHmnz8j2D7GZYMxXgRg9sDf+Mxri0K57jZY6PXoQB8lkit
         Xj2CqgmLleRHdYZTRI1WCeGnp7xhKK+PJGNzpbTHwwIfv27uAlAhi2jsD0gjT2LgGaZr
         PIHvhrFJFXkQ2TPYoccnLB/FL6/9d9m+RDuiCoPtFiX3+nnkKatZ73iHMvA63EuCRlZ0
         YN3Q==
X-Gm-Message-State: AOAM533jAJ2tI8WAj+FG9ho6TiepNOf4WBrpDbgaampvItC+F2hUjoCO
        3Q/FbgHgX7EEfqnkkAxKizI=
X-Google-Smtp-Source: ABdhPJzqJzpQh1N+5SKPnHfngu+Z5Ok1l46TN7zqP9VJfHlNyyjrMU0f435od7m7CG21nzSiI4+EBQ==
X-Received: by 2002:a2e:b543:: with SMTP id a3mr11879754ljn.19.1599531105278;
        Mon, 07 Sep 2020 19:11:45 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id j12sm9070085lfj.5.2020.09.07.19.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 19:11:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/35] i2c: tegra: Use platform_get_irq()
Date:   Tue,  8 Sep 2020 05:09:57 +0300
Message-Id: <20200908021021.9123-12-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908021021.9123-1-digetx@gmail.com>
References: <20200908021021.9123-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common helper for retrieval of the interrupt number in order to make
code cleaner. Note that platform_get_irq() prints error message by itself.

Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/i2c/busses/i2c-tegra.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index c2bbdf92b11f..505b5d37077d 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1684,12 +1684,9 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 
 	base_phys = res->start;
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "no irq resource\n");
-		return -EINVAL;
-	}
-	irq = res->start;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	div_clk = devm_clk_get(&pdev->dev, "div-clk");
 	if (IS_ERR(div_clk)) {
-- 
2.27.0

