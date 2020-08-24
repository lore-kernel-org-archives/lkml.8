Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B7EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A17220706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgVeDome"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgHXWqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 18:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgHXWp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 18:45:59 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E02C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 15:45:59 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id y11so4659604qvl.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 15:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eAiEogNeolRoj2/VtKr8pVb7vPSSO2EkW9IVhYV3vjo=;
        b=YgVeDomeVr5sG7NWB5LRg75GNwmE+8AOdlkN6ZFMZJb4BxEGet2ceR5juK0V6jjbeR
         QD1xYb7GCdEYm42mNPZJcNUMt9v7S/Pu0W6fQkB0ggOJ+eJvY6XnLLB9ALn8TPvT5ZLb
         oKMlhHT7gL4rDvs9kJKuHpP7Po51wFHsjqDUn/ag4q+Uo5mHzNXHsEgLjfMdbbb5WBoB
         Ni6wrAE+EIa7RX23X2HNgIfw045lqpMZl40j5j9+DlVKIa7CEttk+u4FbmmQjB+cPNfF
         kCR5vpWpor9bMfK/1bS0+jzu6JdwaSoH8BnZYg88DfBPv5iHqhah+Tm7bIn0i5+f1qvT
         vz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eAiEogNeolRoj2/VtKr8pVb7vPSSO2EkW9IVhYV3vjo=;
        b=goBuc/wwbVds441c7KgK33WymIdvUbwmXdW0yITGwjGqImYjb63TWERQG47YXjdwy1
         A5Zoax1M7ZCrhsuID2+2yhEhMBAUWjKu9jG74rqfOrHzl4J9855xjKZzU+kBxC54+D02
         Yq6Bh37P2FVkjqK92Bj63P047YBJ6bDwpxaYcaJhSRjMmZjYva2oUrsE2c8jZs3K6x0B
         jRzAmYHgZxSY+WXQjjpe2GcG3dy+BrmPhwYKgb3AXYEIQxKYFdFakMx3wSekuNUD0RZ8
         n3hET/9IG6pizZdHCAnBSADGwMyXMMiKh707hpb6zi8zqD4bK9JncSLCsSPtBv8tOGkG
         gryQ==
X-Gm-Message-State: AOAM530loCGOIxJvumkhrcZdPnMDrXJEeGbz1t/nG4kp531Xa7KBAHdy
        c5jh7c9Q73m7CP+SsoXrk7Y=
X-Google-Smtp-Source: ABdhPJz9vCMVFc0A67rZn3gO+XapGv78ArS8GnlgkiZvXjrrLWmuQoS/DKcbg4Ac/+7E4eqhIols4w==
X-Received: by 2002:a0c:e8c9:: with SMTP id m9mr7160022qvo.178.1598309158933;
        Mon, 24 Aug 2020 15:45:58 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c100:b9d:e9aa:e42d:21e4:5150])
        by smtp.googlemail.com with ESMTPSA id t12sm10421258qkt.56.2020.08.24.15.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 15:45:58 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, ztong0001@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: ca0106: fix error code handling
Date:   Mon, 24 Aug 2020 18:45:41 -0400
Message-Id: <20200824224541.1260307-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_ca0106_spi_write() returns 1 on error, snd_ca0106_pcm_power_dac()
is returning the error code directly, and the caller is expecting an
negative error code

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 sound/pci/ca0106/ca0106_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index 70d775ff967e..c189f70c82cb 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -537,7 +537,8 @@ static int snd_ca0106_pcm_power_dac(struct snd_ca0106 *chip, int channel_id,
 		else
 			/* Power down */
 			chip->spi_dac_reg[reg] |= bit;
-		return snd_ca0106_spi_write(chip, chip->spi_dac_reg[reg]);
+		if (snd_ca0106_spi_write(chip, chip->spi_dac_reg[reg]) != 0)
+			return -ENXIO;
 	}
 	return 0;
 }
-- 
2.25.1

