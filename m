Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F170C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 23:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB8BA2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 23:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="chRmDbJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgDVXAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 19:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725846AbgDVXAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 19:00:30 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279C3C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 16:00:30 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u16so4511063wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 16:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e554rqOamBc28ZX8vvZpsq69HYHRpFVMDSx5grItHmM=;
        b=chRmDbJ0uUdLZcdIJvf8cYaWYGgdwKM+jUSpQz7q9qlWn0tzs2WPYj6NQl2dhIh4fc
         PvAWXm7KCUbFY2ABHnDTtEhST+1qxdmWmWoKLsOwTKX2Iv9osg6hHutG8/6VyWdI0SIm
         Ik+2UYbOCpb0jVQ5GgDCcBUEw+v+wme1WnC60YGXRFZJfNhAhn8hWX038WJ3uJGvGGP5
         ZL/4tbrKW6PgNzgkMNxGH0bX4DdfdBXlyVvLqG6HPlW96IS0WQwRk+tGnB9BVTbxxiFC
         do2w3Wj1azkyqvzvX15VSwGD7f9/593SL5IjcuaK6BGiKA6EQ2xCuNpbQYy5TEXqvQxq
         +QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e554rqOamBc28ZX8vvZpsq69HYHRpFVMDSx5grItHmM=;
        b=lTFFeflJ/r2n0ZZvsHgncdq2qMHc23SmQPKbyYpUlzLnZIXOP5hkCgwSAIHdQw6xlu
         Lwh7oO+aQUJ8LQE1Tpul9+0GYgLZP5XQJKqSJ72bUPuyHoUmW2ws8PecBek2wZriqTBV
         D/2oKJ57ri0FqAtBFW3mDmggx1KsJJbBLzuZ7Tu6A62KxoUsuVtRHTnpD9m0LFyW0jH+
         sgF7/ToZ59HhFb3FmTYTxFZhZsOI8Q/UMJUg5cVX77WLVqr7wvKRgbgnyhVUBv4pZ0FC
         VB2vN4lSprlrMb7frte+BMjOMjSAccMa+Ue0RS80NQsqTEv3BgtERbkQ7aMSlsK/fqw4
         Vuwg==
X-Gm-Message-State: AGi0PuZsKS3sz6hRmhRPxjD2lSSRZo8MKrlXXn6XVKP6Fx8ktDrUEv38
        +ywqYVgd/tUp/dQM7uUlzc8KYwrIxgE0PN1pKCXjng==
X-Google-Smtp-Source: APiQypIBvwm616bfo/vRDZbkHiy6iwoJAtIW33eryYqczNrjRdeZMMvY1tlPxntuueFgSTp8Q1w80CJo4ZfmJvA8awo=
X-Received: by 2002:a1c:9989:: with SMTP id b131mr788850wme.176.1587596428422;
 Wed, 22 Apr 2020 16:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200421195629.GE608746@tassilo.jf.intel.com> <5957D3CC-B54B-4A1A-998A-0E6F58589CF4@amacapital.net>
 <20200421205119.GK1809@sasha-vm>
In-Reply-To: <20200421205119.GK1809@sasha-vm>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 22 Apr 2020 16:00:16 -0700
Message-ID: <CALCETrUGuvMgvcsUWsdmUr-=6c6BpRpOKC1MN+E16g17U7vyMQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/17] Enable FSGSBASE instructions
To:     Sasha Levin <sashal@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simark@simark.ca>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 1:51 PM Sasha Levin <sashal@kernel.org> wrote:
>
> On Tue, Apr 21, 2020 at 01:21:39PM -0700, Andy Lutomirski wrote:
> >
> >
> >> On Apr 21, 2020, at 12:56 PM, Andi Kleen <ak@linux.intel.com> wrote:
> >>
> >> =EF=BB=BF
> >>>
> >>> Andi's point is that there is no known user it breaks, and the Intel
> >>> folks did some digging into potential users who might be affected by
> >>> this, including 'rr' brought up by Andy, and concluded that there won=
't
> >>> be breakage as a result of this patchset:
> >>>
> >>>    https://mail.mozilla.org/pipermail/rr-dev/2018-March/000616.html
> >>>
> >>> Sure, if you poke at it you could see a behavior change, but is there
> >>> an actual user that will be affected by it? I suspect not.
> >>
> >> Actually we don't know of any behavior changes caused by the kernel
> >> with selectors.
> >>
> >> The application can change itself of course, but only if it uses the
> >> new instructions, which no current application does.
> >
> >If you use ptrace to change the gs selector, the behavior is different o=
n a patched kernel.
> >
> >Again, I=E2=80=99m not saying that the change is problematic. But I will=
 say that the fact that anyone involved in this series keeps ignoring this =
fact makes me quite uncomfortable with the patch set.
>
> That's what I referred to with "poke at it". While the behavior may be
> different, I fail to find anyone who cares.
>
> >>
> >> [This was different in the original patch kit long ago which could
> >> change behavior on context switch for programs with out of sync select=
ors,
> >> but this has been long fixed]
> >
> >That=E2=80=99s the issue I was referring to.
> >
> >>
> >> A debugger can also change behavior, but we're not aware of any case
> >> that it would break.
> >
> >How hard did you look?
>
> Come on, how does one respond to this?
>
> Is there a real use case affected by this? If so, point it out and I'll
> be happy to go test it. This was already done (per your previous
> request) for gdb and rr.
>

gdb and rr are certainly a good start.  If patches show up, I'll take a loo=
k.
