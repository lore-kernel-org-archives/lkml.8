Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A3CC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D7D214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="WVOKEwGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgANQvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:51:44 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39370 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgANQvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:51:44 -0500
Received: from zn.tnic (p200300EC2F0C77005C63AD969BD3E4FA.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7700:5c63:ad96:9bd3:e4fa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E3E121EC027A;
        Tue, 14 Jan 2020 17:51:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579020703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BtKKTqVpr3M7ZGMd0iS27SAgqC0ZISimTY+3jNAM9hs=;
        b=WVOKEwGT6tFuELMy4DDbPsMvsqXndWd/PoD53+prwP/Z5uf8VXQUiWHLAldyGJLJi0siJa
        xjLmlnGKp3Y1RGsyTt3hHNQNW7aFoz593xugrzeAhdBeoAW44VzyWVh6jApXcPJnt6xpYT
        RwCynt3OJMmAb9lt9B60+Btu7+iwwro=
Date:   Tue, 14 Jan 2020 17:51:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kees Cook <keescook@chromium.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH v3] x86/vmlinux: Fix vmlinux.lds.S with pre-2.23 binutils
Message-ID: <20200114165135.GK31032@zn.tnic>
References: <20200113161310.GA191743@rani.riverdale.lan>
 <20200113195337.604646-1-nivedita@alum.mit.edu>
 <202001131750.C1B8468@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202001131750.C1B8468@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 05:53:32PM -0800, Kees Cook wrote:
> NAK: linkers can add things at the end of .text that will go missing from
> the kernel if _etext isn't _outside_ the .text section, truly beyond the
> end of the .text section. This patch will break Control Flow Integrity
> checking since the jump tables are at the end of .text.

Err, which linkers are those? Please elaborate.

In any case, after reading the thread, I can't help but favor the idea
of us bumping min binutils version to 2.23.

Michael (on Cc) says that the 2.21 was kinda broken wrt to the symbols
fun outside of sections, 2.22 tried to fix it, see

  fd952815307f ("x86-32, relocs: Whitelist more symbols for ld bug workaround")

which Arvind pointed out and 2.23 fixed it for real.

Now, 2.23 is still very ancient. I'm looking at our releases: openSUSE
12.1 has the minimum supported gcc version 4.6 by the kernel and
also the minimum binutils version 2.21 which we support according to
Documentation/process/changes.rst

Now, openSUSE 12.1 is ancient and we ourselves advise people to update
to current distros so I don't think anyone would still run it.

So, considering that upping the binutils version would save us from all
this trouble I say we try it after 5.5 releases for a maximum time of a
full 5.6 release cycle and see who complains.

Considering how no one triggered this yet until Arvind, I think no one
would complain. But I might be wrong.

So what do people think? hpa?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
