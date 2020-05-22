Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5D1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A40B20776
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPnRvWt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgEVFmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 01:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgEVFmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 01:42:16 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F5CC061A0E;
        Thu, 21 May 2020 22:42:15 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h17so8904211wrc.8;
        Thu, 21 May 2020 22:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=06chsOrgQpjkS/G2JV9vsqi2MbhiGEqCYsM+9Un41es=;
        b=jPnRvWt0Avnr0RC4x9kzCcbvBpUAY6gYq4Xa3jTEkdnW2bv7mRka283TqCNillZXnK
         B+a7TR9U+qeRm+6iVFuCXhqtQzfeWAnJ9QFcLZcCzCW2TRAI2kDxVDTYn1YDsTpvM/UL
         5InKSX3ZmNdHUH4CTMJ3i2FDV7uJqi0ggZNyPb+N18STDoTqSh20ExoagsmUtZw2W5hs
         VESKnoeEcQt19wMOz6zYjtFtPMnmPlPKk0Mr6SFzka9QuRuZUAjAeS89gqK6/1su+K09
         CX8+UCFhJ4dfQ9lYV7HZNLB5+VhTyB/mUDk26xo71geMDgjZplGocmJ0vpWdNsiTYmcm
         GSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=06chsOrgQpjkS/G2JV9vsqi2MbhiGEqCYsM+9Un41es=;
        b=aNtOQbkrJyZS/QnoNp9FIXGxcMIrIfCBg+r4B68/tvmrzaE8z95wBUdrV6TWObahiW
         /RoYE2mKKlG91wsgjIt7Ko6z1Qfytc5Aij/phYg9d6liZ/AqSzILU+2KtVAtZgHp2ig4
         wwKKTuvOOnCuwtQOyBKzBJI2xyi5uVVdbd7cJGGm/3p7QKvD57bZDFdumaQDBtxJDSC/
         9C6xJvdlsvi/8jIeXA6w+4C7cikmmBK1Yf6a1kE8bqNknHqfT9+jP6fKtNQRIIg0MCMG
         MAQv8NoXADxnvnZS5OyUreE0uMRNTnAHr3lD2t/7Uk8bTscKmdFdalAjvhGnYybyNwCH
         YtxA==
X-Gm-Message-State: AOAM531J0qoAxfYhkbJaGgpHOyaHlJthyBcBIasFKCJ5Gx0qsOA9Y/rY
        T3KMt3nvLTAZ+WFQG0YuIzRxtHTXMNgG1woXxr0=
X-Google-Smtp-Source: ABdhPJynqthIPJWIRUluyP+U5q4i7nZgEP4LkojJ69yqmT0dksFo1fdRblwHxH1sjpJ6sczNubh0UyGl7ocbFBtBAzM=
X-Received: by 2002:a5d:654a:: with SMTP id z10mr1737856wrv.234.1590126134702;
 Thu, 21 May 2020 22:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200421143149.45108-1-yuehaibing@huawei.com> <20200422125346.27756-1-yuehaibing@huawei.com>
 <0015ec4c-0e9c-a9d2-eb03-4d51c5fbbe86@huawei.com> <20200519085353.GE13121@gauss3.secunet.de>
 <CADvbK_eXW24SkuLUOKkcg4JPa8XLcWpp6RNCrQT+=okaWe+GDA@mail.gmail.com> <550a82f1-9cb3-2392-25c6-b2a84a00ca33@huawei.com>
In-Reply-To: <550a82f1-9cb3-2392-25c6-b2a84a00ca33@huawei.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Fri, 22 May 2020 13:49:05 +0800
Message-ID: <CADvbK_cpXOxbWzHzonrzzrrb+Vh3q8NhXnapz0yc9h4H4gN02A@mail.gmail.com>
Subject: Re: [PATCH v2] xfrm: policy: Fix xfrm policy match
To:     Yuehaibing <yuehaibing@huawei.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        davem <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        network dev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 9:45 AM Yuehaibing <yuehaibing@huawei.com> wrote:
>
> On 2020/5/21 14:49, Xin Long wrote:
> > On Tue, May 19, 2020 at 4:53 PM Steffen Klassert
> > <steffen.klassert@secunet.com> wrote:
> >>
> >> On Fri, May 15, 2020 at 04:39:57PM +0800, Yuehaibing wrote:
> >>>
> >>> Friendly ping...
> >>>
> >>> Any plan for this issue?
> >>
> >> There was still no consensus between you and Xin on how
> >> to fix this issue. Once this happens, I consider applying
> >> a fix.
> >>
> > Sorry, Yuehaibing, I can't really accept to do: (A->mark.m & A->mark.v)
> > I'm thinking to change to:
> >
> >  static bool xfrm_policy_mark_match(struct xfrm_policy *policy,
> >                                    struct xfrm_policy *pol)
> >  {
> > -       u32 mark = policy->mark.v & policy->mark.m;
> > -
> > -       if (policy->mark.v == pol->mark.v && policy->mark.m == pol->mark.m)
> > -               return true;
> > -
> > -       if ((mark & pol->mark.m) == pol->mark.v &&
> > -           policy->priority == pol->priority)
> > +       if (policy->mark.v == pol->mark.v &&
> > +           (policy->mark.m == pol->mark.m ||
> > +            policy->priority == pol->priority))
> >                 return true;
> >
> >         return false;
> >
> > which means we consider (the same value and mask) or
> > (the same value and priority) as the same one. This will
> > cover both problems.
>
>   policy A (mark.v = 0x1011, mark.m = 0x1011, priority = 1)
>   policy B (mark.v = 0x1001, mark.m = 0x1001, priority = 1)
I'd think these are 2 different policies.

>
>   when fl->flowi_mark == 0x12341011, in xfrm_policy_match() do check like this:
>
>         (fl->flowi_mark & pol->mark.m) != pol->mark.v
>
>         0x12341011 & 0x1011 == 0x00001011
>         0x12341011 & 0x1001 == 0x00001001
>
>  This also match different policy depends on the order of policy inserting.
Yes, this may happen when a user adds 2  policies like that.
But I think this's a problem that the user doesn't configure it well,
'priority' should be set.
and this can not be avoided, also such as:

   policy A (mark.v = 0xff00, mark.m = 0x1000, priority = 1)
   policy B (mark.v = 0x00ff, mark.m = 0x0011, priority = 1)

   try with 0x12341011

So just be it, let users decide.
