Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B3CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD1D207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bq4a/wY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgHQIKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgHQIKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:10:03 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEE7C061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:10:03 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f10so7112358plj.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AVM5Ee6U/PgM24p71AdP1zEptNAhtBHiH/J4elOBoDc=;
        b=bq4a/wY1jTCneE+s/N9XkoTRDfi6FFrXjPFbCX2hyjjVTa0rjLe1BFehd0Ubudyjvy
         2tQCKoiZ7neD1DxzuuX3L/LvtPDeXxuRaXOv48JfMePwptC3F9IB2vlDZMn/VUwBGUYC
         UWtSZ6o5moTekCXzFqTsBLa+GAfSZbT9Hhk2J5nUiAnQ6lPZQ9vXCS61X57fhtyxR9gu
         4zymCvU86fkehj29z6T4OkVDhu3T78E+BBF2HHfHJa/IgAKr4Y7apXqDt+nVMb3Yl1kd
         vvm69unP3toBPnFBDyQjpXmm48RzPMuxN08tJ9N2asske3r0dwT1wjWEbozcCPMoN3gS
         hbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AVM5Ee6U/PgM24p71AdP1zEptNAhtBHiH/J4elOBoDc=;
        b=OLxSu0O1JhSXyFH9/JGDUgeNrGpCxJ6yAhZjUshflyWs5WNDRu+PHkx2mqjxsC6J+a
         MSggihh839HsilRhjlXBUD9acevIKiA4WfiNfu1QGA3sOl8kE55VBYhLZIjt6vPxwKBq
         r8LYIqPxKrlGd82EP5WUCajkv3/oidj+fGVwki9XaOXujYoa0HDgQnBrtG81neWaDOyp
         /boO01phedhefJcdNMrFpJEHlrBo1ZZv60QK8AD7MJK5OwLF5lbp4oWbr/nheM6OEV/Y
         7u410A4MEsEEJub1IKLFYreLfM+UbllFXcOlcmFncDWrt422K+qhAxFnMRdPNwn4VVbE
         8Dxg==
X-Gm-Message-State: AOAM532WXs6D6akH14DvMpnany1yHww2RpxT6xBqCxdo5EAFy6XIDl3O
        7F4dqZZOgcZgXUc6kp7O2Kg=
X-Google-Smtp-Source: ABdhPJy71ZdpBfF9NUMopXz8WNjxk40FSx6iYagIE9KHHij3vLBK71JeyUDcHvmRwLjZ+oTEhlfPiA==
X-Received: by 2002:a17:90a:9405:: with SMTP id r5mr11870057pjo.74.1597651803126;
        Mon, 17 Aug 2020 01:10:03 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id 77sm18499751pfx.85.2020.08.17.01.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:10:02 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, heiko@sntech.de,
        matthias.bgg@gmail.com
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        inux-mediatek@lists.infradead.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 01/19] crypto: amcc: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:39:23 +0530
Message-Id: <20200817080941.19227-2-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817080941.19227-1-allen.lkml@gmail.com>
References: <20200817080941.19227-1-allen.lkml@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/crypto/amcc/crypto4xx_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/amcc/crypto4xx_core.c b/drivers/crypto/amcc/crypto4xx_core.c
index 981de43ea5e2..3700446a99d8 100644
--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -1072,9 +1072,9 @@ static void crypto4xx_unregister_alg(struct crypto4xx_device *sec_dev)
 	}
 }
 
-static void crypto4xx_bh_tasklet_cb(unsigned long data)
+static void crypto4xx_bh_tasklet_cb(struct tasklet_struct *t)
 {
-	struct device *dev = (struct device *)data;
+	struct device *dev = from_tasklet(dev, t, tasklet);
 	struct crypto4xx_core_device *core_dev = dev_get_drvdata(dev);
 	struct pd_uinfo *pd_uinfo;
 	struct ce_pd *pd;
@@ -1452,8 +1452,7 @@ static int crypto4xx_probe(struct platform_device *ofdev)
 		goto err_build_sdr;
 
 	/* Init tasklet for bottom half processing */
-	tasklet_init(&core_dev->tasklet, crypto4xx_bh_tasklet_cb,
-		     (unsigned long) dev);
+	tasklet_setup(&core_dev->tasklet, crypto4xx_bh_tasklet_cb);
 
 	core_dev->dev->ce_base = of_iomap(ofdev->dev.of_node, 0);
 	if (!core_dev->dev->ce_base) {
-- 
2.17.1

