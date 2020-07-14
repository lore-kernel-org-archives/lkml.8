Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0553DC433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D95FA20849
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Z/wYVQyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGNHdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgGNHdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:33:04 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C213C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 00:33:04 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q7so21315827ljm.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 00:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R8orn93ADt/4gOBW8WREoRLbcPdxazQvh/HwHNIuhAY=;
        b=Z/wYVQytSqKk3IH73/ux75nV4a9eng7MqAusYNZKDbWAhyRl1DiFjkwYNX42KabOKB
         j3LZ4sjY4SUzGCaSEKgB9NdJezNz+UehQo+59s/d9nVbH69yfKSQMYKMxi0afnuMg3Vt
         +jfoqZNsgQaj41KfbjsIM5sF4xL4ubkEvxVTjZGSYtl7M+lcUpBp6Y1ct+JOgW5Ka86O
         qZqqQD4TEVIWLz+mf6tYW3p/YYliDIrc3FBTgWd4soRSc3/7NRpUNqfaItmM6k8k5quc
         YETGoX9lodspJ+HWv7iDPcBoK/47UNGi1TP0GGW0VKMxku7BiRKhOsim8gkYmquvtTFS
         NIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R8orn93ADt/4gOBW8WREoRLbcPdxazQvh/HwHNIuhAY=;
        b=IXH3KE8YfSXjGXxxHkkQjG9L4EI2t2+PsMwEiImHJCgsTekqejeBKW+/rqDSzCuqPW
         t3sXF6r0dWL0l6lbHNfrFSUHzOU2ZBum3iANHGooRdVYjxLhre3ds2N1hNY1R6deiWzL
         HRIotRl1GN3aG6BzQlFrTYORK9+UX6rw9AFZlhn1Fz+YWYEa6oRQA5nJWYW75s9eiRv/
         BOrPpSG2OYqDOvgb6Y2sHPjbmLHRzMOd93aY6fqPowdTbaBrhae8sYuxc9d+TBRsZuFk
         Ms6Q6Ehi32YTUFy/5ecwikTlljmmVS2hN/HbEW69JDfMWW4wxKIAdVSFq3sDJEEqE3z7
         P6uQ==
X-Gm-Message-State: AOAM530YnujjOYyr7KaOEVFJxpuf/8x2OxiePC0VNq8YfR7CHH1iiDcq
        Lx0iiQDkkNb5G+aFuZgDppUmkA==
X-Google-Smtp-Source: ABdhPJx7Tu4+/eXTMAvrPy+NFt0qJma4hLbxqpf8m1or7AVtlxWHP6cAteAQCMqlnwkRL1E8WUItLw==
X-Received: by 2002:a05:651c:3c2:: with SMTP id f2mr1714736ljp.37.1594711982733;
        Tue, 14 Jul 2020 00:33:02 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i15sm5093781lfl.57.2020.07.14.00.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 00:33:02 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0F10E101459; Tue, 14 Jul 2020 10:33:06 +0300 (+03)
Date:   Tue, 14 Jul 2020 10:33:06 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux- stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        lkft-triage@lists.linaro.org, Chris Down <chris@chrisdown.name>,
        Michel Lespinasse <walken@google.com>,
        Fan Yang <Fan_Yang@sjtu.edu.cn>,
        Brian Geffon <bgeffon@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, pugaowei@gmail.com,
        Jerome Glisse <jglisse@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: WARNING: at mm/mremap.c:211 move_page_tables in i386
Message-ID: <20200714073306.kq4zikkphqje2yzb@box>
References: <CA+G9fYt+6OeibZMD0fP=O3nqFbcN3O4xcLkjq0mpQbZJ2uxB9w@mail.gmail.com>
 <CAHk-=wgRcFSnQt=T95S+1dPkyvCuVAVGQ37JDvRg41h8hRqO3Q@mail.gmail.com>
 <CA+G9fYuL=xJPLbQJVzDfXB8uNiCWdXpL=joDsnATEFCzyFh_1g@mail.gmail.com>
 <CAHk-=wgB6Ds6yqbZZmscKNuAiNR2J0Pf3a8UrbdfewYxHE7SbA@mail.gmail.com>
 <20200712215041.GA3644504@google.com>
 <CAHk-=whxP0Gj70pJN5R7Qec4qjrGr+G9Ex7FJi7=_fPcdQ2ocQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whxP0Gj70pJN5R7Qec4qjrGr+G9Ex7FJi7=_fPcdQ2ocQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 03:58:06PM -0700, Linus Torvalds wrote:
> Anybody else have any opinions?

Maybe we just shouldn't allow move_normal_pmd() if ranges overlap?

Other option: pass 'overlaps' down to move_normal_pmd() and only WARN() if
see establised PMD without overlaps being true.

Untested patch:

diff --git a/mm/mremap.c b/mm/mremap.c
index 5dd572d57ca9..e33fcee541fe 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -245,6 +245,18 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 	unsigned long extent, next, old_end;
 	struct mmu_notifier_range range;
 	pmd_t *old_pmd, *new_pmd;
+	bool overlaps;
+
+	/*
+	 * shift_arg_pages() can call move_page_tables() on overlapping ranges.
+	 * In this case we cannot use move_normal_pmd() because destination pmd
+	 * might be established page table: move_ptes() doesn't free page
+	 * table.
+	 */
+	if (old_addr > new_addr)
+		overlaps = old_addr - new_addr < len;
+	else
+		overlaps = new_addr - old_addr < len;
 
 	old_end = old_addr + len;
 	flush_cache_range(vma, old_addr, old_end);
@@ -282,7 +294,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 			split_huge_pmd(vma, old_pmd, old_addr);
 			if (pmd_trans_unstable(old_pmd))
 				continue;
-		} else if (extent == PMD_SIZE) {
+		} else if (!overlaps && extent == PMD_SIZE) {
 #ifdef CONFIG_HAVE_MOVE_PMD
 			/*
 			 * If the extent is PMD-sized, try to speed the move by
-- 
 Kirill A. Shutemov
