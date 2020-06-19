Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AE8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E3D208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="rYRKZmmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732776AbgFSNog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:44:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54236 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731806AbgFSNog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:44:36 -0400
Received: from zn.tnic (p200300ec2f0bac004d57d24caa4a0e33.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ac00:4d57:d24c:aa4a:e33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C47BB1EC03D0;
        Fri, 19 Jun 2020 15:44:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592574274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Jw9EeswGVAhRId5Z/cmoaOU/4YK2HM29pcIB4hBn/pg=;
        b=rYRKZmmpr9nuGcCzk+JgYOV0qgBhlUx5hgV+Cd3zH36cFiUm2unC+WhzcRnIpUJYkdJDvI
        7rieju2IeWv5m3RIBAndZQvzy9eNwYM4sn4VlHQkd5fISffZAqOIRKuQFfVQnv8u3lIhPa
        fLhN0aHPID/6C/9VlrgjBJhn8Apz2Zc=
Date:   Fri, 19 Jun 2020 15:44:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Richard Hughes <hughsient@gmail.com>
Cc:     Daniel Gutson <daniel@eclypsium.com>,
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
Message-ID: <20200619134432.GE32683@zn.tnic>
References: <20200618210215.23602-1-daniel.gutson@eclypsium.com>
 <589c89ae-620e-36f8-2be5-4afc727c2911@intel.com>
 <CAFmMkTHNxSN_uWtm63TdkGxj44NXQQKEOmATXhjA=4DSCS92kQ@mail.gmail.com>
 <20200618220139.GH27951@zn.tnic>
 <CAFmMkTGMAu-huTnP1aeMb_W4NddbTD_b2jhbDVKBDrkwgB97wg@mail.gmail.com>
 <20200619074053.GA32683@zn.tnic>
 <CAFmMkTGV0ZR6C=EBGQAiz1vw1vrUXSLTnH5ZbBUvfhPLg_tF6g@mail.gmail.com>
 <20200619132243.GC32683@zn.tnic>
 <CAD2FfiEr0kRWp2ut_PVqVDEVZqwESUxv=fxM9wUgi3n=ZCzPcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD2FfiEr0kRWp2ut_PVqVDEVZqwESUxv=fxM9wUgi3n=ZCzPcQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 02:31:11PM +0100, Richard Hughes wrote:
> 1. that the CPU supports TME (->cpuid, already done)
> 2. that the platform has not disabled TME in some way

Yes, this is what I'm proposing with clearing the flag in /proc/cpuinfo.
The needed information is there:

1. TME in CPUID
2. TME *not* in /proc/cpuinfo

which means the platform doesn't support it.

If we are going to export a list of features which the OS
kernel/platform has enabled - and this means a contract between kernel
and userspace - then this should not be a misc driver which gets loaded
as a module but builtin, maybe a proper sysfs layout similar to

/sys/devices/system/cpu/vulnerabilities

which userspace can use. Along with proper ABI definition, design,
documentation and all that belongs to a proper interface with userspace.
Because once userspace uses it, it is practically cast in stone.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
