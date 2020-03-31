Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7F1C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 06:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0459E20757
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 06:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbgCaGvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 02:51:38 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:34862 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCaGvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 02:51:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 146DD27E03B2;
        Tue, 31 Mar 2020 08:51:37 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id waJ4S9bw_HMh; Tue, 31 Mar 2020 08:51:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id D319527E0450;
        Tue, 31 Mar 2020 08:51:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 31zHK_ttVHDg; Tue, 31 Mar 2020 08:51:35 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id B7D2527E03B2;
        Tue, 31 Mar 2020 08:51:35 +0200 (CEST)
Date:   Tue, 31 Mar 2020 08:51:35 +0200 (CEST)
From:   =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalrayinc.com>
To:     s-anna <s-anna@ti.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Message-ID: <1759281267.12964559.1585637495215.JavaMail.zimbra@kalray.eu>
In-Reply-To: <23fc7800-4ba4-07d0-de15-d81498f04d3c@ti.com>
References: <20200327084939.8321-1-cleger@kalray.eu> <20200327161733.GA18041@xps15> <23fc7800-4ba4-07d0-de15-d81498f04d3c@ti.com>
Subject: Re: [PATCH] remoteproc: remove rproc_elf32_sanity_check
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - GC80 (Linux)/8.8.15_GA_3895)
Thread-Topic: remoteproc: remove rproc_elf32_sanity_check
Thread-Index: 3VVoXwttsIAMn4RaA/dROFzI1f5hRw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman,

----- On 30 Mar, 2020, at 21:11, s-anna s-anna@ti.com wrote:

> Hi Clement,
> 
> On 3/27/20 11:17 AM, Mathieu Poirier wrote:
>> On Fri, Mar 27, 2020 at 09:49:39AM +0100, Clement Leger wrote:
>>> Since checks are present in the remoteproc elf loader before calling
>>> da_to_va, loading a elf64 will work on 32bits flavors of kernel.
>>> Indeed, if a segment size is larger than what size_t can hold, the
>>> loader will return an error so the functionality is equivalent to
>>> what exists today.
>>>
>>> Signed-off-by: Clement Leger <cleger@kalray.eu>
>>> ---
>>>  drivers/remoteproc/remoteproc_core.c       |  2 +-
>>>  drivers/remoteproc/remoteproc_elf_loader.c | 21 ---------------------
>>>  drivers/remoteproc/remoteproc_internal.h   |  1 -
>>>  drivers/remoteproc/st_remoteproc.c         |  2 +-
>>>  drivers/remoteproc/st_slim_rproc.c         |  2 +-
>>>  drivers/remoteproc/stm32_rproc.c           |  2 +-
>>>  6 files changed, 4 insertions(+), 26 deletions(-)
>> 
>> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> 
>>>
>>> diff --git a/drivers/remoteproc/remoteproc_core.c
>>> b/drivers/remoteproc/remoteproc_core.c
>>> index a9ac1d01e09b..02ff076b0122 100644
>>> --- a/drivers/remoteproc/remoteproc_core.c
>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>> @@ -2069,7 +2069,7 @@ struct rproc *rproc_alloc(struct device *dev, const char
>>> *name,
>>>  		rproc->ops->parse_fw = rproc_elf_load_rsc_table;
>>>  		rproc->ops->find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table;
>>>  		if (!rproc->ops->sanity_check)
>>> -			rproc->ops->sanity_check = rproc_elf32_sanity_check;
>>> +			rproc->ops->sanity_check = rproc_elf_sanity_check;
> 
> Do you still need the capability to override the sanity_check? As I
> understand, you introduced this to allow platform drivers to use the
> appropriate elf32 or elf64 one during the ELF64 loader support series.

Indeed, this is probably not needed anymore, I will modify that.

> 
> regards
> Suman
> 
>>>  		rproc->ops->get_boot_addr = rproc_elf_get_boot_addr;
>>>  	}
>>>  
>>> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c
>>> b/drivers/remoteproc/remoteproc_elf_loader.c
>>> index 16e2c496fd45..29034f99898d 100644
>>> --- a/drivers/remoteproc/remoteproc_elf_loader.c
>>> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
>>> @@ -112,27 +112,6 @@ int rproc_elf_sanity_check(struct rproc *rproc, const
>>> struct firmware *fw)
>>>  }
>>>  EXPORT_SYMBOL(rproc_elf_sanity_check);
>>>  
>>> -/**
>>> - * rproc_elf_sanity_check() - Sanity Check ELF32 firmware image
>>> - * @rproc: the remote processor handle
>>> - * @fw: the ELF32 firmware image
>>> - *
>>> - * Make sure this fw image is sane.
>>> - */
>>> -int rproc_elf32_sanity_check(struct rproc *rproc, const struct firmware *fw)
>>> -{
>>> -	int ret = rproc_elf_sanity_check(rproc, fw);
>>> -
>>> -	if (ret)
>>> -		return ret;
>>> -
>>> -	if (fw_elf_get_class(fw) == ELFCLASS32)
>>> -		return 0;
>>> -
>>> -	return -EINVAL;
>>> -}
>>> -EXPORT_SYMBOL(rproc_elf32_sanity_check);
>>> -
>>>  /**
>>>   * rproc_elf_get_boot_addr() - Get rproc's boot address.
>>>   * @rproc: the remote processor handle
>>> diff --git a/drivers/remoteproc/remoteproc_internal.h
>>> b/drivers/remoteproc/remoteproc_internal.h
>>> index b389dc79da81..31994715fd43 100644
>>> --- a/drivers/remoteproc/remoteproc_internal.h
>>> +++ b/drivers/remoteproc/remoteproc_internal.h
>>> @@ -54,7 +54,6 @@ void *rproc_da_to_va(struct rproc *rproc, u64 da, size_t len);
>>>  phys_addr_t rproc_va_to_pa(void *cpu_addr);
>>>  int rproc_trigger_recovery(struct rproc *rproc);
>>>  
>>> -int rproc_elf32_sanity_check(struct rproc *rproc, const struct firmware *fw);
>>>  int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *fw);
>>>  u64 rproc_elf_get_boot_addr(struct rproc *rproc, const struct firmware *fw);
>>>  int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw);
>>> diff --git a/drivers/remoteproc/st_remoteproc.c
>>> b/drivers/remoteproc/st_remoteproc.c
>>> index a6cbfa452764..a3268d95a50e 100644
>>> --- a/drivers/remoteproc/st_remoteproc.c
>>> +++ b/drivers/remoteproc/st_remoteproc.c
>>> @@ -233,7 +233,7 @@ static const struct rproc_ops st_rproc_ops = {
>>>  	.parse_fw		= st_rproc_parse_fw,
>>>  	.load			= rproc_elf_load_segments,
>>>  	.find_loaded_rsc_table	= rproc_elf_find_loaded_rsc_table,
>>> -	.sanity_check		= rproc_elf32_sanity_check,
>>> +	.sanity_check		= rproc_elf_sanity_check,
>>>  	.get_boot_addr		= rproc_elf_get_boot_addr,
>>>  };
>>>  
>>> diff --git a/drivers/remoteproc/st_slim_rproc.c
>>> b/drivers/remoteproc/st_slim_rproc.c
>>> index 3cca8b65a8db..09bcb4d8b9e0 100644
>>> --- a/drivers/remoteproc/st_slim_rproc.c
>>> +++ b/drivers/remoteproc/st_slim_rproc.c
>>> @@ -203,7 +203,7 @@ static const struct rproc_ops slim_rproc_ops = {
>>>  	.da_to_va       = slim_rproc_da_to_va,
>>>  	.get_boot_addr	= rproc_elf_get_boot_addr,
>>>  	.load		= rproc_elf_load_segments,
>>> -	.sanity_check	= rproc_elf32_sanity_check,
>>> +	.sanity_check	= rproc_elf_sanity_check,
>>>  };
>>>  
>>>  /**
>>> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
>>> index 6a66dbf2df40..2e07a95439c8 100644
>>> --- a/drivers/remoteproc/stm32_rproc.c
>>> +++ b/drivers/remoteproc/stm32_rproc.c
>>> @@ -505,7 +505,7 @@ static struct rproc_ops st_rproc_ops = {
>>>  	.load		= rproc_elf_load_segments,
>>>  	.parse_fw	= stm32_rproc_parse_fw,
>>>  	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
>>> -	.sanity_check	= rproc_elf32_sanity_check,
>>> +	.sanity_check	= rproc_elf_sanity_check,
>>>  	.get_boot_addr	= rproc_elf_get_boot_addr,
>>>  };
>>>  
>>> --
>>> 2.17.1
