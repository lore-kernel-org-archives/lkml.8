Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C752C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E851206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgBGK7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 05:59:40 -0500
Received: from smtprelay0087.hostedemail.com ([216.40.44.87]:57265 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726798AbgBGK7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 05:59:40 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 49042182CF666;
        Fri,  7 Feb 2020 10:59:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: unit22_19eb947281c49
X-Filterd-Recvd-Size: 1521
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri,  7 Feb 2020 10:59:38 +0000 (UTC)
Message-ID: <fdcfd8548707e2d6c61fc9739bc91c6720673c81.camel@perches.com>
Subject: Re: [PATCH 2/2] riscv: adjust the indent
From:   Joe Perches <joe@perches.com>
To:     Zong Li <zong.li@sifive.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 07 Feb 2020 02:58:25 -0800
In-Reply-To: <20200207095245.21955-3-zong.li@sifive.com>
References: <20200207095245.21955-1-zong.li@sifive.com>
         <20200207095245.21955-3-zong.li@sifive.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-07 at 17:52 +0800, Zong Li wrote:
> Adjust the indent to match Linux coding style.

trivia:

> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
[]
> @@ -86,7 +89,8 @@ void __init kasan_init(void)
>  	unsigned long i;
>  
>  	kasan_populate_early_shadow((void *)KASAN_SHADOW_START,
> -			(void *)kasan_mem_to_shadow((void *)VMALLOC_END));
> +				    (void *)kasan_mem_to_shadow((void *)
> +								VMALLOC_END));

could also remove an unnecessary (void *) as kasan_mem_to_shadow
returns a void *

	kasan_populate_early_shadow((void *)KASAN_SHADOW_START,
				    kasan_mem_to_shadow((void *)VMALLOC_END));

