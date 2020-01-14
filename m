Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB58C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EEE2467A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="dmWY2t71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgANLin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:38:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40912 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgANLin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:38:43 -0500
Received: from zn.tnic (p200300EC2F0C770060129B71B11B0F90.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7700:6012:9b71:b11b:f90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AFC731EC0BEA;
        Tue, 14 Jan 2020 12:38:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579001921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MUxEvzo2qOemIqNZH2imAAMYdLRr9L+RyhB34mILxjs=;
        b=dmWY2t71WvR+w3m6aakJhQ2w+9wqoNGUKdGQT53gxHyRk50vwDiH9vjYFjS9wUkBZnrRZk
        h+zdx6nwfhpiiom8pDqjrhWrzwTVkR1cEnFH1dVAAf7qs1+BUMICayIAIRnMjxhnlJubqx
        xCgtREbsMHspWtdukCfdDAhVIFIkBW4=
Date:   Tue, 14 Jan 2020 12:38:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Colin King <colin.king@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode/amd: fix uninitalized structure cp
Message-ID: <20200114113834.GE31032@zn.tnic>
References: <20200114111505.320186-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200114111505.320186-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 11:15:05AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where cp is not assigned to the return from
> the call to find_microcode_in_initrd

Where does this happen? I don't see it.

> cp is uninitialized when
> it is assigned to *ret.   Functions that call __load_ucode_amd
> such as load_ucode_amd_bsp can therefore end up checking bogus
> values cp.data and cp.size.  Fix this by ensuring cp is
> initialized as all zero and remove the redundant initialization
> of cp in load_ucode_amd_bsp.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")

I already asked about those: either document what those tags mean or
remove them.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
