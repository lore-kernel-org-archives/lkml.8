Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0088C433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4D24229CA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753193;
	bh=Svt3QHf5poWXDrA1Oyizpu5gksOyZccShXbHmiBr1wU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EIwXmFKqIkBw783hFGLt3c+xikZTFqNxDTHBxz+d6VIHj0I6sApyvngQn3o7nImsp
	 3JXLHQPmgV/gVD53XEGGtSuQzbeD/q0Agq2IjKgxY/tZr1vUb3Czm6EBn9OZ6DBPy5
	 UXj88IGN4bpf+478EMGfLne5LFE9QF4l4vpAZdaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbgGNS7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:59:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731298AbgGNS7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:59:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8B5122507;
        Tue, 14 Jul 2020 18:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753186;
        bh=Svt3QHf5poWXDrA1Oyizpu5gksOyZccShXbHmiBr1wU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K2VbF/Qrj08GkW/IljDaeO3YNbtUwh2N6hVSduDG1k9vqsddbGoGcRQ0rhgMxyGT7
         qk8j9Clz7GwC6HidA6TiTeM278OzkVnN1bA/dQ9xkblTqt+DRY16+cUUY0o63hE4Hf
         Va7STUNHG9BLyuXkxOxu/qUC8whdxojpvfgzYHTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.7 125/166] io_uring: account user memory freed when exit has been queued
Date:   Tue, 14 Jul 2020 20:44:50 +0200
Message-Id: <20200714184121.818351741@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

commit 309fc03a3284af62eb6082fb60327045a1dabf57 upstream.

We currently account the memory after the exit work has been run, but
that leaves a gap where a process has closed its ring and until the
memory has been accounted as freed. If the memlocked ulimit is
borderline, then that can introduce spurious setup errors returning
-ENOMEM because the free work hasn't been run yet.

Account this as freed when we close the ring, as not to expose a tiny
gap where setting up a new ring can fail.

Fixes: 85faa7b8346e ("io_uring: punt final io_ring_ctx wait-and-free to workqueue")
Cc: stable@vger.kernel.org # v5.7
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/io_uring.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -7402,9 +7402,6 @@ static void io_ring_ctx_free(struct io_r
 	io_mem_free(ctx->sq_sqes);
 
 	percpu_ref_exit(&ctx->refs);
-	if (ctx->account_mem)
-		io_unaccount_mem(ctx->user,
-				ring_pages(ctx->sq_entries, ctx->cq_entries));
 	free_uid(ctx->user);
 	put_cred(ctx->creds);
 	kfree(ctx->completions);
@@ -7500,6 +7497,16 @@ static void io_ring_ctx_wait_and_kill(st
 	if (ctx->rings)
 		io_cqring_overflow_flush(ctx, true);
 	idr_for_each(&ctx->personality_idr, io_remove_personalities, ctx);
+
+	/*
+	 * Do this upfront, so we won't have a grace period where the ring
+	 * is closed but resources aren't reaped yet. This can cause
+	 * spurious failure in setting up a new ring.
+	 */
+	if (ctx->account_mem)
+		io_unaccount_mem(ctx->user,
+				ring_pages(ctx->sq_entries, ctx->cq_entries));
+
 	INIT_WORK(&ctx->exit_work, io_ring_exit_work);
 	queue_work(system_wq, &ctx->exit_work);
 }


