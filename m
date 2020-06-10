Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1245AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2CF20734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qo+CIJ0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgFJNrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:47:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39018 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgFJNrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:47:01 -0400
Received: from zn.tnic (p200300ec2f0c1900a8dd7bf9cd2897c1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1900:a8dd:7bf9:cd28:97c1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6502D1EC0337;
        Wed, 10 Jun 2020 15:46:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591796816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eVDam303/36URtPn/p5Stw7lgMOTp4NPKt/zvaEL4Ic=;
        b=qo+CIJ0Q5rmXveOvAR5x3kSovwy+ODye2MR0cAGwO9Ip3M4S9HkaXoR1TWbbcGLCb7JpxM
        VUAQR721QJAeYQlmnO7YhRvUI8OWEVdIdtaFA3yc+Ufh8m0rOtb/azZoXLQqTZNX5MA9f4
        qhY4bz+uj45i3D28JGKoQfHIN313C6E=
Date:   Wed, 10 Jun 2020 15:46:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86-ml <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/microcode: Do not select FW_LOADER
Message-ID: <20200610134650.GH14118@zn.tnic>
References: <20200610042911.GA20058@gondor.apana.org.au>
 <20200610081609.GA14118@zn.tnic>
 <20200610131209.GT11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200610131209.GT11244@42.do-not-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 01:12:09PM +0000, Luis Chamberlain wrote:
> On Wed, Jun 10, 2020 at 10:16:09AM +0200, Borislav Petkov wrote:
> > 
> > Also, I'm working on removing that homegrown get_builtin_firmware() and
> > use the one in the fw loader:
> > 
> > https://lkml.kernel.org/r/20200408094526.GC24663@zn.tnic
> 
> I would like to still encourage this, even with this patch in place,
> as I think it makes this a proper call, and reflects better how the
> firmware loader is used exactly.
> 
> FWIW, firmware loader will be changed soon to not be modular, and just
> built-in or disabled.

I don't mind doing the work but Herbert has a point - there's no need to
require a bunch of code for a trivial function.

What I could do in addition is move that trivial function into a
fw-specific header and have it defined unconditionally so that the
microcode loader can use it without needing the fw loader.

The testcases stuff then goes ontop.

Yes, no?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
