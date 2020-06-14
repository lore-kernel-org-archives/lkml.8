Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE247C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 15:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1BB4207BC
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 15:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyV8mEkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgFNPhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 11:37:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30230 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726717AbgFNPhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 11:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592149059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pdjmOkI1bn7YFDE5FHbHtbuUsgKMpaTMy03LlVOQNFU=;
        b=XyV8mEkplxPkmonF/ESQUmhwksYV8wXO243yRDgE8f6Gbd4By11rLeauXCHBrY25dUYQAj
        sp2n/AnSz21KdrG1VdvufBN2UEy4f0jz8Bg9aWEGV4z4EMTkhr0NJeWesVZOsL6RBFF4kn
        C1cRauBCdhWqooWAhXS6/zuB+OpbDHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-l_vrs5qKOrq-3WyZp3l-VA-1; Sun, 14 Jun 2020 11:37:35 -0400
X-MC-Unique: l_vrs5qKOrq-3WyZp3l-VA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DED81883600;
        Sun, 14 Jun 2020 15:37:33 +0000 (UTC)
Received: from krava (unknown [10.40.192.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2AED3D01E7;
        Sun, 14 Jun 2020 15:37:29 +0000 (UTC)
Date:   Sun, 14 Jun 2020 17:37:28 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@elte.hu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ziqian SUN <zsun@redhat.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH -tip V6 0/6] kprobes: Fixes mutex, rcu-list warnings and
 cleanups
Message-ID: <20200614153728.GA2009260@krava>
References: <158927054236.27680.18209720730136003586.stgit@devnote2>
 <20200527234941.a15490ee50669812df8183dc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527234941.a15490ee50669812df8183dc@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 11:49:41PM +0900, Masami Hiramatsu wrote:
> (Oops, I missed Jiri in loop.)
> 
> Hi Ingo,
> 
> Could you take this series?
> These are not adding any feature, but fixing real bugs.

Hi,
I still can't see this being pulled in, did I miss it?

thanks,
jirka

> 
> Thank you,
> 
> On Tue, 12 May 2020 17:02:22 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi Ingo,
> > 
> > Here is the 6th version of the series for kprobes. The previous
> > version is here.
> > 
> >  https://lore.kernel.org/lkml/158583483116.26060.10517933482238348979.stgit@devnote2/
> > 
> > In this version, I picked 2 patches[1][2] which has been reviewed
> > on LKML but not merged to tip tree yet.
> > 
> > [1] https://lore.kernel.org/lkml/20200408164641.3299633-1-jolsa@kernel.org/
> > [2] https://lore.kernel.org/lkml/20200507185733.GA14931@embeddedor/
> > 
> > You can also pull this series from kprobes/core branch from
> > 
> >  https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/
> > 
> > Thank you,
> > 
> > ---
> > 
> > Gustavo A. R. Silva (1):
> >       kprobes: Replace zero-length array with flexible-array
> > 
> > Jiri Olsa (1):
> >       kretprobe: Prevent triggering kretprobe from within kprobe_flush_task
> > 
> > Masami Hiramatsu (4):
> >       kprobes: Suppress the suspicious RCU warning on kprobes
> >       kprobes: Use non RCU traversal APIs on kprobe_tables if possible
> >       kprobes: Fix to protect kick_kprobe_optimizer() by kprobe_mutex
> >       kprobes: Remove redundant arch_disarm_kprobe() call
> > 
> > 
> >  arch/x86/kernel/kprobes/core.c |   16 ++--------
> >  include/linux/kprobes.h        |    6 +++-
> >  kernel/kprobes.c               |   61 +++++++++++++++++++++++++++++++---------
> >  3 files changed, 56 insertions(+), 27 deletions(-)
> > 
> > --
> > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
> 

