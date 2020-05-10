Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FA5C54E49
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 07:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE13C208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 07:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFU2fqIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgEJHXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 03:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725810AbgEJHXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 03:23:19 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E590C061A0C;
        Sun, 10 May 2020 00:23:18 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b8so2552760plm.11;
        Sun, 10 May 2020 00:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rXuAn4vRgKyVsbP7oi+rRm4HQNBEq5yx2hr95jLxTqw=;
        b=SFU2fqIbNks1QU6eM2sY0HOWiPJYN+Q2Lp74OvJ5Lz+MG+zyxzs/JGrQh3MdN+KyXU
         eRxv4O8J9GaksbPuGyKugLXqTxSa1QofxKnB5KkY97EvR8t2RYrLPtp3icmGduIqa3sG
         b113HbgmV3GYVN3hYeZa21d7mfOaTkA/s8gSR4uHJ1YUJ7XmPrLQ/V29DU9/6vAp55hs
         UI3jv21tpF8kGH5zKxQO7jZ/EtwrzmIWjLPNcKBOwkdF9Qe1rkk8+LvODkzNK2Ns/+Bj
         rOJcu+2VuYcmAx+fTdGkNaNTsjAsx+mtxyZo5GaCA424GVB2UZgZ1W+805kA7ZQ4UKoa
         bzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rXuAn4vRgKyVsbP7oi+rRm4HQNBEq5yx2hr95jLxTqw=;
        b=iDOGhTB3pQXDb9eHGyangOIWgSG4dDKQjU9XHsfLIcAzKn5lScXgP/pUmp9eiATkoe
         v964tylmvrs3lSG8kVZ1Ady/Ba58K0yTZ8PtxiJNBoLisIoGWLGT03ylFzi9jUaoc6xY
         8xFG6qvo3fAIsnyy+Z1bO8dyN4j2pino+gFfwbKcwxbn1Vwr4cZOpyJYsE9oTPfDvmfH
         5QlC23ycN1udgPNLI+mynS86kNjGJztfpBNm3LnJyne14s3nomC8wDyCS+JYhdTntSOd
         BpV8P7f3laSzcZBDd/5R6d9dPlyhMxXX3JI6ZNxlUbI3BESyBlVyUa8WUGXH4oFecakd
         4UMA==
X-Gm-Message-State: AGi0Pualph6NJeY9J1dZRLhHsb0VXmuPJzJGTetS9yrw7VQAWkxiC4le
        eabgMqvjkrCDSrFQ3h/L184=
X-Google-Smtp-Source: APiQypI9UEUDhYH4noIEJ6dWk6NCZdhE1sDVypm//DUOrTk7DiszHnqk35NvJ4Rps/qJ+XV+o5J3FQ==
X-Received: by 2002:a17:902:c50a:: with SMTP id o10mr9546886plx.187.1589095397572;
        Sun, 10 May 2020 00:23:17 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id e196sm6062982pfh.43.2020.05.10.00.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 00:23:17 -0700 (PDT)
Subject: [PATCH 1/3] tools/memory-model: Fix reference to litmus test in
 recipes.txt
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, vpillai@digitalocean.com,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>, linux-doc@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
 <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <5014c7f8-3a0b-e364-4c7a-bb03976e569f@gmail.com>
Date:   Sun, 10 May 2020 16:23:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From c171026a697d401ea5d2ad6656d0481944604b14 Mon Sep 17 00:00:00 2001
From: Akira Yokosawa <akiyks@gmail.com>
Date: Sun, 10 May 2020 13:37:14 +0900
Subject: [PATCH 1/3] tools/memory-model: Fix reference to litmus test in recipes.txt

The name of litmus test doesn't match the one described below.
Fix the name of litmus test.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 tools/memory-model/Documentation/recipes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
index 7fe8d7aa3029..63c4adfed884 100644
--- a/tools/memory-model/Documentation/recipes.txt
+++ b/tools/memory-model/Documentation/recipes.txt
@@ -126,7 +126,7 @@ However, it is not necessarily the case that accesses ordered by
 locking will be seen as ordered by CPUs not holding that lock.
 Consider this example:
 
-	/* See Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus. */
+	/* See Z6.0+pooncelock+pooncelock+pombonce.litmus. */
 	void CPU0(void)
 	{
 		spin_lock(&mylock);
-- 
2.17.1


