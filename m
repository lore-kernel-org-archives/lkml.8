Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44769C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F37320782
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9JqbbIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgDTTgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:36:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41339 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725550AbgDTTgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587411379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P/mZ/FJ5lXBF+ob35a7wpj3e4+gU+R172UXeLQi4XZc=;
        b=R9JqbbISc/4uLgormnvqB+CnOJN/GQEvAWh9efH0FCIecApLmG5Ai8ijRycvObwDiYErHg
        uoimRBZFeOtTVqhDgJ3hmP9ZGPkEwDRdummKN7m8GunxSh/3+Xaki2Kj0/NDFAoba9XY4T
        eQsNbm8MwUtT6OvODHay4gCCq5vv0pU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-wE_fO7tfMiWMcoIFf6Jh7w-1; Mon, 20 Apr 2020 15:36:17 -0400
X-MC-Unique: wE_fO7tfMiWMcoIFf6Jh7w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A79C8017F6;
        Mon, 20 Apr 2020 19:36:16 +0000 (UTC)
Received: from treble (ovpn-118-158.rdu2.redhat.com [10.10.118.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 815CFA1893;
        Mon, 20 Apr 2020 19:36:14 +0000 (UTC)
Date:   Mon, 20 Apr 2020 14:36:12 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] perf/urgent for 5.7-rc2
Message-ID: <20200420193612.4nv5i62onae6smv2@treble>
References: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
 <158730460101.31269.5005570498545135614.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjUS9b-B1n=OCBdqq3mdVTNGz0zqhGnrtMijoB5qT+96g@mail.gmail.com>
 <20200419200758.3xry3vn2a5caxapx@treble>
 <20200420074845.GA72554@gmail.com>
 <CAHk-=wiG=Bz57AUmbTyZYMKU6C+nZpS8P2=vFf5xAAhBzrPuTQ@mail.gmail.com>
 <20200420174031.GM20730@hirez.programming.kicks-ass.net>
 <20200420181730.4bmggezf2zhu4ffb@treble>
 <CAHk-=wg6QqiaLqk19nLLAjLFNf8eY7d1m2-Qigg9w3H6iGu+EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg6QqiaLqk19nLLAjLFNf8eY7d1m2-Qigg9w3H6iGu+EQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 12:21:46PM -0700, Linus Torvalds wrote:
> On Mon, Apr 20, 2020 at 11:17 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > If you added something bad to a file, and just rebuilt that file, you
> > wouldn't see the objtool warning until later when you build the entire
> > kernel.
> 
> Yes, that's not optimal, but I think I'd personally still prefer that
> behavior. Especially since I seldom build single files, and in fact
> rather seldom build without some "make -j32" or similar: so build
> errors don't happen linearly in the first place.
> 
> > (Of course the same complaint would apply to vmlinux.o
> > validation.)  But the warning shows the .o file, which could be
> > confusing.
> 
> The warning should show the proper loe-level *.o file, so I don't see
> what's confusing about that.
> 
> Yes, the error would happen while trying to link (say)
> kernel/built-in.a, and 'make' would report that creating that archive
> had failed, but 'objtool' itself would report the particular object
> file it was working on that had issues.

My workflow is often

  $ vi kernel/livepatch/core.c
  $ make kernel/livepatch/core.o

That way I don't have to wait to see what I broke (compile or objtool).

And if whatever I changed was in response to an objtool warning for
kernel/livepatch/core.o, and the warning didn't show up after doing the
above, I might stupidly assume I fixed it.

That's what I meant about it being confusing.  Maybe that's just me
though.

> So the errors should be pretty obvious. But like PeterZ, the makefile
> magic escapes me.

Ditto...

-- 
Josh

