Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722D4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 480CA206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XqLHbguh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgHOV5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgHOVwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:09 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76624C061376
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:29 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cs12so5254396qvb.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G4c3X4fa7A0Cg+XAPQyHWHEQy+O3UWxNni7PmaUnDAE=;
        b=XqLHbguhqoEPspyNp4hmZ+InRFZrVuqPCt2M/ZX9lbgbDxd0fJ6lELOB9Tmfjw2e2i
         e0XlZUbVd6dwFw2bs6GxDj7WMO/UaAEg5ft9wK2nj1eo2zxgqEV5cbDnS/nRvDlqydjg
         Qv4DYyPVJ8b/lF6ofhoYpaJClXg4UUL24hlPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G4c3X4fa7A0Cg+XAPQyHWHEQy+O3UWxNni7PmaUnDAE=;
        b=DDqhDaL/VFOQpwCEF18NugGyzGFi/nRuYXa/e6FJzaNNR3O6MdhfszB37KVIOYXNFm
         7lIdTqvQ0F6iN4SeonuXdEuW2AxHvq5DtDr+F5R0XKSK5PlA5Xqo/7PkhIK/5sPvCqS2
         NdmXxiP93d6yjzq9W4EjM2ygq+nLGBu19p/8QiX3+w0he3RpcKWxph3BqENhgsKRKTay
         BKwFmA/Iu7ah+M7QtKPYg9XeYKc00aRUPF34iEpolP/y4i3Sf59SqhMe19eUmVHIojmg
         lLxvfkix7HHae87D1Wul3zp8D0gIJwLwcixi7Qi3fG4zprLlrFb9LXO9UpfPlYS3gf94
         GVQg==
X-Gm-Message-State: AOAM533Z+W5MogaYViIOZdTIP3srdJaMfLCYrNxZqqgN3EnlA3uUyiS5
        JQZv2tGTAlMOUVOvHAexkBmfize8rHBuRw==
X-Google-Smtp-Source: ABdhPJzgBZYN0xhpTnUF+ZBz4Y+fmBvhSdmjHQloeZ2QhjKhTWYaNaIClEUgvaSYopOkKJaHM/tUtQ==
X-Received: by 2002:a0c:99c8:: with SMTP id y8mr5477118qve.57.1597461568034;
        Fri, 14 Aug 2020 20:19:28 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id p12sm10055199qkk.118.2020.08.14.20.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 20:19:27 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        fweisbec@gmail.com, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH RFC 05/12] entry/idle: Enter and exit kernel protection during idle entry and exit
Date:   Fri, 14 Aug 2020 23:19:01 -0400
Message-Id: <20200815031908.1015049-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200815031908.1015049-1-joel@joelfernandes.org>
References: <20200815031908.1015049-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the generic_idle_{enter,exit} helper function added in
earlier patches to enter and exit kernel protection.

On exiting idle, protection will be reenabled.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/entry-common.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 2ea0e09b00d5..c833f2fda542 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -374,6 +374,9 @@ void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state);
  */
 static inline void generic_idle_enter(void)
 {
+	/* Entering idle ends the protected kernel region. */
+	sched_core_unsafe_exit();
+
 	rcu_idle_enter();
 }
 
@@ -383,6 +386,9 @@ static inline void generic_idle_enter(void)
 static inline void generic_idle_exit(void)
 {
 	rcu_idle_exit();
+
+	/* Exiting idle (re)starts the protected kernel region. */
+	sched_core_unsafe_enter();
 }
 
 #endif
-- 
2.28.0.220.ged08abb693-goog

