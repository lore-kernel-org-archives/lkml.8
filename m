Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BC2C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01666207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="czzWPWyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgAMSIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 13:08:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52500 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgAMSIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:08:35 -0500
Received: from zn.tnic (p200300EC2F05D30049A87F91DFBF49F4.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:d300:49a8:7f91:dfbf:49f4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 092F61EC068C;
        Mon, 13 Jan 2020 19:08:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578938914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=owy3N1R9tG9P+BYI33k9noSaZuweOD40dXv4GjRa9dQ=;
        b=czzWPWyyeWvOIIwdLrZlymADs7daJjXx0z7l964noY28Vp2vCXxzORDeDYGlWIA2e9S7LH
        LdNA+kIU98SR/+jhnRtj1bkaIxXvB2KSkdXxJpdSUeTZATLO3ltJGxtF9NxJmo3fSm+lia
        ha5U1XH+KGs9wvuLlkAlHMAUBduiR4M=
Date:   Mon, 13 Jan 2020 19:08:26 +0100
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
Message-ID: <20200113180826.GN13310@zn.tnic>
References: <20200110202349.1881840-1-nivedita@alum.mit.edu>
 <20200110203828.GK19453@zn.tnic>
 <20200110205028.GA2012059@rani.riverdale.lan>
 <20200111130243.GA23583@zn.tnic>
 <20200111172047.GA2688392@rani.riverdale.lan>
 <20200113134306.GF13310@zn.tnic>
 <20200113161310.GA191743@rani.riverdale.lan>
 <20200113163855.GK13310@zn.tnic>
 <20200113175937.GA428553@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200113175937.GA428553@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 12:59:38PM -0500, Arvind Sankar wrote:
> How is "breaks with binutils before version 2.23" not clear enough? It

Nevermind, I'll write it myself if/when I end up applying some version
of it. I've wasted enough time trying to get my point across.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
