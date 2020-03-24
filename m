Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9D0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B094620775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055668;
	bh=tIof/jlF4W0lxxddBY8yHhd6PhdVlYk1srdtJMcFEyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yIGoMrZjEWwV3sbFFsYLVyWmA6XUnXCCdYr+SHcrlRVVZg6WVJv7TDIUkLNNLiSAx
	 7KPxu9JOa0H1jqFHx2kIdMRY6OmRYUyyZGZ3FWk/A7Jzj143D+0FYMjGbNSywYDpef
	 2UJQk0dSE1vWXqvGCf03sWepB76R9Al6mX7a5hAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgCXNO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:32836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbgCXNOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:14:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9548A20775;
        Tue, 24 Mar 2020 13:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055665;
        bh=tIof/jlF4W0lxxddBY8yHhd6PhdVlYk1srdtJMcFEyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2l1J6MQY4f+GwOgQlRQi99tuzfVcOabOEKQ7qnrRYDhjPfRKES3KZeCL8tKOwAve8
         ivSa9NH4QPTiQK7OZDZRJVUFE8MBJ5Zq7LlVbdFtrF9aNzDJCs9D88QhQSkIYCz0R4
         5d3AMCGGjazcGxvlw/+XqRZ5scrsfycEH9Ta3aWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 48/65] mm: slub: be more careful about the double cmpxchg of freelist
Date:   Tue, 24 Mar 2020 14:11:09 +0100
Message-Id: <20200324130803.009089028@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130756.679112147@linuxfoundation.org>
References: <20200324130756.679112147@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 5076190daded2197f62fe92cf69674488be44175 upstream.

This is just a cleanup addition to Jann's fix to properly update the
transaction ID for the slub slowpath in commit fd4d9c7d0c71 ("mm: slub:
add missing TID bump..").

The transaction ID is what protects us against any concurrent accesses,
but we should really also make sure to make the 'freelist' comparison
itself always use the same freelist value that we then used as the new
next free pointer.

Jann points out that if we do all of this carefully, we could skip the
transaction ID update for all the paths that only remove entries from
the lists, and only update the TID when adding entries (to avoid the ABA
issue with cmpxchg and list handling re-adding a previously seen value).

But this patch just does the "make sure to cmpxchg the same value we
used" rather than then try to be clever.

Acked-by: Jann Horn <jannh@google.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/slub.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2926,11 +2926,13 @@ redo:
 	barrier();
 
 	if (likely(page == c->page)) {
-		set_freepointer(s, tail_obj, c->freelist);
+		void **freelist = READ_ONCE(c->freelist);
+
+		set_freepointer(s, tail_obj, freelist);
 
 		if (unlikely(!this_cpu_cmpxchg_double(
 				s->cpu_slab->freelist, s->cpu_slab->tid,
-				c->freelist, tid,
+				freelist, tid,
 				head, next_tid(tid)))) {
 
 			note_cmpxchg_failure("slab_free", s, tid);


