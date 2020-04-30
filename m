Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7A2C83002
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1B1E20709
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBzuDoac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgD3Dlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 23:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726309AbgD3Dlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 23:41:36 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6A6C035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 20:41:36 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id g4so4941257ljl.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 20:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lAKpy9G6EbRWu0SNu7HqdDYc2mfW8XyOZWnaalUzsJo=;
        b=cBzuDoacowIj6r76Enk8iq8XtYvrttouwz6NUcNP3//+E9reswYpl0QZb42CEE6azq
         KGTYCkmEkA8J6UJwfWuFWkRnvkIwNlsH9zIEnSGLH8fIWsyK4Cl0dPwGT8IcWwy3FFS6
         P3U24KtHwq6fk6ZWPHh8m/kcuUnK6ZdWSuuhaoEsY5bwPNiPxqwbTMcS48fmXObr6k5B
         vPlQcd5IPw3BHbW/HSNECbZ3oVSyWYQdHskdF2JUoDDI5scAvrF4SX3wqmf3TE7LpUau
         KlWfDWBsVPP91YNJAgpCiV2xTCXM2E5lESKIiq+L/mFguTtdZq0qJVcXkX5U4vx3sQiB
         +4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lAKpy9G6EbRWu0SNu7HqdDYc2mfW8XyOZWnaalUzsJo=;
        b=MsdZTj94yuSDxphEakQ8xZAdqHOkOW5C012aIDjrzHOdXvtbT8D7BTBYZBHbkqEpBq
         6t1mUiG1uOZst23y6VNYW3r+sLKdTo5kHfkTlwtNwOKLY15uun5iOsaTlABK8ayUqnRE
         qJqfowZoyYuTo0fe+RFmTrXTnuXM+jbLgd2wBwY2W9BKsmk7JXFXGs96Cb8Qp0LweXl1
         wZwNf4z5I5RsiG6CKcB/GFirEp2PH9e6qT9M+hdec0R6oFRUXatcbFzuPMyD1aqfVS3g
         3CcwfXbTlxymdEHqc5NO787n9t2Tuw8jOM2ix+zQHiBt5+0wNpvaU8Fa3mVKtZgD2FPh
         8gyQ==
X-Gm-Message-State: AGi0PuYc2wWRWnBUfsAOWL/ZqJLyXbQyFH9GBe5jxzgRoc3vE6MFt26q
        Pdrz7Nyf6Q+VcMRSkMhsxkcatVXf4lJWwPDgmpziSg==
X-Google-Smtp-Source: APiQypKrg+xYbwS9RWRxcI8l8qcEHNfYdlwlHnLQTHxwHOGeSvThNBa+jOvRlnv1RK8sPNAe6sjlczuJdlVwA2Yhl1s=
X-Received: by 2002:a2e:8999:: with SMTP id c25mr829356lji.73.1588218094500;
 Wed, 29 Apr 2020 20:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <CAHk-=wi_zr9dwX3UBYvgkmm6eVQfRP50orryJ6ZVAxuFqdSG5A@mail.gmail.com>
 <20200428190836.GC29960@redhat.com> <CAHk-=wi03QRcUR1DfbEr+Pw-DAMENzY-FuRcGawtj9p597=p2w@mail.gmail.com>
 <CAG48ez03ABTa-KbCtFHqB1hOT7dgAM96c3kiw-e80B+utSEwYw@mail.gmail.com>
 <CAHk-=wjTLnMuZmBO2foeHhsLAoUTpUi7oBVJ67F4XKB+tdEDbQ@mail.gmail.com>
 <CAG48ez3EQOvdbzu9aO-cEAJwF_=fJzn1Cg0LMs3ruc=5r1ie5w@mail.gmail.com>
 <CAHk-=whTgFbjGTP=CqMWs_LOkY7bWvLQGYKwKx86amdbMovAkw@mail.gmail.com>
 <CAG48ez2-Nu2ALN6VEUZL-prtR_Kk8QYBHcnvuh0aU2e4zf37RA@mail.gmail.com>
 <CAHk-=wh=G47oD2F1CgOrvGFbEPh2ddMKLV4_wV_bs6S=98aZ5A@mail.gmail.com>
 <AM6PR03MB5170A6AA240D2E8F5E88B911E4AD0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wguiKq8yf11WJjgSL4ADKZ5sLe_Qbd7vHEqAkTvZJ+d+Q@mail.gmail.com>
 <CAHk-=wjUZLybZBJgOtD2gng=FS7USrbQQ1-tn5M+UP5DbCWdzw@mail.gmail.com>
 <CAG48ez0FL3i4eGFYryOwG2nnS+JigfKYAVSV9ogVHjmjOWzsrA@mail.gmail.com>
 <AM6PR03MB5170C5D02C6FCB6D69DFE3ADE4AA0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg6oKSLkVhY5oqOFyzCCSr9eYPGK2SHJfgCXF_QOmPKog@mail.gmail.com>
 <CAG48ez25=6qrCU51dEAV_ciyU2jvPuRFWfFOAAT22kmeAZccuQ@mail.gmail.com> <CAHk-=wjE_YJ4SFJUasF=tW0jMr6zg+rkRNuNt2hdODPu_LLTVw@mail.gmail.com>
In-Reply-To: <CAHk-=wjE_YJ4SFJUasF=tW0jMr6zg+rkRNuNt2hdODPu_LLTVw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 30 Apr 2020 05:41:07 +0200
Message-ID: <CAG48ez0yLF4KAK5uMi1_b9woC7NYy0NamYD1jP7BOPJkpKR7Mw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 5:26 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Apr 29, 2020 at 8:00 PM Jann Horn <jannh@google.com> wrote:
> >
> > But if we go with Bernd's approach together with your restart
> > suggestion,
>
> So repeat after me: Bernd's approach _without_ the restart is unacceptable.
>
> It's unacceptable because it breaks things that currently work, and
> returns EAGAIN in situations where that is simple not a valid error
> code.

Sure, makes sense to me. I'm not eager to start randomly throwing
EAGAIN where it couldn't happen before either (and I initially missed
that Bernd's patch did that for procfs files, too).

> That bug has nothing to do with ptrace(). It's literally a "write()"
> to a file in /proc.
>
> What is so hard to get about this basic thing?

You said:

| So a ptrace() user (or [...] wouldn't even see the impossible EAGAIN error.

So I assumed you explicitly wanted ptrace() to restart, too. I was
just pointing out that that didn't make sense to me.
