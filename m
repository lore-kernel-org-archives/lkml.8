Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BC4C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E6920738
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="YDxIuM6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731907AbgIHRhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731835AbgIHRg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:36:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8128EC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 10:36:58 -0700 (PDT)
Received: from zn.tnic (p200300ec2f10bf0070b09dfd4356f225.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:bf00:70b0:9dfd:4356:f225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DFA881EC0489;
        Tue,  8 Sep 2020 19:36:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599586617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Vrj3035BsDcdrz0VpAXQtCkSg5zN1Pm7pcoGPlszHkk=;
        b=YDxIuM6lZ+gB0DKwdbm9IwN7GvlMIKA5A3+upt1bsXJzCzj74ffgVcZNn11kQwlT8julbg
        QvO7lMl2HokGbuwr5v1b7J0/Fk0Yh/bBUCl8QWO444YR7wRPRVXVSAGzYYCodTiyjEbvYl
        JULC6n0O2JfAFH53ngqQrD2NJCme2iY=
Date:   Tue, 8 Sep 2020 19:36:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
Message-ID: <20200908173656.GI25236@zn.tnic>
References: <20200907094843.1949-1-Jason@zx2c4.com>
 <20200907100647.GB10657@zn.tnic>
 <22617e57e541e460fac09db04fdb370f8e96e8ef.camel@linux.intel.com>
 <CAHmME9rh8N-Qui2KVxGP33Aar5tao_obA70XKwR2x5Qp1AytTw@mail.gmail.com>
 <20200908172558.GG25236@zn.tnic>
 <CAHmME9pKfvPGf97BM1=VdUL1uU_8aOoc4+QOu6b51XnPz3SkRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9pKfvPGf97BM1=VdUL1uU_8aOoc4+QOu6b51XnPz3SkRA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 07:29:11PM +0200, Jason A. Donenfeld wrote:
> Well that's not cool.

So you're saying that if someone wants to kill its box by poking at that
MSR, we should just let her/him?

If anything, I think that a BIG FAT WARNING at least would make sense.

Now, if there were a proper interface which would allow only valid
commands, now that would be optimal...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
