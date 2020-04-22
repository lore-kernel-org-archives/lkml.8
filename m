Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18086C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D06E12077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="QSaSRN8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgDVVr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDVVr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:47:57 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697ECC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:47:57 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0DC10034799E0EEF8349F9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c100:3479:9e0e:ef83:49f9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E71891EC0D40;
        Wed, 22 Apr 2020 23:47:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587592076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LhNefsMKhteFQFie49WXS2AmS61Op0pGlnLmbupfJJ8=;
        b=QSaSRN8rX7KkmL1wecb9nxvktZ+1ru2jjo8Pa+3uJgBgss1sqyzBW1M0BoRcRv+mdPkVKx
        BzheaUwQ2CXiMF5j0tchnAcj5rUZfcP4gNGZPsOp4ynVnrZAODzRvdCasLg+29JyrWmAo+
        +qbks4+kyrpGoQ7wUXr+GTrqsM/uanM=
Date:   Wed, 22 Apr 2020 23:47:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: AMD boot woe due to "x86/mm: Cleanup pgprot_4k_2_large() and
 pgprot_large_2_4k()"
Message-ID: <20200422214751.GJ26846@zn.tnic>
References: <1ED37D02-125F-4919-861A-371981581D9E@lca.pw>
 <20200422170116.GA28345@lst.de>
 <2568586B-B1F7-47F9-8B6F-6A4C0E5280A8@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2568586B-B1F7-47F9-8B6F-6A4C0E5280A8@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 05:32:00PM -0400, Qian Cai wrote:
> This fixed the sucker,
> 
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index edf9cea4871f..c54d1d0a8e3b 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -708,7 +708,7 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
>  
>         set_pte((pte_t *)pud, pfn_pte(
>                 (u64)addr >> PAGE_SHIFT,
> -               __pgprot(protval_4k_2_large(pgprot_val(prot) | _PAGE_PSE))));
> +               __pgprot(protval_4k_2_large(pgprot_val(prot)) | _PAGE_PSE)));
>  

Very good catch - that's one nasty wrongly placed closing bracket!
pmd_set_huge() has it correct.

Mind sending a proper patch?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
