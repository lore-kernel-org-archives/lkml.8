Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D5AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BB020656
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgFJKlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:41:31 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60270 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbgFJKla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:41:30 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jiyAT-0008OY-PL; Wed, 10 Jun 2020 20:41:14 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Jun 2020 20:41:13 +1000
Date:   Wed, 10 Jun 2020 20:41:13 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86-ml <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/microcode: Do not select FW_LOADER
Message-ID: <20200610104113.GA22678@gondor.apana.org.au>
References: <20200610042911.GA20058@gondor.apana.org.au>
 <20200610081609.GA14118@zn.tnic>
 <20200610102851.GA22584@gondor.apana.org.au>
 <20200610103418.GE14118@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610103418.GE14118@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 12:34:18PM +0200, Borislav Petkov wrote:
> 
> Out Kconfig symbols space is a mess and I'd prefer not to add another
> one if there's no good reason for it.

Adding two thousand lines of code to the kernel when you only need
a few lines is ridiculous.  Worse those two thousand lines increase
the attack surface to the kernel because they're exposed to user-
space.

Adding a hidden Kconfig symbol for the sake of reducing the kernel
attack surface would seem worthwhile.  In fact this isn't even an
issue right now because you are still using the custom function.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
