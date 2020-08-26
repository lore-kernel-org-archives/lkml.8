Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C73C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD5A206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K+PUZGRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgHZJTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbgHZJS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:18:58 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54396C061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:18:58 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so607740plt.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zVbq7zEl/VylsOkImAEnSsEooCYxqv16B/0RWDkhJE=;
        b=K+PUZGRMtL+WeKb15tJBnfkVOHrBfTwHgTsG6Vhq5aOYQ9VzlMP8bC3D4H9s9Vmnwr
         T9UbSHeZLvi2f0631yma1BoIk5JYO0ZMUMnnNgxwstvJPuxz6OXM3Zei5mB9fjd+8QXu
         tOQbQiebKGt/CBAaRYhsoaC02PXAPOJ+6bDTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zVbq7zEl/VylsOkImAEnSsEooCYxqv16B/0RWDkhJE=;
        b=VznhJ42ymTJMIDDvx6vWrhsyF4ubhmTChUU5f0yEn0gubvhS5iwjYHc1ijF8bAuPmo
         RD6dAZqhx3zD3EkQUEbmQSSG87ntSmPzOoXF1fa9IAvX7W4pPWTieXjIBXCP6ZzeInIl
         NloyzVqJm6uYsaYS35EuIjoKYy8kiKq3ag9yasExVRtUPdjUewIDWwDoUnk050MANlbw
         AMUVBJHzYBuEGp8bfOFoIvoXUacYiGJE4dyPuaZhrLDQeigXfVSt/Rfic/eS3UW5m1C2
         MU97g90qRBoOHo7mkFGESRluWOH60Ajk3QVlhTHeamPZ5d6/iucRzyKbgPUR0Og5n53F
         vjyg==
X-Gm-Message-State: AOAM533YaahNwLJDs3MRbRkDYyZ/+K3S6m5iuL6UroxEcc4ha8TFA6f6
        KrG99a/7/Ptm5ShLS4HWdsjETg==
X-Google-Smtp-Source: ABdhPJwmlAUvfRKgb9uu3liuf+trZDCW7x2GR14ieJBTwinOvb3MMKRDTkVHVMx+HWNAbWEyyr44TA==
X-Received: by 2002:a17:902:bb89:: with SMTP id m9mr7541350pls.108.1598433537693;
        Wed, 26 Aug 2020 02:18:57 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id t20sm1922270pgj.27.2020.08.26.02.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:18:57 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Bayi Cheng <bayi.cheng@mediatek.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH] spi: spi-mtk-nor: support standard spi properties
Date:   Wed, 26 Aug 2020 17:18:52 +0800
Message-Id: <20200826091852.519138-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use default supports_op() to support spi-[rt]x-bus-width properties.
And check dummy op's byte length instead of its bus width for output.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/spi/spi-mtk-nor.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index b08d8e9a8ee9..6e6ca2b8e6c8 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -211,25 +211,28 @@ static bool mtk_nor_supports_op(struct spi_mem *mem,
 	if (op->cmd.buswidth != 1)
 		return false;
 
-	/* DTR ops not supported. */
-	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
-		return false;
-	if (op->cmd.nbytes != 1)
-		return false;
-
 	if ((op->addr.nbytes == 3) || (op->addr.nbytes == 4)) {
-		if ((op->data.dir == SPI_MEM_DATA_IN) && mtk_nor_match_read(op))
-			return true;
-		else if (op->data.dir == SPI_MEM_DATA_OUT)
-			return (op->addr.buswidth == 1) &&
-			       (op->dummy.buswidth == 0) &&
-			       (op->data.buswidth == 1);
+		switch(op->data.dir) {
+		case SPI_MEM_DATA_IN:
+			if (!mtk_nor_match_read(op))
+				return false;
+			break;
+		case SPI_MEM_DATA_OUT:
+			if ((op->addr.buswidth != 1) ||
+			    (op->dummy.nbytes != 0) ||
+			    (op->data.buswidth != 1))
+				return false;
+			break;
+		default:
+			break;
+		}
 	}
 	len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
 	if ((len > MTK_NOR_PRG_MAX_SIZE) ||
 	    ((op->data.nbytes) && (len == MTK_NOR_PRG_MAX_SIZE)))
 		return false;
-	return true;
+
+	return spi_mem_default_supports_op(mem, op);
 }
 
 static void mtk_nor_setup_bus(struct mtk_nor *sp, const struct spi_mem_op *op)
-- 
2.28.0.297.g1956fa8f8d-goog

