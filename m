Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586C1C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AA720724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Rt0ZY8y2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgCMTzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:55:14 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39064 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCMTzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:55:13 -0400
Received: by mail-qk1-f196.google.com with SMTP id e16so14691649qkl.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Hfzbt85s5dZWmMp/zqFOHofSsVERX/p3j2BI4mF1Kow=;
        b=Rt0ZY8y2poiOar+1ASETMVRsuXGGZwiwZJ0+/9P7+916QHLd1ikA7PgwHUd1s9zP5N
         H/JoeIE13uEeMa+8Ffoo+GUs+ZVOmZTdJ6NNuFtWClUFy1K5oUKX6Hk7kxkwmVHCXT1L
         WlOVqRJ+e5Ehr+b/eg03cqTD0kgkCoBh71VNSJfVK/BeY8yQb4xwpTdj1SSrNi2kpEhe
         PBPRyOB2X0HjCuXTJ37CxCIysJx8W4RQGFk9fOuKJM9LyCc+FM+eHt16Qmr6ddWnwIqF
         vsr2U4Z8vUnyVA9cgtjaYSoMWPf3ToKpJze60Kv9ad0r4sor0LUsOV1lznOS+MWEOM1Y
         H0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Hfzbt85s5dZWmMp/zqFOHofSsVERX/p3j2BI4mF1Kow=;
        b=q3xasyh98B+/bwPuAWv7PIcaVQZpPYn/PysAIy4rlBLpsQrZ3PaDaTW86sDxcvXTty
         qkvymwpXMKzgN5amFwsfh3lQNIiPYCqZ5kq/maBcrKXTXQeq3+iQeKqN8g+MPwp2Dlw1
         3il7BHuurWprw11WVDNllCUiMNAPffhnypAqtBB0ZZucaeYgVGND5rls3oLm+FfFmyha
         HstBgGzFoukRSLPNfAV755dDnBU0iD5ThjqoXiuQrIAKX4Kv2m/2i0zKKnOyKxO9Y8ZJ
         GHa7jqKeq/bxOsd9Vd7XfcZAlPUiPqv8bdXOYCmpLeaKihi2kH/2fPkArk2Lrd78Mp/c
         lJWA==
X-Gm-Message-State: ANhLgQ1qdaBlnI9H1z7H8oRmvAahEAFPls5OWVJ+AK/yNQQnhyy+mSTE
        YeIVk6uSNZAv4XLklD/TzMaDoA==
X-Google-Smtp-Source: ADFU+vsQ/9mXEjYK792ujrUNhDFdoZ1ykvsP/BfcltKM4tfvpcbRo1UblTXKwwT5sh0NdsUf499AGQ==
X-Received: by 2002:a37:e10f:: with SMTP id c15mr14238676qkm.262.1584129312287;
        Fri, 13 Mar 2020 12:55:12 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d99c])
        by smtp.gmail.com with ESMTPSA id p22sm6387314qki.124.2020.03.13.12.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:55:11 -0700 (PDT)
Date:   Fri, 13 Mar 2020 15:55:10 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 2/9] mm/vmscan: protect the workingset on anonymous LRU
Message-ID: <20200313195510.GA67986@cmpxchg.org>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1582175513-22601-3-git-send-email-iamjoonsoo.kim@lge.com>
 <20200312151423.GH29835@cmpxchg.org>
 <CAAmzW4Mpm6PyZp1jXUo__S-OZ2=MKPuyTA+gpL0X8cW+H0ps4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4Mpm6PyZp1jXUo__S-OZ2=MKPuyTA+gpL0X8cW+H0ps4Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 04:40:18PM +0900, Joonsoo Kim wrote:
> 2020년 3월 13일 (금) 오전 12:14, Johannes Weiner <hannes@cmpxchg.org>님이 작성:
> >
> > On Thu, Feb 20, 2020 at 02:11:46PM +0900, js1304@gmail.com wrote:
> > > @@ -1010,8 +1010,15 @@ static enum page_references page_check_references(struct page *page,
> > >               return PAGEREF_RECLAIM;
> > >
> > >       if (referenced_ptes) {
> > > -             if (PageSwapBacked(page))
> > > -                     return PAGEREF_ACTIVATE;
> > > +             if (PageSwapBacked(page)) {
> > > +                     if (referenced_page) {
> > > +                             ClearPageReferenced(page);
> > > +                             return PAGEREF_ACTIVATE;
> > > +                     }
> >
> > This looks odd to me. referenced_page = TestClearPageReferenced()
> > above, so it's already be clear. Why clear it again?
> 
> Oops... it's just my fault. Will remove it.
> 
> > > +
> > > +                     SetPageReferenced(page);
> > > +                     return PAGEREF_KEEP;
> > > +             }
> >
> > The existing file code already does:
> >
> >                 SetPageReferenced(page);
> >                 if (referenced_page || referenced_ptes > 1)
> >                         return PAGEREF_ACTIVATE;
> >                 if (vm_flags & VM_EXEC)
> >                         return PAGEREF_ACTIVATE;
> >                 return PAGEREF_KEEP;
> >
> > The differences are:
> >
> > 1) referenced_ptes > 1. We did this so that heavily shared file
> > mappings are protected a bit better than others. Arguably the same
> > could apply for anon pages when we put them on the inactive list.
> 
> Yes, these check should be included for anon.
> 
> > 2) vm_flags & VM_EXEC. This mostly doesn't apply to anon pages. The
> > exception would be jit code pages, but if we put anon pages on the
> > inactive list we should protect jit code the same way we protect file
> > executables.
> 
> I'm not sure that this is necessary for anon page. From my understanding,
> executable mapped file page is more precious than other mapped file page
> because this mapping is usually used by *multiple* thread and there is
> no way to check it by MM. If anon JIT code has also such characteristic, this
> code should be included for anon, but, should be included separately. It
> seems that it's beyond of this patch.

The sharing is what the referenced_ptes > 1 check is for.

The problem with executables is that when they are referenced, they
get a *lot* of references compared to data pages. Think about an
instruction stream and how many of those instructions result in data
references. So when you see an executable page that is being accessed,
it's likely being accessed at a high rate. They're much hotter, and
that's why reference bits from VM_EXEC mappings carry more weight.

IMO this applies to executable file and anon equally.

> > Seems to me you don't need to add anything. Just remove the
> > PageSwapBacked branch and apply equal treatment to both types.
> 
> I will rework the code if you agree with my opinion.
> 
> > > @@ -2056,6 +2063,15 @@ static void shrink_active_list(unsigned long nr_to_scan,
> > >                       }
> > >               }
> > >
> > > +             /*
> > > +              * Now, newly created anonymous page isn't appened to the
> > > +              * active list. We don't need to clear the reference bit here.
> > > +              */
> > > +             if (PageSwapBacked(page)) {
> > > +                     ClearPageReferenced(page);
> > > +                     goto deactivate;
> > > +             }
> >
> > I don't understand this.
> >
> > If you don't clear the pte references, you're leaving behind stale
> > data. You already decide here that we consider the page referenced
> > when it reaches the end of the inactive list, regardless of what
> > happens in between. That makes the deactivation kind of useless.
> 
> My idea is that the pages newly appended to the inactive list, for example,
> a newly allocated anon page or deactivated page, start at the same line.
> A newly allocated anon page would have a mapping (reference) so I
> made this code to help for deactivated page to have a mapping (reference).
> I think that there is no reason to devalue the page accessed on active list.

I don't think that leads to desirable behavior, because it causes an
age inversion between deactivated and freshly instantiated pages.

We know the new page was referenced when it entered the head of the
inactive list. However, the old page's reference could be much, much
longer in the past. Hours ago. So when they both reach the end of the
list, we treat them as equally hot even though the new page has been
referenced very recently and the old page might be completely stale.

Keep in mind that we only deactivate in the first place because the
inactive list is struggling and we need to get rid of stale active
pages. We're in a workingset transition and *should* be giving old
pages the chance to move out quickly.

> Before this patch is applied, all newly allocated anon page are started
> at the active list so clearing the pte reference on deactivation is required
> to check the further access. However, it is not the case so I skip it here.
> 
> > And it blurs the lines between the inactive and active list.
> >
> > shrink_page_list() (and page_check_references()) are written with the
> > notion that any references they look at are from the inactive list. If
> > you carry over stale data, this can cause more subtle bugs later on.
> 
> It's not. For file page, PageReferenced() is maintained even if deactivation
> happens and it means one reference.

shrink_page_list() doesn't honor PageReferenced as a reference.

PG_referenced is primarily for the mark_page_accessed() state machine,
which is different from the reclaim scanner's reference tracking: for
unmapped pages we can detect accesses in realtime and don't need the
reference sampling from LRU cycle to LRU cycle. The bit carries over a
deactivation, but it doesn't prevent reclaim from freeing the page.

For mapped pages, we sample references using the LRU cycles, and
PG_referenced is otherwise unused. We repurpose it to implement
second-chance tracking of inactive pages with pte refs. It counts
inactive list cycles, not references.

> > And again, I don't quite understand why anon would need different
> > treatment here than file.
> 
> In order to preserve the current behaviour for the file page, I leave the code
> as is for the file page and change the code for the anon page. There is
> fundamental difference between them such as how referenced is checked,
> accessed by mapping and accessed by syscall. I think that some difference
> would be admitted.

Right, unmapped pages have their own reference tracking system because
they can be detected synchronously.

My questions center around this:

We have an existing sampling algorithm for the coarse-grained page
table referenced bit, where we start pages on inactive, treat
references a certain way, target a certain inactive:active ratio, use
refault information to detect workingset transitions etc. Anon used a
different system in the past, but your patch set switches it over to
the more universal model we have developed for mapped file pages.

However, you don't switch it over to this exact model we have for
mapped files, but rather a slightly modified version. And I don't
quite understand the rationale behind the individual modifications.

So let me turn it around. What would be the downsides of aging mapped
anon exactly the same way we age mapped files? Can we identify where
differences are necessary and document them?
