Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E72C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B83205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Zv00U6h9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgCLOtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:49:21 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37140 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbgCLOtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:49:20 -0400
Received: from zn.tnic (p200300EC2F0DBF0041CBC9F757D3F2F8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:bf00:41cb:c9f7:57d3:f2f8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 615171EC0CB8;
        Thu, 12 Mar 2020 15:49:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584024558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mBHoZL5njnwvI/eO0xcZnPNgJOJeyF1z9HV0KTmorIA=;
        b=Zv00U6h9WsbrsPqWRyn1OwR5ShWoAnRfcGRtafOow3qt5JhRm99BRvNVVkAxu2p9BuoBmo
        4ZcAlrp5t+o2H84NsH1HzCnFG6faYBXKpY5AOeA1yv78m1dw+qsH+jRnJjqk/6qVRmEhNy
        wpr5K0A/TGVjHakyu1TGbK9vw1yI2Xo=
Date:   Thu, 12 Mar 2020 15:49:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] x86/purgatory: Make sure we fail the build if
 purgatory.ro has missing symbols
Message-ID: <20200312144922.GG15619@zn.tnic>
References: <20200311214601.18141-1-hdegoede@redhat.com>
 <20200311214601.18141-3-hdegoede@redhat.com>
 <20200312001006.GA170175@rani.riverdale.lan>
 <3d58e77d-41e5-7927-fe84-4c058015e469@redhat.com>
 <20200312114225.GB15619@zn.tnic>
 <899f366e-385d-bafa-9051-4e93dc9ba321@redhat.com>
 <20200312125032.GC15619@zn.tnic>
 <8af51d90-27fa-6d2a-2159-ef0a9089453a@redhat.com>
 <20200312142553.GF15619@zn.tnic>
 <94c6f903-7dca-503e-aca7-1ee4641bcdac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94c6f903-7dca-503e-aca7-1ee4641bcdac@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 03:38:22PM +0100, Hans de Goede wrote:
> So I've send out 2 versions, not 5 not 10, but only 2 versions in
> the past 2 days and you start complaining about me rushing this and
> not fixing it properly, to me that does not come across positive.

Maybe there's a misunderstanding: when you send a patchset which is not
marked RFC, I read this, as, this patchset is ready for application. But
then the 0day bot catches build errors which means, not ready yet.

And I believe you expected for the 0day bot to test the patches first
and they should then to be considered for application. Yes, no?

That's why I suggested you to do randconfig builds yourself and not
depend on the 0day bot as it is known to be unreliable.

So I didn't do anything to make you feel negative - definitely not
intentionally.

> More specifically my intentions / motives on this were well intended
> and I too believe in fixing things the proper way. Your reply suggested
> that I just want to rush this through, which calls my motives into
> question, for which in my mind there was no reason.
> 
> If you complain about 2 versions in 2 days, or 5 versions over 5 months
> then that feels exaggerated and it certainly does not give me a feeling
> that the effort which I'm putting into this is being appreciated.

I believe I already explained what my problem with that is. If you don't
see it, then let's agree to disagree.

> Anyways we have a plan how to move forward with this now, so lets
> focus on that.

Yes, let's do that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
