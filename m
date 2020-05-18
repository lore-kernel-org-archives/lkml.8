Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE57C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C56A20674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ovxJaWVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgERQzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERQzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:55:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A6CC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:55:02 -0700 (PDT)
Received: from zn.tnic (p200300ec2f06e800e15d4bec2df949c0.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:e800:e15d:4bec:2df9:49c0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 348E51EC011B;
        Mon, 18 May 2020 18:55:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589820900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=k6LpZAryra3EY4vS9Y/qTS00GPq5TvZ4jvfHqH6pFlI=;
        b=ovxJaWVGjvXi6IWjpLFbNp73b8mFBz6lcbwj6YUbkNFmL46ov9WTvbWTti+KuNIpk1mBXG
        nwz/NU7Stp1vYs84bXvV/hUeksh/4QpiDZLDH4taZs6CDgnUSOno22XuRXoZtYGdWqiPA/
        Jdwy9Sgmngk+C63mxG0mFVeqOx+4afc=
Date:   Mon, 18 May 2020 18:55:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Jue Wang <juew@google.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mm: Don't try to change poison pages to uncacheable
 in a guest
Message-ID: <20200518165500.GD25034@zn.tnic>
References: <20200516150229.GB19372@zn.tnic>
 <8022D1E6-A8BC-4610-9F58-67A06B9A9575@intel.com>
 <CAPcxDJ50pbuTbittyvPwKq1uUT8q8jJ+dHH8rCug8a1DDZXVYw@mail.gmail.com>
 <CAPcxDJ6f3pBpwiR9nvXN_g_HBa1RAMG+aOmgfXLFT6aZ9HQn3w@mail.gmail.com>
 <20200518134813.GC25034@zn.tnic>
 <20200518153625.GA31444@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200518153625.GA31444@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 08:36:25AM -0700, Luck, Tony wrote:
> The VMM gets the page fault (because the unmapping of the guest
> physical address is at the VMM EPT level).  The VMM can't map a new
> page into that guest physical address because it has no way to
> replace the contents of the old page.  The VMM could pass the #PF
> to the guest, but that would just confuse the guest (its page tables
> all say that the page is still valid). In this particular case the
> page is part of the 1:1 kernel map. So the kernel will OOPS (I think).

...

> PLease explain how a guest (that doesn't even know that it is a guest)
> is going to figure out that the EPT tables (that it has no way to access)
> have marked this page invalid in guest physical address space.

So somewhere BUS_MCEERR_AR was mentioned. So I'm assuming the error
severity was "action required". What does happen in the kernel, on
baremetal, with an AR error in kernel space, i.e., kernel memory?

If we can't fixup the exception, we die.

So why should the guest behave any differently?

Now, if you want for the guest to be more "robust" and handle that
thing, fine. But then you'd need an explicit way to tell the guest
kernel: "you've just had an MCE and I unmapped the page" so that the
guest kernel can figure out what do to. Even if it means, to panic.

I.e., signal in an explicit way that EPT violation Jue is talking about
in the other mail.

You can inject a #PF or better yet the *first* MCE which is being
injected should say with a bit somehwere "I unmapped the address in
m->addr". So that the guest kernel can handle that properly and know
what *exactly* it is getting an MCE for.

What I don't like is the "am I running as a guest" check. Because
someone else would come later and say, err, I'm not virtualizing this
portion of MCA either, lemme add another "am I guest" check.

Sure, it is a lot easier but when stuff like that starts spreading
around in the MCE code, then we can just as well disable MCE when
virtualized altogether. It would be a lot easier for everybody.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
