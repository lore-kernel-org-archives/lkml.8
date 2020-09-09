Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274DBC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D015E2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="azshADfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgIJCeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730555AbgIJCcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:32:31 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF80C061385
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 16:44:35 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id r184so2364115qka.21
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 16:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1OQRbnpVQqbSHeNIDm4Hm9mK1gT2gj5RYSqpBEjn4gM=;
        b=azshADfVoWxyDpQuXUO3to8kiY9uHNIzQ57x8KjQIX+EK/Em5xQVxYtJPoEDS0aePD
         Y61/giUZ05cffykw283xaA3l6iWVCJg9wpB71S5nzH9EVlsB7DrwYd/1GbZ/6hqyy+aP
         V3CsVsXVhEhkNrcI6fwNQ8MdTXYqYu3mK8JIgFfSqFMjLHbltgP4QvmvdGhsb6hEmTat
         HpU4YccntOhHTahvRdzBbRxShPfV83u92ZPa5sdOLsdziXdRXd2FLqZ8tbj6J+BnKJxh
         1ZzYAG/BSCC00j0EQm3RdQEmkV8TCxNK7oGMetTxZt4LkGA2j5eaVT5Dc+FDNGRbc5iD
         dDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1OQRbnpVQqbSHeNIDm4Hm9mK1gT2gj5RYSqpBEjn4gM=;
        b=KY4tNW8cvFwh5zDyUjKEr8JPn+ADqd19OdOdDrADiwZGNeVi1aj6dD6ZrokVg0rE8K
         tkTMpfiCEzQiyw0RjIx99j0yxNJp1T9PVipSHoLYc3Fr2EJeD33kWmoJcTjSD7UYPCf7
         unj0mWPpWzDKHu9Z+dIN7F8t8CA29djT5C4ChgDvF5pwrBkRfOmodU4LpywYe/fV1OMc
         ohSfqSUA5B59UptM5oWgDCAhRX7HL3OOEBkH9gDvuRNxMmh9z5KgGx+wgsfGQ3PZ6MmV
         9RZGg4NB72s70HRLkOooRsKIRlOYx2wu3DkTKHzTTbrRJCxh/7MOZ/TduscGJV6WvWNZ
         3ctg==
X-Gm-Message-State: AOAM5333BM2p4S/0vWbXdRsa4JnkeTi+ZVNy+K4I7MYd2itgw5D3UZdQ
        1cyYUQR1zXnGG7hrwdjKo/JPqjPTubM=
X-Google-Smtp-Source: ABdhPJzRLKGMJkhtGLLHYN+CRFtSzCzysN6IpaLbffgbJgz/w24BGG12zL9AWcZQDiOos9PZsag2+r5yVUI=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:2d8e])
 (user=satyat job=sendgmr) by 2002:ad4:5565:: with SMTP id w5mr6354094qvy.24.1599695074759;
 Wed, 09 Sep 2020 16:44:34 -0700 (PDT)
Date:   Wed,  9 Sep 2020 23:44:22 +0000
In-Reply-To: <20200909234422.76194-1-satyat@google.com>
Message-Id: <20200909234422.76194-4-satyat@google.com>
Mime-Version: 1.0
References: <20200909234422.76194-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH 3/3] dm: enable may_passthrough_inline_crypto on some targets
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

dm-linear and dm-flakey obviously can pass through inline crypto support.

dm-zero should declare that it passes through inline crypto support, since
any reads from dm-zero should return zeroes, and blk-crypto should not
attempt to decrypt data returned from dm-zero.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 drivers/md/dm-flakey.c | 1 +
 drivers/md/dm-linear.c | 1 +
 drivers/md/dm-zero.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index a2cc9e45cbba..655286dacc35 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -253,6 +253,7 @@ static int flakey_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_discard_bios = 1;
 	ti->per_io_data_size = sizeof(struct per_bio_data);
 	ti->private = fc;
+	ti->may_passthrough_inline_crypto = true;
 	return 0;
 
 bad:
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index e1db43446327..6d81878e2ca8 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -62,6 +62,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_secure_erase_bios = 1;
 	ti->num_write_same_bios = 1;
 	ti->num_write_zeroes_bios = 1;
+	ti->may_passthrough_inline_crypto = true;
 	ti->private = lc;
 	return 0;
 
diff --git a/drivers/md/dm-zero.c b/drivers/md/dm-zero.c
index b65ca8dcfbdc..07e02f3a9cd1 100644
--- a/drivers/md/dm-zero.c
+++ b/drivers/md/dm-zero.c
@@ -26,6 +26,7 @@ static int zero_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	 * Silently drop discards, avoiding -EOPNOTSUPP.
 	 */
 	ti->num_discard_bios = 1;
+	ti->may_passthrough_inline_crypto = true;
 
 	return 0;
 }
-- 
2.28.0.618.gf4bc123cb7-goog

