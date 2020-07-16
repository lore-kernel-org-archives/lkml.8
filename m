Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80013C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4BB206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y78pB0MW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgGPQuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPQuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:50:00 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C571C061755;
        Thu, 16 Jul 2020 09:49:58 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id p25so3366588vsg.4;
        Thu, 16 Jul 2020 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3wSUvUaS6cRd+frWVKlR9DEyTRqvNIifJtDj8gqJC1k=;
        b=Y78pB0MWKHWb0xMcZpVD+JD0mnaMYlz1PHxJys1Ud/+l+NbYSDV3ok5xmAjkwaWj8D
         urjXWNwgQcL9/mykSLKsBfm23Z1UpVxu2RxfLysEh/60jyyPHTD+vxB4z+DSZOYYEYYn
         kWNZmMwvj5pZMffkYPIo5QII1vBlyJwc+FG1UkIhON9WLCKCegPufUYUFeX+q1b/HsD6
         2xa+Wi9MgLd9V0tshGT/PFR7srao02KkHQRY8unbIHhx5lDV6NY59qsDnMGV1izOZsR/
         BHGv+dfEeoGGHCk4m2HtC72pMIlV7NOjwIaW7jgPVl1zUv38sDyb0Duh3grgvdLtYJ8/
         Dovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wSUvUaS6cRd+frWVKlR9DEyTRqvNIifJtDj8gqJC1k=;
        b=QXxI13p6WKyZ13L5/z/W3MjUiUYEdQW55QU1NgWYlaoBSp728t5y6fLd+ZF8T55jty
         IjRod2mPbLOotL33/2mrQkVqqBFxiv2QCRx14n5+F+20lLPkHxcy31JojD61fE/wNp2T
         u2v9HvV7tZM1K4sTBvLli8Txk5uHG6WYKIJv1QZFi2ySYO1nXk+glO7i23240JKPJBpj
         a4wWN6A21U7trrgC5V+lgDuAqGqB3xIZShJK5bLLnRNfkhIpPYr6lnWQjAxt4QW7WjpB
         GYWzzeXI1xSVYcpmH9qagELnpWaZhcW79gJyuXn1rxUJ00w41ExWDty44YXZtRlF5lcI
         Yn5Q==
X-Gm-Message-State: AOAM5326wo2udMeea412Qd2wbQ1rpyE7Fx7+iEXbgAMA+a2Q6dQWf86c
        OZ13A7VEdoGlQuEA6fDCvhsIOztiSCBNFkhYtnc=
X-Google-Smtp-Source: ABdhPJxEEuUzAe3HPLSdKHrS6zY0Au5HEuw0f1/7tM4pxLGyYe5P9HtqUbBoZkJpapEfRcOxsF8zjrCXlF0wloEuh58=
X-Received: by 2002:a67:1183:: with SMTP id 125mr4212880vsr.56.1594918196381;
 Thu, 16 Jul 2020 09:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200620180643.887546-1-jim.cromie@gmail.com> <20200620180643.887546-14-jim.cromie@gmail.com>
 <30de6359-e56b-0915-5742-a360ef1b2814@akamai.com>
In-Reply-To: <30de6359-e56b-0915-5742-a360ef1b2814@akamai.com>
From:   jim.cromie@gmail.com
Date:   Thu, 16 Jul 2020 10:49:30 -0600
Message-ID: <CAJfuBxww0VhwBymScJP-eyag0JB=jEa4v5ch14TiZZybq7EOsA@mail.gmail.com>
Subject: Re: [PATCH v4 13/17] dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'
To:     Jason Baron <jbaron@akamai.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Will Deacon <will@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -321,6 +321,8 @@ static int parse_linerange(struct ddebug_query *query, const char *first)
> >       } else {
> >               query->last_lineno = query->first_lineno;
> >       }
> > +     vpr_info("parsed line %d-%d\n", query->first_lineno,
> > +              query->last_lineno);
> >       return 0;
> >  }
>
> This bit seems like its unrelated to this patch and makes more sense in the
> previous patch, or as separate patch...
>
> Thanks,
>
> -Jason
>

ok, I'll split it out, maybe merge with prior.

Any other tweaks ?
maybe move export last in series ?
how do you feel about changing the pr_fmt
to just mod-name "dynamic_debug" or "dyndbg"

Jim
