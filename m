Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E46C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 12:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4242224683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 12:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a6OljAR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgA1Mel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 07:34:41 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60436 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgA1Mel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 07:34:41 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00SCYWhi018315;
        Tue, 28 Jan 2020 06:34:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580214872;
        bh=xdfCb9Z4jbETkYDlhz9ZRh+fvvPTsMlsaRUiB3TyqJE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=a6OljAR+hCu8dtbadxamM2GWWsxJYHZ3FYhDaHt63ofojQEBJZeHh9Il8/+lVbTYz
         UfZbY80FRcPLfErmqEN6aMl+4UtENfI0NiofEX4ZO2Z4YmN+lDRdoduKCmeLv5IuXe
         Y0jaSjODxFsHlzE9Pe2r8FnbKveBIJPVieM2PnKI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00SCYVrG059652
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jan 2020 06:34:31 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 28
 Jan 2020 06:34:31 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 28 Jan 2020 06:34:31 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00SCYTks006112;
        Tue, 28 Jan 2020 06:34:30 -0600
Subject: Re: Docs build broken by driver-api/dmaengine/client.rst ? (was Re:
 [GIT PULL]: dmaengine updates for v5.6-rc1)
To:     Vinod Koul <vkoul@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
CC:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200127145835.GI2841@vkoul-mobl>
 <87imkvhkaq.fsf@mpe.ellerman.id.au> <20200128122415.GU2841@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <f88ed09c-6244-71e5-3be4-b733ee348b79@ti.com>
Date:   Tue, 28 Jan 2020 14:35:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200128122415.GU2841@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael, Vinod,

On 28/01/2020 14.24, Vinod Koul wrote:
> Hi Michael,
> 
> On 28-01-20, 22:50, Michael Ellerman wrote:
>> Hi Vinod,
>>
>> Vinod Koul <vkoul@kernel.org> writes:
>>> Hello Linus,
>>>
>>> Please pull to receive the dmaengine updates for v5.6-rc1. This time we
>>> have a bunch of core changes to support dynamic channels, hotplug of
>>> controllers, new apis for metadata ops etc along with new drivers for
>>> Intel data accelerators, TI K3 UDMA, PLX DMA engine and hisilicon
>>> Kunpeng DMA engine. Also usual assorted updates to drivers.
>>>
>>> The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
>>>
>>>   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-5.6-rc1
>>>
>>> for you to fetch changes up to 71723a96b8b1367fefc18f60025dae792477d602:
>>>
>>>   dmaengine: Create symlinks between DMA channels and slaves (2020-01-24 11:41:32 +0530)
>>>
>>> ----------------------------------------------------------------
>>> dmaengine updates for v5.6-rc1
>> ...
>>>
>>> Peter Ujfalusi (9):
>>>       dmaengine: doc: Add sections for per descriptor metadata support
>>
>> This broke the docs build for me with:
>>
>>   Sphinx parallel build error:
>>   docutils.utils.SystemMessage: /linux/Documentation/driver-api/dmaengine/client.rst:155: (SEVERE/4) Unexpected section title.
> 
> Thanks for the report.
> 
>>   Optional: per descriptor metadata
>>   ---------------------------------
>>
>>
>> The patch below fixes the build. It may not produce the output you
>> intended, it just makes it bold rather than a heading, but it doesn't
>> really make sense to have a heading inside a numbered list.
>>
>> diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
>> index a9a7a3c84c63..343df26e73e8 100644
>> --- a/Documentation/driver-api/dmaengine/client.rst
>> +++ b/Documentation/driver-api/dmaengine/client.rst
>> @@ -151,8 +151,8 @@ DMA usage
>>       Note that callbacks will always be invoked from the DMA
>>       engines tasklet, never from interrupt context.
>>  
>> -  Optional: per descriptor metadata
>> -  ---------------------------------
>> +  **Optional: per descriptor metadata**
>> +
> 
> I have modified this to below as this:
> 
> --- a/Documentation/driver-api/dmaengine/client.rst
> +++ b/Documentation/driver-api/dmaengine/client.rst
> @@ -151,8 +151,8 @@ The details of these operations are:
>       Note that callbacks will always be invoked from the DMA
>       engines tasklet, never from interrupt context.
>  
> -  Optional: per descriptor metadata
> -  ---------------------------------
> +Optional: per descriptor metadata
> +---------------------------------
>    DMAengine provides two ways for metadata support.
>  
>    DESC_METADATA_CLIENT
> 
> And I will add this as fixes and it should be in linux-next tomorrow

Sorry for breaking the build and thanks Vinod for the quick fix!

> 
> Thanks
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
