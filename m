Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC98C433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D710F21744
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859100;
	bh=QZVW5a1aE5FbLe9+ltNBnDpgn0AHKSmS9TQ8jjloP9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f0eMftzklN/vrivRYQqmDfNthjNaWhzeRJVfrkfEC31A9ZUqbcwazL3SSbKmT8ybp
	 oL1WrILlaUadZDW03AcVMQ5Yptkm+K1VoESZS8eiuqOi8KeHi8ONkFbkS5gEZU40D/
	 AFt1jMjleJGzusdq1vlwBk7qJ3KBYqnHnvYBEoms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgG0OLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:11:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730026AbgG0OLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:11:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4237420838;
        Mon, 27 Jul 2020 14:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859091;
        bh=QZVW5a1aE5FbLe9+ltNBnDpgn0AHKSmS9TQ8jjloP9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqbg/9CRN6SWcZKc0KIWyr90rWj0QkFlm7ctQyUn4omFGgVEs83RS/AyrVXUaEkYE
         kBHwR1YylpzMRp6ezTz5jMdGd6Yh54WzSR05rqs1PAF7vZceV/B13mgQ+xR0RPuCck
         Q+5xWAYFr3AYws7eDQG7xBspZaEs0K9Nm9b8wZhU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot <syzbot+1068f09c44d151250c33@syzkaller.appspotmail.com>,
        syzbot <syzbot+e5344baa319c9a96edec@syzkaller.appspotmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Michal Hocko <mhocko@suse.com>, Todd Kjos <tkjos@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 4.19 61/86] binder: Dont use mmput() from shrinker function.
Date:   Mon, 27 Jul 2020 16:04:35 +0200
Message-Id: <20200727134917.494599997@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134914.312934924@linuxfoundation.org>
References: <20200727134914.312934924@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>

commit f867c771f98891841c217fa8459244ed0dd28921 upstream.

syzbot is reporting that mmput() from shrinker function has a risk of
deadlock [1], for delayed_uprobe_add() from update_ref_ctr() calls
kzalloc(GFP_KERNEL) with delayed_uprobe_lock held, and
uprobe_clear_state() from __mmput() also holds delayed_uprobe_lock.

Commit a1b2289cef92ef0e ("android: binder: drop lru lock in isolate
callback") replaced mmput() with mmput_async() in order to avoid sleeping
with spinlock held. But this patch replaces mmput() with mmput_async() in
order not to start __mmput() from shrinker context.

[1] https://syzkaller.appspot.com/bug?id=bc9e7303f537c41b2b0cc2dfcea3fc42964c2d45

Reported-by: syzbot <syzbot+1068f09c44d151250c33@syzkaller.appspotmail.com>
Reported-by: syzbot <syzbot+e5344baa319c9a96edec@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Michal Hocko <mhocko@suse.com>
Acked-by: Todd Kjos <tkjos@google.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/4ba9adb2-43f5-2de0-22de-f6075c1fab50@i-love.sakura.ne.jp
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder_alloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -987,7 +987,7 @@ enum lru_status binder_alloc_free_page(s
 		trace_binder_unmap_user_end(alloc, index);
 	}
 	up_read(&mm->mmap_sem);
-	mmput(mm);
+	mmput_async(mm);
 
 	trace_binder_unmap_kernel_start(alloc, index);
 


