Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CBCC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C580321532
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="c4LgjOWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394327AbgFSQKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:10:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49348 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391808AbgFSQKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:10:37 -0400
Received: from zn.tnic (p200300ec2f0bac00b008f297983004b5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ac00:b008:f297:9830:4b5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D29B71EC0405;
        Fri, 19 Jun 2020 18:10:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592583035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LOyocwucmjef57Km3oWDbSg9YpNpQlJio5fMhK7ei08=;
        b=c4LgjOWkGKcIXpUvJgVkTlI0z53UiGT4J8eo+CcuPlnJ42TQkGIkiHtszUXWGbIYY01g6W
        XZ1j/IRK4DEWcQv/2zonDNzqs5hpqH0Y+AtT9/RW8yLcGuC2XKhuGmGOYU3BXPyawc+QOm
        Df9S1Pq4s5hw5bZVisGC3ag2b6sii8o=
Date:   Fri, 19 Jun 2020 18:10:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Richard Hughes <hughsient@gmail.com>
Cc:     Daniel Gutson <daniel@eclypsium.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
Message-ID: <20200619161026.GF32683@zn.tnic>
References: <589c89ae-620e-36f8-2be5-4afc727c2911@intel.com>
 <CAFmMkTHNxSN_uWtm63TdkGxj44NXQQKEOmATXhjA=4DSCS92kQ@mail.gmail.com>
 <20200618220139.GH27951@zn.tnic>
 <CAFmMkTGMAu-huTnP1aeMb_W4NddbTD_b2jhbDVKBDrkwgB97wg@mail.gmail.com>
 <20200619074053.GA32683@zn.tnic>
 <CAFmMkTGV0ZR6C=EBGQAiz1vw1vrUXSLTnH5ZbBUvfhPLg_tF6g@mail.gmail.com>
 <20200619132243.GC32683@zn.tnic>
 <CAD2FfiEr0kRWp2ut_PVqVDEVZqwESUxv=fxM9wUgi3n=ZCzPcQ@mail.gmail.com>
 <20200619134432.GE32683@zn.tnic>
 <CAD2FfiFRqwYGB50KK=aA0sU6uCALYneoyD=V4EfOsk-Ex=C+xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD2FfiFRqwYGB50KK=aA0sU6uCALYneoyD=V4EfOsk-Ex=C+xg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 02:50:39PM +0100, Richard Hughes wrote:
> No, it's not a boolean at all.

So before you do any kernel modules, you have to sit down and precisely
define what you want do to:

- do you want to initialize different stuff in your application based on
platform support?

- do you want to tell the user something so that the user can act
accordingly?

- do you just want to display feature support?

- ...

All this needs to be properly written down and discussed first, and then
we can think of the best way for the kernel to provide it, if there is
even any kind of info the kernel can provide reliably.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
