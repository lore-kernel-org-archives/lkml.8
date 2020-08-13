Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7C0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 18:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E97E20774
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 18:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMl3Qj9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHMSJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMSJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 14:09:37 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B86C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 11:09:37 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s16so5053322qtn.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 11:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CQ17aXKfX9jTOeTDi07zI7TGLiegJG5JHkGJpsdYnbM=;
        b=OMl3Qj9/cRzAh+5sk6WnNF6DTQiVtYnzVpue5VKKGT4pXaF572DS1AwIfDYqqDy8O1
         HYqF1Wg6HZ8HqmI48tOkP5J6JGMT5LUNdmGXG4OXcgGB+LYjM8ujpTmhC2EXMiOuTNkR
         t+fQ54hy2lyi0Gvm6hVZxiUVq90W3N/iDWKje0WWdIqYpE39eLdNR9O5LO9kN5np/VWT
         TxtNh99gwDg5FkCt9gZIgMaocRPTAJTIrOg+0VA1jW8K9tTMX86XesA1GWjhqjTNzELQ
         KjZ9+N7MFCG2YxG/DGlfi4/PVc4Oee8RIf/OpfZ/xot1uTJ0w6JrRvXYIRAMwkmQXAZh
         Vd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=CQ17aXKfX9jTOeTDi07zI7TGLiegJG5JHkGJpsdYnbM=;
        b=VdVOC+x1AOqlvy1iilh8o5Yl0KNPMjarfBTRDR+zs/75jsiqFWqR8yjppN6rbsWNlH
         IlzpPz29DUdWXR4hwFgc6pgK36yJ+bsTwq4LxRh4GT76wMSXl6djjsI0l7BKEtlzYyEj
         RhrTH61/jwAj+iwuun7TO/V3kQziuVicDJBy2gF3UJnTrMXl1vV8lAGIj2Qe1vhYkYDB
         GlB048rPJCfqrLN1j/8hU9p7KELViREP/2xmbIV6+ccqr0/GvUwT/J/9nHjiGYG+HZ5F
         XVYRzC35Sv3M95987jM1U7asd8/qeTChSxVq9iIS7d8rdxBiwNWjCji0/XIUWV/UmGNW
         pBsw==
X-Gm-Message-State: AOAM531IUkctImmqH8EN7UbxzwOrK3XjwlJTZh3uWMcCFsY88EuK43ws
        QkbZZ2Rj+c07BQRFd2DY1Xg=
X-Google-Smtp-Source: ABdhPJw7XhfNz87fA6AypSfNJ5n3h0q5/0btXQaZweSv3yWSVHY0xTapycZu62dK9XP4RP81mlBgmQ==
X-Received: by 2002:ac8:6c6:: with SMTP id j6mr6836667qth.129.1597342176242;
        Thu, 13 Aug 2020 11:09:36 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i30sm7832477qte.30.2020.08.13.11.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 11:09:35 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 13 Aug 2020 14:09:33 -0400
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
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
Message-ID: <20200813180933.GA532283@rani.riverdale.lan>
References: <20200527135329.1172644-1-arnd@arndb.de>
 <878serh1b9.fsf@nanos.tec.linutronix.de>
 <CAKwvOdnOh3H3ga2qpTktywvcgfXW5QJaB7r4XMhigmDzLhDNeA@mail.gmail.com>
 <87h7t6tpye.fsf@nanos.tec.linutronix.de>
 <20200813173701.GC4295@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200813173701.GC4295@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 10:37:01AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 13, 2020 at 07:28:57PM +0200, Thomas Gleixner wrote:
> > Nick Desaulniers <ndesaulniers@google.com> writes:
> > > On Thu, Aug 6, 2020 at 3:11 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >> > + *
> > >> > + * Clang sometimes fails to kill the reference to the dummy variable, so
> > >> > + * provide an actual copy.
> > >>
> > >> Can that compiler be fixed instead?
> > >
> > > I don't think so. The logic in the compiler whether to emit an
> > 
> > Forget that I asked. Heat induced brain damaged.
> > 
> > > I'd much rather remove all of __force_order.
> > 
> > Right.
> > 
> > > Not sure about the comment in arch/x86/include/asm/special_insns.h
> > > either; smells fishy like a bug with a compiler from a long time ago.
> > > It looks like it was introduced in:
> > > commit d3ca901f94b32 ("x86: unify paravirt parts of system.h")
> > > Lore has this thread:
> > > https://lore.kernel.org/lkml/4755A809.4050305@qumranet.com/
> > > Patch 4: https://lore.kernel.org/lkml/11967844071346-git-send-email-gcosta@redhat.com/
> > > It seems like there was a discussion about %cr8, but no one asked
> > > "what's going on here with __force_order, is that right?"
> > 
> > Correct and the changelog is uselss in this regard.
> > 
> > > Quick boot test of the below works for me, though I should probably
> > > test hosting a virtualized guest since d3ca901f94b32 refers to
> > > paravirt.  Thoughts?
> > 
> > Let me ask (hopefully) useful questions this time:
> > 
> >   Is a compiler allowed to reorder two 'asm volatile()'?
> > 
> >   Are there compilers (gcc >= 4.9 or other supported ones) which do that?
> 
> I would hope that the answer to both of these questions is "no"!
> 
> But I freely confess that I have been disappointed before on this sort
> of thing.  :-/
> 
> 							Thanx, Paul

Ok, I found this, so gcc developers consider re-ordering volatile asm
wrt each other a bug at least.

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82602
