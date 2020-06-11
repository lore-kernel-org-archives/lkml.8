Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CC3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 05:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17ED72074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 05:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPc879Fn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgFKFpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 01:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgFKFpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 01:45:04 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41201C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 22:45:04 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y17so4737216wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 22:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CMSRdAMjqQ0hUIKg7+9PjXGS1txRLKEo1w8Yv1LWP4U=;
        b=RPc879FnDmXOmAiuG2ZiC2YAn/tFY+I56Ips0B76qiI4DawSzuLFJVbQq0JOYlQDvD
         QLujLY1XQ4R7Jo2IeeSNhcAYgf3KHPenlEC/nFdJIa9AoFcCBxo6ovQH8zm+bPeHfxFx
         Ia36NQzuV5x9wyHdewsXeQX2C1iAjxvRH5d+dcUdrkTKU5Wa2CLaXobq1J4sAnYghdwv
         cN1Knh+GBr2tfe99M45qIk5ozZq8B1Daw1dCXcbesgd3/OscMuvVXSbwvDpkVlMVWCIF
         nwS/J6EaUvJevLnehE9CPm8svB3JeptLEDquIukgcmT5DmpfSsppK5sv3tCRRfqxrYa0
         vg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CMSRdAMjqQ0hUIKg7+9PjXGS1txRLKEo1w8Yv1LWP4U=;
        b=W+XmNXWtWuW8rr7uROmDGlQztndGgBMHqQzKAx7MiBw0U7gC76rr+6RLPTiSi1BSF/
         /PAocoj2khv4MRYdz8pNe0wpBT4znjTezLXhfHz0fnocG6lvvleWBTesQ1Towb/82sMf
         0culi3KaTCa30KTIAAYnEerotQAkBdLjjeQeyhcP/9VVANXXru7DSYq9q+8nsTmszk1t
         ICs6ofrEGJkN+pK74u8SYYqc82qY6r8qtLkmh8mvWGhD0yH3bVN+qjfmRb9yEBoqjh2n
         Kh3Zxwvr0xdJG0ihHcFavXdvG5tBl1GJxfVbYogoL73YiCllJIAxXdx87nZW4D3w6vo6
         zQSw==
X-Gm-Message-State: AOAM531Jn9eFjjwLZvoCp5ZmY6MSEWg/e7sXyplR//WwSqMcWTk6mzsi
        nyQj+5UFQbvQDOQalS1DSjg=
X-Google-Smtp-Source: ABdhPJwiu6b2yxpfn7MNIZSUJW6IzfpHRnguKDTAPMNAkrUoYbMuKaWHiMGXorXYC42Gftp6XKv2Mw==
X-Received: by 2002:a5d:6a4b:: with SMTP id t11mr7404152wrw.404.1591854301729;
        Wed, 10 Jun 2020 22:45:01 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j16sm3492724wre.21.2020.06.10.22.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 22:45:01 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: [PATCH  1/2] mtd: rawnand: brcmnand: Don't default to edu transfer
Date:   Thu, 11 Jun 2020 01:44:53 -0400
Message-Id: <20200611054454.2547-1-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When flash-dma is absent do not default to using flash-edu.
Make sure flash-edu is enabled before setting EDU transfer
function.

Fixes: a5d53ad26a8b ("mtd: rawnand: brcmnand: Add support for flash-edu for dma transfers")
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 8f9ffb46a09f..0c1d6e543586 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2953,8 +2953,9 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 		if (ret < 0)
 			goto err;
 
-		/* set edu transfer function to call */
-		ctrl->dma_trans = brcmnand_edu_trans;
+		if (has_edu(ctrl))
+			/* set edu transfer function to call */
+			ctrl->dma_trans = brcmnand_edu_trans;
 	}
 
 	/* Disable automatic device ID config, direct addressing */
-- 
2.17.1

