Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB5BC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B4A20737
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TVnoFVdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgDMKEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 06:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728140AbgDMKEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 06:04:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9453CC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:58:18 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o81so3266141wmo.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=KmcsA4T+S+WWzjH6BirzHHu1f070Cb4n75Vt4bzQ7mw=;
        b=TVnoFVdP7i6NzzFLwMjWxM3xlqFbcIBq1o9J7E/bTBQ0uzOW8+UegM9N09q07Gb8Pt
         MtHvv7jPmDm/EdqTc8LOg/VtKYICEGws/lMAkblH+kM813ZU0JoJaasghx3IwTGcKd0E
         42OvmNEcHZQ5VCaiHTIO84mRy6CrDZH8EYAeCVp6AgaElvoo718tEt+wJ/84V0XUhhxN
         f4duhfvRg/ia9fT3MeUk6BGznNj5Tixq/bRylfXGr/Iior1h1ImD3+qM5aYCgzxIx0Zi
         yW2DdRaVcQZ3x6NikAgM+x5H/bYYq4FjWTKQPFlyunUiyUqYCPVn2Bmk98TFUkVTHkTB
         0DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KmcsA4T+S+WWzjH6BirzHHu1f070Cb4n75Vt4bzQ7mw=;
        b=Rzwds2e1mW4LGNtE/n1VjlPi5/WNfzWQAnvOVeNIjoFdgvpUrxbF0FbZ/hH3EouF01
         EO5H9bBPrFMsvnEFPgW5Xp8CPK7EyDArRdSbu86WJfRZ40FxqC9U0IZIZTi3rY7K/hQQ
         K9iFus/Db0NgOwFemFkWsgDeUSJZDKg8aifLH9SKPqnl/HHmmNMPk8Rvdg9qit/7HdfP
         ajX0Ngfm8372VHWONkMGUZQnbVIJol2SAhzwMz5nNNZo3UBiwWgqgExRy/tGLZnJsGip
         n/AiXrhyjHOmE5acVNn5IATXkuiWHvptuLRkzmQkrZKZ2A7LhdPu623S8X/yJCbTqY7R
         zMIQ==
X-Gm-Message-State: AGi0PuYpsfigWyUJZ1pnOAUTbyOF49ctd9iXNw6r1qgSuJNHVfBfGAMy
        4gEiV6qOpB/Mk9AaCTOdoLYGOQ==
X-Google-Smtp-Source: APiQypJWhZgB3lIgt3ffPi7fAbvHp4h7OWcPtzktkowmrfegct/r94XOEfrUl2q5rZ1a2eCTjGu2EA==
X-Received: by 2002:a1c:7d15:: with SMTP id y21mr17172416wmc.57.1586771896214;
        Mon, 13 Apr 2020 02:58:16 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id v21sm13594491wmj.8.2020.04.13.02.58.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2020 02:58:15 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 0/9] crypto: sun8i-ce: support TRNG, PRNG and hashes
Date:   Mon, 13 Apr 2020 09:58:00 +0000
Message-Id: <1586771889-3299-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

The main goal of this serie is to add support for TRNG, PRNG and hashes
to the sun8i-ce.
The whole serie is tested with CRYPTO_EXTRA_TESTS enabled and loading
tcrypt.
The PRNG and TRNG are tested with rngtest.

Note that the first patch is common with the recent sun8i-ss PRNG+hashes serie.

Regards

Corentin Labbe (9):
  crypto: rng - add missing __crypto_rng_cast to the rng header
  crypto: sun8i-ce: move iv data to request context
  crypto: sun8i-ce: split into prepare/run/unprepare
  crypto: sun8i-ce: handle different error registers
  crypto: sun8i-ce: rename has_t_dlen_in_bytes to cipher_t_dlen_in_bytes
  crypto: sun8i-ce: support hash algorithms
  crypto: sun8i-ce: Add stat_bytes debugfs
  crypto: sun8i-ce: Add support for the PRNG
  crypto: sun8i-ce: Add support for the TRNG

 drivers/crypto/allwinner/Kconfig              |  26 ++
 drivers/crypto/allwinner/sun8i-ce/Makefile    |   3 +
 .../allwinner/sun8i-ce/sun8i-ce-cipher.c      |  99 ++++-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 365 ++++++++++++++-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 415 ++++++++++++++++++
 .../crypto/allwinner/sun8i-ce/sun8i-ce-prng.c | 191 ++++++++
 .../crypto/allwinner/sun8i-ce/sun8i-ce-trng.c | 123 ++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  | 135 +++++-
 include/crypto/rng.h                          |   5 +
 9 files changed, 1323 insertions(+), 39 deletions(-)
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c

-- 
2.24.1

