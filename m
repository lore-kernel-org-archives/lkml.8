Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD0AC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 22:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24372074E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 22:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O3DKp8Qs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCMWje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 18:39:34 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:35635 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgCMWjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 18:39:33 -0400
Received: by mail-pf1-f202.google.com with SMTP id h12so7519380pfr.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 15:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=k5Th5oxzja32CITvsP8bvPqYgNLWg942G74ndA2m4k0=;
        b=O3DKp8Qsv519WV/tqDln4JX2s0hw+20b1URD4K35HEuGs+5LAqimZb8UaFqOn6MhrR
         mSe9frZxpsvauQVmA+31s/3/ak+V2LLBs1B6zotCjy98VWLOhWRL8Mgl7VQhtWQ0Z958
         fyryzDnSDeKmUeElekMPjtz0Y0kg5/OX1TMd50ysdUYN6FRlgRAJ1IrFEp5iAsWrlAxs
         7g1/cjr5CmPf1zFwiBBTB2fnZALddvE1y/+4uVoAxYDsF2ajqvlArLg3XLyA/qek0mrX
         6Ix3yoCFAsD0l60WoBi8Ot4COCkewGtLUZxJR98mzyL3OahAG3BTQuOplFSr4jLKk0ha
         yO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=k5Th5oxzja32CITvsP8bvPqYgNLWg942G74ndA2m4k0=;
        b=eH6uLbgdPfIDJ9NhA13N5U9vYs264vPsbRcc0Swmx4LRC4P8NTT8/OKSA8A59bX/hW
         CUuKY73uNcklRKNEHAB5CsbitG1AReiYyoIT4xiuyod6E51OWfawba6fGjyQ/5aRNbjo
         YpZ/Kiun+DQlhGvmkJHTip6nLmXj9PN9t/ZjMDmtWLEIJ8Ls7aKR9RzYGkdABOjy7Xl2
         VB/S0/X6wks41BW+75MeGM1o7n0fCSE8XV/GG5XacYJasn7uPz5LLltAOHuwEDlNtsKr
         KF8TlePueH41q9unbUiIJd+Fw4CD/12aCApTMq82iXGUKzXVXOMB+FOXgj80ct6Y89Os
         P1+Q==
X-Gm-Message-State: ANhLgQ0TebJXLr6wgm12cRG9ds+w0DuULcEOhyEYErYBQiVbMlN9Vblo
        szRQT26uUT/F4mBIVoTcDHS7bdf7yLTP6X2MLA==
X-Google-Smtp-Source: ADFU+vvI64pl/GDQ5FTOUMsfshjKMu6JoRvfa2sz4J7N5BTtHp+LsnvTNnevAHQLtfPe+LqgUhtwMSeKQMWYJqKPqw==
X-Received: by 2002:a17:90b:1b01:: with SMTP id nu1mr5402015pjb.129.1584139172402;
 Fri, 13 Mar 2020 15:39:32 -0700 (PDT)
Date:   Fri, 13 Mar 2020 15:39:20 -0700
Message-Id: <20200313223920.124230-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH -next] hugetlb_cgroup: fix illegal access to memory
From:   Mina Almasry <almasrymina@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        syzbot+cac0c4e204952cf449b1@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tejun Heo <tj@kernel.org>, mike.kravetz@oracle.com,
        rientjes@google.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This appears to be a mistake in commit faced7e0806cf ("mm: hugetlb
controller for cgroups v2"). Essentially that commit does
a hugetlb_cgroup_from_counter assuming that page_counter_try_charge has
initialized counter, but if page_counter_try_charge has failed then it
seems it does not initialize counter, so
hugetlb_cgroup_from_counter(counter) ends up pointing to random memory,
causing kasan to complain.

Solution, simply use h_cg, instead of
hugetlb_cgroup_from_counter(counter), since that is a reference to the
hugetlb_cgroup anyway. After this change kasan ceases to complain.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Reported-by: syzbot+cac0c4e204952cf449b1@syzkaller.appspotmail.com
Fixes: commit faced7e0806cf ("mm: hugetlb controller for cgroups v2")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: mike.kravetz@oracle.com
Cc: rientjes@google.com

---
 mm/hugetlb_cgroup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 7994eb8a2a0b4..aabf65d4d91ba 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -259,8 +259,7 @@ static int __hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 		    __hugetlb_cgroup_counter_from_cgroup(h_cg, idx, rsvd),
 		    nr_pages, &counter)) {
 		ret = -ENOMEM;
-		hugetlb_event(hugetlb_cgroup_from_counter(counter, idx), idx,
-			      HUGETLB_MAX);
+		hugetlb_event(h_cg, idx, HUGETLB_MAX);
 		css_put(&h_cg->css);
 		goto done;
 	}
--
2.25.1.481.gfbce0eb801-goog
