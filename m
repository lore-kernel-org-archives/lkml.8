Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA6AC433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642082078B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXMgYuoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgHaUgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 16:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgHaUge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 16:36:34 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E36C061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 13:36:33 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id k13so1466666oor.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ALZ0cI088e7LavEE1zCuQl43dEIuq04xSG5XkBRnPb4=;
        b=cXMgYuoMdUne52TPYEQ+RFvNI7fYFdPFXmQNr2cTfKwhpwzXvn0C1UEkM2V288lmdo
         Bm09UkGWR+j1NnjJtpdsgh4pu7bbkdCOYa4W6LaTudcHbvcA1MeAlIMLvCJZGeFuwJSd
         SvC9QFsb45+heQ0E4L08PQpV0mZ/S1U6t2LLcDOgdATl+i0OpteWp66eF+2mglWO+iNz
         Un2AVZq41XE8zU42eC/gUHnwuKWSRdtpSqKVwu6OTepuiEVN/pA74/aDMO4b5HYmNr/s
         tVHEKv2wvuGJw9bi7Jl8VE6G61KmRs9aF6dPYuIbzLMXOzjKoUJmYltdWsB2lQYUceaK
         J7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ALZ0cI088e7LavEE1zCuQl43dEIuq04xSG5XkBRnPb4=;
        b=pp8OgM/fApvLzymo+iALJL4IirKbrIF9oDOw+S/LbP5H+BnMPF5Xjb/+3UC+dAorLx
         prBZLFS9jLEg8Yi4LbxpkQRGGeQh/0/i79+kvl+w9AZLtGh81ypjJLulC6wwyvi6sQZc
         X0Au1BdvhFbK5SEo1ehQO6ZV6rvotjlZ4AVpqcvnEUFOEndqHGc3K6nnetpe98+cRpqf
         ItnqVK97+t2n4cK48ceMpDEf8pSXK7EX3xyl4jrOiQSdiTILYL5BhfQ/OEUJ5dk4rt0h
         XptZ0auww7ATW9Ez1nQ8cgplGR/r6Hcap6QgGfhhyBRxl943fvVgHBcNLsbqb7y1CIh/
         ImdA==
X-Gm-Message-State: AOAM530b76URWMUrG0Ss3iyycR+1beJN1Y6WfF3yKNpyUmdRJSjzrf78
        v1uOsCfs7eCTdd96ZvaO9E+45g==
X-Google-Smtp-Source: ABdhPJxlYmDe1he0nb+ZttHTJoAT3S1OZGqNC/UYyfdM76yoUFWtJWVAxMeAPXce/Tx266vERYW5SA==
X-Received: by 2002:a4a:d157:: with SMTP id o23mr1078948oor.2.1598906192708;
        Mon, 31 Aug 2020 13:36:32 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l22sm2035015oot.22.2020.08.31.13.36.30
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 31 Aug 2020 13:36:31 -0700 (PDT)
Date:   Mon, 31 Aug 2020 13:36:16 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Jann Horn <jannh@google.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v5 7/7] mm: Remove the now-unnecessary mmget_still_valid()
 hack
In-Reply-To: <CAG48ez15Zxbkjv0WRChZZZ6F78pFVXPTu_Bn1Pqaxx=7Gk1gUg@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2008311326540.3602@eggly.anvils>
References: <20200827114932.3572699-1-jannh@google.com> <20200827114932.3572699-8-jannh@google.com> <alpine.LSU.2.11.2008302225510.1934@eggly.anvils> <CAG48ez15Zxbkjv0WRChZZZ6F78pFVXPTu_Bn1Pqaxx=7Gk1gUg@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020, Jann Horn wrote:
> On Mon, Aug 31, 2020 at 8:07 AM Hugh Dickins <hughd@google.com> wrote:
> > On Thu, 27 Aug 2020, Jann Horn wrote:
> >
> > > The preceding patches have ensured that core dumping properly takes the
> > > mmap_lock. Thanks to that, we can now remove mmget_still_valid() and all
> > > its users.
> >
> > Hi Jann, while the only tears to be shed over losing mmget_still_valid()
> > will be tears of joy, I think you need to explain why you believe it's
> > safe to remove the instance in mm/khugepaged.c: which you'll have found
> > I moved just recently, to cover an extra case (sorry for not Cc'ing you).
> >
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -431,7 +431,7 @@ static void insert_to_mm_slots_hash(struct mm_struct *mm,
> > >
> > >  static inline int khugepaged_test_exit(struct mm_struct *mm)
> > >  {
> > > -     return atomic_read(&mm->mm_users) == 0 || !mmget_still_valid(mm);
> > > +     return atomic_read(&mm->mm_users) == 0;
> > >  }
> > >
> > >  static bool hugepage_vma_check(struct vm_area_struct *vma,
> >
> > The movement (which you have correctly followed) was in
> > bbe98f9cadff ("khugepaged: khugepaged_test_exit() check mmget_still_valid()")
> > but the "pmd .. physical page 0" issue is explained better in its parent
> > 18e77600f7a1 ("khugepaged: retract_page_tables() remember to test exit")
> >
> > I think your core dumping is still reading the page tables without
> > holding mmap_lock
> 
> Where? get_dump_page() takes mmap_lock now:
> <https://lore.kernel.org/lkml/20200827114932.3572699-7-jannh@google.com/>

Right, sorry for the noise, that's precisely what 6/7 is all about,
and properly declares itself there in its Subject - I plead that I
got distracted by the vma snapshot part of the series, and paid too
little attention before bleating.

Looks good to me - thanks.

> 
> I don't think there should be any paths into __get_user_pages() left
> that don't hold the mmap_lock. Actually, we should probably try
> sticking mmap_assert_locked() in there now as a follow-up?

Maybe: I haven't given it thought, to be honest.

Hugh
