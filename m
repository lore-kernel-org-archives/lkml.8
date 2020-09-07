Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959EBC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E1121741
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="UuyGI6s5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgIGL3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbgIGLXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:23:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366E1C0617BE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 04:12:17 -0700 (PDT)
Received: from zn.tnic (p200300ec2f09090030eade31917bbe1c.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:900:30ea:de31:917b:be1c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB00B1EC0445;
        Mon,  7 Sep 2020 13:11:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599477074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cv5cgieD4imCKFHqyFVB5TEo45oyRkcNlpNdT0Kes4I=;
        b=UuyGI6s51Um5rVOmjTwZAduAmuq3+DLBrpOOlbC/Akq3EZwcgOCz+3ElExEWKzzRCGT0G+
        mXDR8hNN16OyTBH1tzid1tIwbNpx/Bm0McKEx3Nc3a/+PD3BtkPOP9ciGPN8dJaDFextnH
        g8zNVqqhJ9sXATij9i8DVYDkdPvZJEs=
Date:   Mon, 7 Sep 2020 13:11:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kitsunyan <kitsunyan@airmail.cc>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
Message-ID: <20200907111109.GB16029@zn.tnic>
References: <20200907094843.1949-1-Jason@zx2c4.com>
 <20200907100647.GB10657@zn.tnic>
 <CAHmME9o_Odo97K7QXKO=konVE-UxR7iBCE5S8uAJgc=kJ2EgsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9o_Odo97K7QXKO=konVE-UxR7iBCE5S8uAJgc=kJ2EgsA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 07, 2020 at 12:46:35PM +0200, Jason A. Donenfeld wrote:
> Are you sure that intel-undervolt using OC_MAILBOX from userspace is
> actually a "misuse"? Should the kernel or kernel drivers actually be
> involved with the task of underclocking? This seems pretty squarely in
> the realm of "hobbyists poking and prodding at their CPUs" rather than
> something made for a kernel driver, right?

The only thing I'm sure is that *if* it makes sense for any driver to
control something in the hardware over MSRs, it should *not* poke at
naked MSRs but use a proper interface.

I'd leave it to the people who actually need this interface, to explain
why they do.

> Also, what was the justification for whitelisting
> MSR_IA32_ENERGY_PERF_BIAS?

That's:

tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c

Once that thing gets converted to a proper interface too, that MSR goes
off the allowlist too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
