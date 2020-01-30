Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAF7C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 11:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36F12083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 11:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="owaJOXae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgA3Lg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:36:28 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59164 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgA3Lg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 06:36:27 -0500
Received: from zn.tnic (p200300EC2F0A2D00708CE17CE0236808.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2d00:708c:e17c:e023:6808])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 00E651EC0C35;
        Thu, 30 Jan 2020 12:36:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1580384186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=H36ykz5naWIQ4dY4VToh2KOl152TyIJxqOH958o/k04=;
        b=owaJOXaekQ8qGc/B0p3nmoF+8Z1/C5hlv6ncPiuv9/fqRzrwFwGMUhe2EuQyqfRA9Idw99
        ta/IEBW70DJaiyz9zcN51MR/Qdm8u+s1A0eyZ9ZIOjvYa2PCF+uqscw5Rmm+NgVi9Rp0Xw
        b/ji/EuCxZDvdhwwMSqwTHPV5OH/Yes=
Date:   Thu, 30 Jan 2020 12:36:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: fix kaslr-enabled build
Message-ID: <20200130113619.GE6656@zn.tnic>
References: <20200129162926.1006-1-sergey.senozhatsky@gmail.com>
 <20200130110008.GD6656@zn.tnic>
 <20200130113134.GA498@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200130113134.GA498@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 08:31:34PM +0900, Sergey Senozhatsky wrote:
> Oh, didn't occur to me that this can be compiler specific.
> But yes, apparently it is. gcc-9.2 is fine, but not gcc-10
> release-candidate.

Ah ok, that makes more sense. That's being discussed ATM but it is merge
window so it'll take a while:

https://lkml.kernel.org/r/20200124181811.4780-1-hjl.tools@gmail.com

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
