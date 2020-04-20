Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA26C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDFF21744
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFTzldCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgDTSRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:17:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57018 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725891AbgDTSRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587406657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LjYYLpViXa5cvb5XcfETBsdixh6Asqe6wqOEDaZtUC8=;
        b=NFTzldCLGlsxKgMMnlSjW6g3SmUoHKNq4IoiLsrL961CvZ0W9RwyhA29fjO62itrhTq1sz
        ze8PXEgWeb+jqxOyD5/zaH16GGEDYz1CFGMa1YzU/E79XomHd+lM+sNXSbNPnvihRVDQc0
        Jee4OmEUrL9yTsHVx8Nnftvb0fGwwAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-qbGKek6pOImhJoEFQ5KkeQ-1; Mon, 20 Apr 2020 14:17:35 -0400
X-MC-Unique: qbGKek6pOImhJoEFQ5KkeQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0DED107ACCA;
        Mon, 20 Apr 2020 18:17:33 +0000 (UTC)
Received: from treble (ovpn-118-158.rdu2.redhat.com [10.10.118.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 722A15C1B2;
        Mon, 20 Apr 2020 18:17:32 +0000 (UTC)
Date:   Mon, 20 Apr 2020 13:17:30 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] perf/urgent for 5.7-rc2
Message-ID: <20200420181730.4bmggezf2zhu4ffb@treble>
References: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
 <158730460101.31269.5005570498545135614.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjUS9b-B1n=OCBdqq3mdVTNGz0zqhGnrtMijoB5qT+96g@mail.gmail.com>
 <20200419200758.3xry3vn2a5caxapx@treble>
 <20200420074845.GA72554@gmail.com>
 <CAHk-=wiG=Bz57AUmbTyZYMKU6C+nZpS8P2=vFf5xAAhBzrPuTQ@mail.gmail.com>
 <20200420174031.GM20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200420174031.GM20730@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 07:40:31PM +0200, Peter Zijlstra wrote:
> On Mon, Apr 20, 2020 at 09:51:55AM -0700, Linus Torvalds wrote:
> > On Mon, Apr 20, 2020 at 12:48 AM Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > > Fortunately, much of what objtool does against vmlinux.o can be
> > > parallelized in a rather straightforward fashion I believe, if we build
> > > with -ffunction-sections.
> > 
> > Well, I was actually thinking about a simpler model.
> > 
> > By "link time" I didn't mean "after final link". Yes, there may be
> > reasons to do it at that point too (to do any whole-program checks),
> > but that wasn't what I meant.
> > 
> > I meant literally doing it in the $(LD) and $(AR) phases, when you
> > still have lots of independent object files that you are just about to
> > link (or archive - do we even do that any more?) into one.
> > 
> > Then you'd parallelize exactly the same way we do now: one object file
> > at a time, and with no real change of semantics.
> > 
> > IOW, what I was thinking that instead of doing it as part of a final
> > step after the CC/AS, we'd do it as a preparatory step before the
> > LD/AR. Same exact operation, same exact target *.o files, just shifted
> > in time.
> 
> So my pet peeve is that when objtool errors, or crashes, the .o file
> gets deleted and it becomes really hard to debug the situation. I'm
> thinking that your suggestion would actually help with that too.

I do have the same pet peeve and I'm thinking we should just revert
644592d32837 ("objtool: Fail the kernel build on fatal errors") which
would ease most of the pain.  Those fatal errors don't really buy us
much IMO.  Agree?

> I just don't have enough Kbuild foo to even attempt this :/

It's an interesting idea, but it might have its own share of annoyances.

If you added something bad to a file, and just rebuilt that file, you
wouldn't see the objtool warning until later when you build the entire
kernel.  (Of course the same complaint would apply to vmlinux.o
validation.)  But the warning shows the .o file, which could be
confusing.

And for localized testing where you don't want to rebuild everything,
you'd have to figure out which archive belongs to the .o file you want
to run objtool on.  And then rebuilding that archive manually might not
work, for example I have no idea what's going wrong here:

  $ make arch/x86/kernel/built-in.a
    CALL    scripts/checksyscalls.sh
    CALL    scripts/atomic/check-atomics.sh
    DESCEND  objtool
    AR      arch/x86/kernel/built-in.a
  ar: arch/x86/kernel/fpu/built-in.a: No such file or directory
  make[2]: *** [scripts/Makefile.build:387: arch/x86/kernel/built-in.a] Error 1
  make[1]: *** [scripts/Makefile.build:488: arch/x86/kernel] Error 2
  make: *** [Makefile:1723: arch/x86] Error 2


Though I do really like Ingo's idea for parallelizing things for
vmlinux.o.

-- 
Josh

