Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F693C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BCE2073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="izYpHgtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgBMK7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 05:59:40 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:33791 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgBMK7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 05:59:40 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48JD6d5y5kz9vBn1;
        Thu, 13 Feb 2020 11:59:37 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=izYpHgtw; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id uMT8b6FJS4mJ; Thu, 13 Feb 2020 11:59:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48JD6d4jyPz9vBn0;
        Thu, 13 Feb 2020 11:59:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581591577; bh=9MA4+/F5Rc+khF9eIgEqNW6jSVgDMFjfGzMXEAy8e0s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=izYpHgtwWwogvPcn9IwvaMmDsHwTyaynTNUvpD2q8ThzbV3WnssHY162X+t0bNlim
         ei8nSpZ5MUfVRK5MeDSwnq2uP+HOWXlS3V8wG3pf4LA3KTXFGN+IJQKFgv2V7PZnGm
         bU5b3Dqw8U878kQaYVBCDuCC1R4CCRkAJNVURAzI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F03AA8B83F;
        Thu, 13 Feb 2020 11:59:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pNKMcJE7jnwh; Thu, 13 Feb 2020 11:59:37 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6DD7D8B83E;
        Thu, 13 Feb 2020 11:59:36 +0100 (CET)
Subject: Re: [PATCH 10/18] powerpc: Replace setup_irq() by request_irq()
To:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Scott Wood <oss@buserror.net>, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
 <303393f75ede6d36241d41f501d9ad2a23897c3f.1581478324.git.afzal.mohd.ma@gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <a4f2ad65-0634-f825-b0b7-7e4cd2dc697f@c-s.fr>
Date:   Thu, 13 Feb 2020 11:59:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <303393f75ede6d36241d41f501d9ad2a23897c3f.1581478324.git.afzal.mohd.ma@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 12/02/2020 à 09:04, afzal mohammed a écrit :
> request_irq() is preferred over setup_irq(). Existing callers of
> setup_irq() reached mostly via 'init_IRQ()' & 'time_init()', while
> memory allocators are ready by 'mm_init()'.
> 
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
> 
> Hence replace setup_irq() by request_irq().
> 
> Seldom remove_irq() usage has been observed coupled with setup_irq(),
> wherever that has been found, it too has been replaced by free_irq().
> 
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>

Tested-by: Christophe Leroy <christophe.leroy@c-s.fr> # for the 8xx parts

> ---
> 
> Since cc'ing cover letter to all maintainers/reviewers would be too
> many, refer for cover letter,
>   https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com
> 
>   arch/powerpc/platforms/85xx/mpc85xx_cds.c | 10 +++-----
>   arch/powerpc/platforms/8xx/cpm1.c         |  9 ++-----
>   arch/powerpc/platforms/8xx/m8xx_setup.c   |  9 ++-----
>   arch/powerpc/platforms/chrp/setup.c       | 14 ++++------
>   arch/powerpc/platforms/powermac/pic.c     | 31 ++++++++++-------------
>   arch/powerpc/platforms/powermac/smp.c     |  9 ++-----
>   6 files changed, 27 insertions(+), 55 deletions(-)
> 


