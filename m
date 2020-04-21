Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66036C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 428A32087E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587453048;
	bh=lNgEaZxNejWIBwTEJxrr4EG2M64IjFtLiENRrWuEaMk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=alQ5wxarg59LahnPSnmWLhuqgHDBppVDwt10HJRBPRLyCRQFrue59jVfiMQIrQ7Fi
	 QLCNQ/bT9h5dnmUD2SwK2vHHnB8hdqHK/BMoeWoe5Zmn3eKV0lUWFse/dvMa2CIbY7
	 Jn6CY9jwYesOq+yQy9J4sKsNRfBNgKd+DHwzvx7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgDUHKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:10:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39748 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgDUHKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:10:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id y24so2385754wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JMtPWfIs1hGyzMK76ejFzPGEE/vds8F5cuAAiHiSdag=;
        b=dt5UtO7fRc/tLat2D7UhYst76cf9sOrfHRbrxvRb8oq7rX3ZiIepepiRuY/g5LN7YB
         +SbboZldpw99rtbUp88L8npIpqQkb+j0waTEL7hycm+FugnBJaVeE1L3ol3CzulJiMC0
         HCdqhLsz8LCsVPVi86I0NKHdH3SqHVaHFERMekizZk0LqUx3ED1DEmjiR9dYEBodvJv5
         nTBFlYRLgvGBN+oPK4j+8nHbUwWMFfxAJImYaJ7byh9k6dIDh4WpeT6dDZuOUCwjtbYo
         4InLUwfMgNvv2hYLf0Dqfr8T1EsA6IeCI6VBYb8p+Egq5ZasnMQ//YHnpEPECpZSKrHn
         m8gA==
X-Gm-Message-State: AGi0PuZ2yfE1DpEUPx61kIo1icXun0suNkbQ6wcXqJblavK/eCGKOCyi
        28GyKePPpAW0HjA6i1AOLTA=
X-Google-Smtp-Source: APiQypJLm0lCOefiYtF3wJooPIWzeIUVrRfnHWpEfEj9o/WnolKahN/iVDZDXBMnKelXqqA2+imjKw==
X-Received: by 2002:a05:600c:2314:: with SMTP id 20mr3261582wmo.35.1587453043618;
        Tue, 21 Apr 2020 00:10:43 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id h3sm2409899wrm.73.2020.04.21.00.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 00:10:42 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm, mempolicy: fix up gup usage in lookup_node
Date:   Tue, 21 Apr 2020 09:10:26 +0200
Message-Id: <20200421071026.18394-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

ba841078cd05 ("mm/mempolicy: Allow lookup_node() to handle fatal signal") has
added a special casing for 0 return value because that was a possible
gup return value when interrupted by fatal signal. This has been fixed
by ae46d2aa6a7f ("mm/gup: Let __get_user_pages_locked() return -EINTR
for fatal signal") in the mean time so ba841078cd05 can be reverted.

This patch however doesn't go all the way to revert it because the check
for 0 is wrong and confusing here. Firstly it is inherently unsafe to
access the page when get_user_pages_locked returns 0 (aka no page
returned).
Fortunatelly this will not happen because get_user_pages_locked will not
return 0 when nr_pages > 0 unless FOLL_NOWAIT is specified which is not
the case here. Document this potential error code in gup code while we
are at it.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/gup.c       | 5 +++++
 mm/mempolicy.c | 5 +----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 50681f0286de..a8575b880baf 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -980,6 +980,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
  * -- If nr_pages is >0, but no pages were pinned, returns -errno.
  * -- If nr_pages is >0, and some pages were pinned, returns the number of
  *    pages pinned. Again, this may be less than nr_pages.
+ * -- 0 return value is possible when the fault would need to be retried.
  *
  * The caller is responsible for releasing returned @pages, via put_page().
  *
@@ -1247,6 +1248,10 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 }
 EXPORT_SYMBOL_GPL(fixup_user_fault);
 
+/*
+ * Please note that this function, unlike __get_user_pages will not
+ * return 0 for nr_pages > 0 without FOLL_NOWAIT
+ */
 static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 						struct mm_struct *mm,
 						unsigned long start,
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 48ba9729062e..1965e2681877 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -927,10 +927,7 @@ static int lookup_node(struct mm_struct *mm, unsigned long addr)
 
 	int locked = 1;
 	err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
-	if (err == 0) {
-		/* E.g. GUP interrupted by fatal signal */
-		err = -EFAULT;
-	} else if (err > 0) {
+	if (err > 0) {
 		err = page_to_nid(p);
 		put_page(p);
 	}
-- 
2.25.1

