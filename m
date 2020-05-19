Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A837C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475442075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="SGe/xqKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgESIuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 04:50:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53638 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgESIuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:50:08 -0400
Received: from zn.tnic (p200300ec2f0b87003113f65f16dcf690.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8700:3113:f65f:16dc:f690])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3BBF91EC0322;
        Tue, 19 May 2020 10:50:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589878206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oWIKO9w7nagklFwlUjYMwTNA1xKQLTH7xLOx4YNGajg=;
        b=SGe/xqKRhri0s0UPZ1njzxNOBUr9KwS3n4D2fz62AW+pRaBLrVorKHut6tHksk4BPElQLa
        nDQgAFkF+109vDQvKfjc/unu0WCR2aNYniHnyYVa9SEagrw3UD6D3pwUUsL4vNaJwpTpOc
        f7393S3ldwgtiurDUV4aTbQvQWGHkMQ=
Date:   Tue, 19 May 2020 10:50:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Jue Wang <juew@google.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mm: Don't try to change poison pages to uncacheable
 in a guest
Message-ID: <20200519085000.GA444@zn.tnic>
References: <20200516150229.GB19372@zn.tnic>
 <8022D1E6-A8BC-4610-9F58-67A06B9A9575@intel.com>
 <CAPcxDJ50pbuTbittyvPwKq1uUT8q8jJ+dHH8rCug8a1DDZXVYw@mail.gmail.com>
 <CAPcxDJ6f3pBpwiR9nvXN_g_HBa1RAMG+aOmgfXLFT6aZ9HQn3w@mail.gmail.com>
 <20200518134813.GC25034@zn.tnic>
 <20200518153625.GA31444@agluck-desk2.amr.corp.intel.com>
 <20200518165500.GD25034@zn.tnic>
 <20200518182629.GA2957@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200518182629.GA2957@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 11:26:29AM -0700, Luck, Tony wrote:
> That question only makes any sense if you know you are running as a
> guest and that someone else has unmapped the address. It's a meaningless
> question to ask if you are running bare metal. So we'd still have a check
> for FEATURE_HYPERVISOR

Maybe I'm not making myself clear enough here: I'm talking about using
a *special* MCE signature which says "your mapping has disappeared from
underneath you." Maybe a bit in MCi_MISC which the hw doesn't use. Or
some other deprecated bit, whatever.

If that signature is unique you won't have to check for hypervisor - you
*know* it comes from it.

Because the hypervisor would be telling the guest: "I have removed the
page from under you, you should act accordingly" with that signature. Vs
the kernel going with the unspecific "am I running as a guest"?

See the huge difference?

> Maybe it isn't pretty. But I don't see another practical solution.

See above. Below too. I actually got two.

> The VMM is doing exactly the right thing here. It should not trust
> that the guest will behave and not touch the poison location again.
> If/when the guest does touch the poison, the right action is
> for the VMM to fake a new machine check to the guest.

Yes, and that new machine check should tell the guest: "do not CLFLUSH
this address - I've unmapped it and you don't have to do anything."
Basically what your hypervisor check does but *actually* stating why it
raised the second MCE.

> Theoretlcally the VMM could decode the instruction that the guest
> was trying to use on the poison page and decide "oh, this is that
> weird case in Linux where it's just trying to CLFLUSH the page. I'll
> just step the return IP past the CLFLUSH and let the guest continue".

... or not inject the second MCE at all.

That would be fixing it in the HV.

Because there's this other way to look at it and come to think of it,
fixing this in the HV makes a lot more sense. Why?

Well, let me elaborate:

The hypervisor just removed that page under the guest's feet and if that
hypervisor wants to support unenlightened guests which cannot even deal
with pages disappearing from under their feet, then that hypervisor
better not inject that second MCE.

Why would it even inject the MCE - what can the guest even do about
it? Exactly *nothing*. The page is unmapped and gone, the guest cannot
salvage any information anymore from it.

And yes, the hypervisor has *all* the information, it knows which page
it just removed so if the guest tries to access memory which HV just
poisoned and is within the range which was covered by that page, then it
should *not* inject that MCE. The guest can't handle it and why would it
inject it - it is an access to a poisoned page which the HV *knows* it
won't succeed so why bother?

The HV simply returns without injecting the MCE and so on, until the
4K page's end. It simply ignores guest accesses to the poisoned page.
Without any guest changes.

> N.B. Linux wants to switch the page to uncacheable so that in the
> persistant memory case the filesytem code can continue to access
> the other "blocks" in the page, rather than lose all of them. That's
> futile in the case where the VMM took the whole 4K away. Maybe Dan
> needs to think about the guest case too.

Yes, if the 4K page just went away, marking it UC doesn't make any
sense.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
