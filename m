Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC14C33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 20:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40117214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 20:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjJO5Fp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgAaUxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:53:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37287 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgAaUxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 15:53:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so10253501wru.4;
        Fri, 31 Jan 2020 12:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kc0XA6SZSs/HJu0wNbOJrCuXV3cTdtqeEXUQ4KwZ90g=;
        b=NjJO5Fp+P7xeOsfoZxq8mUANKUCyQc8YTKUBXLsuZ7TKBNygMhFEv2CYfDG/FLCY1S
         oGJl/pQs+nNvvn5AJr5La31KNonpK1UpGsPRJl2UMNGpNsBiOw503aqqtOcBRUwMfMLf
         /qrtwkP6rfX1NNYkyu+YCDAXhpNd2Aj2bKhULZiHkclX2QwkirX4lYdJ2/zqBr14KIW4
         o928iq4UnUtZbfnEBXOhTBvYdkdLtSfg66v3MCJb7bEhoHzOj9v9l2V6R5qrZGH57KkJ
         llr4oEWh7PeWOXSqUQioMovTAGRUojTguPH37o9GgsrsJ+REIDY/Tt0L9i9teRxbbY86
         lm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kc0XA6SZSs/HJu0wNbOJrCuXV3cTdtqeEXUQ4KwZ90g=;
        b=bP+2qaqhXOAtHM6ANRFqRVJ6/WyYhoTxKMPE2fsrfbZ8yL9ZIQdk57LW/j5ecWawwp
         pCXvMH0GvULezWjYtsinnmaBcB/5TWyQmo3le04QVmAZcyu+Zc8ODq06XauPYgAolhBo
         iZSxaucYlsJMwqK7HKK0nTdzttfMWlJ4zsafyIFNtQpIt59TS3E3rqudzg19fMNeEQR4
         wB7cnu+oAhyhnQZgxLxKXiK6jHQP0nmmnw6isHVWk47HVXn/bgYqKhG8IQ/KJpESuHNi
         m/wfOga1go8Dj9AbSDjWq+rc+W1mRzuVyDNVEMkaWuj/LDgQ+4KXmspFOUXsjX9zkTG5
         pS6w==
X-Gm-Message-State: APjAAAVwO68F7tWLRe40mBBVjW7+SxdLGSso0gw6Moquemn7zdsIsWfK
        wzQbC1QOW3YS9G50Ws1qPyU=
X-Google-Smtp-Source: APXvYqxKGp9UXIlImbtXXSIjDvf9DFoIBRt9HgHcSdse/qXtjz89OebU+jouTUzH/POw83+2Os+Kgw==
X-Received: by 2002:a05:6000:118e:: with SMTP id g14mr265423wrx.39.1580503977452;
        Fri, 31 Jan 2020 12:52:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:bcd7:b36c:40fc:d163])
        by smtp.gmail.com with ESMTPSA id z3sm13483738wrs.94.2020.01.31.12.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:52:56 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net, paulmck@kernel.org
Cc:     SeongJae Park <sjpark@amazon.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] Documentation/memory-barriers: Fix typos
Date:   Fri, 31 Jan 2020 21:52:37 +0100
Message-Id: <20200131205237.29535-6-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131205237.29535-1-sj38.park@gmail.com>
References: <20200131205237.29535-1-sj38.park@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/memory-barriers.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index ec3b5865c1be..01ab5e22b670 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -185,7 +185,7 @@ As a further example, consider this sequence of events:
 	===============	===============
 	{ A == 1, B == 2, C == 3, P == &A, Q == &C }
 	B = 4;		Q = P;
-	P = &B		D = *Q;
+	P = &B;		D = *Q;
 
 There is an obvious data dependency here, as the value loaded into D depends on
 the address retrieved from P by CPU 2.  At the end of the sequence, any of the
@@ -569,7 +569,7 @@ following sequence of events:
 	{ A == 1, B == 2, C == 3, P == &A, Q == &C }
 	B = 4;
 	<write barrier>
-	WRITE_ONCE(P, &B)
+	WRITE_ONCE(P, &B);
 			      Q = READ_ONCE(P);
 			      D = *Q;
 
@@ -1721,7 +1721,7 @@ of optimizations:
      and WRITE_ONCE() are more selective:  With READ_ONCE() and
      WRITE_ONCE(), the compiler need only forget the contents of the
      indicated memory locations, while with barrier() the compiler must
-     discard the value of all memory locations that it has currented
+     discard the value of all memory locations that it has currently
      cached in any machine registers.  Of course, the compiler must also
      respect the order in which the READ_ONCE()s and WRITE_ONCE()s occur,
      though the CPU of course need not do so.
@@ -1833,7 +1833,7 @@ Aside: In the case of data dependencies, the compiler would be expected
 to issue the loads in the correct order (eg. `a[b]` would have to load
 the value of b before loading a[b]), however there is no guarantee in
 the C specification that the compiler may not speculate the value of b
-(eg. is equal to 1) and load a before b (eg. tmp = a[1]; if (b != 1)
+(eg. is equal to 1) and load a[b] before b (eg. tmp = a[1]; if (b != 1)
 tmp = a[b]; ).  There is also the problem of a compiler reloading b after
 having loaded a[b], thus having a newer copy of b than a[b].  A consensus
 has not yet been reached about these problems, however the READ_ONCE()
-- 
2.17.1

