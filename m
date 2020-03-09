Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7BEC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D48120873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZTrZa0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgCIPKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:10:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33148 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgCIPKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:10:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id r7so229264wmg.0;
        Mon, 09 Mar 2020 08:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U+y57M/rwky9fHeiAUJqwYXLvMGk7Mr/fhYU7FCY2u8=;
        b=tZTrZa0oNuLyQv11zAAcrtq0grxpPYhp1zxIKI4a0VIs8CL8ZLdsS3z8zCRsAnfvD1
         Fh2B/GNWvhu4MK7xZI8iHZDz6EyMT2KsbATqZuuZEYSSzpf+uzf/dklsVS5ske/33bOU
         n03FPaEswHbiQ3crXKvQh17YXognajHPvTACDe/zyzsiwRIvJYpYLGLak4KiYjvei8nN
         89h4Gm7U67nwWgnmvW3mjBctNi2T6O5ECa+NfmmOZB+0QE4b+c3wLtyZ2uxUDNdHeZIl
         hbgEyUUIElBp2CPNd9z8RJejneRPkAfWYQTXZeOzbv4Tq2GSt6ttGxVeng+g0GPVvlU2
         gnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U+y57M/rwky9fHeiAUJqwYXLvMGk7Mr/fhYU7FCY2u8=;
        b=Fvwia3voDyRJL3jnRfcMfQ71KaVcnMqQoTfEair1gv5acR9YzZhMH1Z9BuR7y0K5Mc
         S7kSNq6xNoGLtOBjn9XsWYVjzksMtEZpLBMMyND9JSsR2Dfntqc55skdz9RWNDR8XBGg
         D857sPVn9RhABeJpNM5W6VN2auai48BtXU/eb3Y6gygbmCNTJGFS6SOsYGFsOjE6wVC1
         kQ0GqtjPPlAOoRq518Yv60cxgVqzksmBfnXoQi+9f7luppHTamIDEHLBTcDfIZHGGgSv
         n7jWsi3jU388PLCH74Vp7O6w45dkyzsZEEKKIQJGxKoUb1/JQBKj6npWNMQZDoRKAaTd
         bO/Q==
X-Gm-Message-State: ANhLgQ0S4M6LgmNOhzyDDryd7TFBucBCvdtkb2yAJcdxw3lGPygyPLRf
        BjkTbZDazExSP5j5VCtLwaPGJ1lu
X-Google-Smtp-Source: ADFU+vuIh8QwHVhJYbv7DsubaXn6DdBzZV5DDINm8Si5KimyjUsAHlSO6/pgcWLTb0gby2sl9svLyA==
X-Received: by 2002:a1c:ba85:: with SMTP id k127mr18161799wmf.63.1583766612973;
        Mon, 09 Mar 2020 08:10:12 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q7sm7969813wrd.54.2020.03.09.08.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2020 08:10:12 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: rockchip: add compatible string for px30 rk3308 rk3328
Date:   Mon,  9 Mar 2020 16:10:03 +0100
Message-Id: <20200309151004.7780-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip spi binding is updated to yaml and new models
were added. The spi on px30,rk3308 and rk3328 are the same as
other Rockchip based SoCs, so add compatible string for it.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/spi/spi-rockchip.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 2cc6d9951..70ef63e0b 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -843,14 +843,17 @@ static const struct dev_pm_ops rockchip_spi_pm = {
 };
 
 static const struct of_device_id rockchip_spi_dt_match[] = {
-	{ .compatible = "rockchip,rv1108-spi", },
+	{ .compatible = "rockchip,px30-spi", },
 	{ .compatible = "rockchip,rk3036-spi", },
 	{ .compatible = "rockchip,rk3066-spi", },
 	{ .compatible = "rockchip,rk3188-spi", },
 	{ .compatible = "rockchip,rk3228-spi", },
 	{ .compatible = "rockchip,rk3288-spi", },
+	{ .compatible = "rockchip,rk3308-spi", },
+	{ .compatible = "rockchip,rk3328-spi", },
 	{ .compatible = "rockchip,rk3368-spi", },
 	{ .compatible = "rockchip,rk3399-spi", },
+	{ .compatible = "rockchip,rv1108-spi", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, rockchip_spi_dt_match);
-- 
2.11.0

