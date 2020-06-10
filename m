Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494A8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B2520656
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="QxTP5VFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgFJKea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgFJKe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:34:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33164C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:34:28 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c190058967d889e42c717.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1900:5896:7d88:9e42:c717])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3AA5F1EC0347;
        Wed, 10 Jun 2020 12:34:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591785266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oUqsKM3VGX+allcG7hbfIpXBxBk39Nd9J5AqFmM6K8s=;
        b=QxTP5VFvFhwFGfG/QYHXDM7gSslE/W6R1WJhaFnz1bVKe+oeRo84Me3nh+MdyOw/VWloeE
        OznB+C/Y//kxVKnJN/UZ6ud/8aurD2f/dnXT6tBvc48bTJKtlcJT7ZqGC5GcpkDjMC487W
        NmNpiwaF00QJbhLY2aDpaK9rKcTZbDE=
Date:   Wed, 10 Jun 2020 12:34:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86-ml <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/microcode: Do not select FW_LOADER
Message-ID: <20200610103418.GE14118@zn.tnic>
References: <20200610042911.GA20058@gondor.apana.org.au>
 <20200610081609.GA14118@zn.tnic>
 <20200610102851.GA22584@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200610102851.GA22584@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 08:28:51PM +1000, Herbert Xu wrote:
> Because MICROCODE is the only thing on my system that pulls it
> into the kernel.

That's a very interesting system you have.

> That shouldn't be a problem.  That function can simply move under
> another (hidden) Kconfig option that gets selected by both MICROCODE
> and FW_LOADER.

Out Kconfig symbols space is a mess and I'd prefer not to add another
one if there's no good reason for it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
