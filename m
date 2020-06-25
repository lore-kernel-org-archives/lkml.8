Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E782C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BBAF207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="IZu192iR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390739AbgFYIh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 04:37:58 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56392 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390671AbgFYIh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 04:37:57 -0400
Received: from zn.tnic (p200300ec2f0ed10059a0945b2d1dc694.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d100:59a0:945b:2d1d:c694])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9AE121EC0114;
        Thu, 25 Jun 2020 10:37:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1593074275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TEbs56PTtDFwpUeGGKiJlmA6ajGefiuq179NAJxJodY=;
        b=IZu192iRvVGE133R9mgXxZEOXTLDyHlAleLGkmXatnUZM7vj6N9HLylA51XVfSfELa3rrq
        VmXYPagqrqvYv0oABzImhAox1E8fpFFufkyjKWF59mMaLiMKs3DHQzKySFq4UIi9k6JACe
        EI131r7aGsiJ0JwhwV2niHimBohBdxQ=
Date:   Thu, 25 Jun 2020 10:37:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     x86-ml <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH -v2.1] x86/msr: Filter MSR writes
Message-ID: <20200625083746.GA20319@zn.tnic>
References: <20200612105026.GA22660@zn.tnic>
 <20200613154844.GB584@zn.tnic>
 <20200615063837.GA14668@zn.tnic>
 <20200625055140.GA2141@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200625055140.GA2141@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 10:51:40PM -0700, Sean Christopherson wrote:
> Maybe s/unrecognized/unauthorized?  Unrecognized implies the kernel doesn't
> know anything about the MSR being written, which may not hold true.

"unrecognized" in the sense that it is not on the whitelist above. It
contains only one MSR and when the patches for the interface to that MSR
get upstreamed, it won't be needed anymore.

But this all is WIP anyway so we'll adjust that printk when we know
whether we wanna have a whitelist at all...

> Random leftover whitespace change.

That's spreading out the statements for better readability. That file
could use more spreading out too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
