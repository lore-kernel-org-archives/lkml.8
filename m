Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EABC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CA924650
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="j4nIpV63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgBMKuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 05:50:24 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:39086 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729511AbgBMKuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 05:50:24 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48JCvx1tKgz9vBmx;
        Thu, 13 Feb 2020 11:50:21 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=j4nIpV63; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id lNMaryXYPCfP; Thu, 13 Feb 2020 11:50:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48JCvx0Nrhz9vBmv;
        Thu, 13 Feb 2020 11:50:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581591021; bh=a0AdfaSXewQASk+OQDLMZqVVvGG6bse26JEwu3kkGK8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=j4nIpV63cfg4kmkQx5p0ao6MB3efkedTnFl3cl62wRxJIbdldqXF9DpkDOikDEbp7
         MmBRHWqrHVH3uv8Syy+RBPHPoefCGrmzJ9qnve2+A4MqE/pXODXXQuWw/Pne5CDRRx
         7mc3KVJvf2hLZhrwtE33a0vZQlRhywDc6m0/0jOU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6F18E8B840;
        Thu, 13 Feb 2020 11:50:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id dp7BPwOlgiYQ; Thu, 13 Feb 2020 11:50:21 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EA4B88B83E;
        Thu, 13 Feb 2020 11:50:18 +0100 (CET)
Subject: Re: [Regression 5.6-rc1][Bisected b6231ea2b3c6] Powerpc 8xx doesn't
 boot anymore
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Li Yang <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Wood <oss@buserror.net>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <0d45fa64-51ee-0052-cb34-58c770c5b3ce@c-s.fr>
 <aee10440-c244-7c93-d3bb-fd29d8a83be4@c-s.fr>
 <59487f8a-fd2e-703d-d954-d263f756a3a0@rasmusvillemoes.dk>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <a1b742ab-54ad-1027-f11c-820009c54e8e@c-s.fr>
Date:   Thu, 13 Feb 2020 11:50:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <59487f8a-fd2e-703d-d954-d263f756a3a0@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 13/02/2020 à 10:37, Rasmus Villemoes a écrit :
> On 12/02/2020 15.50, Christophe Leroy wrote:
>>
>>
>> On 02/12/2020 02:24 PM, Christophe Leroy wrote:
> 
>>> In your commit text you explain that cpm_muram_init() is called via
>>> subsys_initcall. But console init is done before that, so it cannot work.
>>>
>>> Do you have a fix for that ?
>>>
>>
>> The following patch allows powerpc 8xx to boot again. Don't know if
>> that's the good place and way to do the fix though.
>>
>> ---
>> diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
>> b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
>> index 4cabded8390b..341d682ec6eb 100644
>> --- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
>> +++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
>> @@ -1351,6 +1351,7 @@ static int __init cpm_uart_console_setup(struct
>> console *co, char *options)
>>           clrbits32(&pinfo->sccp->scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
>>       }
>>
>> +    cpm_muram_init();
>>       ret = cpm_uart_allocbuf(pinfo, 1);
>>
>>       if (ret)
> 
> Hmm, that seems to be a somewhat random place, making it hard to see
> that it is indeed early enough. Would it work to put it inside the
> console_initcall that registers the cpm console? I.e.
> 
> static int __init cpm_uart_console_init(void)
> {
> +       cpm_muram_init();
>          register_console(&cpm_scc_uart_console);
>          return 0;
> }
> 
> console_initcall(cpm_uart_console_init);
> 

Yes that works too.

Thanks
Christophe
