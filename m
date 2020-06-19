Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509A1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F79D2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="o/ZeO8Fm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394536AbgFSQSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:18:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50584 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394530AbgFSQRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:17:55 -0400
Received: from zn.tnic (p200300ec2f0bac00b008f297983004b5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ac00:b008:f297:9830:4b5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7BDF11EC02AC;
        Fri, 19 Jun 2020 18:17:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592583474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oPWzOPUAYvnkXbuBTGUDVQqq6X+OUqRfxYb0CIRI0L4=;
        b=o/ZeO8Fmj8Yun6hHjkFtMOFkTbv0PhORp021YwzZrPDwbx/rtT9D5+vrRZxb7hl3WVZz8U
        EMLWfNuBilB1c4WHqva+tTL1wIBZQHdE1skOQfgOOKYhXlJ+VLRZgO/9e0Eea64WNwMIse
        X7JBIxA1hNCG7NnHPUjapyeKNh//vZk=
Date:   Fri, 19 Jun 2020 18:17:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Richard Hughes <hughsient@gmail.com>,
        Daniel Gutson <daniel@eclypsium.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
Message-ID: <20200619161752.GG32683@zn.tnic>
References: <CAD2FfiFRqwYGB50KK=aA0sU6uCALYneoyD=V4EfOsk-Ex=C+xg@mail.gmail.com>
 <0DD7FAE4-3976-4835-8090-80B84B737F3E@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0DD7FAE4-3976-4835-8090-80B84B737F3E@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 08:48:47AM -0700, Andy Lutomirski wrote:
> Boris, it wouldn’t be totally crazy for cpuinfo to learn to
> distinguish between “your platform has this feature but Linux
> isn’t using it” and “your platform doesn’t have this feature
> in the first place”. And I suppose there’s this extra silly state
> “your platform has this feature, but your firmware didn’t enable
> it”. This would be a big job.

Well, I believe all the kernel can do is supply bits of information -
just like MSRs - and depending on the settings of those bits, userspace
can decide what the situation is. For example:

bit 0 - CPUID support
bit 1 - BIOS enabled
bit 2 - quirk applied
bit 3 - microcode fixes present
...

and so on.

It needs a proper definition though and userspace to say, yes, we want
that and that is useful for us.

Where it ends up is then beside the point - /proc/cpuinfo,
/sys/devices/system/cpu, whatever...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
