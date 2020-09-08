Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36285C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 02:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F015421973
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 02:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7WSz1Zb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgIHCOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 22:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbgIHCMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 22:12:18 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F02C061755;
        Mon,  7 Sep 2020 19:12:04 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s205so18039412lja.7;
        Mon, 07 Sep 2020 19:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vveidTkc/eu87y/y+4KUyPRX3Pa9/Zje3+4hy4983PA=;
        b=c7WSz1ZbqVbBub2NvVsjVh1OUH8DlotJWWRh87EUgZSeuvis6PVIcO1w20LsafW/zL
         bembyoaGFU73S2crS6iFYP5HmiXqU5ZA1fkWjXe2K0h/gpw1CSoD+AEcuBu+Yr5koH1t
         oU5IY8RozWSV+Y4MpV56BlK2xqVShD+J7LtxJ3hMrk+qqmuQOVh9W+l/mqPiFwhO5KZL
         Ywc2gahuP0HWf7wpsEcbsIMBVTP/r4QYa4pMjDLUlHlNiH3mhXHWriY4M/I1LKl89ssU
         XtfMgQ5OLbmRkUslRKwB96BFagMdzk6+7acJVZmLstfsGDMa3+JyeveHM+o5l9UvwtKI
         4m1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vveidTkc/eu87y/y+4KUyPRX3Pa9/Zje3+4hy4983PA=;
        b=HhVOz5zPfH/5rZ7su8bujJDKylncbnI1YeduLWQ47/sT7+jltnvFv5YqlQ316OI0U8
         GE5MXjUoVo8bxH7+T28tv9G5ZHBITlPeXauXLH+S11TDjFiI0PfnCRHBp7nTZVH6lU6Z
         skVpeTmyy8hJMVRo1dk/91GqkKkQ5hdrqoXXEgkgfY+zjtTbw70faiOgMeX72/PS2mCa
         sETg7DqIJkJuJVhP7qwrHWHgQr96m3WcXZhEWvkudDgu1UOxnRDwEi22SJT4liH52Rf2
         gisJEL3kc8qANEkpIa84/g2SxJH8dsjdu3DKqUMKmgF1rudPnQBLFtOfD6s/EWr0zAFj
         1vNQ==
X-Gm-Message-State: AOAM530SSP1zDBteVBaYPIml3OJZzBSayIDwiDpGQaGnOSZ2cEo6xeTn
        7miGQlfFfjVIiK8tF4T7b0/DtXWl2Ps=
X-Google-Smtp-Source: ABdhPJxnaYx8Wg6tJI8LnT7XBPQ4oR9WOJsNGXXVwFiMCs5UEHRbucij7ZX452B+vZaY0ftGYYNMQw==
X-Received: by 2002:a2e:a314:: with SMTP id l20mr12264858lje.213.1599531122515;
        Mon, 07 Sep 2020 19:12:02 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id j12sm9070085lfj.5.2020.09.07.19.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 19:12:02 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 30/35] i2c: tegra: Consolidate error handling in tegra_i2c_xfer_msg()
Date:   Tue,  8 Sep 2020 05:10:16 +0300
Message-Id: <20200908021021.9123-31-digetx@gmail.com>
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

Consolidate error handling in tegra_i2c_xfer_msg() into a common code
path in order to make code cleaner.

Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/i2c/busses/i2c-tegra.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 2529d557e0b1..62c7334fe601 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1288,8 +1288,8 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 
 		if (!time_left && !completion_done(&i2c_dev->dma_complete)) {
 			dev_err(i2c_dev->dev, "DMA transfer timeout\n");
-			tegra_i2c_init(i2c_dev);
-			return -ETIMEDOUT;
+			err = -ETIMEDOUT;
+			goto reset_hardware;
 		}
 
 		if (i2c_dev->msg_read && i2c_dev->msg_err == I2C_ERR_NONE) {
@@ -1309,8 +1309,8 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 
 	if (time_left == 0) {
 		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
-		tegra_i2c_init(i2c_dev);
-		return -ETIMEDOUT;
+		err = -ETIMEDOUT;
+		goto reset_hardware;
 	}
 
 	dev_dbg(i2c_dev->dev, "transfer complete: %lu %d %d\n",
@@ -1324,6 +1324,11 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 		return err;
 
 	return 0;
+
+reset_hardware:
+	tegra_i2c_init(i2c_dev);
+
+	return err;
 }
 
 static int tegra_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
-- 
2.27.0

