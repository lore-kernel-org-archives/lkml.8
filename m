Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35481C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A3C22CA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHGOxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:53:54 -0400
Received: from vpn2.c-s.fr ([93.17.235.2]:31032 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727033AbgHGOxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 10:53:44 -0400
X-Greylist: delayed 1332 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Aug 2020 10:53:43 EDT
Received: from localhost (mailhub2-ext [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4BNSTj0v49z9ttfp;
        Fri,  7 Aug 2020 16:31:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [172.26.127.65]) (amavisd-new, port 10024)
        with ESMTP id cj3w-Q5bmpO7; Fri,  7 Aug 2020 16:31:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4BNSTj05PQz9ttfn;
        Fri,  7 Aug 2020 16:31:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5E2FC8BBAD;
        Fri,  7 Aug 2020 16:31:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TRVENUZcnl2M; Fri,  7 Aug 2020 16:31:23 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8AD738BBA8;
        Fri,  7 Aug 2020 16:31:22 +0200 (CEST)
Subject: Re: [PATCH] powerpc:entry_32: correct the path and function name in
 the comment
To:     chenzefeng <chenzefeng2@huawei.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@c-s.fr, tglx@linutronix.de, bigeasy@linutronix.de,
        npiggin@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        zengweilin@huawei.com
References: <20200807101956.67454-1-chenzefeng2@huawei.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <b8d70e7a-7dc8-ef46-9e84-7f03d68a151b@csgroup.eu>
Date:   Fri, 7 Aug 2020 16:31:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200807101956.67454-1-chenzefeng2@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 07/08/2020 à 12:19, chenzefeng a écrit :
> Update the comment for file's directory and function name changed.
> 
> Fixes: facd04a904ff ("powerpc: convert to copy_thread_tls")
> Fixes: 14cf11af6cf6 ("powerpc: Merge enough to start building in arch/powerpc.")
> 
> Signed-off-by: chenzefeng <chenzefeng2@huawei.com>
> ---
>   arch/powerpc/kernel/entry_32.S | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 8420abd4ea1c..9937593d3a33 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -696,8 +696,8 @@ handle_dabr_fault:
>    * to the "_switch" path.  If you change this , you'll have to
>    * change the fork code also.
>    *
> - * The code which creates the new task context is in 'copy_thread'
> - * in arch/ppc/kernel/process.c
> + * The code which creates the new task context is in 'copy_thread_tls'
> + * in arch/powerpc/kernel/process.c

Does it matters at all where the function is ? I'm sure people can find 
it themselves.

Christophe

>    */
>   _GLOBAL(_switch)
>   	stwu	r1,-INT_FRAME_SIZE(r1)
> 
