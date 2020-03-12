Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B32DC2BAEE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 01:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5355220753
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 01:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goyBr3vT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbgCLBlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 21:41:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41705 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387518AbgCLBlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 21:41:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id b5so4162095qkh.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 18:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nF5tqHstvUA30W4LSx4fCVSXA64TvPNEEL8r1P7taag=;
        b=goyBr3vTreoPre7Am+Z4s9hv82VQd0R5kunT8Sv6AMal/j74vgclsA/yQaaeOoBVyR
         OUBGqH1mvr56+9VtAqAH4xW1tjsdX+taJvZCWXimpHRcRTg8jQFxRxlFr88lwH++AUS/
         AvHSWeNaWYQ+lj2X6v2DCypuHSt469HEy8r56wGgGVP9wxWutcmSIW3QjIbmq72uvcfn
         xIGBLHNwpjvk2QN3n8wAYoeeunBv6b+fT1ZfCmfKpVIngny711FQOGLsenn+kBbC9d5d
         E8HysjZA1CEPrLx/9a0oUDW6JE1WvRahvLmL/ssi46iO8mSYHFyK8KbLDZW4u9YNjmsm
         J6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nF5tqHstvUA30W4LSx4fCVSXA64TvPNEEL8r1P7taag=;
        b=Fm2W/9+S+ubnfvZ3A8itR6GH7RWlxHj4RJLKxYkGtIy5K1EWT/OxwZbYZTRGDEToR+
         B/BFlHRE7HME278aioFkoZ75q/etf2BOP5Dew8l3edvjzlvV54lgAmh5UvrZDpvj788J
         x7DkerCmWEcvjioL+NRNb9/ZjH5vBio2spIrZ9cc/zslYaKpcaikAKhiqNMMByzywvN1
         +cj1A/BO71UXa3/JXpXb3/z4GoREb6dk0S2fZhJfP3e/rL2L+fdYxq6jMezy3Y7vJBG/
         lk01AafmRhfeZOmjMj8bR13rrxBP1nAEp0/qc3g5RrDK4U9KvMR+yHTStj5jT8aUCMqg
         7vZg==
X-Gm-Message-State: ANhLgQ061AcXv+xIZ2UT6zJWgrUL55pqQKNEijwCBP+F8KroDsvOj23y
        nNCmZ0bMe4mqM7PIpmQnrT9ux8y7HjATXyr4SysUwl8PsQY=
X-Google-Smtp-Source: ADFU+vsSUTM7uycwkJRxMgl2aNE471s3inCBkW/jeII4Fkhf1HhYIbpK/48gHDTdXi2/24kn+94+ftqMZt6AFqvV7Q0=
X-Received: by 2002:a37:546:: with SMTP id 67mr5362123qkf.272.1583977299116;
 Wed, 11 Mar 2020 18:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200306150102.3e77354b@imladris.surriel.com> <8e67d88f-3ec8-4795-35dc-47e3735e530e@suse.cz>
 <20200311173526.GH96999@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200311173526.GH96999@carbon.dhcp.thefacebook.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 12 Mar 2020 10:41:28 +0900
Message-ID: <CAAmzW4PRCGdZXGceSCfzpesUXNd8GU-zLt-m+t762=WH-BjmoA@mail.gmail.com>
Subject: Re: [PATCH] mm,page_alloc,cma: conditionally prefer cma pageblocks
 for movable allocations
To:     Roman Gushchin <guro@fb.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Roman.

2020=EB=85=84 3=EC=9B=94 12=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 2:35, R=
oman Gushchin <guro@fb.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, Mar 11, 2020 at 09:51:07AM +0100, Vlastimil Babka wrote:
> > On 3/6/20 9:01 PM, Rik van Riel wrote:
> > > Posting this one for Roman so I can deal with any upstream feedback a=
nd
> > > create a v2 if needed, while scratching my head over the next piece o=
f
> > > this puzzle :)
> > >
> > > ---8<---
> > >
> > > From: Roman Gushchin <guro@fb.com>
> > >
> > > Currently a cma area is barely used by the page allocator because
> > > it's used only as a fallback from movable, however kswapd tries
> > > hard to make sure that the fallback path isn't used.
> >
> > Few years ago Joonsoo wanted to fix these kinds of weird MIGRATE_CMA co=
rner
> > cases by using ZONE_MOVABLE instead [1]. Unfortunately it was reverted =
due to
> > unresolved bugs. Perhaps the idea could be resurrected now?
>
> Hi Vlastimil!
>
> Thank you for this reminder! I actually looked at it and also asked Joons=
oo in private
> about the state of this patch(set). As I understand, Joonsoo plans to res=
ubmit
> it later this year.
>
> What Rik and I are suggesting seems to be much simpler, however it's perf=
ectly
> possible that Joonsoo's solution is preferable long-term.
>
> So if the proposed patch looks ok for now, I'd suggest to go with it and =
return
> to this question once we'll have a new version of ZONE_MOVABLE solution.

Hmm... utilization is not the only matter for CMA user. The more
important one is
success guarantee of cma_alloc() and this patch would have a bad impact on =
it.

A few years ago, I have tested this kind of approach and found that increas=
ing
utilization increases cma_alloc() failure. Reason is that the page
allocated with
__GFP_MOVABLE, especially, by sb_bread(), is sometimes pinned by someone.

Until now, cma memory isn't used much so this problem doesn't occur easily.
However, with this patch, it would happen.

Thanks.
