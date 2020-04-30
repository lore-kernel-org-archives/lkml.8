Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3E2C83003
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 02:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E24020787
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 02:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588213245;
	bh=OAxxNFGq11nrroACipQXYvzDvOSq5lDSmKHzShITjr0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rNMaBSOOCmTcbjrkA8QLsW7XwHXDMUcWtHECHjad2dHKfazepk7TTCJzGCXBUJGUP
	 1nL4Bhw/zzkB9JfOB0Mpjm8/Cj0Hb77ZkwF2ji2wAGhTZpjXpyAVV+3JPw8BxxYspu
	 T2G8FexB2lyxzY7p1zFIkaGM1Flxqk3B8n7FN674=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgD3CUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 22:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726286AbgD3CUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 22:20:43 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F042C035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 19:20:43 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u10so3417148lfo.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 19:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYxtKmlqoXk3HGTO1s1DdOG+LqWQPI4ENjVI27yZM/k=;
        b=GmX+frN1P1FGDtJYnb7zPTXSyuypoMkRWzT6YL81gEYrJlbcCgJgybcWHNXzT+fM7y
         tOizmLVBqKP3q1x+c+OTXL61r60ST8kDP+JCua1JluRk1FCwzdsmLm8gYKXGHtWNrbLW
         DZdAFSWp9PP+HVWQB3yRFzF5e5IEZ3HPFZnP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYxtKmlqoXk3HGTO1s1DdOG+LqWQPI4ENjVI27yZM/k=;
        b=G2FaIq4zVuP8mmPADGXOZA8NJ8QxrYia6dIZsXxnSHhFmCGnmpH0i2Qc/asiytfBRA
         M5p/6OxL0V/E66oCrwmz0mM57xC7hcCjMu3opCCsrb9qTgq9OWBJDBEIRxQLCUJu/eK/
         pXtGCxkaYlhC9IHfkms1wcdZWG23sq4+7A37CHoxzaFR3m9OrL0eZ1HWsYpZAXQ6iCjL
         XTuWihB6J85LVsktARfnfQcx+tR7THJsHavfICFO0NHGcnXYT2FWB4GgGm9mYZtvK0yH
         8Ox8XJG+dK24yrLuzrZ4KqvR+NAyLqOel3S73zs98u9DLciWBsLNv/2gWtetnJI/nh6p
         VrNA==
X-Gm-Message-State: AGi0Pubnnaz/mms5rAhuUy+M5oQlWcC21DiceSU4T1FYwuTTzVMBaNxw
        37TfWVSp+3sm5oYnKnsWLV+wKGRo+sc=
X-Google-Smtp-Source: APiQypKOOErlsazioGdJB1yh+piDN1AXreD2TgSsyifhpW20jPdoPwdCoQLfntO+49K7ypMP4gtWEw==
X-Received: by 2002:a19:9141:: with SMTP id y1mr504876lfj.168.1588213240933;
        Wed, 29 Apr 2020 19:20:40 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id q26sm3365256ljg.47.2020.04.29.19.20.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 19:20:39 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id l19so4763383lje.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 19:20:39 -0700 (PDT)
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr608213ljp.209.1588213238646;
 Wed, 29 Apr 2020 19:20:38 -0700 (PDT)
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
 <CAG48ez0FL3i4eGFYryOwG2nnS+JigfKYAVSV9ogVHjmjOWzsrA@mail.gmail.com> <AM6PR03MB5170C5D02C6FCB6D69DFE3ADE4AA0@AM6PR03MB5170.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5170C5D02C6FCB6D69DFE3ADE4AA0@AM6PR03MB5170.eurprd03.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Apr 2020 19:20:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6oKSLkVhY5oqOFyzCCSr9eYPGK2SHJfgCXF_QOmPKog@mail.gmail.com>
Message-ID: <CAHk-=wg6oKSLkVhY5oqOFyzCCSr9eYPGK2SHJfgCXF_QOmPKog@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
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

On Wed, Apr 29, 2020 at 6:08 PM Bernd Edlinger
<bernd.edlinger@hotmail.de> wrote:
>
> I added the BIG FAT WARNNIG comments as a mitigation for that.
> Did you like those comments?

No.

What's the point olf saying "THIS CODE IS GARBAGE" and then expecting
that to make it ok?

No,m that doesn't make it ok. It just means that it should have been
done differently.

> Yes, exactly, the point is the caller is expected to call wait in that
> scenario, otherwise the -EAGAIN just repeats forever, that is an API
> change, yes, but something unavoidable, and the patch tries hard to
> limit it to cases where the live-lock or pseudo-dead-lock is unavoidable
> anyway.

I'm getting really fed up with your insistence on that KNOWN BROKEN
garbage test-case.

It's shit. The test-case is wrong. I've told you before.

Your patch as-is breaks other cases that are *not* wrong in the kernel
currently, and that don't have test-cases because they JustWork(tm).

The livelock isn't interesting. The test-case that shows it is pure
garbage, and is written wrong.

IF that test-case hadn't been buggy in the first place, it would have
had ignored its child (or had a handler for SIGCHLD), and not
livelocked.

                Linus
