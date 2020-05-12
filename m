Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7664C47077
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97CA720769
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Krg+XAix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbgELVg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728313AbgELVg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:36:27 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1175C061A0C;
        Tue, 12 May 2020 14:36:27 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 9so1233251pgr.3;
        Tue, 12 May 2020 14:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U6vUkzWvL2v9PNZQdqR96331DX3UQjvs2Ud55INrKsY=;
        b=Krg+XAix0HNFwdS873MeiTfVECj9XWXdQFPovt/trzuHXSz1Qjh3ib6lUWAot9Vmk2
         dlZAKbTyFIeoZ85o3YPZxuPEVuOpzNEVCzJL6l54idyRpURiJ3u25TI1fw5ael2DWXb0
         42C0LO9gbaUvWouqYb5LJ67i8Nv3SQV8zaWbGVK6TRieUxwNFk9D3TKorhD8h1SFt9jW
         Byy+NDDda0c849GLgfE9HYGhJyDz/6bRWzfUW8zUMMRq5zfooi4sJMEDXQ78i46KKvBC
         30VeV4tTXuo84JlK4NPBwH6A2pQqdulFZDVq8fMJXMLg+pVsu6PwxZT8H+UmCHqRp+/v
         5opQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U6vUkzWvL2v9PNZQdqR96331DX3UQjvs2Ud55INrKsY=;
        b=hKEBPIwVScOi38jPzhcGQ5gqHYm3G9GIAQzcZEFza9II+c9boOPmP/SxsHDb97Rz/f
         U4ppRkNszQ20y3xWW8P7Me/qnSKLjKbyfi0jhhEySP6JlwRTKxGydmCSl3U39t732ipO
         2T+5zwHspETqwxgLHkB766dzBctnbxQ66RRG2iumNLcvbpB6ORVDfc8zpbEaNXYAR2V0
         5dqzfNy/D96/U8OLw9X6QdiaXPGNFyN4aFvt7Q9LIcdlqAuCzNUie/dbVbL6qXjTlRDa
         xzjLbUvdHSeEO9Hm6DwZD4T23zQMOCNpGlSIV5i17e+KLcmy0V/DOk0c5GXTgMEOEjsz
         l3KQ==
X-Gm-Message-State: AGi0PuasovVTYggnWrxQsGlZn8m4LdIBQBL+ZB913BCUodyRZ2qhJZJF
        uLalDkg+8htpBwtRa4fLO0M=
X-Google-Smtp-Source: APiQypJXSjmUQiHjC8jmouuBKk1YDKTMhNUlGLGMylSMqjCjlw3xX30NZvdOd+SsuHjUUi3ERcYM1w==
X-Received: by 2002:a63:68c3:: with SMTP id d186mr21496722pgc.269.1589319387360;
        Tue, 12 May 2020 14:36:27 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id i18sm13578822pjx.33.2020.05.12.14.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 14:36:26 -0700 (PDT)
Subject: [PATCH RESEND 1/4] tools/memory-model: Fix reference to litmus test
 in recipes.txt
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
 <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
 <fd7e7c6f-fda1-7f2b-19f3-a09b73b10de8@gmail.com>
 <CAEXW_YSjo2hgvg-FN_MR7FVEcp-7gH17jb0-262k+ydSuuDjuQ@mail.gmail.com>
 <20200512163022.GI2869@paulmck-ThinkPad-P72>
 <09a8f418-0a46-87ea-dbdb-a43efc66476c@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <d2b38542-5681-a118-768c-f5985a479b6e@gmail.com>
Date:   Wed, 13 May 2020 06:36:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <09a8f418-0a46-87ea-dbdb-a43efc66476c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From f9aa6cde74b95cdaae67d484504c3dd69e8bc205 Mon Sep 17 00:00:00 2001
From: Akira Yokosawa <akiyks@gmail.com>
Date: Sun, 10 May 2020 13:37:14 +0900
Subject: [PATCH RESEND 1/4] tools/memory-model: Fix reference to litmus test in recipes.txt

The name of litmus test doesn't match the one described below.
Fix the name of litmus test.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
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


