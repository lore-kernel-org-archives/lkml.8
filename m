Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE86C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36935207CD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntUqPrmj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgHUXZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 19:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgHUXZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 19:25:09 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BCCC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 16:25:08 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id b2so1385023qvp.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 16:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tPcAOUQXeRo09D74FlY+tpPy6QiUk0I9B9RENqrqcW0=;
        b=ntUqPrmjAo1/EkCYyYOMh3BgGdFcqk4KfkAS3Kqq2ho2+1ApOm9gKR0LdPQo+OWwdG
         a9RSry2SuNJtU0hPPPVKqfBgpA/kRcpdh+4z9SIHJlEx7r6ZotqaSp4rJ7wuUtBUR0Sw
         B5lJv0z+1INf29uhTrMkpKfI6wK8QjsNcTeSG+G1VJKLJhzzpajuCLaQk6H1pULR6wm+
         fxNkMOIuhq+D2wlsn7lnvcb8IX0jEVahvvwMuLsoTS0q7fl2Z3fTxVZOtnHNXAVoCICW
         kCesbQxwJcbbB8YDew1FIUeOGlF+hoxZUTVZPd9C/fbIlacrNEsWhAnKHNEyufDT3ROS
         6eMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tPcAOUQXeRo09D74FlY+tpPy6QiUk0I9B9RENqrqcW0=;
        b=aEyhQMofycA2guP7GIjdYd3s7emIYMz+gsCv/oRp6SNNvjmOPsGnvBYo1WnvuBTD8z
         SBgVJUaSoesAckXvsMJghKSB9KgC60U5FYBANUvn6G2bCz00gkETYWff66UpNlCPpt1l
         69cNaWBfhAaX+eMucpjXA0bmK1l5o+ZPNrUD1LykXRQaQ5Uf0wz7t8cSQ0z6pYKQNvj0
         /oDHG/kHm5lRO1+9nUW48mlCCzM09YVftX4crz/A8bH9JvZ8gHQMsQvBTuj9XYCZGFt4
         97Dtyw76iHHafaBEqCxKuC5eUAHknKqx4dW0mw+9S5CtJFyF/DWluvMVdHNiAFn2x4iQ
         IEDg==
X-Gm-Message-State: AOAM531WFFGZumHUhWL7phnNHPNtcGfk8wF6SDczM+LPj4Cmr9/3qV8O
        m56wvWMFUQSVt9pExzz7BmY=
X-Google-Smtp-Source: ABdhPJzdsa1XdIelQnW3ZUEGiSAMU7vKSSC2YSMuWs1YYOqDTyd6svcZMqK0u6TZ0GHTctLCdpATVg==
X-Received: by 2002:a0c:ec01:: with SMTP id y1mr4495531qvo.167.1598052307897;
        Fri, 21 Aug 2020 16:25:07 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id h55sm3767475qte.16.2020.08.21.16.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 16:25:07 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 21 Aug 2020 19:25:05 -0400
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
Message-ID: <20200821232505.GA66405@rani.riverdale.lan>
References: <878serh1b9.fsf@nanos.tec.linutronix.de>
 <CAKwvOdnOh3H3ga2qpTktywvcgfXW5QJaB7r4XMhigmDzLhDNeA@mail.gmail.com>
 <87h7t6tpye.fsf@nanos.tec.linutronix.de>
 <20200813173701.GC4295@paulmck-ThinkPad-P72>
 <20200813180933.GA532283@rani.riverdale.lan>
 <875z9dioll.fsf@nanos.tec.linutronix.de>
 <20200820130641.GA536306@rani.riverdale.lan>
 <87zh6ohm03.fsf@nanos.tec.linutronix.de>
 <20200821230435.GA56974@rani.riverdale.lan>
 <CAKwvOdkoB+fT9tt7vgg1R6J-NEr77EWP5X8nFat_L-HvEzWGzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdkoB+fT9tt7vgg1R6J-NEr77EWP5X8nFat_L-HvEzWGzA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 04:16:56PM -0700, Nick Desaulniers wrote:
> On Fri, Aug 21, 2020 at 4:04 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Fri, Aug 21, 2020 at 02:37:48AM +0200, Thomas Gleixner wrote:
> > > On Thu, Aug 20 2020 at 09:06, Arvind Sankar wrote:
> > > > I don't think that's an issue, or at least, not one where force_order
> > > > helps.
> > > >
> > > > If the source for foo() is not visible to the compiler, the only reason
> > > > force_order prevents the reordering is because foo() might have
> > > > references to it, but equally foo() might have volatile asm, so the
> > > > reordering isn't possible anyway.
> > > >
> > > > If the source is visible, force_order won't prevent any reordering
> > > > except across references to force_order, but the only references are
> > > > from the volatile asm's which already prevent reordering.
> > > >
> > > > I think force_order can only help with buggy compilers, and for those it
> > > > should really have been an input-output operand -- it wouldn't currently
> > > > do anything to prevent cr writes from being reordered.
> 
> I agree 100%.  From the link to GCC docs, the code in question doesn't
> even follow the pattern from the doc from informing the compiler of
> any dependency, it just looks like !@#$.
> 
> > >
> > > Fair enough. Care to provide a patch which has the collected wisdom of
> > > this thread in the changelog?
> > >
> > > Thanks,
> > >
> > >         tglx
> >
> > The gcc bug I linked to earlier is only fixed in gcc-6 onwards. Is that
> 
> (based on https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82602#c14)

I actually checked gcc's git repo too. The fix is not there in gcc-4.9
and gcc-5.

> 
> > good enough to remove force_order? I can test gcc-4.9 and gcc-5 to check
> > if it would currently have any impact.
> 
> I think checking the disassemblies with a pre-gcc-6 would be good
> enough then; that bug isn't specific to this particular case.
> 
> > CBL guys, can you confirm that clang also will not reorder volatile asm?
> 
> Full disassemblies of vmlinux pre vs post __force_order removal are
> the same.  That's pretty good actually; I was worried for a code base
> of this size whether two compiles would produce the exact same
> disassemblies; I know the version strings are timestamped, for
> instance, but I didn't compare data, just .text.  I should triple
> check i386, and some of the ko's that use modified functions.  I'd be
> happy to help provide a tested by tag for numerous configurations with
> Clang.
> 
> Attaching the diff I was testing, feel free to add a commit message.
> --
> Thanks,
> ~Nick Desaulniers

Thanks, will write it up over the weekend.
