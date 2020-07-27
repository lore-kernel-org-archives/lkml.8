Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54D3C433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C9A20663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860100;
	bh=uz4e4AJkJbVasdh38UWCAAdt40jCQWdvIqlGIDUj+yQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B1NvSuXI0FLkk9mYXOx2I64Rc7pT47j7xv9hssyymOB3noAgF1Q0WLKnUlggNIBPb
	 LopaxH7A+NeBbkm+UZzEs82Qa4Ks3l7vFh7SggxmVTP37BbiHMS4V1xsCkV9XiNcYH
	 UfhiTKJ2p6G4RXQHCzsxB+rYKKEC0qDjtQu9320k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbgG0O2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732299AbgG0OYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:24:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 070B721883;
        Mon, 27 Jul 2020 14:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859876;
        bh=uz4e4AJkJbVasdh38UWCAAdt40jCQWdvIqlGIDUj+yQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ht+Xn13VwfDO9wGYlP5AxLyu6SYTZwkMSZK/7zB+sHEzzkpdxg1f6iV2xlkCQUjVo
         nt30RKx4aQiVavliVGvJ3ufqdupySOqvvupJ+3Qi90h4yLRY1AgseFLTVlusTzq6ib
         5tQQZFA1f5qc7tqSa/oNSLfDkVxYIO0byvEY1tqU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot <syzbot+1068f09c44d151250c33@syzkaller.appspotmail.com>,
        syzbot <syzbot+e5344baa319c9a96edec@syzkaller.appspotmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Michal Hocko <mhocko@suse.com>, Todd Kjos <tkjos@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 5.7 139/179] binder: Dont use mmput() from shrinker function.
Date:   Mon, 27 Jul 2020 16:05:14 +0200
Message-Id: <20200727134939.407104892@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
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
@@ -947,7 +947,7 @@ enum lru_status binder_alloc_free_page(s
 		trace_binder_unmap_user_end(alloc, index);
 	}
 	up_read(&mm->mmap_sem);
-	mmput(mm);
+	mmput_async(mm);
 
 	trace_binder_unmap_kernel_start(alloc, index);
 


