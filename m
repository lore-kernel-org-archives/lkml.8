Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30E9C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D13E24125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="WV0dvGFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgAUF7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 00:59:01 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:16569 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgAUF7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 00:59:01 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 481yXL64VTz9ty3Y;
        Tue, 21 Jan 2020 06:58:58 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=WV0dvGFU; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PHTZgmKWrw3Y; Tue, 21 Jan 2020 06:58:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 481yXL4vJKz9ty3X;
        Tue, 21 Jan 2020 06:58:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579586338; bh=S4GlmXILbwAbseJ3N4t+VG0i0jAmUowOEGM6twfSvl8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WV0dvGFUSU+rn7UwNLs5jFnXVUnawCjgqjTRPGXZHtb36bii2OPU2yJnCJaHZEbrm
         1/qdndZLfzCLb8rqntTFyMZIMklzT9Y0HpFlWiIYe98STQP7vp4NZX8FBFbzwlvEHy
         fRSLQJSq7lBb0RBy+x4phR5Nox55vLKrUFtdaJG4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D21118B78F;
        Tue, 21 Jan 2020 06:58:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Xg_Kupstu5q6; Tue, 21 Jan 2020 06:58:58 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 21A858B776;
        Tue, 21 Jan 2020 06:58:54 +0100 (CET)
Subject: Re: [PATCH] powerpc/sysdev: fix compile errors
To:     wangwenhu <wenhu.pku@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     lonehugo@hotmail.com, trivial@kernel.org, wenhu.wang@vivo.com
References: <20200121053114.89676-1-wenhu.pku@gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <9d32c935-a193-b339-1950-3443cb022780@c-s.fr>
Date:   Tue, 21 Jan 2020 06:58:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200121053114.89676-1-wenhu.pku@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 21/01/2020 à 06:31, wangwenhu a écrit :
> From: wangwenhu <wenhu.wang@vivo.com>
> 
> Include arch/powerpc/include/asm/io.h into fsl_85xx_cache_sram.c to
> fix the implicit declaration compile errors when building Cache-Sram.

It is usually better to include <linux/io.h> instead of <asm/io.h>

Christophe
