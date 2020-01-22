Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43372C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1520D24685
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ii89gOTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgAVNKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:10:40 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52188 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgAVNKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:10:40 -0500
Received: from zn.tnic (p200300EC2F0CAE008532B502E47E7E30.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:ae00:8532:b502:e47e:7e30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 34CDA1EC0C8A;
        Wed, 22 Jan 2020 14:10:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579698639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cn9PMfKYi+SF3FfyBIoKBZ3cZ9tYxQfF+ZOukqCDKe4=;
        b=ii89gOTn+eiw/SyXCGW56vw0wS56hAGjdLhyH0AFgURrs64zEHD4AUmbj5/eC0S0KXJMtn
        pKpWtz2IEWsNfG7Kqm2KRUmeCxIU87EbiJpinFWLnKvToUrrY/YFDKeaZfo0XNBI1tTz1C
        9PB597XnNhTvGryRbh5053idiaY2YmE=
Date:   Wed, 22 Jan 2020 14:10:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     mateusznosek0@gmail.com
Cc:     linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Subject: Re: [PATCH] arch/x86/mm/mpx.c: Clean up code by removing unnecessary
 assignment
Message-ID: <20200122131037.GB20584@zn.tnic>
References: <20200119130933.12228-1-mateusznosek0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200119130933.12228-1-mateusznosek0@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2020 at 02:09:33PM +0100, mateusznosek0@gmail.com wrote:
> From: Mateusz Nosek <mateusznosek0@gmail.com>
> 
> Previously variable 'ret' is assigned just before return instruction.
> The variable is local so this assignment is useless
> and therefore can be removed.
> 
> Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
> ---
>  arch/x86/mm/mpx.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/mm/mpx.c b/arch/x86/mm/mpx.c
> index 895fb7a9294d..30ab444301f5 100644
> --- a/arch/x86/mm/mpx.c
> +++ b/arch/x86/mm/mpx.c
> @@ -827,10 +827,8 @@ static int try_unmap_single_bt(struct mm_struct *mm,
>  	/*
>  	 * No bounds table there, so nothing to unmap.
>  	 */
> -	if (ret == -ENOENT) {
> -		ret = 0;
> +	if (ret == -ENOENT)
>  		return 0;
> -	}
>  	if (ret)
>  		return ret;
>  	/*
> -- 

That code is going away so you can ignore it completely.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
