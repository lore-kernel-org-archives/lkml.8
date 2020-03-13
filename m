Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00482C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 07:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3EEA206B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 07:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+QFiAI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCMHkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 03:40:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32996 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgCMHkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 03:40:31 -0400
Received: by mail-qt1-f193.google.com with SMTP id d22so6772304qtn.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 00:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J7ndIi/MT3iZaElufcyTUOc6zBIGYckkL1yyLZFimu4=;
        b=c+QFiAI38yIpq8he59G2BYAKBkvT7cjIyWIMX2iFc+rDvP2Ls9g5N/OL5XCeJIAk4Z
         VTcnu7LFVsHWBJ2gVcazmPz4eVbohzHlzyIwOSpAlA8eAQkVvXhgmNq2uHQPTKTIxePC
         UgNMF0PmDZ2MQBkOtmW0Zm0JODnSWIgh1EHpbEVHLGbuarbMJw6mLt7n8Yt/nvUn8Tpf
         0NrTnOTDan7ds/+VJX2gcTuIlU2n1JfxppzO3S/LeaLQVWzxIV5XFBNVOwYqTy/wEd1e
         5bLyWqipVyOmk6c2/4k8NvCVszL7SzsdvqBE2naDCRM5M92HxCtfPWlrT0IGgVfLZ97U
         spVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J7ndIi/MT3iZaElufcyTUOc6zBIGYckkL1yyLZFimu4=;
        b=THCPFQ3kqOX9NoanesMWJX8kbBtTEyj90zIW7awm9WyhOaAfIH4JC6nPFp7dQROWOo
         0uOQxwuSpyg4Qd7OF+Au+PqY04XbmBmn8JhBQDyM+q6hz9JBN1oH754A7PeK9v8YBsjB
         CD8ABY1/Cf8+gckxGjHGtw4j+P3SwzyOl2eG6r8vTFZdurgjyI/+f23l8UEJXuYbJ3ub
         7DKn7v00vlc06aEVO1QiWjgUYs6CpxLqu+YTWzAD4WRmxHl80+178Rfo0nAljtjo+TJJ
         R7b5CU2VqOaZ8/kONuFYix9sFeWLcAF+n63ZSZR+93hGBEdxDjrr7xILaBciP6GmcPK0
         dKdA==
X-Gm-Message-State: ANhLgQ3TVdqXpPG1lf0+Y1cC89IRZ3G+UNtIBP20o3Q5qtlbH++kyebA
        KlnJksQD5cDyIi3Z2Hf7xb1i4BKGGGiL6HdmeZQ=
X-Google-Smtp-Source: ADFU+vv1AsIzP3nFTLx7SUeEOTctflwbxK+9gTgYkoPwf8MrQEHXHABbRFu92q0DaROHo9Fh4qxpvd+o3lJbCTz7xbg=
X-Received: by 2002:ac8:2648:: with SMTP id v8mr11276212qtv.65.1584085229273;
 Fri, 13 Mar 2020 00:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1582175513-22601-3-git-send-email-iamjoonsoo.kim@lge.com> <20200312151423.GH29835@cmpxchg.org>
In-Reply-To: <20200312151423.GH29835@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 13 Mar 2020 16:40:18 +0900
Message-ID: <CAAmzW4Mpm6PyZp1jXUo__S-OZ2=MKPuyTA+gpL0X8cW+H0ps4Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] mm/vmscan: protect the workingset on anonymous LRU
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 3=EC=9B=94 13=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 12:14, =
Johannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Feb 20, 2020 at 02:11:46PM +0900, js1304@gmail.com wrote:
> > @@ -1010,8 +1010,15 @@ static enum page_references page_check_reference=
s(struct page *page,
> >               return PAGEREF_RECLAIM;
> >
> >       if (referenced_ptes) {
> > -             if (PageSwapBacked(page))
> > -                     return PAGEREF_ACTIVATE;
> > +             if (PageSwapBacked(page)) {
> > +                     if (referenced_page) {
> > +                             ClearPageReferenced(page);
> > +                             return PAGEREF_ACTIVATE;
> > +                     }
>
> This looks odd to me. referenced_page =3D TestClearPageReferenced()
> above, so it's already be clear. Why clear it again?

Oops... it's just my fault. Will remove it.

> > +
> > +                     SetPageReferenced(page);
> > +                     return PAGEREF_KEEP;
> > +             }
>
> The existing file code already does:
>
>                 SetPageReferenced(page);
>                 if (referenced_page || referenced_ptes > 1)
>                         return PAGEREF_ACTIVATE;
>                 if (vm_flags & VM_EXEC)
>                         return PAGEREF_ACTIVATE;
>                 return PAGEREF_KEEP;
>
> The differences are:
>
> 1) referenced_ptes > 1. We did this so that heavily shared file
> mappings are protected a bit better than others. Arguably the same
> could apply for anon pages when we put them on the inactive list.

Yes, these check should be included for anon.

> 2) vm_flags & VM_EXEC. This mostly doesn't apply to anon pages. The
> exception would be jit code pages, but if we put anon pages on the
> inactive list we should protect jit code the same way we protect file
> executables.

I'm not sure that this is necessary for anon page. From my understanding,
executable mapped file page is more precious than other mapped file page
because this mapping is usually used by *multiple* thread and there is
no way to check it by MM. If anon JIT code has also such characteristic, th=
is
code should be included for anon, but, should be included separately. It
seems that it's beyond of this patch.

> Seems to me you don't need to add anything. Just remove the
> PageSwapBacked branch and apply equal treatment to both types.

I will rework the code if you agree with my opinion.

> > @@ -2056,6 +2063,15 @@ static void shrink_active_list(unsigned long nr_=
to_scan,
> >                       }
> >               }
> >
> > +             /*
> > +              * Now, newly created anonymous page isn't appened to the
> > +              * active list. We don't need to clear the reference bit =
here.
> > +              */
> > +             if (PageSwapBacked(page)) {
> > +                     ClearPageReferenced(page);
> > +                     goto deactivate;
> > +             }
>
> I don't understand this.
>
> If you don't clear the pte references, you're leaving behind stale
> data. You already decide here that we consider the page referenced
> when it reaches the end of the inactive list, regardless of what
> happens in between. That makes the deactivation kind of useless.

My idea is that the pages newly appended to the inactive list, for example,
a newly allocated anon page or deactivated page, start at the same line.
A newly allocated anon page would have a mapping (reference) so I
made this code to help for deactivated page to have a mapping (reference).
I think that there is no reason to devalue the page accessed on active list=
.

Before this patch is applied, all newly allocated anon page are started
at the active list so clearing the pte reference on deactivation is require=
d
to check the further access. However, it is not the case so I skip it here.

> And it blurs the lines between the inactive and active list.
>
> shrink_page_list() (and page_check_references()) are written with the
> notion that any references they look at are from the inactive list. If
> you carry over stale data, this can cause more subtle bugs later on.

It's not. For file page, PageReferenced() is maintained even if deactivatio=
n
happens and it means one reference.

> And again, I don't quite understand why anon would need different
> treatment here than file.

In order to preserve the current behaviour for the file page, I leave the c=
ode
as is for the file page and change the code for the anon page. There is
fundamental difference between them such as how referenced is checked,
accessed by mapping and accessed by syscall. I think that some difference
would be admitted.

Thanks.
