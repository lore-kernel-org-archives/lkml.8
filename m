Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D4DC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B02D20754
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="IGeCLBMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgCRT6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:58:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37714 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgCRT6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:58:04 -0400
Received: from zn.tnic (p200300EC2F0B450051E70FD0A142DE40.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:4500:51e7:fd0:a142:de40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9DBDA1EC0985;
        Wed, 18 Mar 2020 20:58:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584561483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lJ3lAL2e7UJQ2cm2VDUW2t8k97NFcKqCK7YFFba7WNg=;
        b=IGeCLBMHFi/SWWFfusiiyWLLJPuXCPQnYm09f4c9tGeDWtsaNyhQalmDX94zXIgtq+hSdc
        Xvb+pGHRUbGWYfVb4fMWN2ul6Dv6yWJlr2dC6pPnM4vO5KrQu+PeNMdo9kf1mRrO0Nbfh4
        8pEOkb20OpPkLYw03d41p7NTctNamr8=
Date:   Wed, 18 Mar 2020 20:58:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     gilad kleinman <dkgs1998@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/module: Fixed bug allowing invalid relocation
 addresses.
Message-ID: <20200318195803.GE4377@zn.tnic>
References: <20200314213626.30936-1-dkgs1998@gmail.com>
 <20200316125824.GB12561@hirez.programming.kicks-ass.net>
 <CAOQ9fa-i3mW2jQ2P=+34Feh9sZzaqDFKHau9GrgEWR9d26AqDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ9fa-i3mW2jQ2P=+34Feh9sZzaqDFKHau9GrgEWR9d26AqDg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 09:40:47PM +0200, gilad kleinman wrote:
> When you load a bad module and the kernel crashes -- the panic message will
> usually be related to the module and easily traced back. If you load a
> module with a bad relocation table (because of a bit-flip \ bad toolchain),

First of all, please do not top-post.

Then, if you're worried about corrupted module text, we have
CONFIG_MODULE_SIG which verifies previously signed modules. AFAICT, that
should take care of the issue you're talking about here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
