Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090D7C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D3D2080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TZL7+S96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgIGRwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgIGLXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:23:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327CCC061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 04:23:49 -0700 (PDT)
Received: from zn.tnic (p200300ec2f09090030eade31917bbe1c.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:900:30ea:de31:917b:be1c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A2CEE1EC0445;
        Mon,  7 Sep 2020 13:23:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599477827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7aHUFz8z8HXZoDDtX/mcqXNHzz5ehkgh7/St8AwvguU=;
        b=TZL7+S96XjOnWVb/OXGGthMwo36VSGuzdd5iSOdBePEFfcyfV5tGM408XBo9f97SY8Ar/7
        J1UnoCVmOdZCYAHcS4NnrCS8M1oecVQyKk297e4Or1gpH8Rb1wldNUKT8q1kUTctzkJNK/
        N5o3T3GNn8w1YHMpulL7s6LTe90NKl8=
Date:   Mon, 7 Sep 2020 13:23:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kitsunyan <kitsunyan@airmail.cc>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
Message-ID: <20200907112346.GD16029@zn.tnic>
References: <20200907094843.1949-1-Jason@zx2c4.com>
 <20200907100647.GB10657@zn.tnic>
 <CAHmME9o_Odo97K7QXKO=konVE-UxR7iBCE5S8uAJgc=kJ2EgsA@mail.gmail.com>
 <20200907111109.GB16029@zn.tnic>
 <CAHmME9pR5Z+G5Z-+-11Hr2gO+SXY6oVoDF+p0Ox7V1oHNVsBvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9pR5Z+G5Z-+-11Hr2gO+SXY6oVoDF+p0Ox7V1oHNVsBvg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 01:15:14PM +0200, Jason A. Donenfeld wrote:
> Gotcha. So your perspective is that the goal is actually to have no
> list at all in the end, because all MSR writes should go through sysfs
> interfaces and such, always? I certainly like that goal -- it'd make a
> whole lot of CPU functionality a lot more discoverable and easier to
> tinker with. In practice, it seems like that's a hard goal to
> accomplish, with different MSRs having different semantics and
> meanings of different bit offsets, and a great deal of them aren't
> actually publicly documented by Intel. Were you hoping to just handle
> these piece by piece, and eventually Linux will have a decent
> compendium of MSRs? That sure would be nice.

Yes to all of the above.

The MSRs should not have been exposed to userspace in the first place.
See the commit message of:

  a7e1f67ed29f ("x86/msr: Filter MSR writes")

for why not.

> Is Intel on board with that plan?

They better be. Like the other vendors who have MSRs too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
