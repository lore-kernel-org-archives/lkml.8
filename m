Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA71C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2692D2082F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586367158;
	bh=eqVDGVlhcE0lUxAepvs/UtvKy1Uv9Zo5E5UsKA6k9eU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q1vGb6kL11O+HQxtT0NVV2TRuojOrkdgfiY44OWlSWL3yay0gONECCzGuMUYSFqZf
	 X5QDoRK4rxluI+ZyHL9JYEvuocyFOm6i3cDCtEXtfBSGcZ+zX6Vkxw/X3KyIjPqZfp
	 S5gtS3x78Hkp1av7q3Nv/HLaDczmQ2OXhtmGSNOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgDHRch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 13:32:37 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46160 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgDHRcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 13:32:36 -0400
Received: by mail-lf1-f65.google.com with SMTP id m19so3752417lfq.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 10:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YQQMXlSDD2aTZuR5oNz9w6UhTsUGbMpZlbO1WixGP4o=;
        b=Fu70uLe/XZI4EbdMXPhHOgGMmBe2yEY6za4E/fhH0nNNJeIEmQCdneCThQ/0F31Noy
         sD4qZXa40Z+dYI6OG7xj2FTC9tUEGqHDEOjFzqfIxB50OWT70bAW9hMe6y5N7PT2jhpA
         iNrzYmqImkCXGe0HA1P5MxCSGHaEPWRxS9M18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YQQMXlSDD2aTZuR5oNz9w6UhTsUGbMpZlbO1WixGP4o=;
        b=L2rBwt7uUAfSqjFfHsHlht26Nf4q7TkxL27tleDqW8RLzfGw4b4Rhxdd3yl/aT0AKw
         M0klXB+4PCYvQQBmdRRJ/PptONb4adOiL686fnKJJYc5V1BE5iraVCCoinTeNuc2cNgw
         nUsZNxNo+mILfQKOlY3lkKskhncC+8vqmxLdBnUKkHfXAdr10PdrciIh0rGgP3570KKY
         zZvS00Z/WZo4KhOfOTWAz25NEbIJB/XnZRqJdLTIXTgfVZ07dZUQqyaR7CUgq/Rck811
         lRR4gHs+k+a7gevxnNIvuX5wsMWSb5csra+5nGa0Wl7rvuTmCPDhL1H1MsMkV04r3KUr
         Rtcg==
X-Gm-Message-State: AGi0Pua2I+duEJjiJpprA4CSeCzyfxqnARtMHk8o0otRVYOv38tirk2E
        tM1BZo32rhuXYJEV/TvPPbYP+q8rAE4=
X-Google-Smtp-Source: APiQypKtW/Zn2rMeWgj591+SOXiLg14kfzEyldCulEF1Zz2MkCQ11InDDDflchv9cbpc7T5y4XgQ5g==
X-Received: by 2002:a19:40ca:: with SMTP id n193mr5132546lfa.196.1586367154195;
        Wed, 08 Apr 2020 10:32:34 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id t6sm15441411lfb.55.2020.04.08.10.32.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 10:32:33 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id n17so8506019lji.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 10:32:33 -0700 (PDT)
X-Received: by 2002:a2e:8911:: with SMTP id d17mr5847808lji.16.1586367152876;
 Wed, 08 Apr 2020 10:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200408155924.107722-1-peterx@redhat.com> <20200408172723.GR20730@hirez.programming.kicks-ass.net>
In-Reply-To: <20200408172723.GR20730@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Apr 2020 10:32:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYpkgECNNk0O6+TyoUgJCB0Ny19HOSHZfDyHR4ms5TyA@mail.gmail.com>
Message-ID: <CAHk-=wjYpkgECNNk0O6+TyoUgJCB0Ny19HOSHZfDyHR4ms5TyA@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: Let __get_user_pages_locked() return -EINTR for
 fatal signal
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        syzbot+3be1a33f04dc782e9fd5@syzkaller.appspotmail.com,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 10:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > -             if (fatal_signal_pending(current))
> > +             if (fatal_signal_pending(current)) {
> > +                     if (!pages_done)
> > +                             pages_done = -EINTR;
>
> Why -EINTR here and -ERESTARTSYS at the other site?

I'd prefer EINTR for all fatal signals.

Not because it should matter (it's fatal, after all, the thread should
die before it ever sees it), but because I think it's less confusing.

If something is fatal, it sure as hell isn't going to restart any system calls.

But interrupting things because of fatal signals sounds sane (even if
the error code makes it to user space it's interrupting the flow of
code).

So I'd say that the other place should probably be EINTR too. But it
would obviously be a good idea to verify that no caller cares..

           Linus

              Linus
