Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7884C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 19:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852CC21741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 19:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="QePTF/xt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgBGTQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 14:16:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39000 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgBGTQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 14:16:32 -0500
Received: from zn.tnic (p200300EC2F0B4B00F45CB4F40F3B3948.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:4b00:f45c:b4f4:f3b:3948])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1859D1EC0CD0;
        Fri,  7 Feb 2020 20:16:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581102991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uZXHVIOjNJpxDHoRPGthW7gcWk9yRG3mr0wirROheH0=;
        b=QePTF/xtXKYS621h7AkLcBAdhQprM5Yivcp4XHU208eoHt1HyagAZVS3INTot/6WG9wNJq
        a8yZ/dn+0BDpUiNXwOQM0kSfY/VGctFCxprFplFbopdMIKegclmQDFND2rg9wrx6tJNSk6
        VIwF8oz/4OLuCQiFC+Xc/w/aQgpTwUI=
Date:   Fri, 7 Feb 2020 20:16:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: What should we do with match_option()?
Message-ID: <20200207191625.GG24074@zn.tnic>
References: <20200204222547.GA21277@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200204222547.GA21277@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 02:25:47PM -0800, Luck, Tony wrote:
> But this seems to be a belt, braces (USA=suspenders) and stapling the
> waistband of trousers (USA=pants) to your body approach.

Haha.

> If the user supplies a large enough buffer to cmdline_find_option()
> for any of the legal options Then the resulting "arg" will not be
> truncated for anything legal. So we should be able to just use
> "strcmp()" to see which of the options is matched.
> 
> So should we promote match_option() to <linux/string.h>? Or
> drop it and just use strcmp() instead?

Makes sense to me: cmdline_find_option() will make sure the string is
NULL-terminated if the buffer is smaller than the option so strcmp()
should not go off into the weeds. The worst that can happen, AFAICT,
is the option not matching but that should be picked up pretty soon in
testing. (I'm assuming we all test our code before sending :-))).

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
