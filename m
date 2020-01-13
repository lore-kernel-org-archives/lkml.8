Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CCBC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 20:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76F72084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 20:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="j4l/1P+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgAMUIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 15:08:42 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42410 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgAMUIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 15:08:42 -0500
Received: from zn.tnic (p200300EC2F05D300358610FD1FF8C6B9.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:d300:3586:10fd:1ff8:c6b9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 16F461EC0985;
        Mon, 13 Jan 2020 21:08:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578946121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=e6V80P3R4PBa0Iyuh+qQodVmYqsFuqbMaC4SCgWU9fo=;
        b=j4l/1P+a1K1RlbiFNSsgZ9ksX0un/KYeGDublc5qCnRN93EtGIA2f0dBOEFvQNH8nvtIUH
        5HdqwTaWHKCwWfcv5Km7ystY3sCYcshjLWKYdiuoxU5TlNKKjD4WE2ndtHk5TSI0NYmPq5
        SknetiAZq3ZpB1y1k36mSsgeedKH/Fg=
Date:   Mon, 13 Jan 2020 21:08:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jari Ruusu <jari.ruusu@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: Fix built-in early-load Intel microcode alignment
Message-ID: <20200113200832.GR13310@zn.tnic>
References: <CACMCwJK-2DHZDA_F5Z3wsEUEKJSc3uOwwPD4HRoYGW7A+kA75w@mail.gmail.com>
 <20200113154739.GB11244@42.do-not-panic.com>
 <CACMCwJL8tu+GHPeRADR_12xhcYSiDv+Yxdy=yLqMxEsn=P9zFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACMCwJL8tu+GHPeRADR_12xhcYSiDv+Yxdy=yLqMxEsn=P9zFA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 09:58:25PM +0200, Jari Ruusu wrote:
> Before that 16-byte alignment patch was applied, my only one
> microcode built-in BLOB was "accidentally" 16-byte aligned.

Btw, just out of curiosity: why are you using built-in microcode and not
the initrd method?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
