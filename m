Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244C3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F110D207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m72c9lmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgGILUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgGILUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 07:20:38 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE4EC061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 04:20:37 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id l1so1906534ioh.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 04:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7q7kkmf8wZyu5ug5I9VjNgbwhsLCYY0Z9gPTp77FgyE=;
        b=m72c9lmdtddUuZSEuKmFaloK+d6prkvhzEMCNvxu12H/4EWQlyoqIhLZRGjXuKE5Cd
         305maYmSdpNNpVPX/sGifLZu5sM4FSOjn+5pMa6Ji1T8374Sc52dynsNFRp44qZ1s1LD
         djl3PLvZV25CbO7t53Hlu45DRv8BdH6w7Y6S/qEL77Dlz2WvTz1Kn1k9uTqjYMXiankQ
         FcEDgAjPKPiSll/zp2XTGUBDhVPge9Pzm8A5XWXtOxR98S4g3jRitSjcNUOyPKoFEX4J
         ctTYXKi+NNF8nerjpz65aUo5MKf+T83aCg39LUdyW5CIlkKUdOI6+07406P24Vy5VyH3
         aoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7q7kkmf8wZyu5ug5I9VjNgbwhsLCYY0Z9gPTp77FgyE=;
        b=iOT0wJNlUW0IJURJnmhUulp3oam1MCLjp5uAjySXYq73QnPqLmEFnKBz7zbQ61hCek
         y6itRa1A0s0ZFGjY7DaNbU/ztQKeIPf6xD4w+m+nNAn2/cKreop2CLsf0BlZH4UxsCjr
         +NdXLBKdc9D5JjvlYcyIFgYsTeHkvUx4BbzVk0G3+h0K645mdJal2LLDx0qMkYOFsObE
         wOEVz8pt7u2ukUFy0FWuddNp/9ETsfwv+KLWDl65VGbyn8OHoyAyitnaS+G14+gqJ6hs
         6UTD+sOorc1C+KgOLjngXGEey5GGTgLSgmqFGFao0cbtD9/FddS4TGyK1JAuMogEfaBj
         xj3Q==
X-Gm-Message-State: AOAM5328GC+SMrMIOH4pG6Er25/mUA04HPJ81OCP/G5C5cy5ixjOn6v1
        Y2p6DA+FDtGSLcQnnSzRPuIHGhDZX8S7JGK1xUc=
X-Google-Smtp-Source: ABdhPJz0FlFUKvhOR52ze1uV0vP9JT6ZxlBDHqQ+9vehqjJWEXItQIQ5zTLj4B6Qj6+W2A7aIklPd+ZSVU/UWmQuqlg=
X-Received: by 2002:a05:6602:2dd4:: with SMTP id l20mr41510009iow.13.1594293637259;
 Thu, 09 Jul 2020 04:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200709062603.18480-1-mhocko@kernel.org> <20200709062603.18480-2-mhocko@kernel.org>
 <CALOAHbAezHHN58cn0unLNbOjHJyYW=zhzQxpQD8_rD4O7qmYRQ@mail.gmail.com>
 <20200709081813.GD19160@dhcp22.suse.cz> <CALOAHbDZLM4bfGi7EQDzE6FabBinnZJ7yF+uZADUgx2S_pfg1w@mail.gmail.com>
 <20200709095840.GE19160@dhcp22.suse.cz>
In-Reply-To: <20200709095840.GE19160@dhcp22.suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 9 Jul 2020 19:20:01 +0800
Message-ID: <CALOAHbC9bk10=GFt7SO9=XOEdvMUkOKnaWOJxuKK7YTshimyRg@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc, mm: clarify /proc/<pid>/oom_score value range
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 5:58 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 09-07-20 17:01:06, Yafang Shao wrote:
> > On Thu, Jul 9, 2020 at 4:18 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Thu 09-07-20 15:41:11, Yafang Shao wrote:
> > > > On Thu, Jul 9, 2020 at 2:26 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > > >
> > > > > From: Michal Hocko <mhocko@suse.com>
> > > > >
> > > > > The exported value includes oom_score_adj so the range is no [0, 1000]
> > > > > as described in the previous section but rather [0, 2000]. Mention that
> > > > > fact explicitly.
> > > > >
> > > > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > > > ---
> > > > >  Documentation/filesystems/proc.rst | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > > > > index 8e3b5dffcfa8..78a0dec323a3 100644
> > > > > --- a/Documentation/filesystems/proc.rst
> > > > > +++ b/Documentation/filesystems/proc.rst
> > > > > @@ -1673,6 +1673,9 @@ requires CAP_SYS_RESOURCE.
> > > > >  3.2 /proc/<pid>/oom_score - Display current oom-killer score
> > > > >  -------------------------------------------------------------
> > > > >
> > > > > +Please note that the exported value includes oom_score_adj so it is effectively
> > > > > +in range [0,2000].
> > > > > +
> > > >
> > > > [0, 2000] may be not a proper range, see my reply in another thread.[1]
> > > > As this value hasn't been documented before and nobody notices that, I
> > > > think there might be no user really care about it before.
> > > > So we should discuss the proper range if we really think the user will
> > > > care about this value.
> > >
> > > Even if we decide the range should change, I do not really assume this
> > > will happen, it is good to have the existing behavior clarified.
> > >
> >
> > But the existing behavior is not defined in the kernel documentation
> > before, so I don't think that the user has a clear understanding of
> > the existing behavior.
>
> Well, documentation is by no means authoritative, especially when it is
> outdated or incomplete. What really matters is the observed behavior and
> a lot of userspace depends on that or based on the specific
> implementation.
>
> > The way to use the result of proc_oom_score is to compare which
> > processes will be killed first by the OOM killer, IOW, the user should
> > always use it to compare different processes. For example,
> >
> > if proc_oom_score(process_a) > proc_oom_score(process_b)
> > then
> >      process_a will be killed before process_b
> > fi
> >
> > And then  the user will "Use it together with
> > /proc/<pid>/oom_score_adj to tune which
> >  process should be killed in an out-of-memory situation."
> >
> > That means what the user really cares about is the relative value, and
> > they will not care about the range or the absolute value.
>
> In an ideal world yes. But the real life tells a different story. Many
> times userspace (ab)uses certain undocumented/unintended (mis)features
> and the hard rule is that we never break userspace. We've learned that
> through many painful historical experiences. Especially vaguely defined
> functionality suffers from the problem.
> --

All right. I don't insist if we think the change in range may break
the userspace.

-- 
Thanks
Yafang
