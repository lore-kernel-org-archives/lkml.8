Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF698C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8540E2082E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aTaZlC3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbgFPSBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbgFPSBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:01:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3CBC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:01:34 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f4c001d7e5f403e90d72b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4c00:1d7e:5f40:3e90:d72b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 91E8B1EC02C3;
        Tue, 16 Jun 2020 20:01:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592330492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hqVl7foDxxfge5hzy354qD6wQeIWNCQs1gQEI+LCBC4=;
        b=aTaZlC3yYdxaOyYbZFlqVO5L7S2UIRyNBYTwQS8QFNVUSCrH2nnR7Lt6gzM8FcZ4wQ42VX
        d4snp0rckqJXFxjvwPUEvkHkl/FkEPxVHth2HwmZn7EGGU0Is5hwCaZ8LD9wWSpRnGWtEE
        H7L0BgXHGlWfKVov0HK5y+oe3NXyfG8=
Date:   Tue, 16 Jun 2020 20:01:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     x86-ml <x86@kernel.org>, jpa@kernelbug.mail.kapsi.fi,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/fpu: Reset MXCSR to default in kernel_fpu_begin()
Message-ID: <20200616180123.GL13515@zn.tnic>
References: <20200616095340.GD13515@zn.tnic>
 <CALCETrWQJtv6f1zYnWSiPe7qFUx4znthbysVC9NJ-88YqP5-eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrWQJtv6f1zYnWSiPe7qFUx4znthbysVC9NJ-88YqP5-eg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 09:53:39AM -0700, Andy Lutomirski wrote:
> On Tue, Jun 16, 2020 at 2:53 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > Ok,
> >
> > here's the fix first so that it goes in. I'll hammer on the test case later.
> 
> Does the 32-bit case need FNINIT?

Pasting from IRC:

I'm thinking if you'd need to reinit the FPU, then you need to do it for
both, not only 32-bit or do you mean something else? Also, if you end up
doing FNSAVE (old CPU) that one reinits state.

Whatever we decide doing, this should be a separate patch anyway.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
