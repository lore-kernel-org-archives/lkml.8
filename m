Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6928C83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 04:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831552083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 04:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5Qkn+RO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgD3ETp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 00:19:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32300 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725280AbgD3ETp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 00:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588220383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y3qA5YQectFk94IrJZbga3NnhiVolyAIIRBNdV0hWko=;
        b=A5Qkn+RO7hxZUJdkSw7uQ5LZ1xv+ju6V9HI4RXaPKLWhKhkTodnTK1QEb7224umh5Cvitt
        cPSGVTVEMrQQt7s3Bgkkw+/ynRxBSsnj09U3ZrRnROOF85TKxI1IFNdqzB55n4yKBzJbu5
        mOI3mEdw5YzfoQzCi/sV/vbdYaRMQWI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-MvezKSFdNsaAZwOF5Ug5Sw-1; Thu, 30 Apr 2020 00:19:41 -0400
X-MC-Unique: MvezKSFdNsaAZwOF5Ug5Sw-1
Received: by mail-qk1-f198.google.com with SMTP id a18so5219710qkl.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 21:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3qA5YQectFk94IrJZbga3NnhiVolyAIIRBNdV0hWko=;
        b=C8X0sGDah+Jf8RFETjcLYss2NFNGxCaXNIHyhaNHVrvET3mRROKAYLpFwpYU1tc3Ss
         Wen3P/izr19exX0F/GJGXRYsXDZthUR4viBOTurbMCPeCHaQ3BEZREj75CO32U+QHQqX
         J/dFtGWdLs2pZ2G1Lociue1gSj1AuOInQkQLrPR7TsCzPF7TaUbsnl0JYF+VnB0G5Brl
         bPxtytBaZKBJMHb0MKYAKzmF8lLgEWiYG9Cp4U0T04GjuROjXmYRf72TGTYsdf021h1y
         1CpN5c34gvabKPOSMt7719uprnqCnTg2cD9W14ekq1Rpqdx3oAhHHiFhrqrYfjKguRWW
         iZxg==
X-Gm-Message-State: AGi0PubkG3YeUfA5hYEQjR4gmPh/JRQTITg6W1XtTZAxhWXxD2hsqJID
        YuZjtf04goyWDinASYbhrLj3H/fTJXmdPymXSYwT1Dxg5XWnHJ7SaJL0+YJ9gy5zY0HdwX3sLvD
        2q5JZWg1MHT7ckNAmXv58Teh35Nf0dzE9+09MeZ1y
X-Received: by 2002:ac8:4a06:: with SMTP id x6mr1781017qtq.163.1588220381014;
        Wed, 29 Apr 2020 21:19:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypIIKuSa5A+bA3rxaYpbMr2qY1S5iFmZ3KbqmvVuXVRobXja+joDUE5FfWMDx8MBIFnGysBfmL5Fe5CK6jPRK2U=
X-Received: by 2002:ac8:4a06:: with SMTP id x6mr1780995qtq.163.1588220380778;
 Wed, 29 Apr 2020 21:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <1588063937-5744-1-git-send-email-bhsharma@redhat.com> <20200428100745.GA15300@C02TD0UTHF1T.local>
In-Reply-To: <20200428100745.GA15300@C02TD0UTHF1T.local>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Thu, 30 Apr 2020 09:49:27 +0530
Message-ID: <CACi5LpM9_O6gRgMgfAXrmZuaO111xJk3=xtjYXK5rKhTF7Znsg@mail.gmail.com>
Subject: Re: [PATCH] hw_breakpoint: Remove unused '__register_perf_hw_breakpoint'
 declaration
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thanks for the review.

On Tue, Apr 28, 2020 at 3:37 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Bhupesh,
>
> On Tue, Apr 28, 2020 at 02:22:17PM +0530, Bhupesh Sharma wrote:
> > commit b326e9560a28 ("hw-breakpoints: Use overflow handler instead of
> > the event callback") removed '__register_perf_hw_breakpoint' function
> > usage and replaced it with 'register_perf_hw_breakpoint' function.
> >
> > Remove the left-over unused '__register_perf_hw_breakpoint' declaration
> > from 'hw_breakpoint.h' as well.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>
> This is generic code, so I'm a bit confused as to why you've sent it to
> us. I'd expect this to go via the perf core maintainers (cc'd).

Oops, my bad. Seems my git patch sending script messed up while
picking up the perf maintainers (who should have been Cc'ed on the
patch) :(

Thanks for adding them in the Cc list.

Hi Peter, Frederic, Ingo - Kindly help review this patch and help
apply the patch (if suitable).

Thanks,
Bhupesh

> FWIW, this looks sane to me, so:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> Mark.
>
> > ---
> >  include/linux/hw_breakpoint.h | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
> > index 6058c3844a76..fe1302da8e0f 100644
> > --- a/include/linux/hw_breakpoint.h
> > +++ b/include/linux/hw_breakpoint.h
> > @@ -72,7 +72,6 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
> >                           void *context);
> >
> >  extern int register_perf_hw_breakpoint(struct perf_event *bp);
> > -extern int __register_perf_hw_breakpoint(struct perf_event *bp);
> >  extern void unregister_hw_breakpoint(struct perf_event *bp);
> >  extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events);
> >
> > @@ -115,8 +114,6 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
> >                           void *context)              { return NULL; }
> >  static inline int
> >  register_perf_hw_breakpoint(struct perf_event *bp)   { return -ENOSYS; }
> > -static inline int
> > -__register_perf_hw_breakpoint(struct perf_event *bp)         { return -ENOSYS; }
> >  static inline void unregister_hw_breakpoint(struct perf_event *bp)   { }
> >  static inline void
> >  unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)      { }
> > --
> > 2.7.4
> >
>

