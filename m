Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F73C35240
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 02:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586EC2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 02:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLQmbVVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgA0Caa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 21:30:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51814 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgA0Caa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 21:30:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id t23so5198321wmi.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 18:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+zOFTt6UKRgiZgbHNX0Ivyy+sSohBG1TI+SnAWAaAJw=;
        b=ZLQmbVVOX+wWSxd5zgYrUhLoO71FQItr6aD5ZRRdFcp7eDO87TGjDrUjmjfVz6uSje
         mFDet4aS2bAC3ZOf8y3v0jfAmKRE/lyD0i07Aq2qDvS26tw/QgHkIwTBB2xFgs4PhLT3
         8gspK/V7BNBqu5s0WBJms3lDP1xgwzvxBd15XDLOnuqVXlIXVM4Fmb4wu81gVSjFAvQN
         SW+CO9rpxqAs6haQVxQPmQpwdWzDUeDXDZg97jLFChntKJfi84XGKWOlj5aHTKLHwfk9
         wdm9HEyckea7mbypf71KmOzAuq3Nm9IEYCVqXZZqImnHmrrXocTrtwZb3MSsso+WVPv8
         r2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+zOFTt6UKRgiZgbHNX0Ivyy+sSohBG1TI+SnAWAaAJw=;
        b=M92ucVunxRnX+JI7qNKCTh4izkYtSLSZABDt7SlmlQIrWY8B0mdoA/cWKNYBSeHGef
         PDniXxqp+NNKoMNvsBuqkp6bh3eWGvWJ9MvaP7+0NyMTE8VAZr+28kGdJjQMAGd5zkD9
         NqwBODr8U9ygSj9SVHLTfKpKfn5nsyJsfwE16TkdvzT8U50OOjz7H/XsgEeJLfPRSXfk
         0tpxGpG/vaZnHgeQO62H2DRwUWQzORJLMZOK4Tzb4qUewVgeU/eCMNaBCL3XrKwaZLs5
         5rwfHkAvSdk+lVdLXqVKCe4NqMBUDKlXr1/RSA2TrsRgRJUFvSVGlAZROHZV/00/agLr
         ITMw==
X-Gm-Message-State: APjAAAVEvblpTNWJmkyfYe264gnBeEQWxOBSC098haMGwK16mRayTufJ
        BL+U3T9TB8peHQBOHAOo8g==
X-Google-Smtp-Source: APXvYqyZ3cw/Asv6sU6QeQUQ3Z99CdWeYNuAFKh0FcGiIyiL2h1lI2ko9t8GXaEh3fCfq6enF1gwVQ==
X-Received: by 2002:a05:600c:230d:: with SMTP id 13mr11553375wmo.12.1580092228714;
        Sun, 26 Jan 2020 18:30:28 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id k8sm18089458wrl.3.2020.01.26.18.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 18:30:28 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH v2 1/2] hrtimer: Add missing annotation to lock_hrtimer_base()
Date:   Mon, 27 Jan 2020 02:30:08 +0000
Message-Id: <20200127023008.87124-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
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

The root cause is a missing annotation of lock_hrtimer_base()
which also causes the "unexpected unlock" warnings.
To fix these,
an __acquires(timer) annotation is added to lock_hrtimer_base().
Given that lock_hrtimer_base() does actually call READ_ONCE(timer->base),
this fixes the warnings.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/time/hrtimer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 8de90ea31280..d149b599bdf7 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -157,9 +157,9 @@ static inline bool is_migration_base(struct hrtimer_clock_base *base)
  * possible to set timer->base = &migration_base and drop the lock: the timer
  * remains locked.
  */
-static
-struct hrtimer_clock_base *lock_hrtimer_base(const struct hrtimer *timer,
-					     unsigned long *flags)
+static struct hrtimer_clock_base *
+lock_hrtimer_base(const struct hrtimer *timer,
+		  unsigned long *flags) __acquires(timer)
 {
 	struct hrtimer_clock_base *base;
 
-- 
2.24.1

