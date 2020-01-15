Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7DAC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 00:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAD024658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 00:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdVXSo44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgAOAVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 19:21:35 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36810 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbgAOAVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 19:21:35 -0500
Received: by mail-qk1-f195.google.com with SMTP id a203so14113313qkc.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 16:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UxwVzZAl/9qlrzZun9B/nNh1T9A8qomSi5TcQ/Q+olk=;
        b=NdVXSo44flwST5J5jMsU2lvQ3yaMXFMtUaxSvE9mb1l2ZMMTMblpNr8seMd5/QGgOs
         /FDxHwHiF1FKFNrIpJIe1rRAHmpvgCI22foQi+yRJ41kq7/ReqK0D4nCnuC90/TAOW80
         80ScOLSoCPJuWyBJTs+U9DKsR2Z5U7y7PVmfYWtP0Ba8rJYZf/nGhWpB39P44TRX2STN
         fKEUsO/Ppv8d4pwo+qxmacXmFBiul4zd/P9cQDIrvDv39EwODeMoBJogPbHlaZ+HUVyr
         /eEsU6npNymdv040GOkOk4+H/eYmvjCzeiLYJZr6TOwlbotj828aM1nI7qMZgXHtc9ud
         sbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UxwVzZAl/9qlrzZun9B/nNh1T9A8qomSi5TcQ/Q+olk=;
        b=g2FDb27YMvVngGQ8faowbiiG7EWg9EgPTWa7mQT+gcXGHnZEoJqC3AWenq7XmIohwr
         n6Wn5BXEiICjl+eFX3rD1tFq4x+QgFzql3lVrI5JdbwklRkM0a4s2x22z81Nhleqpw5M
         c1fXaIJYI7FW36s50ZHioXU6uM/Q7YJ62QkqrI+40d3fts6Xp3dHFxXddNBE7W/r9t4C
         R6FyOHDEd2Eo70pXTsRcV4sBmY+CiGck5IpYUKqW7iDwZ9FWMRvVor06LNUHat8C1QYt
         GbCTExfFCv8r86L17bkmVGIltr7/ZANUWTeMp8iGFzw8UwxrsPl4SfF2+If1dhIQwmYT
         PLfA==
X-Gm-Message-State: APjAAAUfsLdsuuwCYV0BwP419yqybrqLtXn517HTITd6eRDoPVOJb9Os
        OjJw+OPY0s45X+d6onA0/eI=
X-Google-Smtp-Source: APXvYqyye2RKR+/jzL6JHvryEkVXq8d+MoRSnLvVzcrgiMtH0iCfDjgSAKO2WO+0qTM2thsygm8qfg==
X-Received: by 2002:a37:a98e:: with SMTP id s136mr19838938qke.253.1579047694256;
        Tue, 14 Jan 2020 16:21:34 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k88sm8393335qte.32.2020.01.14.16.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 16:21:33 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 14 Jan 2020 19:21:32 -0500
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH v3] x86/vmlinux: Fix vmlinux.lds.S with pre-2.23 binutils
Message-ID: <20200115002131.GA3258770@rani.riverdale.lan>
References: <20200113161310.GA191743@rani.riverdale.lan>
 <20200113195337.604646-1-nivedita@alum.mit.edu>
 <202001131750.C1B8468@keescook>
 <20200114165135.GK31032@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200114165135.GK31032@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 05:51:35PM +0100, Borislav Petkov wrote:
> On Mon, Jan 13, 2020 at 05:53:32PM -0800, Kees Cook wrote:
> > NAK: linkers can add things at the end of .text that will go missing from
> > the kernel if _etext isn't _outside_ the .text section, truly beyond the
> > end of the .text section. This patch will break Control Flow Integrity
> > checking since the jump tables are at the end of .text.
> 
> Err, which linkers are those? Please elaborate.
> 
> In any case, after reading the thread, I can't help but favor the idea
> of us bumping min binutils version to 2.23.
> 
> Michael (on Cc) says that the 2.21 was kinda broken wrt to the symbols
> fun outside of sections, 2.22 tried to fix it, see
> 
>   fd952815307f ("x86-32, relocs: Whitelist more symbols for ld bug workaround")
> 
> which Arvind pointed out and 2.23 fixed it for real.
> 
> Now, 2.23 is still very ancient. I'm looking at our releases: openSUSE
> 12.1 has the minimum supported gcc version 4.6 by the kernel and
> also the minimum binutils version 2.21 which we support according to
> Documentation/process/changes.rst
> 
> Now, openSUSE 12.1 is ancient and we ourselves advise people to update
> to current distros so I don't think anyone would still run it.

RHEL7 looks to have been released with 2.23 and we already don't
support the version in RHEL6, so that should be good too.

> 
> So, considering that upping the binutils version would save us from all
> this trouble I say we try it after 5.5 releases for a maximum time of a
> full 5.6 release cycle and see who complains.
> 
> Considering how no one triggered this yet until Arvind, I think no one
> would complain. But I might be wrong.
> 
> So what do people think? hpa?
> 

Thumbs up from me -- I had thought there were a few other reports
earlier about these, but looking at those threads, it seems like they're
all actually with ld.gold, which we already decided to drop support for
in commit 75959d44f9dc ("kbuild: Fail if gold linker is detected").

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
