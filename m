Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5294AC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A10D2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588339640;
	bh=baC/hUKXrxs/tjNcbhgr2gs9AikJqaDGQ8pWgO2QMMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jpqPiBvJ18+2RgUjqrcCp30ai8nI/p++Hhk4P62LRBJzryHJnWp8TZN+ugYndLbvN
	 wBW5E9TYpQ4bXZJEL/cso3JyFHqJNjURXHyIWKDfVhGg4Na8//Trt+RzMiIEdz/Iay
	 HJ9HfcUfrXKRlK/T5aWnf2KxYTKQHLvvL2AJR4gs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbgEAN1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729425AbgEAN1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:27:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73442208D6;
        Fri,  1 May 2020 13:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339632;
        bh=baC/hUKXrxs/tjNcbhgr2gs9AikJqaDGQ8pWgO2QMMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQbyZSMG6HqgvUIFrz/tGFufjuY5fNxaMAjjKJ/udNpgUJcccRb54QWmZAm4Qg8L7
         ks95qPcVzv5x3R9qVYDCL4zWxnlv4IdB4mm1TZASR7KYPddQweuA+z5s1Iw8oiuhxi
         +c7ZocvGu9569sxp1oE/MsiJgdppNY4mf0x3L+rU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 56/70] fuse: fix possibly missed wake-up after abort
Date:   Fri,  1 May 2020 15:21:44 +0200
Message-Id: <20200501131530.296926543@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131513.302599262@linuxfoundation.org>
References: <20200501131513.302599262@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

commit 2d84a2d19b6150c6dbac1e6ebad9c82e4c123772 upstream.

In current fuse_drop_waiting() implementation it's possible that
fuse_wait_aborted() will not be woken up in the unlikely case that
fuse_abort_conn() + fuse_wait_aborted() runs in between checking
fc->connected and calling atomic_dec(&fc->num_waiting).

Do the atomic_dec_and_test() unconditionally, which also provides the
necessary barrier against reordering with the fc->connected check.

The explicit smp_mb() in fuse_wait_aborted() is not actually needed, since
the spin_unlock() in fuse_abort_conn() provides the necessary RELEASE
barrier after resetting fc->connected.  However, this is not a performance
sensitive path, and adding the explicit barrier makes it easier to
document.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: b8f95e5d13f5 ("fuse: umount should wait for all requests")
Cc: <stable@vger.kernel.org> #v4.19
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/dev.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -145,9 +145,13 @@ static bool fuse_block_alloc(struct fuse
 
 static void fuse_drop_waiting(struct fuse_conn *fc)
 {
-	if (fc->connected) {
-		atomic_dec(&fc->num_waiting);
-	} else if (atomic_dec_and_test(&fc->num_waiting)) {
+	/*
+	 * lockess check of fc->connected is okay, because atomic_dec_and_test()
+	 * provides a memory barrier mached with the one in fuse_wait_aborted()
+	 * to ensure no wake-up is missed.
+	 */
+	if (atomic_dec_and_test(&fc->num_waiting) &&
+	    !READ_ONCE(fc->connected)) {
 		/* wake up aborters */
 		wake_up_all(&fc->blocked_waitq);
 	}
@@ -2222,6 +2226,8 @@ EXPORT_SYMBOL_GPL(fuse_abort_conn);
 
 void fuse_wait_aborted(struct fuse_conn *fc)
 {
+	/* matches implicit memory barrier in fuse_drop_waiting() */
+	smp_mb();
 	wait_event(fc->blocked_waitq, atomic_read(&fc->num_waiting) == 0);
 }
 


