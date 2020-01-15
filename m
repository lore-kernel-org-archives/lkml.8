Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23507C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC80822522
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LSXFYBcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgAOMZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:25:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43354 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgAOMZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:25:08 -0500
Received: from zn.tnic (p200300EC2F0C7700ACD7CA379FB916C9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7700:acd7:ca37:9fb9:16c9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 983851EC05B5;
        Wed, 15 Jan 2020 13:25:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579091106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7TLB2bCnxciSvh08/oEK/yM49r9Hby4OGy55ioio0mY=;
        b=LSXFYBcH1ZO6zNPT1P4jLH5+LFTSLdy36lf1W/jAXiuH/IrosRo7WRiz1eudax0DWmhHrt
        OwbD3sgnr8CtxxbTyF+ArvKReTkzZOIFFldNtK4/nwgVTrYpjzh+j8kN8W8PlQpTUDKbLO
        0KaOxfySE9iFvBoi3KJaJzonsQpfM8A=
Date:   Wed, 15 Jan 2020 13:24:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH v3] x86/vmlinux: Fix vmlinux.lds.S with pre-2.23 binutils
Message-ID: <20200115122458.GB20975@zn.tnic>
References: <20200113161310.GA191743@rani.riverdale.lan>
 <20200113195337.604646-1-nivedita@alum.mit.edu>
 <202001131750.C1B8468@keescook>
 <20200114165135.GK31032@zn.tnic>
 <20200115002131.GA3258770@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200115002131.GA3258770@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 07:21:32PM -0500, Arvind Sankar wrote:
> RHEL7 looks to have been released with 2.23 and we already don't
> support the version in RHEL6, so that should be good too.

Good.

> Thumbs up from me -- I had thought there were a few other reports
> earlier about these,

Lemme clarify what I meant: I'm not aware of any other reports wrt
current kernel and ancient binutils build issues.

> but looking at those threads, it seems like they're
> all actually with ld.gold, which we already decided to drop support for
> in commit 75959d44f9dc ("kbuild: Fail if gold linker is detected").

Ok, then. So I'd say, we should do a trivial patch upping the binutils
version in Documentation/process/changes.rst with an explanation why
we're doing it. I'll queue it after 5.6-rc1 into tip and then it would
spend the maximal amount of exposure time in linux-next until it
releases in 5.7 sometime in the late summer.

I think that's the maximal exposure we can do before it hits an
upstream, non-rc release and hope that whoever wants to complain, will
do so before then.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
