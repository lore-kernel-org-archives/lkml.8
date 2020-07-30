Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5346C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 03:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F8422C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 03:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="W34bhE3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgG3DCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 23:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgG3DCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 23:02:34 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287BCC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 20:02:33 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id d14so24354152qke.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 20:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X+qtJerENl+R3lIp2sk3UvcjK8RDOhGe6ueG91tUx9Q=;
        b=W34bhE3PYvBO+cD5maoCqKLyBwxlrKfZJWJmIXlwFAmV/Zz/HUQMlX/gSME1g5Vo/S
         gYgvR98W5uiqKvcPOdD1prpaq6BIsaAi6cLqrjmM6oWG5/zx7GvEgk3apmoNCFqLHOcs
         iJy+N5iXXdZVAzJqHnyTotST3uy+ty8sJT8sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+qtJerENl+R3lIp2sk3UvcjK8RDOhGe6ueG91tUx9Q=;
        b=d8X5CpgP5KS1WVLKEdMue/+qtyBq2nevbULSfc8xrBD+sb3E29Rg26beCagnBPY7H2
         hmsM554aEh8gCebk2OqH3cXghJqXTRkSL173kxjRFBMk/EH3so/OhMyrGk7sHDdINXLm
         uupUVFTgByYnAb5DsfQz+4x6sNnFNTOTRGMeHFjP6bEJxQX0ZEKcOkJGySq0iXzxILLo
         txaKgJmvO3viD9X8YUBSxkPiSBN4lG53xpIGd1Y3M+dlFu5U4CN+8hXup4ccxBPZaG6+
         HQ0x8D6OwVgeA34owJek/NAiLKK0tSKZEgw76K+nfPzY6Ss/2yyjVNdydQisK/ZUXpv1
         Vy+Q==
X-Gm-Message-State: AOAM532wB0Kjx1CBTJFWTHzzxAnkCbyPC9aRTW7xklKbPMlkCtKFrYJq
        YCA6LFJjgplveqcJ1AKCYFC6TuBZaB4=
X-Google-Smtp-Source: ABdhPJww1CYOHQZg3gqYgW/xhuEjY+TNk0Uptw6KHekHWei4FCKzbWk/J/943+pUJkiBhnACgWll2g==
X-Received: by 2002:a37:9507:: with SMTP id x7mr29285452qkd.253.1596078151592;
        Wed, 29 Jul 2020 20:02:31 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id f7sm3122044qkj.32.2020.07.29.20.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 20:02:31 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/2] rcu/tree: Clarify comments about FQS loop reporting quiescent states
Date:   Wed, 29 Jul 2020 23:02:21 -0400
Message-Id: <20200730030221.705255-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200730030221.705255-1-joel@joelfernandes.org>
References: <20200730030221.705255-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least since v4.19, the FQS loop no longer reports quiescent states
unless it is a dire situation where an offlined CPU failed to report
a quiescent state. Let us clarify the comment in rcu_gp_init() inorder
to keep the comment current.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1e51962b565b..929568ff5989 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1701,8 +1701,8 @@ static bool rcu_gp_init(void)
 
 	/*
 	 * Apply per-leaf buffered online and offline operations to the
-	 * rcu_node tree.  Note that this new grace period need not wait
-	 * for subsequent online CPUs, and that quiescent-state forcing
+	 * rcu_node tree.  Note that this new grace period need not wait for
+	 * subsequent online CPUs, and that RCU hooks in CPU offlining path
 	 * will handle subsequent offline CPUs.
 	 */
 	rcu_state.gp_state = RCU_GP_ONOFF;
-- 
2.28.0.rc0.142.g3c755180ce-goog

