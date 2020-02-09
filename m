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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063ACC2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 22:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA49C2082E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 22:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbjrvTbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgBIWhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 17:37:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42816 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgBIWhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 17:37:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id k11so5212518wrd.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 14:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cXf+jO5ZWvRDTJhKr1qz8qqVWp2b4yTSloCOZU8N0tg=;
        b=jbjrvTbw0nT4sGncnqOXQKCdxOICymwt2izhEoqBuVUYQ3IvDTMFmKj1Hr2ihPIvYb
         wUI63snwMA4gz3cO/vPdlNajAn1MCJxhR25MzMUoz+rQqMZVyFJaWrM2G4ptB/4i3QCq
         J/u9fHGgY5r0dGymWmpvrRlc0FpgSifFRXfRXb01Fu7wf7mRj63Dep8OIHwwq2weQW0c
         WhMIoUvMrA668CFuP50GFzJJt48uRjMlm3Ndy+iDXpnHMN7fjfxg0I29VHbFfGQNKfdH
         zkycKaB471KxydxOW7m/VUP4QL7g7u+1YxvP8Xi/AjnpAI3tDWPUHJ02zIL/0XPGOeM9
         ud2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cXf+jO5ZWvRDTJhKr1qz8qqVWp2b4yTSloCOZU8N0tg=;
        b=cuupaX4aSC009DphNeWWcJCw5V4DUdtkCEiUY2xjwZel9DLMO4rk3vfvwDRzvEy/OT
         i0HWd1eMEEK+OBup8cEMHx7/grpWnXoByYCvcmmo2kAbey9OSZWL7wNwqlPETtiFt06t
         k9+luHlE3bBFCfJnbyZha94YHd6gnb8Q7/fOnS6kTrFWKFnn+c0UU2sxyyqXhXXPfD05
         N37xMGOAi+FHej6Ze/VBgHN9o73qenIBJKEHiJWWnwgbvBanHmWfdFUx0o/1o16SKPrt
         MgQGmo93reDUcUOnYpWE5hCVhZ6TxiEWmFpiUNvjOK/bVroKc4hpPOh73VAkkUzlJxBg
         /pTg==
X-Gm-Message-State: APjAAAXXgOyEFTuiZjM5F+o175/Gmyha0uALtb+3ycNoG90GsufywUX5
        9bu3kJHrz2m+WrHSdpulYg==
X-Google-Smtp-Source: APXvYqyVrbhbtg2eRMXa/GcyY3xAk8bq2xlHcQwP3BDcmQU0EqH21aELBnKDXAW8MDbOQp76B676jA==
X-Received: by 2002:adf:f302:: with SMTP id i2mr12809653wro.21.1581287872634;
        Sun, 09 Feb 2020 14:37:52 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id b18sm13643138wru.50.2020.02.09.14.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 14:37:52 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 05/11] sched/fair: Add missing annotation for nohz_newidle_balance()
Date:   Sun,  9 Feb 2020 22:37:39 +0000
Message-Id: <ca8c5c88a5882a4b7e243be73b4f0402e9da9cc2.1581282103.git.jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581282103.git.jbi.octave@gmail.com>
References: <0/11> <cover.1581282103.git.jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at nohz_newidle_balance()
warning: context imbalance in nohz_newidle_balance() - wrong count at exit
The root cause is a missing annotation

Add the missing __must_hold(this_rq->lock)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fe4e0d775375..81f8a440469a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10050,7 +10050,7 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 	return true;
 }
 
-static void nohz_newidle_balance(struct rq *this_rq)
+static void nohz_newidle_balance(struct rq *this_rq) __must_hold(&this_rq->lock)
 {
 	int this_cpu = this_rq->cpu;
 
-- 
2.24.1

