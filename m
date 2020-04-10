Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB621C2BB86
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04EA212CC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kuywN1kl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgDJQ0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 12:26:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37249 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgDJQ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 12:26:29 -0400
Received: by mail-oi1-f194.google.com with SMTP id u20so1806444oic.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yMpjPxGLH2Lp2A4mAz8ncaxXmDPUVi4Uv45pydJcVpE=;
        b=kuywN1klF3kBcJFwWdJ5ijaZAm+7utN3CT2xbbOKo0hdFunF60vX+2OTdGiWqQDzyB
         /c5UIni7YWWpnEyFGbWYryN+NJkGWUg6axBuEC//gAgOjVcZml1B58XL8q1p2ER5uQar
         hnUs3jKdxIMZjfN0XJIlCMoFVIjlbVAsWNAs/ZIIQDRT9QS5evCuVaHBhwdMGw+73ekN
         c5GV4iy+scAFfCAKFuWKZj1Wwp7iNKk/TmUb1amSqhBMxLZeMUSai++DcBgA5CnAtzEM
         S2jm3GMt7afBQSNUkMPnd+RQ5HMbH2IN0KIXb3tDH4vZTS2ZDh40rJ/GNjI5IJmN68nZ
         KKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yMpjPxGLH2Lp2A4mAz8ncaxXmDPUVi4Uv45pydJcVpE=;
        b=sOcbMOJbJr9P9rwrNlX42ysFndfmWVbZZ5DMlS8z7/BpNrm9MxKak2fRnTn/lj86ZF
         99uaETPgVm1Xk868ZaBxwzKuK8nS1sYj0D41OAEqvVp5Qh9oD9PFDD+grj3w+SGOJtsI
         DNrxVQE0ofeYsWzSUBX4qlaxsffU4MvehNm1ytehYDcRn70ynAU36haYnwl5Cvs5i250
         k24u1CsomfRu4YEFZISv0hyN8TgZTSDBrjeBrb1TQZTu/g62LIRWF/W9nB3GhcI+eOG3
         qqmcCDIMTQGzGfX+UMUmmONYuB46JP0TEsIzgjQoSeYQ7nfZXwcG83fDlambaHJISYfR
         JaDA==
X-Gm-Message-State: AGi0PuaOlpZWn+AmFlCKx1Lys1Dyl2kv20wFqQKpxpGa8K5mEYWXEti5
        xrFk85DaAgKIcfvsMqG/epzZ8m8U4teFY+boxoH5vCnE
X-Google-Smtp-Source: APiQypLwu3CIER9GRUCXG/kaBErHqHIU1JKtWh1Oqv6yRwp2XcMnJ2Wqf+F/NUj5ULxwn4dcYERJFvFH0f97UW/gKwI=
X-Received: by 2002:aca:682:: with SMTP id 124mr3967570oig.69.1586535987677;
 Fri, 10 Apr 2020 09:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200410034634.7731-1-sashal@kernel.org> <20200410034634.7731-14-sashal@kernel.org>
 <20200410062931.GD1663372@kroah.com> <CAGETcx9Kp6JvuyF770XKsMTCY6=rC2zuBTG07oB18bya0owgWw@mail.gmail.com>
 <20200410065227.GA1665508@kroah.com>
In-Reply-To: <20200410065227.GA1665508@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 10 Apr 2020 09:25:51 -0700
Message-ID: <CAGETcx8RBjr6rzR7=m6LuA=OQOT2Hh4ioPndUP8mkpYLve+6yw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.6 14/68] driver core: Reevaluate
 dev->links.need_for_probe as suppliers are added
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 11:52 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 09, 2020 at 11:39:55PM -0700, Saravana Kannan wrote:
> > On Thu, Apr 9, 2020 at 11:29 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Apr 09, 2020 at 11:45:39PM -0400, Sasha Levin wrote:
> > > > From: Saravana Kannan <saravanak@google.com>
> > > >
> > > > [ Upstream commit 1745d299af5b373abad08fa29bff0d31dc6aff21 ]
> > > >
> > > > A previous patch 03324507e66c ("driver core: Allow
> > > > fwnode_operations.add_links to differentiate errors") forgot to update
> > > > all call sites to fwnode_operations.add_links. This patch fixes that.
> > > >
> > > > Legend:
> > > > -> Denotes RHS is an optional/potential supplier for LHS
> > > > => Denotes RHS is a mandatory supplier for LHS
> > > >
> > > > Example:
> > > >
> > > > Device A => Device X
> > > > Device A -> Device Y
> > > >
> > > > Before this patch:
> > > > 1. Device A is added.
> > > > 2. Device A is marked as waiting for mandatory suppliers
> > > > 3. Device X is added
> > > > 4. Device A is left marked as waiting for mandatory suppliers
> > > >
> > > > Step 4 is wrong since all mandatory suppliers of Device A have been
> > > > added.
> > > >
> > > > After this patch:
> > > > 1. Device A is added.
> > > > 2. Device A is marked as waiting for mandatory suppliers
> > > > 3. Device X is added
> > > > 4. Device A is no longer considered as waiting for mandatory suppliers
> > > >
> > > > This is the correct behavior.
> > > >
> > > > Fixes: 03324507e66c ("driver core: Allow fwnode_operations.add_links to differentiate errors")
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > Link: https://lore.kernel.org/r/20200222014038.180923-2-saravanak@google.com
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > ---
> > > >  drivers/base/core.c | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index dbb0f9130f42d..d32a3aefff32f 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -523,9 +523,13 @@ static void device_link_add_missing_supplier_links(void)
> > > >
> > > >       mutex_lock(&wfs_lock);
> > > >       list_for_each_entry_safe(dev, tmp, &wait_for_suppliers,
> > > > -                              links.needs_suppliers)
> > > > -             if (!fwnode_call_int_op(dev->fwnode, add_links, dev))
> > > > +                              links.needs_suppliers) {
> > > > +             int ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
> > > > +             if (!ret)
> > > >                       list_del_init(&dev->links.needs_suppliers);
> > > > +             else if (ret != -ENODEV)
> > > > +                     dev->links.need_for_probe = false;
> > > > +     }
> > > >       mutex_unlock(&wfs_lock);
> > > >  }
> > >
> > > For some reason this wasn't for stable kernels, but I can't remember.
> >
> > It *is* for stable kernels too. It is an actual bug that's fixable in
> > stable kernels. I think this might have been the one patch that I
> > bundled into an unrelated series, but called it out as an unrelated
> > bug. Maybe my wording in that email threw you off?
>
> I think it did, sorry.  So no problem adding this to the stable trees so
> I can go add it right now?

Yes, please do.

-Saravana
