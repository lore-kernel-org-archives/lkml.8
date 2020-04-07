Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FD6C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D9420768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="jsS/hKOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgDGThQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:37:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55700 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgDGThP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:37:15 -0400
Received: from zn.tnic (p200300EC2F0B270035AFF05F0368BCDC.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2700:35af:f05f:368:bcdc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A811D1EC0CB7;
        Tue,  7 Apr 2020 21:37:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586288234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=V4cybn+CymPXYIghb52WMFTzqhy3jyV0hMGgojr1JGI=;
        b=jsS/hKOIee56H7YCsYHZ+QiIYWQ7QccXozS4IcSVF4Qlfja/sZCZrebeOWxCjOZSdF1A1x
        dSyXBjETDFuVkNu31i8q0fC39j5qkhiT0hC+Ryn1NhrOq1fA8kxUVsww7nn5JEnH8oW7L3
        YKaOcYtQPmj9vzQN8bDf8Sub+pJVFj8=
Date:   Tue, 7 Apr 2020 21:37:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/7] x86/mce: Change default mce logger to check
 mce->kflags
Message-ID: <20200407193710.GE9616@zn.tnic>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200214222720.13168-1-tony.luck@intel.com>
 <20200214222720.13168-6-tony.luck@intel.com>
 <20200407111047.GB9616@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F5D3DA2@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F5D3DA2@ORSMSX115.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 04:43:29PM +0000, Luck, Tony wrote:
> >> +	if (m->kflags)
> >> +		pr_emerg(HW_ERR "kflags = 0x%llx\n", m->kflags);
> >
> > I've zapped that hunk. I'd like to avoid exposing those kflags to
> > luserspace in any shape or form for now.
> 
> Sure. It was useful while I was debugging. But I'm sure all the bugs are
> gone now :-)

Do you need it for debugging?

If yes, it should be really clear that it is a debugging print and
nothing should rely on it. We could do a cmdline-param controllable
debugging scheme which tools cannot mistakenly start using and it
becomes an ABI, all of a sudden.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
