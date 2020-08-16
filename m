Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78113C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 20:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FDCA20829
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 20:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UokVGw0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgHPUop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 16:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgHPUon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 16:44:43 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED827C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 13:44:42 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id w2so6855185qvh.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 13:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=02orff/xitfT1a7j0rdVSyXbwLl/LTZJUmel3rsHuGY=;
        b=UokVGw0bTBJzJAP5mk46z+ZAX1acPHahIvehLKmbkgF3U8E9vy11enHSv+59uhwfC6
         MB3FvyjmlA5NIi013M4LoTlAE9J9fjNT0v/6XkK6XphahSOtUcdZsqAqW/EgonzucWyK
         9kOg+bxovxDslcdtaukP+scTTN7kDSbJr/EVHp35q/ksab+5hv3P3l0hQkRQRNG8aSjn
         BWAIF0kwbmkwpX8S6xylalaoPiqTNvyBSvLVdcEDD8oVCvgQzxYhiwzn206r/LbjTaZh
         8Ng8M+J+/CQNDd4fIRMdy/HCNGmDYlGiHaGeq4mp6V7Uu8CIObegTuWaulCMi+dj+1c6
         0TsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=02orff/xitfT1a7j0rdVSyXbwLl/LTZJUmel3rsHuGY=;
        b=D5aCYRz3jNgRXZGzx/ZkYcNqsnwHjt2GZpn62F55/IBck2mx87dk+eSN/yN0fiYtbL
         Mdpo+pNPKtiBK57lm9R0AHl8YvCjWxjBLLtonWKwHQFkhtrmCha0eMYsVmhKtsbPIW+F
         rUh5Z+Injpr2Hs2v1vXbvyb/lb/9UIK6y6SUyYh9gc+sWryYXlWGbzZiqnGCFAM+mhES
         BNFiZMXGDtTTqGIKXTyU5HY7d4Kied9DLQb9HSdiy3QZR9li0GxfyB2FgqRk8a07BxM0
         Lpn8rySN8tUBtpOHxwm2v1GBazo1wNmdIjEcG5FRwLT84wpvE5b1M7nCAmFSjJe9RYGU
         B49Q==
X-Gm-Message-State: AOAM533ta04X61eoELkurUTTeY88a/wjFYHFuLoDttqgieXUgClGrbmj
        geM2XNAGXrtnsOv+p7FMZ0s6eBgj67iXlA==
X-Google-Smtp-Source: ABdhPJwwIEktwhWl//yA7SPQ9oSlYxBhu7RfeU4o4F7Vox9jA9eko+wClGjweWMWErokbEvHa4RSNg==
X-Received: by 2002:a0c:e604:: with SMTP id z4mr11941741qvm.222.1597610681263;
        Sun, 16 Aug 2020 13:44:41 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k48sm18444264qtk.44.2020.08.16.13.44.38
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 16 Aug 2020 13:44:39 -0700 (PDT)
Date:   Sun, 16 Aug 2020 13:44:25 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] uprobes: __replace_page() avoid BUG in munlock_vma_page()
Message-ID: <alpine.LSU.2.11.2008161338360.20413@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot crashed on the VM_BUG_ON_PAGE(PageTail) in munlock_vma_page(),
when called from uprobes __replace_page().  Which of many ways to fix it?
Settled on not calling when PageCompound (since Head and Tail are equals
in this context, PageCompound the usual check in uprobes.c, and the prior
use of FOLL_SPLIT_PMD will have cleared PageMlocked already).

Reported-by: syzbot <syzkaller@googlegroups.com>
Fixes: 5a52c9df62b4 ("uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org # v5.4+
---
This one is not a 5.9-rc regression, but still good to fix.

 kernel/events/uprobes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- v5.9-rc/kernel/events/uprobes.c	2020-08-12 19:46:50.851196584 -0700
+++ linux/kernel/events/uprobes.c	2020-08-16 13:18:35.292821674 -0700
@@ -205,7 +205,7 @@ static int __replace_page(struct vm_area
 		try_to_free_swap(old_page);
 	page_vma_mapped_walk_done(&pvmw);
 
-	if (vma->vm_flags & VM_LOCKED)
+	if ((vma->vm_flags & VM_LOCKED) && !PageCompound(old_page))
 		munlock_vma_page(old_page);
 	put_page(old_page);
 
