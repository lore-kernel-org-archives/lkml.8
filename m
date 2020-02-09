Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF708C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 22:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B7220820
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 22:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ddg3KP5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBIW1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 17:27:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53833 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgBIW1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 17:27:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id s10so7832385wmh.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 14:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V7HZmuLvPAvtEVH2AwWm+lK2s0FBYOIIxH0tWrnWAKc=;
        b=Ddg3KP5stSjbjDtOlbs8qeRCNKC9Ip0dqBef1MwuZYKLuErXQVlBlxkocglhfStMf4
         IFqqzuuI4A63NCFbZFlxDIO7hp5HIuLVAW13ut7lbF9Ap3M4KoIfxBVIRTLqnCdNbHQ5
         A4BkL6Tsd18z26fT5ni59s2JEuJ8N2nGbVvHAr+3O4UJ+mZ6FB5AFnhrMsl6HXnMdgd4
         rDxuUY0XyRRUMLGJKzVwq9PH5C7W4r5p0nVlyV7/XlagDq3Pi4+GCa7gHqa0rz2Z10af
         x1qRgm0sf1gJzvo5FjE1ETOtDBDJ4sPLKSTvH+g9AUFHX1zCA28Tpa59huL8eFp1LkRB
         uDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V7HZmuLvPAvtEVH2AwWm+lK2s0FBYOIIxH0tWrnWAKc=;
        b=G1275yBMwK7FUV3eBr4yDbyul9vN9tgh6jIxMZWqK/mHWJNl3EwFvdc1o65aXMO8Mz
         bd5NODePMZnBKwEScsbPfUXbGGsV5LpaWEWAiOF97MDsod1Lwrzc371QEfM9djCHMvbf
         jyR9Hs++uV6Aim0DcIqrSDlszxJ2mpvwRTH+H66RrfIJV64wW2lv+Ekv+LAEVuk11DcL
         EUZNOSCAuXJZHa7ZT8hzjMVkKxqL3ItzJmHl2+oGWl9f/mpBODDVI/C8J8Bs56kpv0JQ
         KlL/89zTcQtHlCm8PsobC2X2CnhAXbfQRypZM6YmLwPa+hHwzXBVD5IF8TmN7snIPOdN
         TsxQ==
X-Gm-Message-State: APjAAAXVVutUPNtV46SmDUaV+RY/0bqcM0VzqyydR82dNB6mOnoW5/0G
        BhNQls2NozIkT17fbiKeaw==
X-Google-Smtp-Source: APXvYqzjJ3QQNrX7e8Q0wty3M8Z1UnusmGWcAwJtZkTMSrNSaNvfCbENrhGINg8yx45M2lFOCk7zMQ==
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr11873687wml.83.1581287233280;
        Sun, 09 Feb 2020 14:27:13 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id w1sm14314404wro.72.2020.02.09.14.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 14:27:12 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 01/11] hrtimer: Add missing annotation to lock_hrtimer_base()
Date:   Sun,  9 Feb 2020 22:27:04 +0000
Message-Id: <3532c7ba07ff3c855764ca6a4146bd2c49b22c0e.1581282103.git.jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581282103.git.jbi.octave@gmail.com>
References: <0/11> <cover.1581282103.git.jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports several warnings;
warning: context imbalance in lock_hrtimer_base() - wrong count at exit
warning: context imbalance in hrtimer_start_range_ns() - unexpected unlock
warning: context imbalance in hrtimer_try_to_cancel() - unexpected unlock
warning: context imbalance in __hrtimer_get_remaining() - unexpected unlock

The root cause is a missing annotation of lock_hrtimer_base() which
causes also the "unexpected unlock" warnings.

Add the missing __acquires(timer->base) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/time/hrtimer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3a609e7344f3..bb8340e2a3b9 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -160,6 +160,7 @@ static inline bool is_migration_base(struct hrtimer_clock_base *base)
 static
 struct hrtimer_clock_base *lock_hrtimer_base(const struct hrtimer *timer,
 					     unsigned long *flags)
+	__acquires(timer->base)
 {
 	struct hrtimer_clock_base *base;
 
-- 
2.24.1

