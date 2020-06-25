Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C53C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D84F2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="UjFVtjOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406470AbgFYV1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:27:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56876 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403774AbgFYV1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:27:42 -0400
Received: from zn.tnic (p200300ec2f0ed1000d60c73cccfe0752.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d100:d60:c73c:ccfe:752])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 82CE91EC0422;
        Thu, 25 Jun 2020 23:27:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1593120461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OEQ8LAKMJpX2G9JI7xBon4UAPZWXmQZyvBikkcSaurk=;
        b=UjFVtjOm+Znu+lPGCj4HPfd58w3f9KBlsDVg4mSKdSjoReBtoMDNSVhXlNM6WTnpujRS6F
        DnIDDAocPMC0Pn9Sp5NB6DzFSUFdlT0MrdU67IGDYdmqYn4pZei5qRC2pxdmqlX1YjLxDT
        VYjwcjHDy1nDW2pEBla9DQmPLOeZ/XM=
Date:   Thu, 25 Jun 2020 23:27:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH] Ability to read the MKTME status from userspace (patch
 v2)
Message-ID: <20200625212736.GT20319@zn.tnic>
References: <20200625211029.34733-1-daniel.gutson@eclypsium.com>
 <20200625211453.GS20319@zn.tnic>
 <CAFmMkTGy5vOiPUpWw6HfQv-JM90JqLBcsKwMpbWdsjaLBw730Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFmMkTGy5vOiPUpWw6HfQv-JM90JqLBcsKwMpbWdsjaLBw730Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 06:16:12PM -0300, Daniel Gutson wrote:
> What didn't become clear from the thread last time is the direction to
> proceed. Concrete suggestion?

Here are two:

https://lkml.kernel.org/r/20200619161752.GG32683@zn.tnic
https://lkml.kernel.org/r/20200619161026.GF32683@zn.tnic

but before that happens, I'd like to hear Dave confirm that when we
expose all that information to userspace, it will actually be true and
show the necessary bits which *actually* tell you that encryption is
enabled.

If you're still unclear, go over the thread again pls.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
