Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CBCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACF12071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltsInCDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404238AbgAXUMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 15:12:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42062 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392047AbgAXUMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 15:12:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id q6so3477675wro.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 12:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rnZfmnfc0pdMs+T6EM9ZhemmIaH2rgKaKzRcGLzQZ9k=;
        b=ltsInCDhajaw66MUZMfK29p2YHPoXGir+AkvjRXvaYbKfOAvVWqTnG0EzcIeAv6KkX
         qIG1uW+vS30Jk4C4YKTyhMo+alYP+R5fGleQSuaPeIlPowqVM6vuwErPsKO3M+8e4rjG
         6iukxV9xtYnFadsiWs+aXn6QN1b7iRgLgkZsZ5Crzj6x+zm45o9PLzEpx7yxpV5pEU4g
         4HYkSSk63MnPpf4Snz2a5te87xRWkVaKzXjrDBnbH7pJSjKcSS2zk+kQq7O9x4+Hnr39
         57pHiEpzFH3ZTgMkLBuvfzNVz1y7kxZUczTWxtc5liUszmG68QnGGnoUmGZIcrUErJV4
         htYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rnZfmnfc0pdMs+T6EM9ZhemmIaH2rgKaKzRcGLzQZ9k=;
        b=lrWT7eAntGZsR6FcNZ6+kC8ec19C8NZtfokG5lYwqQ2FFBZouXac+r4dkUUy3Yrybj
         v29mUE1yBY3R8nN4Sihz0j8lGsmtrS4Bx9MsYl7TuFTseQl2f1t8X0MCZe20d/FMpJzn
         kvYpUJ5t+6q45e3Eux7xN9Nj34DbRlKR/5vnSX060gnha0HcdwpCEkh/8UDiytQ3XEbs
         /hglOEFJwAUriO9S2eU7gPukXV/GDt3uvpC34RN8SJElB6BHi8yxFWFZJZld3gwcEk5P
         /AZjTSxkBUFo1jBmp/E3vpca5EaoJcYwjH8q055ydsRSaIN5UBFKq5Iu8r55Hp0gOpKG
         Utxw==
X-Gm-Message-State: APjAAAUZqB4VYhMX04oV2PlnYg8K7YplJEoN7YZtFoLs+nXOH1Lm/gpX
        1XCOfP6KzWdYulJsfYrENw==
X-Google-Smtp-Source: APXvYqwOTzONn14SM5w9ztBXTXgDQSkFLvGviHhpNBxRuwSo8oJmTtzdwwQv2p1do/XofKhHAZGitw==
X-Received: by 2002:adf:dfc1:: with SMTP id q1mr6163608wrn.155.1579896755290;
        Fri, 24 Jan 2020 12:12:35 -0800 (PST)
Received: from ninjahub.lan (host-92-15-174-87.as43234.net. [92.15.174.87])
        by smtp.googlemail.com with ESMTPSA id i204sm6897654wma.44.2020.01.24.12.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 12:12:34 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mutex: Add missing annotations
Date:   Fri, 24 Jan 2020 20:12:20 +0000
Message-Id: <8e8d93ee2125c739caabe5986f40fa2156c8b4ce.1579893447.git.jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1579893447.git.jbi.octave@gmail.com>
References: <0/3> <cover.1579893447.git.jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports false warnings and hide real warnings
where mutex_lock() and mutex_unlock() are used within the kernel
An example is within the kernel cgroup files
where the below warnings are found
|warning: context imbalance in cgroup_lock_and_drain_offline()
| - wrong count at exit
|warning: context imbalance in cgroup_procs_write_finish()
|- wrong count at exit
|warning: context imbalance in cgroup_procs_write_start()
|- wrong count at exit.

To fix these,
an __acquires(lock) is added to mutex_lock() declaration
a __releases(lock) to mutex_unlock() declaration

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 include/linux/mutex.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index aca8f36dfac9..a8ab4029913e 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -162,7 +162,7 @@ do {									\
 } while (0)
 
 #else
-extern void mutex_lock(struct mutex *lock);
+extern void mutex_lock(struct mutex *lock) __acquires(lock);
 extern int __must_check mutex_lock_interruptible(struct mutex *lock);
 extern int __must_check mutex_lock_killable(struct mutex *lock);
 extern void mutex_lock_io(struct mutex *lock);
@@ -181,7 +181,7 @@ extern void mutex_lock_io(struct mutex *lock);
  * Returns 1 if the mutex has been acquired successfully, and 0 on contention.
  */
 extern int mutex_trylock(struct mutex *lock);
-extern void mutex_unlock(struct mutex *lock);
+extern void mutex_unlock(struct mutex *lock) __releases(lock);
 
 extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
 
-- 
2.24.1

