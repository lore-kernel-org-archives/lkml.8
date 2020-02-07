Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A684CC2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766C82082E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwdB63XD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgBGHWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 02:22:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31452 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgBGHWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 02:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581060173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lgVyzV98WCkCA7JLqOF1Cqp3XlDwsyJOWyuCfKoS/hQ=;
        b=NwdB63XDlY7KtdMk7jlbH+rLvb1ZzWSzeqmeLyJ9btaQjzCMEaR1nNJOjhNWpdZi7wDive
        ZXyfG6Ku1swqmw9oQtoehjTgWT7z85bxeksnmhGjGi2TU04NmHNVAXSF2+np1zEhaZ1ncs
        8JjSDQex0gfSKU+UV0MWILstXVYLrg0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-dt6MGbb9M1awyS0HTAVJ_g-1; Fri, 07 Feb 2020 02:22:49 -0500
X-MC-Unique: dt6MGbb9M1awyS0HTAVJ_g-1
Received: by mail-qk1-f197.google.com with SMTP id s9so800743qkg.21
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 23:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgVyzV98WCkCA7JLqOF1Cqp3XlDwsyJOWyuCfKoS/hQ=;
        b=fOLV/yd9BtIQCcNY/WXOwm0u2gnAo0Izfo7/vb8p/fELNcdTKzOjh9ImOdgOLsv1Wj
         PM3rJe5JfIZlSH4QYsaBhVTEt1x9wYvbleWiZTZEnoWRN0GiksH16jS6zGlBvkjWVOAr
         wYYXWO020I83lcIBS0YUrEcjvXGTDMh0G0DpBwbFzG2xoZRnF31vUhORPiQl8lxtymcN
         C300x2WDyYf71gyzc8O53hDDIKwrXRNDfTs574pZ71H8NlzkBcqAqX3s58pFrZbH1H50
         eb+GIwJzAfbpFfKCAETFDSic/AUT4r/GSUNt+N58Z5XsPo9DAcWD5ex/1/8Iu7sG8Ls8
         y1lw==
X-Gm-Message-State: APjAAAUziJkYCTWDVraznrDpw+ysKY7gZK+iWQABFUcsIVedGPeuqOUk
        CGCIQ8uzD0eppa7OIVF770nhSVljdkwLlPczaLVAIJXz1ow6mQ+oJhzQCLOPMykIhwLXyaels04
        +SyYJ3Z7sqTynnNxsUJDrlgeYJCItMJlxJhDnb6hh
X-Received: by 2002:a37:8cc:: with SMTP id 195mr6075721qki.456.1581060169017;
        Thu, 06 Feb 2020 23:22:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqydmVvTffqnOIk3fXrn9Ur3ZslgLahtGidDn7lhiibNQVBA9X4nupwC/DYYmAcfTwowjXQ8U5lbiUjFW6nQ7Ac=
X-Received: by 2002:a37:8cc:: with SMTP id 195mr6075715qki.456.1581060168719;
 Thu, 06 Feb 2020 23:22:48 -0800 (PST)
MIME-Version: 1.0
References: <1580768784-25868-1-git-send-email-bhsharma@redhat.com>
 <1580768784-25868-3-git-send-email-bhsharma@redhat.com> <20200206103858.GB17074@willie-the-truck>
In-Reply-To: <20200206103858.GB17074@willie-the-truck>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Fri, 7 Feb 2020 12:52:36 +0530
Message-ID: <CACi5LpPTQ6f5tHEXFsFFhPQ2phLefZY8L3rZ-9xLGyTJ7_SdCQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf/arm64: Allow per-task kernel breakpoints
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

Thanks for your inputs.

On Thu, Feb 6, 2020 at 4:09 PM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Feb 04, 2020 at 03:56:24AM +0530, Bhupesh Sharma wrote:
> > commit 478fcb2cdb23 ("arm64: Debugging support") disallowed per-task
> > kernel breakpoints on arm64 since these would have potentially
> > complicated the stepping code.
> >
> > However, we now have several use-cases (for e.g. perf) which require
> > per-task address execution h/w breakpoint to be exercised/set on arm64:
>
> To be honest, the perf interface to hw_breakpoint is an abomination and
> I think we should remove it entirely for arm64. It's flakey, complicated,
> adds code to context-switch and reduces the capabilities available to
> ptrace.

Sure, I agree.

> > For e.g. we can set address execution h/w breakpoints, using the
> > format prescribed by 'perf-list' command:
> > mem:<addr>[/len][:access]                          [Hardware breakpoint]
> >
> > Without this patch, currently 'perf stat -e' reports that per-task
> > address execution h/w breakpoints are 'not supported' on arm64. See
> > below:
> >
> > $ TEST_FUNC="vfs_read"
> > $ ADDR=0x`cat /proc/kallsyms | grep -P "\\s$TEST_FUNC\$" | cut -f1 -d' '`
> > $ perf stat -e mem:$ADDR:x -x';' -- cat /proc/cpuinfo > /dev/null
> >
> > <not supported>;;mem:0xffff00001031dd68:x;0;100.00;;
> >
> > After this patch, this use-case can be supported:
> >
> > $ TEST_FUNC="vfs_read"
> > $ ADDR=0x`cat /proc/kallsyms | grep -P "\\s$TEST_FUNC\$" | cut -f1 -d' '`
> > $ perf stat -e mem:$ADDR:x -x';' -- cat /proc/cpuinfo > /dev/null
> >
> > 5;;mem:0xfffffe0010361d20:x;912200;100.00;;
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> > ---
> >  arch/arm64/kernel/hw_breakpoint.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> > index 0b727edf4104..c28f04e02845 100644
> > --- a/arch/arm64/kernel/hw_breakpoint.c
> > +++ b/arch/arm64/kernel/hw_breakpoint.c
> > @@ -562,13 +562,6 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
> >       hw->address &= ~alignment_mask;
> >       hw->ctrl.len <<= offset;
> >
> > -     /*
> > -      * Disallow per-task kernel breakpoints since these would
> > -      * complicate the stepping code.
> > -      */
> > -     if (hw->ctrl.privilege == AARCH64_BREAKPOINT_EL1 && bp->hw.target)
> > -             return -EINVAL;
> > -
>
> Sorry, but this is broken; the check is there for a reason, not just for
> fun!
>
> Look at how the step handler toggles the bp registers.

Not sure I follow. Can you please give me some pointers. All the perf
tests I have from test-suite run fine with this chunk removed.

Thanks for your help.
Regards,
Bhupesh

