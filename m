Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E464C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2068021973
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Q1mfZRzd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505497AbgDPKsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 06:48:11 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:51691 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505052AbgDPKgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 06:36:46 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 492wd560Khz9v1KF;
        Thu, 16 Apr 2020 12:36:41 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Q1mfZRzd; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id gjgErL3lbfTm; Thu, 16 Apr 2020 12:36:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 492wd54vTKz9v1KC;
        Thu, 16 Apr 2020 12:36:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587033401; bh=l5FwhWsZFKoNYPFvSBrPZm1J3No4Lds1oXRu+U6EyzE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q1mfZRzdVTVLZ9spIAcjumqoNKfKtAXMhqqu72UQK2qqOHAgzcyZ93dCPB4Z9HBDb
         eUTezV8zEsorpEL5x5DoxpQ1KoJ4kzp5DqP3jd5KDzneZxqh06kk6xhlxU4YVc9Zbm
         iebw9fw1oWps8adcEcDcgg+pOfjnMtWRYxvJ/Pmc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 29BEB8BBF0;
        Thu, 16 Apr 2020 12:36:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UL0sASDHqyWS; Thu, 16 Apr 2020 12:36:43 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 991E18B99F;
        Thu, 16 Apr 2020 12:36:42 +0200 (CEST)
Subject: Re: [PATCH v3,0/4] drivers: uio: new driver uio_fsl_85xx_cache_sram
To:     =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        oss@buserror.net, linuxppc-dev@lists.ozlabs.org, kernel@vivo.com
References: <AIgAKQBlCIqtPx5U5P0kFqpr.3.1587029369636.Hmail.wenhu.wang@vivo.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <a3032813-ba1e-101a-0b73-cc477d702aac@c-s.fr>
Date:   Thu, 16 Apr 2020 12:36:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <AIgAKQBlCIqtPx5U5P0kFqpr.3.1587029369636.Hmail.wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/04/2020 à 11:29, 王文虎 a écrit :
> Hi,
> Seems there is something wrong with the server that multiple dumplications
> of the v3 patches were sent out, please ignore the rest and take this newest
> series as formal count.

Which series ?

It seems you sent 3 times, at 9:29, 9:41 and 9:49 (Paris Time)

 From the series of 9:29, I received patches 0 to 3
 From the series of 9:41, I received patches 0 to 3
 From the series of 9:49, I received patches 0 and 4.

Looks like powerpc patchwork 
(https://patchwork.ozlabs.org/project/linuxppc-dev/list/?submitter=78320) 
got:
 From the series of 9:29, I received patches 0 to 4
 From the series of 9:41, I received patches 1 to 4
 From the series of 9:49, I received patches 1 to 4

So this seems to be something wrong somewhere.

Christophe


> 
> Thanks,
> Wenhu
> 
> From: Wang Wenhu <wenhu.wang@vivo.com>
> Date: 2020-04-16 15:49:14
> To:  gregkh@linuxfoundation.org,linux-kernel@vger.kernel.org,oss@buserror.net,christophe.leroy@c-s.fr,linuxppc-dev@lists.ozlabs.org
> Cc:  kernel@vivo.com,Wang Wenhu <wenhu.wang@vivo.com>
> Subject: [PATCH v3,0/4] drivers: uio: new driver uio_fsl_85xx_cache_sram>This series add a new uio driver for freescale 85xx platforms to
>> access the Cache-Sram form user level. This is extremely helpful
>> for the user-space applications that require high performance memory
>> accesses.
>>
>> It fixes the compile errors and warning of the hardware level drivers
>> and implements the uio driver in uio_fsl_85xx_cache_sram.c.
>>
>> Changes since v1:
>> * Addressed comments from Greg K-H
>> * Moved kfree(info->name) into uio_info_free_internal()
>>
>> Changes since v2:
>> * Drop the patch that modifies Kconfigs of arch/powerpc/platforms
>>    and modified the sequence of patches:
>>     01:dropped, 02->03, 03->02, 04->01, 05->04
>> * Addressed comments from Greg, Scott and Christophe
>> * Use "uiomem->internal_addr" as if condition for sram memory free,
>>    and memset the uiomem entry
>> * Modified of_match_table make the driver apart from Cache-Sram HW info
>>    which belong to the HW level driver fsl_85xx_cache_sram to match
>> * Use roundup_pow_of_two for align calc(really learned a lot from Christophe)
>> * Remove useless clear block of uiomem entries.
>> * Use UIO_INFO_VER micro for info->version, and define it as
>>    "devicetree,pseudo", meaning this is pseudo device and probed from
>>    device tree configuration
>> * Select FSL_85XX_CACHE_SRAM rather than depends on it
>>
>> Wang Wenhu (4):
>>   powerpc: sysdev: fix compile error for fsl_85xx_l2ctlr
>>   powerpc: sysdev: fix compile error for fsl_85xx_cache_sram
>>   powerpc: sysdev: fix compile warning for fsl_85xx_cache_sram
>>   drivers: uio: new driver for fsl_85xx_cache_sram
>>
>> arch/powerpc/sysdev/fsl_85xx_cache_sram.c |   3 +-
>> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c     |   1 +
>> drivers/uio/Kconfig                       |   9 ++
>> drivers/uio/Makefile                      |   1 +
>> drivers/uio/uio_fsl_85xx_cache_sram.c     | 158 ++++++++++++++++++++++
>> 5 files changed, 171 insertions(+), 1 deletion(-)
>> create mode 100644 drivers/uio/uio_fsl_85xx_cache_sram.c
>>
>> -- 
>> 2.17.1
>>
> 
> 
