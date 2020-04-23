Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C45C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B26A620767
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b6zdPxuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgDWS2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbgDWS2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:28:43 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071ADC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:28:43 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x15so3394497pfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Y/9ITAGgGN1ObZLXZNElUJooxFBQUxzx7tXw0tLGrw=;
        b=b6zdPxuhwvf6mbGggB4PksAI1ex0t7K0elOYcg58ZwrTjn8AjcWwZGTTkOt8xtEop1
         QgJUSGvj+wJ1HD5HRDh4RvxxaMJq6yj8Ef8yIBSVdRMjVYw9bGTWpKc07ah08JcYCbF3
         RdvWKOb7jr8FUoUPlrx507urw3KMBQUv7F7bI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Y/9ITAGgGN1ObZLXZNElUJooxFBQUxzx7tXw0tLGrw=;
        b=OOXNoUHqFCNhUEjcDDX7Hx72eXVu8IXKQE5bixYaYUksjMljLv+vv2TDY2VXessqbB
         ApoIRe8S5dhOvt+aNNoamqL486Eb5OTFzLI6axr30t5NuOi38J35GsTfcV69i2Df+zdz
         hgjGgb+LFJYYTQiVNXFeO/usVka9vdPU4HufVx3nD92aeVmylI6oTNKed6giBpBjVAiu
         Z0nLf12Fm39sHOliZ5h+p/1kvj8VlzNJjzYawHqjscLLH3Gc+dPUnFYZ/7QcpJnz3Jp9
         lSnOIjEs1pUwDsZv7/hQPMw4HFvR0+45siIGiSXkO1JM2tX+jfL8bTVynbeMKP0SuxMY
         ti1w==
X-Gm-Message-State: AGi0Puaj+JLzviLWvh/z7nNyXXJmUvQ4N+yu3fuQaK1x102Mc6qovVBE
        KclZdZlCUiHA7m9T9CLt/wDD2w==
X-Google-Smtp-Source: APiQypL3X1xlYzw2iOcrrAvDuDiryUSnxNiAeJYrDux+iWD+qj2k8HUN3EnuJVtWslaYhtMemGHUDw==
X-Received: by 2002:a62:1c97:: with SMTP id c145mr5322854pfc.68.1587666522523;
        Thu, 23 Apr 2020 11:28:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s44sm2954819pjc.28.2020.04.23.11.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 11:28:41 -0700 (PDT)
Date:   Thu, 23 Apr 2020 11:28:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 01/12] add support for Clang's Shadow Call Stack (SCS)
Message-ID: <202004231121.A13FDA100@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200416161245.148813-1-samitolvanen@google.com>
 <20200416161245.148813-2-samitolvanen@google.com>
 <20200420171727.GB24386@willie-the-truck>
 <20200420211830.GA5081@google.com>
 <20200422173938.GA3069@willie-the-truck>
 <20200422235134.GA211149@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422235134.GA211149@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 04:51:34PM -0700, Sami Tolvanen wrote:
> On Wed, Apr 22, 2020 at 06:39:47PM +0100, Will Deacon wrote:
> > On Mon, Apr 20, 2020 at 02:18:30PM -0700, Sami Tolvanen wrote:
> > > On Mon, Apr 20, 2020 at 06:17:28PM +0100, Will Deacon wrote:
> > > > > +	 * The shadow call stack is aligned to SCS_SIZE, and grows
> > > > > +	 * upwards, so we can mask out the low bits to extract the base
> > > > > +	 * when the task is not running.
> > > > > +	 */
> > > > > +	return (void *)((unsigned long)task_scs(tsk) & ~(SCS_SIZE - 1));
> > > > 
> > > > Could we avoid forcing this alignment it we stored the SCS pointer as a
> > > > (base,offset) pair instead? That might be friendlier on the allocations
> > > > later on.
> > > 
> > > The idea is to avoid storing the current task's shadow stack address in
> > > memory, which is why I would rather not store the base address either.
> > 
> > What I mean is that, instead of storing the current shadow stack pointer,
> > we instead store a base and an offset. We can still clear the base, as you
> > do with the pointer today, and I don't see that the offset is useful to
> > an attacker on its own.
> 
> I see what you mean. However, even if we store the base address +
> the offset, we still need aligned allocation if we want to clear
> the address. This would basically just move __scs_base() logic to
> cpu_switch_to() / scs_save().

Okay, so, I feel like this has gotten off into the weeds, or I'm really
dense (or both). :) Going back to the original comment:

> > > > Could we avoid forcing this alignment it we stored the SCS
> > > > pointer as a (base,offset) pair instead? That might be friendlier
> > > > on the allocations later on.

I think there was some confusion about mixing the "we want to be able to
wipe the value" combined with the masking in __scs_base(). These are
unrelated, as was correctly observed with "We can still clear the base".

What I don't understand here is the suggestion to store two values:

Why is two better than storing one? With one, we only need a single access.

Why would storing the base be "friendlier on the allocations later on"?
This is coming out of a single kmem cache, in 1K chunks. They will be
naturally aligned to 1K (unless redzoing has been turned on for some
slab debugging reason). The base masking is a way to avoid needing to
store two values, and only happens at task death.

Storing two values eats memory for all tasks for seemingly no meaningful
common benefit. What am I missing here?

-- 
Kees Cook
