Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F37EC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 06:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7164D20773
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 06:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="pTi+8Lza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgCTG4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 02:56:08 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:40553 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgCTG4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 02:56:03 -0400
Received: by mail-qv1-f65.google.com with SMTP id cy12so2427307qvb.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 23:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+ruBW5svJNNwK4T7b3xChy9UrVEHEFAmhNhDXoWMas=;
        b=pTi+8LzaXbYs3NcLg4xVWXEHAL9IX0yIf9lreQDveNQ4bSrq0MscW4/7QgDD3uh0zg
         ErePlzUufo4lP4yOjUv4DUy74pcv56BHTiUn80LtQ142v30fAehrRYxhTOcO14ZqMIus
         w3YLPQCbSNpoV8cbe/hG6GL1gfRWkCFRH6x30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+ruBW5svJNNwK4T7b3xChy9UrVEHEFAmhNhDXoWMas=;
        b=fObjzLZtUvUXorGXdGumUlfhvWOsnfj6hUBMsI15oahz7BwNZvkWmuNF9GUFoebsTY
         ndR7TtKjEZJ/EnVuFyLfwBKsfyjDaCUF4k0Fu0hWQHHER5RyLComrbLxEiWVxMWeoKwS
         6KiD/Xf3zSsvCU9rZgRUxk+liJSaNmQNU4j2PNpfKwac6ZvMlca9wAHby0/VvLNum8bC
         Wk8yNV/+ochjlsvwoeXGPGhvoEdOWQmG+aPLrNnVMlZFwxM3ewi+ayxO4d+zph+2HiJd
         B1sdBMnUM+tqMqCiE/SgjKj3InnnkBzl/0xfAOHh3Ox5hbApi2ev4HaDZVZNW4w+GOEH
         OadA==
X-Gm-Message-State: ANhLgQ3ZvaLbQ1a/+1blyYti1qmu9/OGCGukjtIwYHMJXdVVh8Jw/3Vl
        e30Cc+Zbs2W+MMV2io/p0aoR4NQmfbs=
X-Google-Smtp-Source: ADFU+vvRPyWcUWODGO5eNkoJj05BokJuOxVUJV3+JfcFX1K7jPiU9mxjLxXe8jg8Hmr5JHstH1mFUw==
X-Received: by 2002:a05:6214:885:: with SMTP id cz5mr355723qvb.43.1584687362509;
        Thu, 19 Mar 2020 23:56:02 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m15sm419985qkk.26.2020.03.19.23.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 23:56:02 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 3/3] LKMM: Rename MP+onceassign+derefonce for better clarity
Date:   Fri, 20 Mar 2020 02:55:52 -0400
Message-Id: <20200320065552.253696-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200320065552.253696-1-joel@joelfernandes.org>
References: <20200320065552.253696-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better consistency with RCU examples, rename MP+onceassign+derefonce
to RCU+MP+onceassign+derefonce.

I plan to add more RCU related litmus tests, so we could use this
convention if that's Ok.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 ...sign+derefonce.litmus => RCU+MP+onceassign+derefonce.litmus} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename tools/memory-model/litmus-tests/{MP+onceassign+derefonce.litmus => RCU+MP+onceassign+derefonce.litmus} (94%)

diff --git a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus b/tools/memory-model/litmus-tests/RCU+MP+onceassign+derefonce.litmus
similarity index 94%
rename from tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
rename to tools/memory-model/litmus-tests/RCU+MP+onceassign+derefonce.litmus
index 97731b4bbdd8e..f9bfe0fd42e4d 100644
--- a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
+++ b/tools/memory-model/litmus-tests/RCU+MP+onceassign+derefonce.litmus
@@ -1,4 +1,4 @@
-C MP+onceassign+derefonce
+C RCU+MP+onceassign+derefonce
 
 (*
  * Result: Never
-- 
2.25.1.696.g5e7596f4ac-goog

