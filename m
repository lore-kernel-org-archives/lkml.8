Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C39C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C205620772
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JdBgyG4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHQHSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgHQHSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:18:08 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C899BC061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 00:18:07 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id d14so14124442qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 00:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=/Set//dgm7G/XdtiNNP38eYsEDsXQCMaAkbmzasEPMg=;
        b=JdBgyG4W1iyFfmRRasE/WxCe+QioC2gKjz2BHSMl7Mow6xxBfhSXol7QKLgheZht1F
         DCP89xzuke3Sm08FZLbNOchZ6zcVdgyjGxrQvFUAex9B0thU/DTSkHj4VuCOriaw+0BA
         F8vW+w84c7DQPmVSRTBWs1SE2R4Ii17eZwzyepJKanQZQIiR23vJ6J3doVGopNqc8Dmh
         IzgN3x1rlXiMnMaCCLNUDrRptOHoWc/4whQuHkVAM5RuSkDe+AbSD87BPWofVBE2le1c
         3omWdmBJa8cVa3g0KiG0+gAZNxEnsOtHDL7XsdndPbfhfd1rlNabtWjsdl3QZ29vOxx7
         k5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=/Set//dgm7G/XdtiNNP38eYsEDsXQCMaAkbmzasEPMg=;
        b=Cy9NJqT1tItvk2XJOSmy/uLY1m2qUJ5k+KAtNhyn6CWxiUCWAfc0i5Re97AVJ7WaBy
         CfKpJZ3k7DX2+Zd3rgof3yuSjXj98bdU78q6V10WFUaml1wtC8y0qVQJ+m5QS2Y8H3uI
         OYpzqyd0L9y94KcPYHEWjmVB2YFVuRv7kuIb45feniHD5qtn33CuViDasfAOj0hjK57X
         xJNr5P2HOzDnKdkmCPIlVn01UAmu8BnEMvc7iqoxcrUIJGGrNuxS8oYYMA8DkWernhK6
         eNuXd0XrEvNRvDtuZTOAV+gfvBiMVHDWwhLu5RWwHzqBixEE90I3O2qKne/eGOiZP8uz
         IrYA==
X-Gm-Message-State: AOAM531xbVvYGX6Mxioa6kBtGj/K4qgo3mH3czvPm5IxvzNUkOTDEwig
        2s0vkFjnOdwyL2FRWGMpI9d4P94t5q5QJw==
X-Google-Smtp-Source: ABdhPJxYEgL55GYgsN0r/l+TigB5h3PzzlWKJwkc8ZGKufBA3D5n+IxqISh4QRcIWzBUlPgZjKA4JQ==
X-Received: by 2002:a05:620a:152d:: with SMTP id n13mr10980555qkk.43.1597648686064;
        Mon, 17 Aug 2020 00:18:06 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b187sm15642131qkd.107.2020.08.17.00.18.02
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 17 Aug 2020 00:18:04 -0700 (PDT)
Date:   Mon, 17 Aug 2020 00:17:49 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Song Liu <songliubraving@fb.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] uprobes: __replace_page() avoid BUG in
 munlock_vma_page()
In-Reply-To: <852258AE-75B6-404A-B236-9EEF37AEE43F@fb.com>
Message-ID: <alpine.LSU.2.11.2008162340320.1025@eggly.anvils>
References: <alpine.LSU.2.11.2008161338360.20413@eggly.anvils> <852258AE-75B6-404A-B236-9EEF37AEE43F@fb.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020, Song Liu wrote:
> > On Aug 16, 2020, at 1:44 PM, Hugh Dickins <hughd@google.com> wrote:
> > 
> > syzbot crashed on the VM_BUG_ON_PAGE(PageTail) in munlock_vma_page(),
> > when called from uprobes __replace_page().  Which of many ways to fix it?
> > Settled on not calling when PageCompound (since Head and Tail are equals
> > in this context, PageCompound the usual check in uprobes.c, and the prior
> > use of FOLL_SPLIT_PMD will have cleared PageMlocked already).
> > 
> > Reported-by: syzbot <syzkaller@googlegroups.com>
> > Fixes: 5a52c9df62b4 ("uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > Cc: stable@vger.kernel.org # v5.4+
> > ---
> > This one is not a 5.9-rc regression, but still good to fix.
> > 
> > kernel/events/uprobes.c |    2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- v5.9-rc/kernel/events/uprobes.c	2020-08-12 19:46:50.851196584 -0700
> > +++ linux/kernel/events/uprobes.c	2020-08-16 13:18:35.292821674 -0700
> > @@ -205,7 +205,7 @@ static int __replace_page(struct vm_area
> > 		try_to_free_swap(old_page);
> > 	page_vma_mapped_walk_done(&pvmw);
> > 
> > -	if (vma->vm_flags & VM_LOCKED)
> > +	if ((vma->vm_flags & VM_LOCKED) && !PageCompound(old_page))
> 
> Do we need munlock_vma_page() for THP page head? 

No: as the commit message says "the prior use of FOLL_SPLIT_PMD
will have cleared PageMlocked already" - our THP implementation
has difficulty supporting Mlocked consistently when the huge page is
somewhere mapped by ptes, so one of the things that __split_huge_pmd()
does is clear_page_mlock(), then PageDoubleMap will prevent Mlocked
being set again once GUP has brought the old_page pte back in.

But if you'd prefer us to munlock_vma_page(compound_head(old_page))
instead, I can certainly change the patch: it's one of the options
I considered, but couldn't quite bring myself to do it that way,
knowing that actually it would never find PageMlocked set.  (If
PageMlocked were allowed on tail pages, I'd have used a PageMlocked
test instead of the PageCompound one: I spent nearly an hour
bikeshedding the alternatives here!)

(One day I must remind myself of when munlock_vma_page() should be
used, versus when clear_page_mlock() should be used: I think it comes
down to a choice of which stats get incremented, but I may also be
forgetting something more important: anyway, no obvious reason to
depart from the munlock_vma_page() that's always been used here.)

Hugh
