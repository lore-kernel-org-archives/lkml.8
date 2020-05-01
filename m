Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DBBC35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A665208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sl1JL0Aq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgEAVJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAVJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:09:09 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D3BC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 14:09:08 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id l19so3770845lje.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 14:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x04P+zjFpwy+CE+LmGmypRV0DXrC/67SUR0cWlYpuzo=;
        b=Sl1JL0Aq3kvwbS6AivuUGYJxWK4VdCD06bIWO3mLHQ0kGy2VWJvb7B0sajmZIoN1g5
         iBm3hANHeRbiMYsE56oMVuIU9PKRzwrzDWTuNMbBts7k3hvgXmNErUGRE2AD7AIYB1Ks
         thFE/+VFgp77SYMC8Z6Ex/5bGYoxpKR+3m5y7rknt9fE5fAA1CYJvvetCjdASAQbevqP
         33k9JWJ2MtsFFblUfMGrezhg1io0B1UVod8DSQ85xCU7J81Qdd9VMzC3K5iIqJ9k9km7
         obrKgB7T41NMc+nfM2R2vpRWOjHJLVwGy/gFilSYkEGx1Fe4+p+xOJpzZvi5WWOk0eoJ
         8M7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x04P+zjFpwy+CE+LmGmypRV0DXrC/67SUR0cWlYpuzo=;
        b=XacxG2c0HTfc1INKHb/sru4YuR9FErzitIMXfBtkst+ovvFNuMapv69fwLFCx8/V7S
         v7K17ZD89GyA9V7zSCi5drnOzW07Ef1KnAtzPOozaPCTgkRXL//oa32Npl6S9u2JvTtw
         9mS7QA0BpsvnmHtszqLLfAwoVCanlgB8OVvVrh2xD2YFWuE715VuzaIfrQgOv7EqLktF
         7lENlHbndpNnZWbIomtOoWsALkGS8n3yT/mFuJBP7ny1R294PLVH7wavCsegO6imbL3e
         dh5EB2WRR8Hm1DwhpzNII5CRERnQzWgfwKqTL6+CF8365M0HKbXbeKERk26YNGoaCT6+
         kJNg==
X-Gm-Message-State: AGi0PuZcfKx93KO9PWptUSe1AAfjDRLPJoMml4HHQu8WJpHU6GdqNuee
        NcWoN1XQUyvqp3fBfC3991MlMxWURiHhl0mu5SU=
X-Google-Smtp-Source: APiQypISFMZYh6/WnwoE4zYIYRZ6W4TIsYZUVBUabxADDAgmg5ZG5QTesER3BzYBdsXOGwh5AlYiIukHvENIaq39S9M=
X-Received: by 2002:a2e:3012:: with SMTP id w18mr3498996ljw.55.1588367346623;
 Fri, 01 May 2020 14:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <1588277518-21425-1-git-send-email-jrdr.linux@gmail.com> <20200430212411.GB582335@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200430212411.GB582335@iweiny-DESK2.sc.intel.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 2 May 2020 02:46:59 +0530
Message-ID: <CAFqt6zZ0w+i-Chc7_MCvjbMjWmC78+T+E+5RwGF=pc7ouMnHBA@mail.gmail.com>
Subject: Re: [PATCH] mm/gup.c: Handle error at earliest for incorrect nr_pages value
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 1, 2020 at 2:54 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Fri, May 01, 2020 at 01:41:58AM +0530, Souptick Joarder wrote:
> > As per documentation, pin_user_pages_fast() & get_user_pages_fast()
> > will return 0, if nr_pages <= 0. But this can be figure out only after
> > going inside the internal_get_user_pages_fast().
>
> Why is nr_pages not unsigned?

Not sure of why but it can be unsigned.

>
> >
> > This can be handled early. Adding a check for the same.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> >  mm/gup.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 50681f0..a13aaa6 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2817,6 +2817,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
> >        */
> >       if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
> >               return -EINVAL;
> > +     if (nr_pages <= 0)
> > +             return 0;
>
> I think the documentation may be wrong here...  Is there a caller who expects a
> return of 0 for this behavior?
>

My understanding is -
{get/pin}_user_pages_fast() -> internal_get_user_pages_fast()

Inside internal_get_user_pages_fast()
...
start = untagged_addr(start) & PAGE_MASK;
addr = start;
len = (unsigned long) nr_pages << PAGE_SHIFT;
end = start + len;

if (end <= start)
return 0;
...
This is the only place where {get/pin}_user_pages_fast() returns 0 which
indirectly checks for nr_pages <= 0. For each call to
{get/pin}_user_pages_fast()
we end up checking *nr_pages <= 0* anyway.

There are some instances where caller of these APIs handles return
value 0 as well. Example -
arch/ia64/kernel/err_inject.c#L145
arch/powerpc/kvm/book3s_64_mmu_hv.c#L582
arch/powerpc/kvm/book3s_64_mmu_hv.c#L1174
drivers/staging/gasket/gasket_page_table.c#L489
drivers/rapidio/devices/rio_mport_cdev.c#L865
drivers/platform/goldfish/goldfish_pipe.c#L277
drivers/gpu/drm/via/via_dmablit.c#L242
(some of the error handling looks incorrect)

If we end up checking *nr_pages <= 0* inside  internal_get_user_pages_fast(),
then why not at first place like this patch does ?

2nd opinion is, inside internal_get_user_pages_fast(), for *nr_pages
<= 0* better
to return -ERRNO rather than 0 ?
