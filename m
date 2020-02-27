Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C473C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CF720801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="pbwifbyn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbgB0SBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:01:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41542 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbgB0SBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:01:09 -0500
Received: from zn.tnic (p200300EC2F0E0F005C616343C404DD6B.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:f00:5c61:6343:c404:dd6b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B7B81EC0CDD;
        Thu, 27 Feb 2020 19:01:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582826468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=C0ocNCl0BvV6Iv70Wd4elUhmzpKLGyoPGx9MZ3ic7rg=;
        b=pbwifbynEjeq04eVHBEaQ4ua8gvBNpa63SFtiJ/8A3bnWuAHapUaa7ybToyYZpCyj/PfVV
        V922BdHVBoL7turZyP2MYEsidOwC6HsgsX/VHR7cjQgTMDGgbbIOYmiqRMV+4MX6ncj4Ge
        hsGCGATkLHBl76oj69SLwmpEgogzoTw=
Date:   Thu, 27 Feb 2020 19:01:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/pkeys: Manually set X86_FEATURE_OSPKE to preserve
 existing changes
Message-ID: <20200227180100.GB18629@zn.tnic>
References: <20200226231615.13664-1-sean.j.christopherson@intel.com>
 <a492b4f4-4a54-5e5a-b79f-e21f9038f259@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a492b4f4-4a54-5e5a-b79f-e21f9038f259@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 04:16:13PM -0800, Jacob Keller wrote:
> I tested this and it resolves my report! Thanks for a timely fix.

Adding your Tested-by.

> I agree with the analysis. Perhaps it would make sense in the long term
> to find a solution where get_cpu_cap can remember what was cleared for
> each CPU and restore those? It already does this using the global
> variables...

get_cpu_cap() remembers if you use setup_force_cpu_cap() but I agree
that that whole feature bit handling is a bit, hm, "strange". It had its
raisins.

FWIW, we had started cleaning those up but then the security nightmares
happened so on the backburner it went...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
