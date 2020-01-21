Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB541C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 07:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B41921734
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 07:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ru9094CO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgAUH1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 02:27:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46184 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgAUH1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 02:27:52 -0500
Received: from zn.tnic (p200300EC2F0B040000195D609404E69E.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:400:19:5d60:9404:e69e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 140D21EC0BE5;
        Tue, 21 Jan 2020 08:27:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579591671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=t+PM6Oc2ij6AV8rno557RFMrsYc6NEDFWWH1fOYDxbk=;
        b=Ru9094COIS6H4cYm2k/CmhM15ylnm/0gD/xCVLwxlZbUQNA4tiTSZR/5UI11n1l5dfPYUO
        H8twfHgdCgxLOLH4LTGVbIm/9+q0tFG4GNUstyxOkkSJ1BYWG1ciYTcl/i6PZEdliImzIZ
        qVuQy/MPdKLz4tzLRK0K+vE0BBKnYV0=
Date:   Tue, 21 Jan 2020 08:27:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Qian Cai <cai@lca.pw>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, elver@google.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] x86/mm/pat: fix a data race in cpa_inc_4k_install
Message-ID: <20200121072744.GA7808@zn.tnic>
References: <20200121041200.2260-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121041200.2260-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 11:12:00PM -0500, Qian Cai wrote:
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 20823392f4f2..31e4a73ae70e 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -128,7 +128,7 @@ static inline void cpa_inc_2m_checked(void)
>  
>  static inline void cpa_inc_4k_install(void)
>  {
> -	cpa_4k_install++;
> +	WRITE_ONCE(cpa_4k_install, READ_ONCE(cpa_4k_install) + 1);
>  }
>  
>  static inline void cpa_inc_lp_sameprot(int level)
> -- 

Fix a data race, says your subject?

If it had to be honest, it probably should say "Make the code ugly
because the next tool can't handle it".

Frankly, I'm not a fan of all this "change the kernel to fix the tool"
attitude.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
