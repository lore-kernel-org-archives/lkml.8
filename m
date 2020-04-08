Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33304C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060E72082D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIhF4lRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgDHP7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:59:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31990 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730045AbgDHP7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586361573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Cv3Uc9k7RiYBuNJnamJbsFgYPRzsKo70MnUziLuuZdQ=;
        b=CIhF4lRnNCUitwSmA+z3sr89LKVm/jySzKCIbAhUJ1Z6cnuojdu/qlsX3V1DG+qqFS6ktb
        ghFIO5jGWjOwp20hDxJcDyszYK2MEM9pKUEGqWdGtpEWG8Jnu2W5ZpNgKQXttCKziOoR+N
        TIV+PfmXzCfynt7a0u/gCuIfeWV54XI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-Me-tmjjHPciFk-E9Thb-Rg-1; Wed, 08 Apr 2020 11:59:29 -0400
X-MC-Unique: Me-tmjjHPciFk-E9Thb-Rg-1
Received: by mail-wm1-f69.google.com with SMTP id u6so18710wmm.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 08:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cv3Uc9k7RiYBuNJnamJbsFgYPRzsKo70MnUziLuuZdQ=;
        b=WmVNz2Dcdfb8TNXwohA/ql35He8f0dBMjEYzgjw+fH+YX9wdhg+4AxbV7mmHKUXufW
         LrNWRnXjUWUD8Gk7WKUDLY/Kf1xD/DpQ9Nux4ztGEZ9bZpgVJ47gL/kWuR2p99E/vLN/
         2f302WOjzuhqi/3Rz4l4qxzeXA+ddmlNsZgQDV5IE0zOVrJ1cInRsNELToBHV14YBzo5
         qF+xgsicOQJhwkcJ9NfTDwa03N2Iutn0o0jEJAtk7RspmZNfUgdx0XBXPFRUTZUd0scI
         qxzYHfZJJt8eRhEYnsxGCE9J/ohmbonxg8H8qSExmR16epGabu1jv/LZ+h8piKzNCTYE
         lDQQ==
X-Gm-Message-State: AGi0Pub7psMH003vbrXjrVi3ahduVx6Ye7v/BiCJLNof5BtQg2OyaAXJ
        Rh7WiX/r/g7h8swrDut4joXs5g5p9wk4P4H4aN6LEzz5Tvof+WUe8Nt677ccoKDAwPOjn+Tavty
        r94Ao309vsfGdOi58d6bumalt
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr8478739wrm.33.1586361568685;
        Wed, 08 Apr 2020 08:59:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypJCu9BKLGk84AVscL0fKdbMzfDwWwkDvUB3DvqVVHDfVGxmDXVIvCJNVm8g5nLEPbtDXIKktQ==
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr8478726wrm.33.1586361568473;
        Wed, 08 Apr 2020 08:59:28 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::3])
        by smtp.gmail.com with ESMTPSA id p5sm38401663wrg.49.2020.04.08.08.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 08:59:27 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Hillf Danton <hdanton@sina.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+3be1a33f04dc782e9fd5@syzkaller.appspotmail.com,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm/gup: Let __get_user_pages_locked() return -EINTR for fatal signal
Date:   Wed,  8 Apr 2020 11:59:24 -0400
Message-Id: <20200408155924.107722-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hillf Danton <hdanton@sina.com>

__get_user_pages_locked() will return 0 instead of -EINTR after commit
4426e945df588 which added extra code to allow gup detect fatal signal
faster.  Restore that behavior.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 4426e945df58 ("mm/gup: allow VM_FAULT_RETRY for multiple times")
Reported-by: syzbot+3be1a33f04dc782e9fd5@syzkaller.appspotmail.com
Signed-off-by: Hillf Danton <hdanton@sina.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---

PS. Patch verified with syzbot.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index afce0bc47e70..6076df8e04a4 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1326,8 +1326,11 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 		 * start trying again otherwise it can loop forever.
 		 */
 
-		if (fatal_signal_pending(current))
+		if (fatal_signal_pending(current)) {
+			if (!pages_done)
+				pages_done = -EINTR;
 			break;
+		}
 
 		ret = down_read_killable(&mm->mmap_sem);
 		if (ret) {
-- 
2.24.1

