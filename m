Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CACC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A64120656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595934384;
	bh=ZpJaIXXypUwV39fADwnwKnSp2pdQavNaAYxk3SHOptk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DfxElfvUAOeIuTzrZqwEKC4caH3HBxCzYEGDjzfmfylQI4gkebm9NDcc0tGQldzvb
	 9AzqeZZ6Imy0OJW7fratlM9jSSRlsUjXxltZN0PVncD+NCTACwjqpfRKTCTss2++Ak
	 blZxhTMB1Q5f9mH56jHKl3m/dWtl3kMHtjjALbl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgG1LGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbgG1LGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:06:22 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35651C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:06:21 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id qc22so5416674ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4UWmPJ7i4JMhfQOK58HSHVwtoQUyHyUz1mTTDeERchM=;
        b=GkRUGk99cojqJncqSrhZfg76aajwwQyVE2Q4OkBBiFKEtr0/ah5Y3DnaHimWC2tavL
         3XOZxLZ3Zva8/pEZSZAqOJkfLgBGsG7i5DZjHk/bvbMoblF2mmukNhQjNk8Cvi9nfhHp
         FZdLCE5b+J7rESs9diGuAgMBouB7WpPWS5Uu2kh8Duxs8bbnfD37yhvw0pvq5F3z8q2S
         B/FWjP7O4PNdMzceRftDZCdNzKldU8K8doGRAND3KNnLG9GdtFGoTb9DdsbHxq4U9DgN
         TJBZoCRmmY/5mXBfDxIpw9BAR/7+aITJW97fLVYU3r9NKl98advI9X9LeHCKuZoVMkGJ
         LopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4UWmPJ7i4JMhfQOK58HSHVwtoQUyHyUz1mTTDeERchM=;
        b=jQL1/CANhxOhR28wFuIkMLgGiuvGtROsOjTj7glNe4POGgbMyw6ani5EoDSLYe1iB0
         YyiwbZUAQ3N3+cDWUpQZQ81quA2esYxouvsxEj3HmsUobaXbldCSPhgnySrOANq4PBKk
         n8TWbzZw26OmXAFDKB6M/x0ibJ0x1oNv9FgNaZlMmdz8yLIfwv75Zj+VpxtZ19qNf6Eh
         msFKxSTIy1L2OHRIrSHH/hCICXyX4iQYc16Y8Ea8qcWuHh89BlZ+x3+3Cn3JbE7Spae3
         ZgHJBtpTL1AN2v8m3+PELhuamM0Js8Ule2mwZK57GEZ90DUEBJMpxUbDU89nsHCK8EJa
         BotA==
X-Gm-Message-State: AOAM530DWvoNjN7lNVDVp8WWQiNFUY6/h6tyjPjixpvsHU0cXoyAHMxb
        /LLoHXC+qfph6BcnUrjtK60tkOOZ
X-Google-Smtp-Source: ABdhPJyNixEz8FPdm8f1dzu+EKT/NoIJrj7HvEnhEEWJmzLyciJjvIfcrT9Rthv94FuAj3WBOmgyhA==
X-Received: by 2002:a17:906:c0da:: with SMTP id bn26mr17002790ejb.359.1595934379952;
        Tue, 28 Jul 2020 04:06:19 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id bs18sm9565558edb.38.2020.07.28.04.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 04:06:19 -0700 (PDT)
Date:   Tue, 28 Jul 2020 13:06:17 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] x86/kaslr: Cleanup and small bugfixes
Message-ID: <20200728110617.GF222284@gmail.com>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
 <20200727230801.3468620-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arvind Sankar <nivedita@alum.mit.edu> wrote:

> The first 7 patches are cleanup and minor bugfixes on the x86 KASLR
> code.
> 
> The last one is a bit of an RFC. The memory regions used for KASLR are
> stored as 64-bit even on a 32-bit kernel. However there are still a few
> local variables that are 32-bit, but should be ok as far as I can see
> because they are assigned values that have been already limited to
> 32-bit. It does make it a little harder to verify that the code is
> correct. Since KASLR cannot actually use 64-bit regions for the 32-bit
> kernel, the patch reduces regions to their below-4G segment when
> creating them, making the actual variables 32-bit. Alternatively, the
> few local variables could be upgraded to 64-bit.
> 
> v1->v2:
> - Fix a bug in the bugfix 5/8: overlap.start can be smaller than
>   region.start, so shouldn't subtract before comparing.
> 
> Arvind Sankar (8):
>   x86/kaslr: Make command line handling safer
>   x86/kaslr: Remove bogus warning and unnecessary goto
>   x86/kaslr: Fix process_efi_entries comment
>   x86/kaslr: Initialize mem_limit to the real maximum address
>   x86/kaslr: Simplify __process_mem_region
>   x86/kaslr: Simplify process_gb_huge_pages
>   x86/kaslr: Clean up slot handling
>   x86/kaslr: Don't use 64-bit mem_vector for 32-bit kernel
> 
>  arch/x86/boot/compressed/acpi.c  |   7 +-
>  arch/x86/boot/compressed/kaslr.c | 228 ++++++++++++-------------------
>  arch/x86/boot/compressed/misc.h  |  19 ++-
>  3 files changed, 111 insertions(+), 143 deletions(-)

I've applied patches 1-4 to x86/kaslr and will push them out if they 
pass testing - see the review feedback for the others.

Thanks,

	Ingo
