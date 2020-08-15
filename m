Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC74BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC3692053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597529029;
	bh=RR8vpAJe95yICjOTWbJRmMXbXjVmhrK6B8p7jQvpcGA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=B+8OKyojHxuoIgUBWnAgQouzSd+Qfj20+L2fx8Ig0JGkq1yhDQSsStF2JPj+IgxvF
	 csBvUKio9DMTv1gE1ck7esOoxmLAvEiGoevb+Pa7+3gA5iu5rryb5wobLE9zlqV6zU
	 E6D09vAI0qF4icauoQfnpqvg7gP55I8f6r1jpEEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbgHOWDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbgHOVvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:10 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7DFC02B8D7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 04:13:29 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o18so12548679eje.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 04:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4ACFDihbhurDMLYhkZetXKBIk5H6sAegYTpSfKafOUo=;
        b=SnRnOYM3EeMhrQ2sr9Yl50V40LP3tsUHkKKwlWIK67CHT+1OihQI5m9lKA1D42aPy5
         9kllqkgMNfCveZeq1LqrcgENzFWsDe/pV+Gmj8LLFXpaBhCLkFgD4iWXzATE7nOMHvXx
         Q3raBFfDcuYdCw3ggQSvXWysGvlAaogozaL/YiPbmJL5fCVBQeAXrZHBO/F5/l+F7cI7
         UPimvN0HpYOmjbHeoRM3AJoYYjeKFvoX8cnR5AUfGaaXrJlC/y6WyQlMf3MGRQnHYqDg
         d/Y4UwG/As5CW9+8uTV2yXksJ/SLxU4y3tyszl9o2kw9ExBKTq4JYaH/yWN6kl5Re4rG
         PwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=4ACFDihbhurDMLYhkZetXKBIk5H6sAegYTpSfKafOUo=;
        b=RK7hnc6FRpnhSh45oo8G686rZnHsGRI81QV2PooZnoFH9FxQypYZBOzBcQ49/YG8+J
         2IRo5iyOZx/2gBGg9Oy1m8CvtrGNYjpD3ND2IPsqUTM8EZZupPF2Dc4dk4eCiAS6y9Bu
         hnYAu7TR3qN7UOiom89jOEGUKEQ0+QYByNSp8zjuWTROkhP6pfswOMA9VYjETgQCLMsq
         RwTmcvdbKi14gNoAhgd5hTTWYWHfLU0t6n7AacM0FOm2agXrhD9+t/sAPCkB1tDZlP8W
         S0htLEejxONRMYdCch1kx5GyCg0Xe2Vu0AILorAlGz/v83KBiylt7hJ3Z5Mc2tkfn4W4
         P2bA==
X-Gm-Message-State: AOAM531DUgepW/B3vz1Tgp6GfvwBc5zjiztvj+uoO2soEE7QwIZFcwII
        AVHUbjjGTAxL2NRfhFxhudw=
X-Google-Smtp-Source: ABdhPJwQ0RWmv8xiZJM3NoutaWIzuRWqM6Xky4WihS0f4wFonyRZNgR5TY0sHxGOvjqcMRTneLWsJw==
X-Received: by 2002:a17:906:85ce:: with SMTP id i14mr6825953ejy.318.1597490006889;
        Sat, 15 Aug 2020 04:13:26 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 89sm8649247ede.29.2020.08.15.04.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 04:13:26 -0700 (PDT)
Date:   Sat, 15 Aug 2020 13:13:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Subject: [GIT PULL] locking fixes
Message-ID: <20200815111323.GA2461929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-08-15

   # HEAD: 405fa8ac89e7aaa87282df659e525992f2639e76 futex: Convert to use the preferred 'fallthrough' macro

A documentation fix and a 'fallthrough' macro update.

 Thanks,

	Ingo

------------------>
Huang Shijie (1):
      Documentation/locking/locktypes: Fix a typo

Miaohe Lin (1):
      futex: Convert to use the preferred 'fallthrough' macro


 Documentation/locking/locktypes.rst | 2 +-
 kernel/futex.c                      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
index 1b577a8bf982..4cefed8048ca 100644
--- a/Documentation/locking/locktypes.rst
+++ b/Documentation/locking/locktypes.rst
@@ -10,7 +10,7 @@ Introduction
 ============
 
 The kernel provides a variety of locking primitives which can be divided
-into two categories:
+into three categories:
 
  - Sleeping locks
  - CPU local locks
diff --git a/kernel/futex.c b/kernel/futex.c
index 61e8153e6c76..a5876694a60e 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3744,12 +3744,12 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	switch (cmd) {
 	case FUTEX_WAIT:
 		val3 = FUTEX_BITSET_MATCH_ANY;
-		/* fall through */
+		fallthrough;
 	case FUTEX_WAIT_BITSET:
 		return futex_wait(uaddr, flags, val, timeout, val3);
 	case FUTEX_WAKE:
 		val3 = FUTEX_BITSET_MATCH_ANY;
-		/* fall through */
+		fallthrough;
 	case FUTEX_WAKE_BITSET:
 		return futex_wake(uaddr, flags, val, val3);
 	case FUTEX_REQUEUE:
