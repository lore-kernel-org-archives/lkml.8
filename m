Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD06C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C1320658
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="fJqbIq7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbgIHTb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731130AbgIHTae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 15:30:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E892C0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 12:30:32 -0700 (PDT)
Received: from zn.tnic (p200300ec2f10bf0059bdf9fa8e813382.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:bf00:59bd:f9fa:8e81:3382])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CCA7C1EC02B9;
        Tue,  8 Sep 2020 21:30:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599593429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4Z3SaY9hLpwpb++kP8jU/6wRFeEbV6IvS5RvGnja5vE=;
        b=fJqbIq7w2ddlu/9gyzcdM/lrAC98pbJDH8w43vlzuiRzeH8tDGn+iS/Wwhpuem/QKtktet
        Lcp4IKgOPSiwcOymgS4CF5fkP1iz3n8CG25n1wPaW36aRz1xDTSneNF/+bMJk5GTjWYxlB
        3+zMUho5DQXOn61YCkaVmRyYCemlHiQ=
Date:   Tue, 8 Sep 2020 21:30:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
Message-ID: <20200908193029.GM25236@zn.tnic>
References: <20200907094843.1949-1-Jason@zx2c4.com>
 <20200907100647.GB10657@zn.tnic>
 <22617e57e541e460fac09db04fdb370f8e96e8ef.camel@linux.intel.com>
 <CAHmME9rh8N-Qui2KVxGP33Aar5tao_obA70XKwR2x5Qp1AytTw@mail.gmail.com>
 <20200908172558.GG25236@zn.tnic>
 <CAHmME9pKfvPGf97BM1=VdUL1uU_8aOoc4+QOu6b51XnPz3SkRA@mail.gmail.com>
 <20200908173656.GI25236@zn.tnic>
 <CAHmME9pVO01mj8vgKPEX7a6pZDRSfX62e2Ow8R=L79hLSJoaMA@mail.gmail.com>
 <20200908180112.GK25236@zn.tnic>
 <20200908191838.GA2014@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908191838.GA2014@sultan-box.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 12:18:38PM -0700, Sultan Alsawaf wrote:
> I'd like to point out that on Intel's recent 14nm parts, undervolting
> is not so much for squeezing every last drop of performance out of the
> SoC as it is for necessity.

<snip interesting examples>

Sounds to me that this undervolting functionality should be part of
the kernel and happen automatically. I have no clue, though, whether
people who do it, just get lucky and undervolting doesn't cause any
other hardware issues, or there's a real reason for this power madness
and if not done, power-related failures happen only on some boxes so
they decided to do them on all.

Or maybe BIOS is nuts, which is not a stretch.

Srinivas, what's the story here?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
