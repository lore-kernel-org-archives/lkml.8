Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A57C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17AC214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="k1CQPAZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgANMKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 07:10:05 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46568 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgANMKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 07:10:04 -0500
Received: from zn.tnic (p200300EC2F0C77003938F16A642D0E75.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7700:3938:f16a:642d:e75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 41DAD1EC0C98;
        Tue, 14 Jan 2020 13:10:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579003803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UVBVRwQAHchxAi67wcQn1l/n0Q8ILWONdjW0r4Pz9Oo=;
        b=k1CQPAZkTFeGujiaSCpD85Dps96nHnz6Y+2EdQklq1wygC303JzKNGUCsxmcb+OY6LYEW8
        +lfOeAifIm0OYq3H6ZJ7paJGNSrQG1Mo/nDe8TRxuEC4NSdG8kEo9Q2qAtKD6ROqaVVnYt
        CfvRlSgv+bjUYfpT+uNTaqtdw0T7yvs=
Date:   Tue, 14 Jan 2020 13:10:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode/amd: fix uninitalized structure cp
Message-ID: <20200114121000.GH31032@zn.tnic>
References: <20200114111505.320186-1-colin.king@canonical.com>
 <20200114113834.GE31032@zn.tnic>
 <b59bb156-891e-3a26-3204-f5a0a1cc60d3@canonical.com>
 <20200114120156.GG31032@zn.tnic>
 <54eca4f8-33ca-24b1-9123-70df3b164043@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54eca4f8-33ca-24b1-9123-70df3b164043@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 12:03:36PM +0000, Colin Ian King wrote:
> On 14/01/2020 12:01, Borislav Petkov wrote:
> > On Tue, Jan 14, 2020 at 11:51:43AM +0000, Colin Ian King wrote:
> >> Starting at load_ucode_amd_bsp(), this initializes a local cp to zero,
> >> then passes &cp when it calls __load_ucode_amd() as parameter *ret.  In
> >> __load_ucode_amd a new local cp is created on the stack and *only* is
> >> assigned here:
> >>
> >>        if (!get_builtin_microcode(&cp, x86_family(cpuid_1_eax)))
> >>                 cp = find_microcode_in_initrd(path, use_pa);
> > 
> > Is there any case where cp doesn't get assigned here? Either by
> > get_builtin_microcode() or by find_microcode_in_initrd()?
^^^^^^^^^^^^^

You missed this question.

> OK, I will try to extract every special Tag from Coverity and get this
> documented when I get some spare cycles.

tglx just explained to me the whole situation about coverity.

I'm not asking about extracting special tags but rather about a
couple of sentences somewhere in Documentation/ explaining what
Addresses-Coverity* means for the unenlightened among us and how one can
find further invormation.

Reportedly, there's even a web page with the tags somewhere...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
