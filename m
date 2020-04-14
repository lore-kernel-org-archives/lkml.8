Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63FFC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF1F20578
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="2KlNhzQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437271AbgDNI7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437262AbgDNI7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:59:33 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E09C0A3BDC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 01:59:32 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id m4so12410208ioq.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 01:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ps0rUUJIjN8jOUU540NCbYhMIlpbUvSyeTk00fT86E=;
        b=2KlNhzQLtuXQRSp6m58k5eWmkBihIlZdVNueMW+JsuhLppSHHnnPLEiOTQOXKeSjHr
         RMWmgt8U0Ds5/KWBxHRIXB2r1dQ+yZrXUfde16di0+e49nwwP4WhS30eS1d96URvorDQ
         +DRIM3ZI0ebx7XxTtdLh7XuO4MkQdaXWu3qi0bdYon7aSN2mnayufMly113ziejPEJD4
         jUmK97o9MP9sJhpDZkgiJ5zEUr26wj9TrL/wOj4f+azDKSmodxKyIDcen4BKsvZ39UP7
         gGSBx+cZAZEpHtzx21RiUQI2OTY3qoJYsJjDxw4Dm8SCl25jrY4HyWyhXIDUNH0i36WS
         /6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ps0rUUJIjN8jOUU540NCbYhMIlpbUvSyeTk00fT86E=;
        b=Sz61ZsuAQE5bZx7m4DYmrLVJ1H/+Mxg1KBZqxFiWR0Q1WkZyDxuCtQgmoxSx+W05DE
         VbmmnUk5ppw0c7OU61ianpQ6s+k/X9GEE2hfEQZVllObSOqNAASxPCQJjZysJBDyUVjI
         ZlQkcm3W32iLfiLv3ow8cd6jtFD2oUUDhn6Wj2EqOGmhsP/Rnqxj8VrlsLM0eKR7zrGS
         ya0oRsHFxogKaEpu1+kayXz8ci72Bq83Aui9RZqF9ONFrucuCo0Y8f9cxa6NkZLw//4z
         Wx1m3W+Ui3fZFrZleNafc4iOsMzCZFTuwUsNpzWxJ68rZuy5Rggimm1soUh+et5iJWBP
         R+8w==
X-Gm-Message-State: AGi0PubuMJo9dbJeueAYuCr60CcKQCcoQO5AxhM8siyRHMxx0VGTNj0r
        a4NRgpDp0ijcS6A0Rk3hWUV3/0x+5NpAaNk7f1k2yQ==
X-Google-Smtp-Source: APiQypK0fBhKSolIXP7kMjNQOyFnWbzNrAl7Ps7MwYQHlH24USjan3npQxYlUQFtXq220h5QhBtZEJQszWnd88wwBaI=
X-Received: by 2002:a02:4445:: with SMTP id o66mr19290270jaa.36.1586854771403;
 Tue, 14 Apr 2020 01:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200409134558.90863-1-songmuchun@bytedance.com> <20200410115658.GB24814@willie-the-truck>
In-Reply-To: <20200410115658.GB24814@willie-the-truck>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 14 Apr 2020 16:58:55 +0800
Message-ID: <CAMZfGtURunxwwGHM+5J-A605y=Ww=jQsxCF173mgQFQ=ySVV0A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] seqlock: Use while instead of if+goto in __read_seqcount_begin
To:     peterz@infradead.org
Cc:     mingo@redhat.com, Will Deacon <will@kernel.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 7:57 PM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Apr 09, 2020 at 09:45:58PM +0800, Muchun Song wrote:
> > The creators of the C language gave us the while keyword. Let's use
> > that instead of synthesizing it from if+goto.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/seqlock.h | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> > index 8b97204f35a77..7bdea019814ce 100644
> > --- a/include/linux/seqlock.h
> > +++ b/include/linux/seqlock.h
> > @@ -125,12 +125,8 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
> >  {
> >       unsigned ret;
> >
> > -repeat:
> > -     ret = READ_ONCE(s->sequence);
> > -     if (unlikely(ret & 1)) {
> > +     while (unlikely((ret = READ_ONCE(s->sequence)) & 1))
> >               cpu_relax();
> > -             goto repeat;
> > -     }
> >       kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
> >       return ret;
>
> Patch looks fine to me, but I'll leave it to Peter as I don't have a
> preference either way.
>

This patch can make the code look simple and easy to read.
What is your opinion, Peter? Thanks.


-- 
Yours,
Muchun
