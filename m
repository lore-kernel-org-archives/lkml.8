Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCD4C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D5B24658
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="RA1f5Dyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAMQjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:39:05 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38378 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgAMQjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:39:04 -0500
Received: from zn.tnic (p200300EC2F05D30061EC8816C59C4425.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:d300:61ec:8816:c59c:4425])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D46F01EC0CAA;
        Mon, 13 Jan 2020 17:39:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578933543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9e88VmXVZOWwKi7Lf0kiLhtpdX2JvIFuLxWAoudDvAA=;
        b=RA1f5DyiqVuzD5fniya6vj7rBWgoi0MQ2vs5IWw2iTyjsLsB0UAaBOB2lYkVsAKjz4X9zW
        sec6pJTKJbdg4w/2CUMY7UGLc1VKJkDmzyGaWtnAF8pZhAbSFrxrLkzCXsqlOK529IZDEy
        5l41uoE7NjOig9UoP0guj/XHFvczJ0I=
Date:   Mon, 13 Jan 2020 17:38:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] x86/tools/relocs: Add _etext and __end_of_kernel_reserve
 to S_REL
Message-ID: <20200113163855.GK13310@zn.tnic>
References: <20200110202349.1881840-1-nivedita@alum.mit.edu>
 <20200110203828.GK19453@zn.tnic>
 <20200110205028.GA2012059@rani.riverdale.lan>
 <20200111130243.GA23583@zn.tnic>
 <20200111172047.GA2688392@rani.riverdale.lan>
 <20200113134306.GF13310@zn.tnic>
 <20200113161310.GA191743@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200113161310.GA191743@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 11:13:10AM -0500, Arvind Sankar wrote:
> I will note that the purpose of S_REL in relocs.c was originally to
> handle exactly this case of symbols defined outside output sections:

And we should try not to do hacks, if it can be fixed properly, as
binutils expects symbols to be usually relative to a section.

> How to reproduce is just "build with old binutils". I don't see it's
> reasonable to include a tutorial on how to build the kernel with a
> toolchain that's not installed in the default PATH, as part of the commit
> message.

The point is that it should be clear that it should state whether it is
something you trigger with some stock distro which has been shipping
this way or it is something you've customly created. Huge difference.

So pls make sure that is clear from the commit message.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
