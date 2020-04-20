Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6476FC38A30
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DAA5207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cEqq5T80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgDTRki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726711AbgDTRki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:40:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5D2C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o/LaYNUL2OH2fRo2sDxOcKfL/xjUaNCqaDe6bJwkfk0=; b=cEqq5T80Eq4YaLi8JxUE2AXcYw
        nZoapZ0Oh9Ku3WwJn/b1xkvUrqJT7HFldBxXX9gVwk/DgQiP/FF9kwcYay9RTMmUzIQiZMQqOhDbp
        lymrwuc5x6uND/9UT3Wd4F4xNE8RANaE7JsgBTAKxz1XmB22mxWX2KfW4IInrgKNAtJc71vFjnrTK
        Lahbf64vs8M8Qo5QMRNhl2e78yWc/Nwpl735G64YsHG7arSNBClJ3vkYDWBoLeyXpGuStJNQyvP04
        xztlOYvJ2z7KTm6OG7hceek96+XnC5gQX/qZtUmiIzXm7MwxtFZmQ9CO7SfSPZ98Gngv5oEZNUDDr
        lu0dfJ8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQaPJ-0004Ju-3S; Mon, 20 Apr 2020 17:40:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 890273024EA;
        Mon, 20 Apr 2020 19:40:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 76AFB2B9E12C8; Mon, 20 Apr 2020 19:40:31 +0200 (CEST)
Date:   Mon, 20 Apr 2020 19:40:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] perf/urgent for 5.7-rc2
Message-ID: <20200420174031.GM20730@hirez.programming.kicks-ass.net>
References: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
 <158730460101.31269.5005570498545135614.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjUS9b-B1n=OCBdqq3mdVTNGz0zqhGnrtMijoB5qT+96g@mail.gmail.com>
 <20200419200758.3xry3vn2a5caxapx@treble>
 <20200420074845.GA72554@gmail.com>
 <CAHk-=wiG=Bz57AUmbTyZYMKU6C+nZpS8P2=vFf5xAAhBzrPuTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiG=Bz57AUmbTyZYMKU6C+nZpS8P2=vFf5xAAhBzrPuTQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 09:51:55AM -0700, Linus Torvalds wrote:
> On Mon, Apr 20, 2020 at 12:48 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Fortunately, much of what objtool does against vmlinux.o can be
> > parallelized in a rather straightforward fashion I believe, if we build
> > with -ffunction-sections.
> 
> Well, I was actually thinking about a simpler model.
> 
> By "link time" I didn't mean "after final link". Yes, there may be
> reasons to do it at that point too (to do any whole-program checks),
> but that wasn't what I meant.
> 
> I meant literally doing it in the $(LD) and $(AR) phases, when you
> still have lots of independent object files that you are just about to
> link (or archive - do we even do that any more?) into one.
> 
> Then you'd parallelize exactly the same way we do now: one object file
> at a time, and with no real change of semantics.
> 
> IOW, what I was thinking that instead of doing it as part of a final
> step after the CC/AS, we'd do it as a preparatory step before the
> LD/AR. Same exact operation, same exact target *.o files, just shifted
> in time.

So my pet peeve is that when objtool errors, or crashes, the .o file
gets deleted and it becomes really hard to debug the situation. I'm
thinking that your suggestion would actually help with that too.

I just don't have enough Kbuild foo to even attempt this :/
