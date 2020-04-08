Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E32C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0ECF206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZhDpk9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgDHBk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:40:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43798 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726436AbgDHBkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 21:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586310024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fSQbrEAc+w70rT9qB0nDUcFBa4qHjfjCBhj2Rky49/o=;
        b=HZhDpk9rshQ3k2xMQGU3BjYCE1tGhC6fEHLJ1prJ1ujQrBpPTH+W/8SRnUfcpP5zJRrJXH
        v6sw/cS6K06PqRvuzUtqCeTyfwi5b4YYdvkW1hjDesSsIWsLPM7yPihVLbDNglCI3EODjH
        OTfSpIP72EXhzjHjGoJNa3gP6FZiiUY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-bHa42HK9PH-3ujoxNQ8rRQ-1; Tue, 07 Apr 2020 21:40:23 -0400
X-MC-Unique: bHa42HK9PH-3ujoxNQ8rRQ-1
Received: by mail-qt1-f197.google.com with SMTP id z5so5014396qtd.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 18:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fSQbrEAc+w70rT9qB0nDUcFBa4qHjfjCBhj2Rky49/o=;
        b=KVx/qsv95Qr7EA9+0Q5uumKlxEgysfmWiYyc28OiQX+m55o5ciNJP/kNdc1QWHnm+D
         4gajE7qbJmPqKlhBZL5xd7Fcn7fpQU/CyZ8PFLIj7HWt4y8bcm+aAkTh486/qU+Nlpk0
         sN6M58zMxrAQc9CIi7lv3WQnc/bproRBoBM9PUSXbhSRC5DQj4luVCK+bOJiYBgUPlUn
         DnpQ48+fWi6r+fc42kPOfMh4m/x7r0i/QNmHwQKlR24tCIUOLBEKz7UZI3VRMmwwBfg3
         Nkjhk8owIWVLKiMzEyciOJBGVfPuPLniyU1yBle6jcsjqywAdyzNGAwOBQePiMtKHxHX
         0hMw==
X-Gm-Message-State: AGi0PuYhxhvVl1Q9VPHovJMMeAZfUKGXJavrCR1+VG1nTcy4o8tGwVMh
        hlPN+8I13ueaJnqzoFK9KmFprLYJfvB7FzGvRVLZw0Tqwwjfkic3Cauf0/SMfTKqEEuoLSZTq8z
        UoxG7g+2+hePpwP0MdrwwfAsk
X-Received: by 2002:aed:3b4c:: with SMTP id q12mr5171839qte.18.1586310022101;
        Tue, 07 Apr 2020 18:40:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypKjaxC86ETeSiD0L0Kj0V5llgsE6iR778Jm5S9I3k5ubB9PlpALIp3ITqh0ujLQ2viwPE/E4Q==
X-Received: by 2002:aed:3b4c:: with SMTP id q12mr5171819qte.18.1586310021884;
        Tue, 07 Apr 2020 18:40:21 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::3])
        by smtp.gmail.com with ESMTPSA id x24sm6126607qth.80.2020.04.07.18.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 18:40:18 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        syzbot+a8c70b7f3579fc0587dc@syzkaller.appspotmail.com
Subject: [PATCH 2/2] mm/gup: Mark lock taken only after a successful retake
Date:   Tue,  7 Apr 2020 21:40:10 -0400
Message-Id: <20200408014010.80428-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200408014010.80428-1-peterx@redhat.com>
References: <20200408014010.80428-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's definitely incorrect to mark the lock as taken even if
down_read_killable() failed.  It's overlooked when we switched from
down_read() to down_read_killable() because down_read() won't fail
while down_read_killable() could.

Reported-by: syzbot+a8c70b7f3579fc0587dc@syzkaller.appspotmail.com
Fixes: 71335f37c5e8 ("mm/gup: allow to react to fatal signals")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index da3e03185144..1f9a9b3a5869 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1328,7 +1328,6 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 		if (fatal_signal_pending(current))
 			break;
 
-		*locked = 1;
 		ret = down_read_killable(&mm->mmap_sem);
 		if (ret) {
 			BUG_ON(ret > 0);
@@ -1337,6 +1336,7 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 			break;
 		}
 
+		*locked = 1;
 		ret = __get_user_pages(tsk, mm, start, 1, flags | FOLL_TRIED,
 				       pages, NULL, locked);
 		if (!*locked) {
-- 
2.24.1

