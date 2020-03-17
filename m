Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD093C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940DD205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="S2qnvktO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgCQLK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:10:58 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46442 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgCQLK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:10:56 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48hVpQ3gWvz9tyNL;
        Tue, 17 Mar 2020 12:10:54 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=S2qnvktO; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id tw69ROBWa6CW; Tue, 17 Mar 2020 12:10:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48hVpQ2R82z9tyNJ;
        Tue, 17 Mar 2020 12:10:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584443454; bh=5ZVaxgAPu7tRLwzrgx0YFwBG2He1G66cpQN69Xz0K3I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S2qnvktOMP0HeIE4yDIfvL8NtDojuzvqd6Yono4mp4tlyid+D2eqdC6uNj7eRj0wX
         FHOC+zMWLqjaAGqnuE6tHE824l/AcsFlrF5NTK4eYimJ4TADfjMOC7LIMWoIaVbqU3
         KBCSot4jqb+oEXLpaQSdetJWRycgM8DaB8UQoGGI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 654358B785;
        Tue, 17 Mar 2020 12:10:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id emwlBXj-XvrU; Tue, 17 Mar 2020 12:10:54 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7E44B8B787;
        Tue, 17 Mar 2020 12:10:46 +0100 (CET)
Subject: Re: [PATCH 14/15] powerpc/watchpoint/xmon: Don't allow breakpoint
 overwriting
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
 <20200309085806.155823-15-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b6892b22-c521-207e-e5fd-ca66c774b314@c-s.fr>
Date:   Tue, 17 Mar 2020 12:10:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309085806.155823-15-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/03/2020 à 09:58, Ravi Bangoria a écrit :
> Xmon allows overwriting breakpoints because it's supported by only
> one dawr. But with multiple dawrs, overwriting becomes ambiguous
> or unnecessary complicated. So let's not allow it.

Could we drop this completely (I mean the functionnality, not the patch).

Christophe

> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>   arch/powerpc/xmon/xmon.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 0ca0d29f99c6..ac18fe3e4295 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -1381,6 +1381,10 @@ bpt_cmds(void)
>   			printf("Hardware data breakpoint not supported on this cpu\n");
>   			break;
>   		}
> +		if (dabr.enabled) {
> +			printf("Couldn't find free breakpoint register\n");
> +			break;
> +		}
>   		mode = 7;
>   		cmd = inchar();
>   		if (cmd == 'r')
> 
