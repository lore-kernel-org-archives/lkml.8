Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2E3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 21:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15DE2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 21:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quXCzrFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgFKVoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 17:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgFKVoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 17:44:16 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDFAC03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 14:44:16 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id g7so3470904qvx.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 14:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vlGLqbRt1ysLw4LRieBzZ3hIExddgO1NFVFXED2H08I=;
        b=quXCzrFvs5Tj9kDSX86/yFxKZzQIPXpFVPaU1SFKyn27t1iZEUL5XoOqQUTDxSxZxF
         bIxYXxLAhw2mabxbIgeQW6sdeMovCY6PsfIgd6AJpIk6FNaL+GGo5dFidkXrAV0Spj7Z
         gu0iKu+MzhSIEK4Ob/BCoJD0AhILmyoKBn7K7lqNLk9TQLsaCdtKbIw4jYfT9WngLnNK
         +5ctoC+aIdao/kBiJa4xerA00rvDTKx4zSyPPSdu5mF84+gYrZ7BA30swFvQGu4zfQzw
         F71j3B7qoPUc8T48lRHSUisGdKOliNpLQv/R9g6uebruBrXSWXdn+sIGjzgqQT0UzD2d
         DB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vlGLqbRt1ysLw4LRieBzZ3hIExddgO1NFVFXED2H08I=;
        b=a/EG4FCHJcTaG7/N4FRyPP6s8XVjcZr/LB0dvNbEANB+7+BqpE9e92eNQ0XrXt+68d
         CA3tW9mZYXzDXLcW2i1ONpfRGrgRfoqHoxE5KAICVGfoQs67vFE/SkSJPFzfzHRTzDEW
         dYc/i9Eb1XYqfWPQ/sarwPhvB0NkBx67GWey5mNLSw76gpesO1UB/7S+sUQ5Gfpko3/q
         mX3p497CwXZnfH7xr6JE/UqB8uT4XaabRzzMUl90o//KBIbme4yxpsVZgr3ZI5rfOoXw
         4AMeUEQ5shYTIO+AtmwLjun7HgUauaEYG4GIf2UKnYR/X5Qq/0sQacnzXi+x3pDPqDSa
         s0uA==
X-Gm-Message-State: AOAM533VQQZuE7i6ZPFkV2OgTiXdhDMnwOTFmAGBqqs9BMfY7Abg4TVO
        g7tnKkmArXIQJkjqtftoqGM=
X-Google-Smtp-Source: ABdhPJztCVw1122mqj+u/qbb3QBrsB29sitSBNZwrTD1S7Cf2dwqWv1C83ZXBcIJYTGoDQVy1eE0kw==
X-Received: by 2002:aed:2253:: with SMTP id o19mr55340qtc.236.1591911855402;
        Thu, 11 Jun 2020 14:44:15 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id s201sm3142424qka.8.2020.06.11.14.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 14:44:14 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 11 Jun 2020 17:44:13 -0400
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Makefile: Improve compressed debug info support detection
Message-ID: <20200611214413.GA3924125@rani.riverdale.lan>
References: <20200610063715.v2qrqvwtegdxdwzl@google.com>
 <20200610191106.2662548-1-nivedita@alum.mit.edu>
 <CAKwvOdnF9xhrs+FP4QXo6uXxgHMfHO8NvPYs1=KDE2ZyhCw2QQ@mail.gmail.com>
 <20200610233046.GA2941409@rani.riverdale.lan>
 <20200610233954.GB2941409@rani.riverdale.lan>
 <CAKwvOd=UyEPOx5M0w+uwiYwE5fY-A5vDmuvPnWs_pK4zW4RH-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=UyEPOx5M0w+uwiYwE5fY-A5vDmuvPnWs_pK4zW4RH-w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 01:44:53PM -0700, Nick Desaulniers wrote:
> On Wed, Jun 10, 2020 at 4:39 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Wed, Jun 10, 2020 at 07:30:46PM -0400, Arvind Sankar wrote:
> > > On Wed, Jun 10, 2020 at 02:27:55PM -0700, Nick Desaulniers wrote:
> > >
> > > No, as-option does invoke the assembler. The problem here is that with
> > > -Wa, the option is only seen by the assembler, not the gcc driver. So it
> > > will succeed because the assembler supports it, but it will not test
> > > whether the gcc driver also supports it.
> > >
> >
> > I think in theory another way to fix it is to just use -Wa even for
> > CFLAGS, assuming the compiler itself doesn't have to do anything with
> > the option and it's purely an assembler thing. Then you'd just do the as
> > and ld tests.
> 
> I don't think the CFLAGS are used for .S source files though.  We may
> drive assembler via the compiler, but AFLAGS are used in place of
> CFLAGS IIRC.  (eh, maybe not for ARCH=arc, ARCH=sh, ARCH=csky,
> ARCH=mips)
> 
> -- 
> Thanks,
> ~Nick Desaulniers

I meant just replace
	KBUILD_CFLAGS += -gz=zlib
with
	KBUILD_CFLAGS += -Wa,--compress-debug-sections=zlib
leaving KBUILD_AFLAGS the same as before
	KBUILD_AFLAGS += -Wa,--compress-debug-sections=zlib

This would avoid depending on the subtleties in the gcc driver's support
for this option. But -gz=zlib is passed to cc1 as well as the assembler,
so I'm not sure if there would be some loss from not passing it to the
compiler.
