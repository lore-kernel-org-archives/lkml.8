Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79639C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50C882065C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUrrnF4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgEOJPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:15:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44526 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727837AbgEOJPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589534145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/5awcNeBjTNuGjgZ8wQMW9no+F30tdMR8rr0G98WOb4=;
        b=PUrrnF4FKQSZxSw0csN8FDAqlNzENWf/jryaBSRXrbb5Od1yS9gd7G7+epLY36spfAVlPc
        d/FccOebp4UJhm+J5qiAyl0bSWgnpVuk4AhqxK5yWJussyyJDgwO78NZZsiZ1Yfk7hCRTt
        f/QtMO1C/nJCmYEi/2qMw2D70sFwHIo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-t_m2kxuhMVmScts-aFHLug-1; Fri, 15 May 2020 05:15:43 -0400
X-MC-Unique: t_m2kxuhMVmScts-aFHLug-1
Received: by mail-qt1-f197.google.com with SMTP id z29so1753293qtj.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 02:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5awcNeBjTNuGjgZ8wQMW9no+F30tdMR8rr0G98WOb4=;
        b=E+7wPj6PWGUHnybzrz/pFHWh2h1EwtFjbbhxE8JTM3DiDSDfKMkjcAovyuwNgoeFn7
         KtFutBTIfHW+JxSkgkC9P9eEneQ3+v8qmxLkhdNyjnekGNct7TbrVi0fNkMiY43EfniY
         RbPn+lj1bxaTdTog+6JJrlGpxa7sU7iMGw6VHWyCt/yzmawTyUQ4ZDvkg+QnzP4ufqih
         NA0nO7W+TGrXzrnEdQntV01yu0RFp6jv2EVNOcUw1GzFf35JJLzKspWv4RoL25L6xQIH
         s4qWDoyMx3nVPfp0uQCkwqSQAVM65nBesDngxM0cRTkSQIQSrQH1qreLiaXfv3ZTy2qz
         nHmQ==
X-Gm-Message-State: AOAM533xzk1DFzBOoxYtGUmR1eHiuNwbw8gKYmQOYg3gAuU1uM8GEkra
        ROI3WUsc952HZ8S2WVrE080/gcCjEgfFsR5T7Unyo5BKKk6OPY6byvY2pwIvUMi0kCzG+ohbfLa
        Meqs1Zpi9D1wuAEC2Eu5H2YOmUtPrTbvSC1x5t2H2
X-Received: by 2002:ac8:380d:: with SMTP id q13mr2372094qtb.200.1589534142852;
        Fri, 15 May 2020 02:15:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8nyyO55A3mAp5k/ZtXVWiRwhEwxpHzlb/m+SHwSRPOCkAKQQlYUW1tRALhgZ0tlz8hGPGU5nXJcBAoRq0W1Y=
X-Received: by 2002:ac8:380d:: with SMTP id q13mr2372075qtb.200.1589534142649;
 Fri, 15 May 2020 02:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <1588063937-5744-1-git-send-email-bhsharma@redhat.com>
 <20200428100745.GA15300@C02TD0UTHF1T.local> <CACi5LpM9_O6gRgMgfAXrmZuaO111xJk3=xtjYXK5rKhTF7Znsg@mail.gmail.com>
In-Reply-To: <CACi5LpM9_O6gRgMgfAXrmZuaO111xJk3=xtjYXK5rKhTF7Znsg@mail.gmail.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Fri, 15 May 2020 14:45:29 +0530
Message-ID: <CACi5LpPqjm6Tc7vP1oCt4ZFm0UQTMMr3CZuVGhA4Swz-DxjvsA@mail.gmail.com>
Subject: Re: [PATCH] hw_breakpoint: Remove unused '__register_perf_hw_breakpoint'
 declaration
To:     Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Frederic, Ingo

On Thu, Apr 30, 2020 at 9:49 AM Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
> Hi Mark,
>
> Thanks for the review.
>
> On Tue, Apr 28, 2020 at 3:37 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > Hi Bhupesh,
> >
> > On Tue, Apr 28, 2020 at 02:22:17PM +0530, Bhupesh Sharma wrote:
> > > commit b326e9560a28 ("hw-breakpoints: Use overflow handler instead of
> > > the event callback") removed '__register_perf_hw_breakpoint' function
> > > usage and replaced it with 'register_perf_hw_breakpoint' function.
> > >
> > > Remove the left-over unused '__register_perf_hw_breakpoint' declaration
> > > from 'hw_breakpoint.h' as well.
> > >
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> >
> > This is generic code, so I'm a bit confused as to why you've sent it to
> > us. I'd expect this to go via the perf core maintainers (cc'd).
>
> Oops, my bad. Seems my git patch sending script messed up while
> picking up the perf maintainers (who should have been Cc'ed on the
> patch) :(
>
> Thanks for adding them in the Cc list.
>
> Hi Peter, Frederic, Ingo - Kindly help review this patch and help
> apply the patch (if suitable).

Ping. Any comments on this patch?

Thanks,
Bhupesh

> > FWIW, this looks sane to me, so:
> >
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> >
> > Mark.
> >
> > > ---
> > >  include/linux/hw_breakpoint.h | 3 ---
> > >  1 file changed, 3 deletions(-)
> > >
> > > diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
> > > index 6058c3844a76..fe1302da8e0f 100644
> > > --- a/include/linux/hw_breakpoint.h
> > > +++ b/include/linux/hw_breakpoint.h
> > > @@ -72,7 +72,6 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
> > >                           void *context);
> > >
> > >  extern int register_perf_hw_breakpoint(struct perf_event *bp);
> > > -extern int __register_perf_hw_breakpoint(struct perf_event *bp);
> > >  extern void unregister_hw_breakpoint(struct perf_event *bp);
> > >  extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events);
> > >
> > > @@ -115,8 +114,6 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
> > >                           void *context)              { return NULL; }
> > >  static inline int
> > >  register_perf_hw_breakpoint(struct perf_event *bp)   { return -ENOSYS; }
> > > -static inline int
> > > -__register_perf_hw_breakpoint(struct perf_event *bp)         { return -ENOSYS; }
> > >  static inline void unregister_hw_breakpoint(struct perf_event *bp)   { }
> > >  static inline void
> > >  unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)      { }
> > > --
> > > 2.7.4
> > >
> >

