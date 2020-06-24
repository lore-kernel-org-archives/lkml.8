Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC37C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149C520738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tjyu6khi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404692AbgFXQLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:11:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22963 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404235AbgFXQLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593015114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=A4jhzXNSNkKjQ25lQLNxsf4Iqa8gVw2wrfWG5+sE2n4=;
        b=Tjyu6khiIB8JvLvXk2iT1BnaqD3AJRVyvFsppg5kTpF5qgjsgQWCUC3sQ+YWmYcPOdhQxh
        lq8UT0QJXNU3m9gLgxnf4ONBaDasBnPL9qzQWR7ylH4C6rjCmWkj1eZh4Y591q/gHfhdtu
        pvWWn0ww22f0R/nnFJ+lVylSBXvj0ws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-E7mrOMq7NfyV6kkiRbCgKw-1; Wed, 24 Jun 2020 12:11:47 -0400
X-MC-Unique: E7mrOMq7NfyV6kkiRbCgKw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD5EA107ACCA;
        Wed, 24 Jun 2020 16:11:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.207])
        by smtp.corp.redhat.com (Postfix) with SMTP id 361373C6B;
        Wed, 24 Jun 2020 16:11:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 24 Jun 2020 18:11:45 +0200 (CEST)
Date:   Wed, 24 Jun 2020 18:11:42 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Lukas Czerner <lczerner@redhat.com>, linux-kernel@vger.kernel.org
Subject: wait_on_page_bit_common(TASK_KILLABLE, EXCLUSIVE) can miss wakeup?
Message-ID: <20200624161142.GA12184@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suppose that 2 threads T1 and T2 call __lock_page_killable() and sleep in
wait_on_page_bit_common() -> io_schedule().

T1 is killed, it does test_and_set_bit_lock() but the page is still locked.

unlock_page() calls __wake_up_common(nr_exclusive = 1), this wakes T1 up.
T2 is not woken.

T1 checks signal_pending_state() and returns EINTR.

T2 will sleep until another thread does lock/unlock ?

----------------------------------------------------------------------------
I noticed this by accident, I am hunting for another / unrelated bug. I did
git-blame and iiuc the commit a8b169afbf06a ("Avoid page waitqueue race leaving
possible page locker waiting") tried to fix the problem but see above, I don't
understand how can it help.

Don't we need something like below or I am totally confused?

Oleg.

--- x/mm/filemap.c
+++ x/mm/filemap.c
@@ -1131,14 +1131,23 @@ static inline int wait_on_page_bit_commo
 	wait_page.bit_nr = bit_nr;
 
 	for (;;) {
+		int intr = 0;
+
 		spin_lock_irq(&q->lock);
 
-		if (likely(list_empty(&wait->entry))) {
-			__add_wait_queue_entry_tail(q, wait);
-			SetPageWaiters(page);
-		}
+		// see the comment prepare_to_wait_event()
+		if (signal_pending_state(state, current)) {
+			list_del_init(&wait->entry);
+			intr = 1;
+		} else {
+			if (likely(list_empty(&wait->entry))) {
+				// HMM. head/tail depending on EXCLUSIVE ???
+				__add_wait_queue_entry_tail(q, wait);
+				SetPageWaiters(page);
+			}
 
-		set_current_state(state);
+			set_current_state(state);
+		}
 
 		spin_unlock_irq(&q->lock);
 
@@ -1146,7 +1155,7 @@ static inline int wait_on_page_bit_commo
 		if (behavior == DROP)
 			put_page(page);
 
-		if (likely(bit_is_set))
+		if (!intr && likely(bit_is_set))
 			io_schedule();
 
 		if (behavior == EXCLUSIVE) {
@@ -1157,7 +1166,7 @@ static inline int wait_on_page_bit_commo
 				break;
 		}
 
-		if (signal_pending_state(state, current)) {
+		if (intr) {
 			ret = -EINTR;
 			break;
 		}

