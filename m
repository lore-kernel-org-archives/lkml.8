Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64727C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C489206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHM3/sHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgENNHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbgENNHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:07:21 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F48C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:07:20 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id r25so24452088oij.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8NV16GFiBJNWCA0OVx7TbffCUg4QNsB+1OOfXXBvkrE=;
        b=BHM3/sHLyHFtZ7CWU6vrg7iC1dP7OaBu6AlwERvOEbdy+sktUiTjSSoZeflxfx2UPK
         +DbFveiaLHQVJa6xozL6NSuk0ge7HqIxE6UuvPIuE4P0XfK+9wDjWNTBzAc87Hv8TpGp
         NW6pgR4YZI+qDuZLhXMc4pNDYTTq2P25kwqDY/4BVCxHsON4MnQXdiFu4KBjt+Db+O5r
         n8uU0fs7eCyA309jWThGwpxDoXsc0d1s8UkFV1zOkQYvO/1zpdpvGh+pO3+qvvozjJTH
         c7Qaz8ghzHoqmbUwPlTxxzAxchBzzUbWU/Nzxw9HetUwy8t3g/R1Z/ShncVL7aBr8oVM
         FC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NV16GFiBJNWCA0OVx7TbffCUg4QNsB+1OOfXXBvkrE=;
        b=PUZOHtOKZAh61oNZkG+7Mn6tWxHmM4eYttHrnMs9eqs6IsyttDk6OJQ4swhJeeER/o
         c8B+BDisWLicVPq/T38qx6IMmvNLA+kqU87OnRJC6G2+ezFqYpNCo1A+7z8yX1sttf59
         us4iG8mLNBwv1vU/07P+3ugUwFr4MhGYKH0EmyFLSiMrDZrz8H7SpAFEjXNsbND/rzzR
         qHRqX2+z2ztA7iJ1LLCfnG8E7pnqYPL3CFniWBfsrKeUVgRFthLmTJFsGUNzFyWLecSt
         amX8oKCMJAGuRsDPc2b4ZifbXl0BhN8x4Io5scYbUJFOfckGW229PSnyuYsfb1lFLEbz
         pJaw==
X-Gm-Message-State: AGi0PuZkbdu3yW5JpXeBm2D9dqxRYDFiFWqi8fqVeawvBC8PmFykuhJt
        J+9MmDav/Dmp7JnH1E0lIbv6a4P6EISUs+nsS/nmdQ==
X-Google-Smtp-Source: APiQypLh3YOlCumYeNfR0wBo1cSOvrScMD4+LC8kqWJLvd4YTjxxwL3dmtu58EkQWEzaq4z0cF3O1J1SolCmY7kZy/U=
X-Received: by 2002:aca:3254:: with SMTP id y81mr10461078oiy.172.1589461639927;
 Thu, 14 May 2020 06:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
 <20200513111057.GN2957@hirez.programming.kicks-ass.net> <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net> <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513132440.GN2978@hirez.programming.kicks-ass.net> <CANpmjNM5dD1VH0hoQwsZYEL=mhWunKwAEJMQgASzHSN019OCnw@mail.gmail.com>
 <20200514112142.GV2978@hirez.programming.kicks-ass.net> <20200514120104.GD4280@willie-the-truck>
 <20200514122735.GW2978@hirez.programming.kicks-ass.net>
In-Reply-To: <20200514122735.GW2978@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Thu, 14 May 2020 15:07:08 +0200
Message-ID: <CANpmjNPmZv6TBQJ93TRuxCxJCpvJy8+XS5u9+ucOE2eEebEw9Q@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 at 14:27, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, May 14, 2020 at 01:01:04PM +0100, Will Deacon wrote:
>
> > > +#if __has_feature(undefined_sanitizer)
> >
> > Hmm, this might want to be __has_feature(undefined_behavior_sanitizer)
> > (and damn is that hard for a Brit to type out!)
>
> (I know right, it should be behaviour, dammit!)
>
> I tried without the condition, eg.:
>
> +#define __no_sanitize_undefined \
> +               __attribute__((no_sanitize("undefined")))
>
> and it still generated UBSAN gunk.

Which ubsan calls are left? I'm trying to reproduce.

Thanks,
-- Marco
