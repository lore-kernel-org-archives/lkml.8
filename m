Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD65C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDFFE2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Crs/WMRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbgHTQr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbgHTQrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:47:48 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2569C061386
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 09:47:45 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id n4so1409517vsl.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 09:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nFydOyAQ5fL3vfPVLLh49VOLqsGjFEw91D0MHzilX5M=;
        b=Crs/WMRP2fmy0A72/nAxgdRh1jfjB94SUBuYbmOq48ob45Uzpcdl5nhkDGqNm7qoA2
         TD0b4DY5l/Qw+s+OnoFycCHQUiOIXwSqelSRQpHr1zh8EFDyT3vVeonqlctaneuaw88I
         oO2pgxaiumGK4NEBocYXkEPI1ZdXcSq/hos4GcXyz1FvH2fj44gjr6nA6FXGRfwKaDpU
         Dn8WFQDKrdztr09XqxuJP3F6OcosPKMDku0vSq0NBDKqKRiiiE5noOi4Pa3KZgpo5hWf
         J+unhSgn03KkLd+g1U+cyFBLi34TV4Ny1w1o7utrfI8/zFfa9dTq51x7FpHY6bUT5WB9
         B4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFydOyAQ5fL3vfPVLLh49VOLqsGjFEw91D0MHzilX5M=;
        b=U6W3LS4bYOClCFcxRgcrl4hiGkSK2jqvHS+3GwX5u9durxfp+CEx2KdNDbbViG328M
         /TJiMSDY8xzQA/tu79DgDKdoGUEo/N2bueTEDPbTv5FF49UxsfJKzkgOHegnWVtYoSul
         U4l5SluKt6k5+FevLq+64Ez9citaJZa8avhvThHXlItPqfSOyrnjndPmgFKtCcWgZ2Sy
         MkNxpWoIdrdhG4CXKernqFtKj3w6xn63IvNcbhbsneaSTBy5psLyfOt5uTyU8TmXevyh
         Bh6OAbE9ZIDHBuWe/4WYiUn9piemaj0MylaqqWlVnBzwhevtuSJtvbQSBc0mPy/E5LRk
         mC5g==
X-Gm-Message-State: AOAM532grbo/3Ami3AwjVD3gdN0JZJ/f2awARJD7oOEkQl5Q/bp+/fRE
        xV9qt9ydG1Hely99/2Z92QbOuIuLJ7gRWVh6U/b5pw==
X-Google-Smtp-Source: ABdhPJxnUe2uAAoTjmaHQnh8K/T2EFQWZBMt0JSgkurOi8fetLFAZM9cBXHIfYSIjsnKPiy6LTpMFgA9pyZPBi2FClM=
X-Received: by 2002:a67:f30e:: with SMTP id p14mr2079034vsf.119.1597942064479;
 Thu, 20 Aug 2020 09:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <87lfi9xz7y.fsf@x220.int.ebiederm.org> <87d03lxysr.fsf@x220.int.ebiederm.org>
 <20200820132631.GK5033@dhcp22.suse.cz> <20200820133454.ch24kewh42ax4ebl@wittgenstein>
 <dcb62b67-5ad6-f63a-a909-e2fa70b240fc@i-love.sakura.ne.jp>
 <20200820140054.fdkbotd4tgfrqpe6@wittgenstein> <637ab0e7-e686-0c94-753b-b97d24bb8232@i-love.sakura.ne.jp>
 <87k0xtv0d4.fsf@x220.int.ebiederm.org> <CAJuCfpHsjisBnNiDNQbm8Yi92cznaptiXYPdc-aVa+_zkuaPhA@mail.gmail.com>
 <20200820162645.GP5033@dhcp22.suse.cz> <20200820162927.s275qsr4lkwizutu@wittgenstein>
In-Reply-To: <20200820162927.s275qsr4lkwizutu@wittgenstein>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 20 Aug 2020 09:47:32 -0700
Message-ID: <CAJuCfpFK9VRNA=hztFoEyyhkU_W4x4uF41J-fApyLZpXeUFuKQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in
 __set_oom_adj when not necessary
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tim Murray <timmurray@google.com>, mingo@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com,
        Shakeel Butt <shakeelb@google.com>, cyphar@cyphar.com,
        Oleg Nesterov <oleg@redhat.com>, adobriyan@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        gladkov.alexey@gmail.com, Michel Lespinasse <walken@google.com>,
        daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de,
        John Johansen <john.johansen@canonical.com>,
        laoar.shao@gmail.com, Minchan Kim <minchan@kernel.org>,
        kernel-team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 9:29 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Thu, Aug 20, 2020 at 06:26:45PM +0200, Michal Hocko wrote:
> > On Thu 20-08-20 08:56:53, Suren Baghdasaryan wrote:
> > [...]
> > > Catching up on the discussion which was going on while I was asleep...
> > > So it sounds like there is a consensus that oom_adj should be moved to
> > > mm_struct rather than trying to synchronize it among tasks sharing mm.
> > > That sounds reasonable to me too. Michal answered all the earlier
> > > questions about this patch, so I won't be reiterating them, thanks
> > > Michal. If any questions are still lingering about the original patch
> > > I'll be glad to answer them.
> >
> > I think it still makes some sense to go with a simpler (aka less tricky)
> > solution which would be your original patch with an incremental fix for
> > vfork and the proper ordering (http://lkml.kernel.org/r/20200820124109.GI5033@dhcp22.suse.cz)
> > and then make a more complex shift to mm struct on top of that. The
> > former will be less tricky to backport to stable IMHO.
>
> /me nods

Ah, ok. Then I'll incorporate these changes, re-test and re-post as v2. Thanks!

>
> Christian
