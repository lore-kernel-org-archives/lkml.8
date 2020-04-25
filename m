Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C37BC55186
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF4C2071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SW0/rxz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDYKl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:41:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54301 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgDYKl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587811285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0FrIzgjmsdkrsW5Ow3+nivBsO872iMxrrZWBo1xRaiI=;
        b=SW0/rxz6vorsoEaV+5N8AiyHPp5aiq3sOdD89Zv+kSE0t0jlJzvFx1RyfSvflp5kBmLeOv
        802+vCGBpyhFH4SFwXgvCi/a+xZEcnqyed8nsCAGI36UqFaG4WhYWCtSgauN7UUt+/8exx
        tb+4PCY+Cpe0DQLB0KCtlR+pS/eEK80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-51GP5heuOROyBvzCG7LRpw-1; Sat, 25 Apr 2020 06:41:16 -0400
X-MC-Unique: 51GP5heuOROyBvzCG7LRpw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41B3F8014D5;
        Sat, 25 Apr 2020 10:41:14 +0000 (UTC)
Received: from treble (ovpn-114-29.rdu2.redhat.com [10.10.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E33D6061B;
        Sat, 25 Apr 2020 10:41:12 +0000 (UTC)
Date:   Sat, 25 Apr 2020 05:41:10 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 00/11] ORC fixes
Message-ID: <20200425104110.3bx5xb57fssdvd4y@treble>
References: <cover.1587808742.git.jpoimboe@redhat.com>
 <20200425102512.GA12331@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200425102512.GA12331@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 12:25:12PM +0200, Ingo Molnar wrote:
> 
> * Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > v2:
> > - Dropped three patches which technically weren't fixes.  Will post them
> >   later as part of another patch set with more improvements.
> > - Removed show_iret_regs() declaration [mbenes]
> > - Added Miroslav Reviewed-by, Linus Reported-by
> > 
> > v1 was here:
> > https://lkml.kernel.org/r/cover.1584033751.git.jpoimboe@redhat.com
> > 
> > Jann Horn (1):
> >   x86/entry/64: Fix unwind hints in rewind_stack_do_exit()
> > 
> > Josh Poimboeuf (9):
> >   objtool: Fix stack offset tracking for indirect CFAs
> >   x86/entry/64: Fix unwind hints in register clearing code
> >   x86/entry/64: Fix unwind hints in kernel exit path
> >   x86/entry/64: Fix unwind hints in __switch_to_asm()
> >   x86/unwind/orc: Convert global variables to static
> >   x86/unwind: Prevent false warnings for non-current tasks
> >   x86/unwind/orc: Prevent unwinding before ORC initialization
> >   x86/unwind/orc: Fix error path for bad ORC entry type
> >   x86/unwind/orc: Fix premature unwind stoppage due to IRET frames
> > 
> > Miroslav Benes (1):
> >   x86/unwind/orc: Don't skip the first frame for inactive tasks
> 
> Thanks for doing this. These ORC handling bugs IMHO look serious and 
> widespread enough to warrant x86/urgent treatment, and the v2 series is 
> fixes-only.
> 
> Any objections against targeting v5.7-rc3 with this, assuming that 
> there's no problems found during review and it passes about a week of 
> testing?

Hi Ingo,

Due to other distractions, I unfortunately have been sitting on some of
these fixes for several months -- notice some of the long Reported-by
chains :-/

They're good small localized fixes and I would agree it makes sense to
target x86/urgent.

Thanks!

-- 
Josh

