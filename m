Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC12C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B7A121741
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LQ1D4gtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbgIHR0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731808AbgIHR0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:26:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F8BC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 10:25:59 -0700 (PDT)
Received: from zn.tnic (p200300ec2f10bf0070b09dfd4356f225.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:bf00:70b0:9dfd:4356:f225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 776091EC0489;
        Tue,  8 Sep 2020 19:25:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599585958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CDPHzVOtjsYxVqMtTeVl7g411FkW4WHmSDs5Qd5T+KA=;
        b=LQ1D4gtne1y2gBQFmGW6p4rvLKM9mrwANcc1dl80u88eOSkzSRibQ2cxgLLhczSnW5Bv7S
        cb0LPDvm17Rxy3NfnVG4RGBiXJHkxgtCY02oh/AWtD79iroosjS0DT9gMSP9hoZsh0mBKR
        tir9k29H8eWXFBKswCucewg91YfKiwU=
Date:   Tue, 8 Sep 2020 19:25:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
Message-ID: <20200908172558.GG25236@zn.tnic>
References: <20200907094843.1949-1-Jason@zx2c4.com>
 <20200907100647.GB10657@zn.tnic>
 <22617e57e541e460fac09db04fdb370f8e96e8ef.camel@linux.intel.com>
 <CAHmME9rh8N-Qui2KVxGP33Aar5tao_obA70XKwR2x5Qp1AytTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9rh8N-Qui2KVxGP33Aar5tao_obA70XKwR2x5Qp1AytTw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 07:12:44PM +0200, Jason A. Donenfeld wrote:
> > Overclocking is not architectural I/F and is supported by some special
> > CPU skews. I can't find any public document to specify the commands
> > which can be used via this OC mailbox. I have to check internally to
> > see if there is any. To add a proper sysfs interface we have to make
> > sure that we are not allowing some random commands to hardware and
> > crash the system.
> 
> Well you can definitely crash the system this way -- undervolting can
> result in all sorts of nice glitching. You might be able to even
> programmatically undervolt to compromise the kernel in clever ways (a
> lockdown bypass, I guess, but who cares).
> 
> That's why I initially suggested this was pretty squarely in the realm
> of hobbyists and should just be added to that whitelist.

If that MSR can cause all kinds of crazy, I'd prefer writes to it from
userspace to be completely forbidden, actually. And if force-enabled,
with a BIG FAT WARNING each time userspace writes to it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
