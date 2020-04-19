Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB7CC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6F921744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmWi4d/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDSUJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 16:09:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20235 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725793AbgDSUJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 16:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587326947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3A2WsTlKyCqcpEYGhy9Sxngw/Q073wgh7iBTbMSaLqw=;
        b=YmWi4d/xzv5mj1EMlV6d/mUXCiOTRAeixHJOnqk7JOsZCS0Iz0qbpsAjfPNZW5bPD5TgcQ
        7E59117Rbss7eQq9qzpZogaUj8NGwJ8Xc+XyIgMUkDwDZZnKpG9V9BeRORFNCPqPYofwCZ
        y/NleT9cQg+nDNQtcyQkfV+5h0QJtbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-ceLCFr1NMMeU4sliqNqURg-1; Sun, 19 Apr 2020 16:08:02 -0400
X-MC-Unique: ceLCFr1NMMeU4sliqNqURg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67C3E1005510;
        Sun, 19 Apr 2020 20:08:01 +0000 (UTC)
Received: from treble (ovpn-112-22.rdu2.redhat.com [10.10.112.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 110525DA76;
        Sun, 19 Apr 2020 20:07:59 +0000 (UTC)
Date:   Sun, 19 Apr 2020 15:07:58 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT pull] perf/urgent for 5.7-rc2
Message-ID: <20200419200758.3xry3vn2a5caxapx@treble>
References: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
 <158730460101.31269.5005570498545135614.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjUS9b-B1n=OCBdqq3mdVTNGz0zqhGnrtMijoB5qT+96g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjUS9b-B1n=OCBdqq3mdVTNGz0zqhGnrtMijoB5qT+96g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 11:56:51AM -0700, Linus Torvalds wrote:
> On Sun, Apr 19, 2020 at 6:57 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > please pull the latest perf/urgent branch from:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-04-19
> 
> So this one took me by surprise, because it only touched the 'tools'
> subdirectory for the perf tool, and then when I did what I thought
> would be a trivial test build, it re-built the whole kernel.
> 
> And that made me go "Whaa?!?"
> 
> After looking at it for a while (longer than I really want to admit),
> I realized that it's because the headers are also shared with objtool,
> and it all kind of made sense.
> 
> I say "kind of" because I would have wished that objtool wouldn't
> necessarily rebuild everything.

Objtool is run against every .o file, and it's considered part of the
toolchain, because of ORC generation and other reasons.  If anything in
the toolchain changes, everything gets rebuilt.  It *is* kind of crude,
because GCC shouldn't really need to run again.  I don't know if there's
a more refined way to handle that dependency.  ccache helps :-)

> So I'm wondering if there any way that objtool could be run at
> link-time (and archive time) rather than force a re-build of all the
> object files from source?

We've actually been making progress in that direction.  Peter added
partial vmlinux.o support, for Thomas' noinstr validation.  The problem
is, linking is single-threaded so it ends up making the kernel build
slower overall.

So right now, we still do most things per compilation unit, and only do
the noinstr validation at vmlinux.o link time.  Eventually, especially
with LTO, we'll probably end up moving everything over to link time.

-- 
Josh

