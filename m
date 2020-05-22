Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676C1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A841206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="jUCEzp3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbgEVKry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 06:47:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57592 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728606AbgEVKrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 06:47:53 -0400
Received: from zn.tnic (p200300ec2f0d490039ac3da161697ee8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4900:39ac:3da1:6169:7ee8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9CD9D1EC02B2;
        Fri, 22 May 2020 12:47:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1590144472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=U2u6tNLsMLNzMWM2MweWWtY4enccp4IwxfFDf0b0Msg=;
        b=jUCEzp3EIp812A0pusJ1Kttz23vvdzsdB+s6lFbDcqIRxskgeyi2gA/CsMq4uww48EphyG
        r/JcL8XQqzzoKqSeX62e4zdGCT5lCFbGIAzj7ra0CInYhv5r1Xem8dcYC3HU5PyNeMaVsG
        XWViWOISpgHAntpgC4/RUTNXUNox/Zs=
Date:   Fri, 22 May 2020 12:47:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH -tip v3 03/11] kcsan: Support distinguishing volatile
 accesses
Message-ID: <20200522104747.GD28750@zn.tnic>
References: <20200521142047.169334-1-elver@google.com>
 <20200521142047.169334-4-elver@google.com>
 <20200522102630.GC28750@zn.tnic>
 <CANpmjNM=aHuTWFk45j8BwRFoTQxc-ovghjfwQr5m4K3kVP8r0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNM=aHuTWFk45j8BwRFoTQxc-ovghjfwQr5m4K3kVP8r0w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 12:34:00PM +0200, Marco Elver wrote:
> Yeah, my patch for GCC is still pending. But we probably need more
> fixes for GCC, before we can re-enable it.
>
> We restrict supported compilers later in the series:
> https://lore.kernel.org/lkml/20200521142047.169334-7-elver@google.com/

Yah, tglx just pointed me to it. I'll move 6/11 up in the series.

Just a tip for the future: the idea is to have the kernel build
successfully at each patch so that bisection doesn't break.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
