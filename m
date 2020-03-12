Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BB9C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6442071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZhCBOK2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgCLOZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:25:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33476 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbgCLOZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:25:50 -0400
Received: from zn.tnic (p200300EC2F0DBF0041CBC9F757D3F2F8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:bf00:41cb:c9f7:57d3:f2f8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 41FE31EC0273;
        Thu, 12 Mar 2020 15:25:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584023148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+tS8ojAFOCBQv6/DTX9OrTW5DWYkaLIc3oLYcrJwoD4=;
        b=ZhCBOK2CBD/GCBpSmUns5EqYzMJoB3mkYEb6Sx3K6VFiQb6pVOZLpi0ERuDYGQRapsRJwN
        +9B6FrrVfmd8ICewwRhhU81tO1HwizyhV3zrtvjE5Ifi1+daYh4tcezWXwfY3ODrMTCljL
        1dklxduA2Q4FrPj7nJ4s0GXvUph1x6k=
Date:   Thu, 12 Mar 2020 15:25:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] x86/purgatory: Make sure we fail the build if
 purgatory.ro has missing symbols
Message-ID: <20200312142553.GF15619@zn.tnic>
References: <20200311214601.18141-1-hdegoede@redhat.com>
 <20200311214601.18141-3-hdegoede@redhat.com>
 <20200312001006.GA170175@rani.riverdale.lan>
 <3d58e77d-41e5-7927-fe84-4c058015e469@redhat.com>
 <20200312114225.GB15619@zn.tnic>
 <899f366e-385d-bafa-9051-4e93dc9ba321@redhat.com>
 <20200312125032.GC15619@zn.tnic>
 <8af51d90-27fa-6d2a-2159-ef0a9089453a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8af51d90-27fa-6d2a-2159-ef0a9089453a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 02:34:30PM +0100, Hans de Goede wrote:
> Which is why I have been fixing the issues which the 0day bot finds,
> but then I get complaints about reving the patch set to quickly...

So here's what I'm seeing: patchsets get sent and 0day bot finds an
issue almost each time. Which tells me, this patchset doesn't look ready.

I suggested you to do "make randconfig" builds to find those breakages
yourself but if you prefer 0day bot to do that, that's fine too.

> In my experience once a patch-set has a maintainers attention,
> quickly fixing any issues found usually is the right approach.
> Because then usually it can get merged quickly and both the maintainer
> and I can move on to other stuff. I'm sorry if you are finding this
> annoying.

My experience shows that almost always there's an aspect where both the
submitter and the maintainer haven't thought about and hurrying stuff
makes it worse. That's why I prefer stuff to be hammered out and tested
properly and *then* applied.

> TBH I'm quite unhappy that I'm being "yelled" at now (or so it
> feels) while all I'm doing is trying to fix a long standing issue :(

What in my reply made you feel you're being "yelled" at?

> No not ok, I'm doing my best to help make things better here and
> in return I'm getting what feels as a bunch of negativity and that
> is NOT ok!

I have no clue what in my replies made you feel that. Please explain.
How should I have replied so that it doesn't come across negative?

> Now as how to move forward with this, I suggest that:
> 
> 1) We wait a bit to see if the 0daybot finds any more existing issues
> which are exposed by my patch
> 
> 2) Change my patch to check for missing symbols to use the approach
> which Arvind has suggested
> 
> 3) Check that "kexec -l <kernel>" + "kexec -e" still work
> 
> 4) Post v6.

5) Wait for 0day bot to chew on it too.

> Does that work for you ?

Yes, sounds ok.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
