Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C5FC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 07:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF50924655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 07:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAVHmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 02:42:21 -0500
Received: from [167.172.186.51] ([167.172.186.51]:37734 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725883AbgAVHmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 02:42:20 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id F263EDF340;
        Wed, 22 Jan 2020 07:42:27 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JD6AL0fXdQgw; Wed, 22 Jan 2020 07:42:27 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 593E1DFD93;
        Wed, 22 Jan 2020 07:42:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jJ2e1UJDIMu1; Wed, 22 Jan 2020 07:42:27 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id E5E38DF340;
        Wed, 22 Jan 2020 07:42:26 +0000 (UTC)
Date:   Wed, 22 Jan 2020 08:42:15 +0100
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Allison Randal <allison@lohutok.net>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/olpc: Fix the error handling of
 memblock_alloc failure
Message-ID: <20200122074215.GA178804@furthur.local>
References: <20200121232818.28018-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121232818.28018-1-pakki001@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 05:28:16PM -0600, Aditya Pakki wrote:
> In case of an error in memblock_alloc, the code calls both panic and
> BUG_ON. Revert the error handling to BUG_ON.
> 
> Fixes: 8a7f97b902f4 (add checks for the return value of memblock_alloc*())
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Reviewed-by: Lubomir Rintel <lkundrak@v3.sk>

Thank you
Lubo

> ---
>  arch/x86/platform/olpc/olpc_dt.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/olpc_dt.c
> index 26d1f6693789..92d5ce1232ab 100644
> --- a/arch/x86/platform/olpc/olpc_dt.c
> +++ b/arch/x86/platform/olpc/olpc_dt.c
> @@ -137,9 +137,6 @@ void * __init prom_early_alloc(unsigned long size)
>  		 * wasted bootmem) and hand off chunks of it to callers.
>  		 */
>  		res = memblock_alloc(chunk_size, SMP_CACHE_BYTES);
> -		if (!res)
> -			panic("%s: Failed to allocate %zu bytes\n", __func__,
> -			      chunk_size);
>  		BUG_ON(!res);
>  		prom_early_allocated += chunk_size;
>  		memset(res, 0, chunk_size);
> -- 
> 2.20.1
> 
