Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44171C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 18:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F564206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 18:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="J1HDIxyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgDYSxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 14:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726145AbgDYSxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 14:53:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154A3C09B04D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 11:53:22 -0700 (PDT)
Received: from zn.tnic (p200300EC2F2A1100B46A3E12B0A6AFFD.dip0.t-ipconnect.de [IPv6:2003:ec:2f2a:1100:b46a:3e12:b0a6:affd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8527F1EC0C84;
        Sat, 25 Apr 2020 20:53:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587840800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iTbPHyhUCYp1hsTKDTL6Rkak9xj3g4rssRfqZNkVLdA=;
        b=J1HDIxyv/9Q6KrgTFyzUaS9MzUgSTqUl1CHKzxt9TsfuRWCgenOsqkBAUiSvooHmIFgoYR
        xTFg4Y4kCmZjWDIrRtDZdBKr0CU76/YyCxbHLM8CBk0vP11S/rVp9yFpSmoUqaXMTtJMbC
        uoQ0v7K3Cuy7iuezi+zng5kYLFXuv0o=
Date:   Sat, 25 Apr 2020 20:53:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Jakub Jelinek <jakub@redhat.com>, jgross@suse.com,
        x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, Michael Matz <matz@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Pierret_=28fepitre=29?= 
        <frederic.pierret@qubes-os.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH] x86: Fix early boot crash on gcc-10, next try
Message-ID: <20200425185313.GD24294@zn.tnic>
References: <CAKwvOdkbcO8RzoafON2mGiSy5P96P5+aY8GySysF2my7q+nTqw@mail.gmail.com>
 <20200422212605.GI26846@zn.tnic>
 <CAKwvOd=exxhfb8N6=1Q=wBUaYcRDEq3L1+TiHDLz+pxWg8OuwQ@mail.gmail.com>
 <20200423125300.GC26021@zn.tnic>
 <20200423161126.GD26021@zn.tnic>
 <20200425014657.GA2191784@rani.riverdale.lan>
 <20200425085759.GA24294@zn.tnic>
 <20200425150440.GA470719@rani.riverdale.lan>
 <20200425173140.GB24294@zn.tnic>
 <20200425183701.GE17645@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200425183701.GE17645@gate.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 01:37:01PM -0500, Segher Boessenkool wrote:
> That is a lot more typing then
> 	asm("");

That's why a macro with a hopefully more descriptive name would be
telling more than a mere asm("").

> but more seriously, you probably should explain why you do not want a
> tail call *anyway*, and in such a comment you can say that is what the
> asm is for.

Yes, the final version will have a comment and the whole spiel. This
diff is just me polling the maintainers: "do you want this for your arch
too?" Well, the PPC maintainers only, actually.

The other call in init/main.c would be for everybody.

> I don't see anything that prevents the tailcall in current code either,
> fwiw.

Right, and I don't see a reason why gcc-10 would do that optimization on
x86 only but I better ask first.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
