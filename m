Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A151C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51B2215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="FtqB4s91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCJQhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:37:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50720 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCJQhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:37:39 -0400
Received: from zn.tnic (p200300EC2F09B400F44F66F0FEFB445E.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:b400:f44f:66f0:fefb:445e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 737C71EC0CDF;
        Tue, 10 Mar 2020 17:37:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1583858257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6WsP7J52kSHVDsNtaPW0KbXpQ88k9vu03UTfCPSXnlY=;
        b=FtqB4s91xzciK1Uf1CxdIJS3/K5xtCbH77hWu11JcqrUUnB/e1VC2QUtv6qnVsDmJxonHq
        eOZzPTjIhx9TZCQjcc0ZRAzDlfoxt1orycRlfUI8MG3m1lwHn+nI0QXMeXivioKxwHtQZM
        qJESkKgoNV2OT9hlc2Jfs8iaEpG7XAM=
Date:   Tue, 10 Mar 2020 17:37:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Bruce Rogers <brogers@suse.com>
Subject: Re: [PATCH] x86/ioremap: Map EFI runtime services data as encrypted
 for SEV
Message-ID: <20200310163738.GF29372@zn.tnic>
References: <2d9e16eb5b53dc82665c95c6764b7407719df7a0.1582645327.git.thomas.lendacky@amd.com>
 <20200310124003.GE29372@zn.tnic>
 <20200310130321.GH7028@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200310130321.GH7028@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 02:03:21PM +0100, Joerg Roedel wrote:
> See the comment added in the patch, walk_mem_res() does not iterate over
> the resource which contains EFI_RUNTIME_SERVICES_DATA, so
> __ioremap_check_encrypted() will not be called on that resource.
> 
> walk_system_ram_range() might do the job, but calling it only for
> EFI_RUNTIME_SERVICES_DATA has some overhead.

Ok, then.

Let's wrap this in a new function which is called at the end of
__ioremap_check_mem() instead of trying to map EFI_RUNTIME_SERVICES_DATA
to IORES_DESC types and match the flags just so that we can preserve the
flow. And add a comment above it why we're doing this.

As you said on IRC, none of the IO resource ranges covers the
EFI_RUNTIME_SERVICES_DATA.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
