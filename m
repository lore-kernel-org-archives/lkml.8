Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359E2C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 20:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29592467A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 20:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="a+xBrkWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgAMUqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 15:46:20 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49028 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgAMUqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 15:46:20 -0500
Received: from zn.tnic (p200300EC2F05D300358610FD1FF8C6B9.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:d300:3586:10fd:1ff8:c6b9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B09D1EC0C98;
        Mon, 13 Jan 2020 21:46:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578948378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dW6ZKQ6DQh5kTanDhU2IOHJ1t4Hr6XOG3diwIIiq8mo=;
        b=a+xBrkWd/Ok0phsODwK9yJv2tgak87EEbk8f2uKdTXwvSMQZV7I00LwmBBwV0ViWpfY6s5
        x6xrgiFDXpGp7jH9BYJY9G7zAvw/aVWyXoBHjnJ/PwoHibXXx1MtzPqx26L3SCdbhkv7mQ
        0e36SEMCBWjaOLrS8zJhiI+0sDhAI3Y=
Date:   Mon, 13 Jan 2020 21:46:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jari Ruusu <jari.ruusu@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: Fix built-in early-load Intel microcode alignment
Message-ID: <20200113204611.GS13310@zn.tnic>
References: <CACMCwJK-2DHZDA_F5Z3wsEUEKJSc3uOwwPD4HRoYGW7A+kA75w@mail.gmail.com>
 <20200113154739.GB11244@42.do-not-panic.com>
 <CACMCwJL8tu+GHPeRADR_12xhcYSiDv+Yxdy=yLqMxEsn=P9zFA@mail.gmail.com>
 <20200113200832.GR13310@zn.tnic>
 <CACMCwJLsj6D884Sxy82VbpKkip=ja2ymHKvQ78c=-ftx-zmV_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACMCwJLsj6D884Sxy82VbpKkip=ja2ymHKvQ78c=-ftx-zmV_Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 10:30:13PM +0200, Jari Ruusu wrote:
> On 1/13/20, Borislav Petkov <bp@alien8.de> wrote:
> > Btw, just out of curiosity: why are you using built-in microcode and not
> > the initrd method?
> 
> Initrd method is better when it is a kernel intended to be booted
> on many different computers. Built-in microcode method kernel is
> tuned for one computer only. It is less hassle that way.

Oh well, you only need to do an initrd which is not that big of a deal.

The built-in method requires you to rebuild the kernel when there's
new microcode but new microcode is a relatively seldom occurrence
in practice. The last two years putting my statistics completely
out-of-whack.

But they should be coming back to normal because there should simply
be no more room for microcode patches anymore in the most x86 CPUs out
there. :)

So if you're building kernels often, it doesn't really matter if you do
initrd or builtin microcode.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
