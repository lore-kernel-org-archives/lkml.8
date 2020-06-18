Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA89DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC3132083B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592505430;
	bh=Knz5GZwIrR2m3rJkhIEdASfCnCSkNHIP610FXM2qoNs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=blKFfXLXZknE6aTuLu9fTPsgALIDFXLBFfEJ3fu52pZkJdpdXNynQB0gxn6jCxekT
	 Eil5IJnzWJt62qfzLkIe8vUjN/bEmo7iQT7TPPIbTHptxm4maNJPX4W4xpfumtcjz0
	 lNSqqUt6RqOSNEUGhk78KQUAAd/tTcgb+jRwi4HA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgFRShJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgFRShH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 14:37:07 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A40B8208C3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592505426;
        bh=Knz5GZwIrR2m3rJkhIEdASfCnCSkNHIP610FXM2qoNs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wPW4GY5zOPz7yJL5L7HuzdkJsaiJSLmRDAgYqv+lax5ZiBG4034xzT9Yex3qsiY1k
         joe1MsFiItJnnLNpQKMSPuTaitrUgrDngeLSs1PaEkyilFGM1O8TVm44XDqz5s/qJs
         fumbkA91fwtSrUTGzHvA3orAbUpRLvroIIjlCU3I=
Received: by mail-wm1-f41.google.com with SMTP id t194so6733566wmt.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 11:37:06 -0700 (PDT)
X-Gm-Message-State: AOAM531HapEWjKsL6/wc1uIcWoW9wXsEc/drAbEECheHQSP1lBucpkH5
        me2FvYEE//dvSN+JaJ3+WVwUkLR62Iyerp4ZC4geLg==
X-Google-Smtp-Source: ABdhPJyNUbpWrJsnkXl6Eo+/ZBuC12pBSC8BrZof+nKJiNGZ22bGcbqtLmOGL5H/HKdIbSq7gXIIUgqnUBDDPD93kSA=
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr5383841wmd.138.1592505425251;
 Thu, 18 Jun 2020 11:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200618144801.642309720@infradead.org> <70455B9B-0952-4E03-B2CE-EEAE1E110C5B@amacapital.net>
 <20200618155017.GK576905@hirez.programming.kicks-ass.net>
In-Reply-To: <20200618155017.GK576905@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 18 Jun 2020 11:36:53 -0700
X-Gmail-Original-Message-ID: <CALCETrWvrmuuTqZzhGswsFSCWxO3tuVBiJ+M4a=Negqwo1dyNA@mail.gmail.com>
Message-ID: <CALCETrWvrmuuTqZzhGswsFSCWxO3tuVBiJ+M4a=Negqwo1dyNA@mail.gmail.com>
Subject: Re: [PATCH 1/7] x86/entry: Fix #UD vs WARN more
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>, jthierry@redhat.com,
        Miroslav Benes <mbenes@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 8:50 AM Peter Zijlstra <peterz@infradead.org> wrote=
:
>
> On Thu, Jun 18, 2020 at 07:57:35AM -0700, Andy Lutomirski wrote:
> >
> >
> > > On Jun 18, 2020, at 7:50 AM, Peter Zijlstra <peterz@infradead.org> wr=
ote:
> > >
> > > =EF=BB=BFvmlinux.o: warning: objtool: exc_invalid_op()+0x47: call to =
probe_kernel_read() leaves .noinstr.text section
> > >
> > > Since we use UD2 as a short-cut for 'CALL __WARN', treat it as such.
> > > Have the bare exception handler do the report_bug() thing.
> >
> > I think you should consider inlining or noinstr-ifying report_bug()
> > too if you want to make this more bulletproof. I admit the scenario
> > where someone instruments it and it goes wrong is farfetched.
>
> How far down that rabbit hole do we go? Because then we need to noinstr
> printk, the console drivers, those will very quickly pull in lovely bits
> like PCI, USB, DRM :/
>
> At some point we have to just give up.

I wasn't imagining going far down the rabbit hole at all -- I think
that, at most, we should cover the path for when the fault wasn't a
BUG/WARN in the first place.  I admit that, for #UD in particular,
this isn't a big deal, but if it were a different vector, this could
matter.

I suppose report_bug() could be split into lookup_bug() and
handle_bug(), and just lookup_bug() could be noinstr.

--Andy
