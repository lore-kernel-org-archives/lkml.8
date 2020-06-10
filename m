Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F65C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE0920656
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="XewkXilq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgFJKsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:48:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41342 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbgFJKsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:48:52 -0400
Received: from zn.tnic (p200300ec2f0c190058967d889e42c717.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1900:5896:7d88:9e42:c717])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 36F921EC0288;
        Wed, 10 Jun 2020 12:48:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591786131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oWvY/ttIdgCzHFFtL4b8GfSMuKAdFbgMhQ9EUStJ0qI=;
        b=XewkXilqw6kbnHNMwYdZITGzGWU0+pHbmtqkNdME9UAsRSEIrwlp2lEB4t/i0FvTkmYy5D
        25/muVzFLaZrGCEwXoR9TR4hQVGNRQqjp+l3vvSYwRVAEMXyWn4Ugum8qi3SdJ4NJnJ+hX
        PzOjXQ3FNzgXAahrM0F2sc1Vpwme21I=
Date:   Wed, 10 Jun 2020 12:48:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86-ml <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/microcode: Do not select FW_LOADER
Message-ID: <20200610104845.GF14118@zn.tnic>
References: <20200610042911.GA20058@gondor.apana.org.au>
 <20200610081609.GA14118@zn.tnic>
 <20200610102851.GA22584@gondor.apana.org.au>
 <20200610103418.GE14118@zn.tnic>
 <20200610104113.GA22678@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200610104113.GA22678@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 08:41:13PM +1000, Herbert Xu wrote:
> Adding two thousand lines of code to the kernel when you only need
> a few lines is ridiculous.  Worse those two thousand lines increase
> the attack surface to the kernel because they're exposed to user-
> space.

Why isn't *this* in your commit message?

> Adding a hidden Kconfig symbol for the sake of reducing the kernel
> attack surface would seem worthwhile.

And that.

> In fact this isn't even an issue right now because you are still using
> the custom function.

Actually, I'd prefer your version which doesn't depend on FW_LOADER at
all for the above reasons.

Please resubmit with amended commit message, adding the justification
for the change.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
