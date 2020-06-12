Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C660C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F4B20663
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgiE7Yxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgFLV30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 17:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgFLV3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 17:29:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D71C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 14:29:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q11so11399177wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 14:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CMSRdAMjqQ0hUIKg7+9PjXGS1txRLKEo1w8Yv1LWP4U=;
        b=sgiE7Yxvxl9Y4Ht4Q2v4oPYkEK0Fz7gmbTbu2x+0VwWkT/K/4p2dxYX7VhNh8hUVBA
         Oz/l6pMJiXtm4wbmZgJnDpBgP0urRmoMv3VUdADKZZGhBnGnh8i3yOSXXZSmtYpicVeX
         yCKhHihBQAua3m8VhYbr+dpuccfVP3MSR9axQu9Z2RigKYwKhYxB5FjO3nfuHrD4vvgz
         aIyHvaJEr2pc2bS+Rivuo7A0E0mYiqlxFUsMw0Yw6yNa9O/K7xr7l4R/s8iYlP0QeYtY
         kLnAG6JqtsTt2lX/JhBwTBepzmeWIxblqFc8hp8QmLfXnWi7U4QmpWKTSzgdoAx3VBui
         KlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CMSRdAMjqQ0hUIKg7+9PjXGS1txRLKEo1w8Yv1LWP4U=;
        b=rXTmKcrNzqmhbQcSPDepjODr+fCVP4z0Xtom1X19Zb8sU0afZlRNdH7vCBaccADRfS
         dTcOTjfHyaXGxpZAogrX629HdFv12xN/4x1Ypywj/tlM/g0e2MPVn+YhcBR+S3inh6K8
         KvFE/vPyjzkhn0F01D3NP1EWG/w2L7r/XFirwt6m8NugnG3iWSh8o4Trw7zeEbt1KrG4
         7tXQkYBQYlkJW/3A9+//JXxwiPW3prVy1YOe8Hdt2xHhJQzsQ9WZLarnISEXOTjOEKhb
         fX+ez8F/UXUdd3BjepTIXbBOpDOBCglXqAK8S69rZxrCzAJGK0ZOFOD7t4PGKAFTU4og
         eAvA==
X-Gm-Message-State: AOAM530i0biCS1HN2XImBOKxQACnApgWS26E69at7pp7rFeYMdnXl2z4
        qBywG/qOxM5uY8hBW6uupkc=
X-Google-Smtp-Source: ABdhPJyv5GIgPQ9eO6QSupsEk8hcs6qEXOwQe2ngWetm4fbiOaRcihoSEmG/ke54phMF/9AmFY5C4g==
X-Received: by 2002:adf:a34d:: with SMTP id d13mr16218472wrb.270.1591997363791;
        Fri, 12 Jun 2020 14:29:23 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id n189sm10442048wmb.43.2020.06.12.14.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 14:29:23 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     computersforpeace@gmail.com, kdasu.kdev@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mtd: rawnand: brcmnand: Don't default to edu transfer
Date:   Fri, 12 Jun 2020 17:29:01 -0400
Message-Id: <20200612212902.21347-2-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612212902.21347-1-kdasu.kdev@gmail.com>
References: <20200612212902.21347-1-kdasu.kdev@gmail.com>
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

