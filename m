Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB4BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44BDB20706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592873027;
	bh=aYy2UNwOd1hQi9e+H84dft4nx0pPPFXsEG7gx7BEz6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S/lJycD3gldtcq7zSrRLlYVtLXt7VJf8GRFSCNatduPfGkw7RN69vzNqflxLpWyGp
	 8KeHS+YtOFY42UtNPY6ZcZ7I3LHKsf1CPla5IbNKzEIYaqSu8aToCNzz+M23bhbE16
	 0Snbi0ccYUIM9qMFTn21IkT3621VFGeD84vJVZfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbgFWAni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:43:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732152AbgFWAng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:43:36 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3F2F20809;
        Tue, 23 Jun 2020 00:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592873015;
        bh=aYy2UNwOd1hQi9e+H84dft4nx0pPPFXsEG7gx7BEz6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CjbevtBI7iv9n/N0+qX3Voe44iKDfv6UzfDzaWq6rHngfC64szQOWLm+xsBAmmV6M
         SQ5rEdmZiRrk7lD3rqXY6eEhE6NX+bVCy3fi2OxGNPkrIoG/V78HUm3SjlEXKZ7Irj
         aZJUZ9RSlZ1f2fsgRlhrqONaV7LpiCDguJ1m0GR8=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/10] rculist: Add ASSERT_EXCLUSIVE_ACCESS() to __list_splice_init_rcu()
Date:   Mon, 22 Jun 2020 17:43:26 -0700
Message-Id: <20200623004333.27227-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

After the sync() in __list_splice_init_rcu(), there should be no
readers traversing the old list.  This commit therefore enlists the
help of KCSAN to verify this condition via a pair of calls to
ASSERT_EXCLUSIVE_ACCESS().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Marco Elver <elver@google.com>
---
 include/linux/rculist.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index df587d1..2ebd112 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -248,6 +248,8 @@ static inline void __list_splice_init_rcu(struct list_head *list,
 	 */
 
 	sync();
+	ASSERT_EXCLUSIVE_ACCESS(*first);
+	ASSERT_EXCLUSIVE_ACCESS(*last);
 
 	/*
 	 * Readers are finished with the source list, so perform splice.
-- 
2.9.5

