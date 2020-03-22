Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90633C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F17E20724
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qOUehZhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgCVQkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 12:40:43 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45886 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 12:40:43 -0400
Received: by mail-ot1-f66.google.com with SMTP id c9so823195otl.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 09:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/NRcff3IU+6Tgzkshu1srIwPGx1YyS4nMPqqG29Ytvw=;
        b=qOUehZhX/pacNMUrZn/+2SHmA4iod5L4EySZ0kuBn/JxSDPHHsZ4fUjgfRPm5xH/ur
         QhZW2pgT6REGxos8IW5vtbuWqrcPmZOKZYbh0zucvshGq41tH0oYUvqFq9R52YJ2MSCK
         ui/JImCB7Ii7rGWqmE83tjH2r0Ktg/7whFLg8eTxxywfklN6+NgCwh9TwZHvrYvDXdXa
         f8hTK2U4JPZ6vqrGlbaqIyTYMooPNXIMk4L1t2LND7/PBl2spbVXqYl4p9bZ/LCVrcqu
         LS+UD0HrPB7TiFLSrhB+PyIsdC1e3Tcw4GVy+2xakizAMaqU7c2RcnqGxmVVrmur5Mtk
         F+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/NRcff3IU+6Tgzkshu1srIwPGx1YyS4nMPqqG29Ytvw=;
        b=JEEGNP2jiJWujUNoTgmospO/qfLu33rRR9ROPj8RYIlTG+0GLsQQK0Vx/LJKkBWBJe
         FttkMONdYJIGJq1yij7JtGXOp3HMEX+fWvayAsv5JDt1eq2zZ3ioLfPptEximHsDbxdF
         P2WuBdYLCIvBh+Vn7crBQQkEaQhQlNvJ1sLAv9MtadpLtlIegVzDwFTdKMqAX3yW4tuo
         rbvSXWs0jqxVE6jZuTnvqmOLjlHn1skzqfvZEggNmqDwYsHv1gzaIkrSb2j8dUAW/sRN
         3F2XD60QEUnr86L4imF/xwHZG4thhX+BpN9fqr66EhJv65FVJGl61CTYwt/6W2yeGIF0
         NmfQ==
X-Gm-Message-State: ANhLgQ2tyXO/lq4wxCBKAnwGhryWX/wOgspHvK+2SPDvhv+hKnIqpiVR
        ttn3mMTuRACKkcDX7vOmmFtYxX98a1yaY0dUJR9ygA==
X-Google-Smtp-Source: ADFU+vsVjAmfgADMn2cxBqjZaGcNAPlcChbn032d7ohsMEN24TTue0FnA92UPrFjZQ8PErnKxknKoey9xg0zOjUTle8=
X-Received: by 2002:a05:6830:1054:: with SMTP id b20mr4151189otp.360.1584895240706;
 Sun, 22 Mar 2020 09:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200322013525.1095493-1-aquini@redhat.com> <20200321184352.826d3dba38aecc4ff7b32e72@linux-foundation.org>
 <20200322020326.GB1068248@t490s> <20200321213142.597e23af955de653fc4db7a1@linux-foundation.org>
 <20200322054131.GC1068248@t490s>
In-Reply-To: <20200322054131.GC1068248@t490s>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 22 Mar 2020 09:40:29 -0700
Message-ID: <CALvZod5cC6dzMkLNh0Rt_VcdmcyuJHuSMqTjWYdYVVp9RDkYPA@mail.gmail.com>
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 10:41 PM Rafael Aquini <aquini@redhat.com> wrote:
>
> On Sat, Mar 21, 2020 at 09:31:42PM -0700, Andrew Morton wrote:
> > On Sat, 21 Mar 2020 22:03:26 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> >
> > > > > + * In order to sort out that race, and get the after fault checks consistent,
> > > > > + * the "quick and dirty" trick below is required in order to force a call to
> > > > > + * lru_add_drain_all() to get the recently MLOCK_ONFAULT pages moved to
> > > > > + * the unevictable LRU, as expected by the checks in this selftest.
> > > > > + */
> > > > > +static void force_lru_add_drain_all(void)
> > > > > +{
> > > > > +       sched_yield();
> > > > > +       system("echo 1 > /proc/sys/vm/compact_memory");
> > > > > +}
> > > >
> > > > What is the sched_yield() for?
> > > >
> > >
> > > Mostly it's there to provide a sleeping gap after the fault, whithout
> > > actually adding an arbitrary value with usleep().
> > >
> > > It's not a hard requirement, but, in some of the tests I performed
> > > (whithout that sleeping gap) I would still see around 1% chance
> > > of hitting the false-negative. After adding it I could not hit
> > > the issue anymore.
> >
> > It's concerning that such deep machinery as pagevec draining is visible
> > to userspace.
> >
> > I suppose that for consistency and correctness we should perform a
> > drain prior to each read from /proc/*/pagemap.  Presumably this would
> > be far too expensive.
> >
> > Is there any other way?  One such might be to make the MLOCK_ONFAULT
> > pages bypass the lru_add_pvecs?
> >
>
> Well,
>
> I admit I wasn't taking the approach of changing the kernel because I was
> thinking it would require a partial, or even full, revert of commit
> 9c4e6b1a7027f, and that would be increasing complexity, but on a
> second thought, it seems that we might just be missing:
>
> diff --git a/mm/swap.c b/mm/swap.c
> index cf39d24ada2a..b1601228ded4 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -473,6 +473,7 @@ void lru_cache_add_active_or_unevictable(struct page *page,
>                 __mod_zone_page_state(page_zone(page), NR_MLOCK,
>                                     hpage_nr_pages(page));
>                 count_vm_event(UNEVICTABLE_PGMLOCKED);
> +               SetPageUnevictable(page);

No, this is not correct. Check __pagevec_lru_add_fn() for
TestClearPageUnevictable().

As I mentioned in the other email, I think the better solution would
be to introduce a sysctl to drain the pageves. That way there will not
be any dependency on compaction as was in your original patch.

Shakeel
