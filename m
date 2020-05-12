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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98915C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA4020673
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uc4IEDrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbgELPHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730516AbgELPHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:07:10 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B463C061A0C;
        Tue, 12 May 2020 08:07:10 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t7so5506144plr.0;
        Tue, 12 May 2020 08:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0TU9phia50Kr8gEoVpaq8VxyNOROUqRKj1SwNNfGXzs=;
        b=Uc4IEDrgeYoxV1CSYknk2emJMTMTKXaxReu0E7u/OI4G8D6QWf3lyX28PWWz4tp/Wz
         BPwi0f7zhZ6dj8M9UpaQqMtOPaUbmZrSlrTDV9KHAoQChtrP5/NbRJUgXOGM1OntaLDp
         3eSLRoAZBK+x+4Gn/4KVsITawEdevyMFGSgvY1ah8KGb3aBiY3/8Qol2JYeN755x/dY4
         4RAGK2cTxNuBeLWmjTYB160VlXUn0kgGRZS2HYRqriAF1dM87FvgSkOewuVKqcxjuUwC
         JU1NVWdFvOWOJtKFYAkP84LXxnjc4FgBXuFgTiMPGLNWFBfEIo2MtJwvxacme32Rh1VS
         2xsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0TU9phia50Kr8gEoVpaq8VxyNOROUqRKj1SwNNfGXzs=;
        b=JMbmeH4WJzdCU70jvSSTK8i9EWMRGpkRftDqL/Lii6cynmk/tY3GivWmltY0LCG6Ed
         z0p5xZKMMnRqZhw5p2xp9/2a/+r+KLss8Izl1VQI+AYD8MYeWQRqfvLEadsLmwXo5cwQ
         tzqrwJ1lSCyvi6/pvxRFU76y8NOlOFT8LTCjMxhF6RDsCWUsMbT7dG2MbVAaEwWMeM0P
         VHYQagtQvGv8EZYpChkT+fAa2fybaaQOjJa18zaAiyzRswprMoiJMPSc+3oos+0y6V2C
         9shblCBdxIAWAXRxB5YVJK1FYUGRox/z5eAKvHEstvvlYvUDNj0+SkqoCfQHC802YVna
         Qzcg==
X-Gm-Message-State: AGi0PuYHD60ekn2iovcqpO6UywzbwKAU/pQLVti2XRsWXtcPMGGvf87S
        /TJmjxq6ts6ZZPaHw4Zbytw=
X-Google-Smtp-Source: APiQypL/zzTYzH5hzP0Vw5PITnoYT7iA7U4N+8HllUIc6DhQQEx3VzprkUVrCNMQFbC/3uDm+k/GKA==
X-Received: by 2002:a17:90a:3a81:: with SMTP id b1mr28365385pjc.184.1589296029623;
        Tue, 12 May 2020 08:07:09 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id j13sm13353615pje.1.2020.05.12.08.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 08:07:09 -0700 (PDT)
Subject: [PATCH 4/3] docs: litmus-tests: Clarify about the RCU
 pre-initialization test
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
Message-ID: <fd7e7c6f-fda1-7f2b-19f3-a09b73b10de8@gmail.com>
Date:   Wed, 13 May 2020 00:07:04 +0900
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

From 7bb979aacd8788d174df8a56e9803ba9e5b7a381 Mon Sep 17 00:00:00 2001
From: Joel Fernandes (Google) <joel@joelfernandes.org>
Date: Mon, 11 May 2020 22:06:46 -0400
Subject: [PATCH 4/3] docs: litmus-tests: Clarify about the RCU pre-initialization test

Since this test returned to tools/memory-model/, make sure that it is
at least referenced from Documentation/litmus-tests/'s README.

Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Co-developed-by: Akira Yokosawa <akiyks@gmail.com>
[Alan: grammar nit]
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
I said in the earlier message:

> The explanation under tools/memory-model/litmus-tests/README also need the same
> rewording.

, but obviously I was confused. It is good as is.

This is on top of my earlier patch series.

Joel, Alan, does this work with you?

        Thanks, Akira
--
 Documentation/litmus-tests/README | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index ac0b270b456c..b79e640214b9 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -24,6 +24,10 @@ Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
 RCU (/rcu directory)
 --------------------
 
+MP+onceassign+derefonce.litmus (under tools/memory-model/litmus-tests/)
+    Demonstrates the use of rcu_assign_pointer() and rcu_dereference() to
+    ensure that an RCU reader will not see pre-initialization garbage.
+
 RCU+sync+read.litmus
 RCU+sync+free.litmus
     Both the above litmus tests demonstrate the RCU grace period guarantee
-- 
2.17.1


