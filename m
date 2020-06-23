Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE0EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A12752078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nOg1elpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733050AbgFWQwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732940AbgFWQwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:52:49 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F96C061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:52:49 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id x18so24204443lji.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9eAoVwwU455W7Czxum9R509qblQHWN+bx3H+gQGOmvw=;
        b=nOg1elpgMjDnL2iUKJnVpDVctBW1jvhE72nBWtCOTXcRixhdoxgqpu23EPtJijz9Wz
         RM3TWym8YyqJtD77Ke3onfEX/7wwyzu348UkdvOS11RVeykvCmYfosMW4mNn5MjGeDj5
         qdfplHhOzj90GifR7zC1P71u46HgqJbl1ShYWUhCxFkCWgJcjyl5KidjfiBihz9YNO9w
         68zKO0VTcBu0H5WVPK17creR0T1vupxTz+4/QbYO/A54YEkfQxdRP53Bk9hPkc1gGg57
         6tVFhHqYnWoloJ5ORhKy+J9lZ2QhD8jcrdt84W/COE0amXGMNVI8pYEBiCJJNsPCWW0V
         c54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9eAoVwwU455W7Czxum9R509qblQHWN+bx3H+gQGOmvw=;
        b=A+7KcLd0t8m250cwflGx3m4qF2wwVnWsZEZv4gtbpKU1DCF7oDkAgzaZTc/LdEmDef
         qe5N3J13B2AIs2D9sdlEr5m37f1qYslBHd8WUvL+zWrWTO565EVFPRcUzYrDPZnEIGuD
         0ROBo7MCrTrzBFt3m9FJe60LsHaBvmbKTiTwyqbw9bOi2Rnv+nE9Samoo9Xmk/cxvT6L
         AdeXdFbtH/6OioMhD9c2epOA909EUIatRMNG/jcqYc9n9c5Kbj8G3bZNZtKKr9vnjXci
         X/4Be4fuYUTBSppL13/iqDGvFT51YPs0b+4k4l2bkWfnEZORIkkXCF3KIyIDArrjyArp
         rJ4w==
X-Gm-Message-State: AOAM531UaJQfJ3ggmfdRPKBSXYtMXUntKiwrOjqKgqQtSufSGvoYdLeB
        C4J3KBojwFuJh3uP7xs2kNKvtw==
X-Google-Smtp-Source: ABdhPJy5hnqphZVKvT4tjhqXiFArb8FWO5XWovl0z0bz4em/Ks3QTF0sE1lcBeYCa96oqq5SCFQkrg==
X-Received: by 2002:a2e:9a4d:: with SMTP id k13mr11631973ljj.43.1592931167616;
        Tue, 23 Jun 2020 09:52:47 -0700 (PDT)
Received: from localhost.localdomain (37-144-159-139.broadband.corbina.ru. [37.144.159.139])
        by smtp.googlemail.com with ESMTPSA id e13sm3405325ljo.6.2020.06.23.09.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 09:52:46 -0700 (PDT)
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@iki.fi,
        manivannan.sadhasivam@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, c.barrett@framos.com,
        a.brela@framos.com, peter.griffin@linaro.org,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Subject: [PATCH] media: i2c: imx290: replace msleep(10) with usleep_range(10000, 11000)
Date:   Tue, 23 Jun 2020 19:52:26 +0300
Message-Id: <20200623165226.12197-1-andrey.konovalov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes checkpatch warnings of "msleep < 20ms can sleep for up to 20ms".

Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
---
 drivers/media/i2c/imx290.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index 9c97830164e9..adcddf3204f7 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -406,7 +406,7 @@ static int imx290_set_register_array(struct imx290 *imx290,
 	}
 
 	/* Provide 10ms settle time */
-	msleep(10);
+	usleep_range(10000, 11000);
 
 	return 0;
 }
@@ -484,14 +484,14 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
 		if (ctrl->val) {
 			imx290_write_reg(imx290, IMX290_BLKLEVEL_LOW, 0x00);
 			imx290_write_reg(imx290, IMX290_BLKLEVEL_HIGH, 0x00);
-			msleep(10);
+			usleep_range(10000, 11000);
 			imx290_write_reg(imx290, IMX290_PGCTRL,
 					 (u8)(IMX290_PGCTRL_REGEN |
 					 IMX290_PGCTRL_THRU |
 					 IMX290_PGCTRL_MODE(ctrl->val)));
 		} else {
 			imx290_write_reg(imx290, IMX290_PGCTRL, 0x00);
-			msleep(10);
+			usleep_range(10000, 11000);
 			if (imx290->bpp == 10)
 				imx290_write_reg(imx290, IMX290_BLKLEVEL_LOW,
 						 0x3c);
-- 
2.17.1

