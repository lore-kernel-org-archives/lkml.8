Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA40C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5599C206CD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgDVPGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:06:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:60022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbgDVPGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:06:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 80FE4AFC6;
        Wed, 22 Apr 2020 15:06:36 +0000 (UTC)
Date:   Wed, 22 Apr 2020 15:06:36 +0000 (UTC)
From:   Michael Matz <matz@suse.de>
To:     =?ISO-8859-15?Q?Martin_Li=A8ka?= <mliska@suse.cz>
cc:     Jakub Jelinek <jakub@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
In-Reply-To: <20a91f2e-0f25-8dba-e441-3233cc1ef398@suse.cz>
Message-ID: <alpine.LSU.2.21.2004221501440.11688@wotan.suse.de>
References: <20200417085859.GU2424@tucnak> <20200417090909.GC7322@zn.tnic> <CAKwvOdnFXPBJsAUD++HtYS5JiR2KmX73M5GAUe-tvX-JYV7DaA@mail.gmail.com> <CAKwvOdmNwNwa6rMC27-QZq8VDrYdTQeQqss-bAwF1EMmnAHxdw@mail.gmail.com> <20200417190607.GY2424@tucnak>
 <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com> <alpine.LSU.2.21.2004201401120.11688@wotan.suse.de> <20200422102309.GA26846@zn.tnic> <20200422114007.GC20730@hirez.programming.kicks-ass.net> <20200422134924.GB26846@zn.tnic>
 <20200422135531.GM2424@tucnak> <20a91f2e-0f25-8dba-e441-3233cc1ef398@suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1609957120-295431784-1587567996=:11688"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1609957120-295431784-1587567996=:11688
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hello,

On Wed, 22 Apr 2020, Martin Liška wrote:

> One possible solution can be usage of a GCC pragma that will disable the
> tail-call optimization:
> 
> $ cat tail.c
> int foo(int);
> 
> #pragma GCC push_options
> #pragma GCC optimize("-fno-optimize-sibling-calls")

As we determined upthread (and the reason why we even still have this 
thread): the optimize attribute (and pragma) reset flags from the command 
line (the case in point was -fno-omit-frame-pointer).  So, that's not a
solution for now.

> And as I talked to Boris, I would recommend to come up with a 
> "configure" check that a compiler does not optimize the key code 
> sequence:

Right.  I think the traditional asm (i.e. one without operands) is good 
enough for the forseeable future from GCCs side: it relies on documented 
behaviour of traditional asms, and hence would be very hard to change.


Ciao,
Michael.
---1609957120-295431784-1587567996=:11688--
