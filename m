Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1037C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE7A720801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="kUCOgcNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgFLRDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:03:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57992 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgFLRDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 13:03:09 -0400
Received: from zn.tnic (p200300ec2f0af40048a70bbbe71adfd0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:f400:48a7:bbb:e71a:dfd0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 42D4E1EC0286;
        Fri, 12 Jun 2020 19:03:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591981388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wKDkjgF19/IiDKySgt9F5cncsG16y1YBxi2M6a3xPN0=;
        b=kUCOgcNLwxQG2N1XYoUn9cdLG8LbkKJPKu31XMOnWZ0oShF3qldTth6z7CdA++rWcW5+ev
        aEY0+Z42/gLRZ815rmrUQjJCpNS/0hxAJxlUScu9OO8EQugEj5jM0fkPPScnRgPOreTjzs
        5HQ9DqSEEyjlYJWsZx7BG6Vz7/2dngY=
Date:   Fri, 12 Jun 2020 19:03:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     x86-ml <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/msr: Filter MSR writes
Message-ID: <20200612170303.GD22660@zn.tnic>
References: <20200612105026.GA22660@zn.tnic>
 <20200612163406.GA1026@linux.intel.com>
 <20200612164602.GC22660@zn.tnic>
 <20200612165709.GB1026@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200612165709.GB1026@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 09:57:09AM -0700, Sean Christopherson wrote:
> DS_AREA takes a virtual (linear) address, i.e. the address can be legal from
> the CPUs perspective but still lead to a #PF due to the address not being
> mapped in the page tables.

It's not that - peterz and tglx - and I assume you meant that too - you
all want to taint on the very *attempt* to WRMSR, regardless of whether
the MSR exists or not.

I don't necessarily agree with that because I don't think we should
taint when the MSR doesn't exist but if you all want it, sure, whatever.
I don't care that deeply.

> So users don't have to unload and reload the module just to enable or
> disable writes.  I don't think it changes the protections in any way, a
> priveleged user still needs to explicitly toggle the control.

There's /sys/module/msr/parameters/. A privileged user can do whatever.
A non-privileged should not disable that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
