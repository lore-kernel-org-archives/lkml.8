Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377EAC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3D12082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="e6+c4MRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgBJOp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:45:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37362 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbgBJOp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:45:29 -0500
Received: by mail-pg1-f193.google.com with SMTP id z12so4033585pgl.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 06:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AoC6oLn1iN9nAEM4B11m4EnisMnCyq2bdXkwzvNp36c=;
        b=e6+c4MRotQlIlu/VHkezDMBYJX1/ZntF5pE9VwiOcSLxcpPcryDxRTgwjK/ptX2sZv
         LBDhDetYzW+4Z4d8dGkJzlA2TwdJotNQCxS2fQCHayLykVo8l3wAY0o2ATl9Y9g+3AOk
         kQ1/uD4zYT0qz6DR3jwmGqIvwE3t+i9kjfhe6aEXTAWzGd3RWJI9OjNNGU3O2clJ596g
         ArbvoO0mrJfcZc39E+qoUSnlcy08ENMtwhGnSWT+RZuAmUHnwYD1ldGQIdOVhHzaf2rb
         lBtrI7M1fKmSme3mrpABjmQwDIHrcYBovYaCkck2Ai7dcoaE0YeLFxZdo9f3ybZ4biRV
         IfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AoC6oLn1iN9nAEM4B11m4EnisMnCyq2bdXkwzvNp36c=;
        b=JrzJhiBWImtQmilwvXY8jYAQk0Y7/5/Mm2JDNGQ2RW6mcYLPyLUG1JNqSzE3pmAzya
         9D/U35VcBPKctJV4Xigw0HiSQB7LNyG5ij6A1wZU5hYE8HVuUP+ZDm6zR4Y3p1lI0X1w
         LiU++wAqmTDg0/XQLNt+HE3Z+or5P1SMksM48iRvFjX7sOcP+IIYNQ6wsde1aCOwYUfM
         uh+exc6ZPOQf/TC3IPAe2j7p6TZHovWM1T7muCAokTdISwrojUNF/D711KZdEztKSl6j
         gFjRHqEd17YGkdt7cGqQKyP1WiQJ5gYTotbCi9SM/DAVJlzIBhnyopDxEHYnTJoPBDCm
         x7Jg==
X-Gm-Message-State: APjAAAXIIWWWrzfqF/5OA8a6ArlLvfYrI587FBtz0b3U05EOTpaBBvR3
        6bISON6XdU1a81+G2TshgVjU/RgJx5g=
X-Google-Smtp-Source: APXvYqy56C+LYN/F5dUKKelbs886mNzI9yqb6YM3uacrsLXpoxwP4uDXYx/soWzP+PzK+jDRnMeuJA==
X-Received: by 2002:a65:420b:: with SMTP id c11mr2013833pgq.306.1581345926732;
        Mon, 10 Feb 2020 06:45:26 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id dw10sm552079pjb.11.2020.02.10.06.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 06:45:26 -0800 (PST)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>
Subject: [PATCH 0/4 v2] random add rng-seed to command line option
Date:   Mon, 10 Feb 2020 06:45:01 -0800
Message-Id: <20200210144512.180348-1-salyzyn@android.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A followup to commit 428826f5358c922dc378830a1717b682c0823160
("fdt: add support for rng-seed") to extend what was started
with Open Firmware (OF or Device Tree) parsing, but also add
it to the command line.

If CONFIG_RANDOM_TRUST_BOOTLOADER is set, then feed the rng-seed
command line option length as added trusted entropy.

Always erase all views of the rng-seed option, except early command
line parsing, to prevent leakage to applications or modules, to
eliminate any attack vector.

It is preferred to add rng-seed to the Device Tree, but some
platforms do not have this option, so this adds the ability to
provide some command-line-limited data to the entropy through this
alternate mechanism.  Expect on average 6 bits of useful entropy
per character.

Mark Salyzyn (4):
  init: move string constants to __initconst section
  init: boot_command_line can be truncated
  random: rng-seed source is utf-8
  random: add rng-seed= command line option

---
v2
- Split into four bite sized patches.
- Correct spelling in commit message.
- rng-seed is assumed to be utf-8, so correct both to 6 bits/character
  of collected entropy.
- Move entropy collection to a static __always_inline helper function.

 drivers/char/random.c  |  10 +++-
 include/linux/random.h |   5 ++
 init/main.c            | 115 ++++++++++++++++++++++++++++++-----------
 3 files changed, 100 insertions(+), 30 deletions(-)

-- 
2.25.0.341.g760bfbb309-goog

