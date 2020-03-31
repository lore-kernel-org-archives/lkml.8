Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3977C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 03:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AF92072D
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 03:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgCaDFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 23:05:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12656 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727464AbgCaDFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 23:05:34 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DB44D73EF08DFFDA918F;
        Tue, 31 Mar 2020 11:05:31 +0800 (CST)
Received: from [127.0.0.1] (10.173.223.234) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 31 Mar 2020
 11:05:26 +0800
Subject: Re: [PATCH] powerpc/44x: Make AKEBONO depends on NET
To:     Michael Ellerman <mpe@ellerman.id.au>,
        <mporter@kernel.crashing.org>, <benh@kernel.crashing.org>,
        <paulus@samba.org>
References: <20200330143153.32800-1-yuehaibing@huawei.com>
 <87pnctuyq3.fsf@mpe.ellerman.id.au>
CC:     <alistair@popple.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <bda28b40-b573-cff5-817a-3ddca1d8f969@huawei.com>
Date:   Tue, 31 Mar 2020 11:05:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <87pnctuyq3.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/31 8:58, Michael Ellerman wrote:
> YueHaibing <yuehaibing@huawei.com> writes:
>> Fix Kconfig warnings:
>>
>> WARNING: unmet direct dependencies detected for NETDEVICES
>>   Depends on [n]: NET [=n]
>>   Selected by [y]:
>>   - AKEBONO [=y] && PPC_47x [=y]
>>
>> WARNING: unmet direct dependencies detected for ETHERNET
>>   Depends on [n]: NETDEVICES [=y] && NET [=n]
>>   Selected by [y]:
>>   - AKEBONO [=y] && PPC_47x [=y]
>>
>> AKEBONO select NETDEVICES and ETHERNET unconditionally,
> 
> It shouldn't do that, that's the job of a defconfig.
> 
> It might want to enable NET_VENDOR_IBM iff the config already has NET
> and other dependencies enabled.
> 
> So the patch below might work?

Yes, It works for me, Thanks!

Tested-by: YueHaibing <yuehaibing@huawei.com> # build-tested

> 
> cheers
> 
> diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
> index 25ebe634a661..32aac4f40f1b 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -207,9 +207,7 @@ config AKEBONO
>  	select PPC4xx_HSTA_MSI
>  	select I2C
>  	select I2C_IBM_IIC
> -	select NETDEVICES
> -	select ETHERNET
> -	select NET_VENDOR_IBM
> +	imply NET_VENDOR_IBM
>  	select IBM_EMAC_EMAC4 if IBM_EMAC
>  	select USB if USB_SUPPORT
>  	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
> 
> 
> 
>> If NET is not set, build fails. Add this dependcy to fix this.
>>
>> Fixes: 2a2c74b2efcb ("IBM Akebono: Add the Akebono platform")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  arch/powerpc/platforms/44x/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
>> index 25ebe634a661..394f662d7df2 100644
>> --- a/arch/powerpc/platforms/44x/Kconfig
>> +++ b/arch/powerpc/platforms/44x/Kconfig
>> @@ -199,6 +199,7 @@ config FSP2
>>  config AKEBONO
>>  	bool "IBM Akebono (476gtr) Support"
>>  	depends on PPC_47x
>> +	depends on NET
>>  	select SWIOTLB
>>  	select 476FPE
>>  	select PPC4xx_PCI_EXPRESS
>> -- 
>> 2.17.1
> 
> .
> 

