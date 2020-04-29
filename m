Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F55FC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F0A2208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TaxHKdPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgD2MHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:07:02 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56758 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgD2MHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:07:01 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200429120700euoutp012cba1d4259a623e8fde6b938a9534b3c~KSPFonIDx1747417474euoutp01Q
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:07:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200429120700euoutp012cba1d4259a623e8fde6b938a9534b3c~KSPFonIDx1747417474euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588162020;
        bh=dTge4FnxGdh1JeaXARxbuwKGOvOSz9PCdZUO8KY3UGo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TaxHKdPuhqZIrBXc7TfeZCHU83ET8Ok5USossb7so4fZfgD9ryHCq+l4AyzkHZ7Q5
         k8ks3yE/YntD8jDZvaok6bMrzpCQKC0jxMVBZRPcmR9HnaVwDS+dlPy6l+b1nuGd5S
         f92LkZi9dwVqJyx91dcmAT7qN+ukuxGfAQYy42YU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200429120659eucas1p2814adf32c85b42359a578eb93250a675~KSPFSnpKZ1690316903eucas1p2G;
        Wed, 29 Apr 2020 12:06:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4D.76.60679.3ED69AE5; Wed, 29
        Apr 2020 13:06:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200429120659eucas1p22ddcaa5cd23afc8c10a331d868c40d00~KSPFBP46e1690316903eucas1p2F;
        Wed, 29 Apr 2020 12:06:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200429120659eusmtrp1f3533d40502dcc33366a10d13d5ce8bc~KSPFAeTjm2302523025eusmtrp1p;
        Wed, 29 Apr 2020 12:06:59 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-f7-5ea96de3beea
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 45.F4.08375.3ED69AE5; Wed, 29
        Apr 2020 13:06:59 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200429120659eusmtip2b424af4cf97043f61fa0d99f98445859~KSPEmClnN0848208482eusmtip2a;
        Wed, 29 Apr 2020 12:06:59 +0000 (GMT)
Subject: Re: [PATCH v2] video: fbdev: controlfb: fix build for
 COMPILE_TEST=y && PPC_PMAC=y && PPC32=n
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kbuild test robot <lkp@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <28839ddd-36bb-3a69-b3dc-9dc14ac7eaee@samsung.com>
Date:   Wed, 29 Apr 2020 14:06:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200429115417.GA12801@ravnborg.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7djPc7qPc1fGGfR2mVosfHiX2eLK1/ds
        FqcnLGKyONH3gdXi8q45bBavmh+xWaz4uZXRYuveq+wOHB6NN26weez9toDFY/MKLY/Fe14y
        edzvPs7ksWTaVTaPz5vkAtijuGxSUnMyy1KL9O0SuDIOzvzIUrBQpOL//QNsDYwbBboYOTkk
        BEwkeua/Yu9i5OIQEljBKHFxXh8rhPOFUeLe5x1Qmc+MElvX/WWHafm1byUbRGI5o8SBG/ug
        Wt4ySvS+f8YKUiUskCHxueMfG4gtIqAscfz8NbAiZoH/jBIfe38xgSTYBKwkJravYgSxeQXs
        JD4f3ssCYrMIqEqcnnsSrEZUIELi04PDrBA1ghInZz4Bq+EUMJI4c3QV2EnMAuISt57MZ4Kw
        5SW2v53DDLJMQuAcu8T226tZIe52kfh38h3UD8ISr45vgbJlJE5P7mGBaFjHKPG34wVU93ZG
        ieWTIX6QELCWuHPuF5DNAbRCU2L9Ln2IsKPEp60f2UHCEgJ8EjfeCkIcwScxadt0Zogwr0RH
        mxBEtZrEhmUb2GDWdu1cyTyBUWkWktdmIXlnFpJ3ZiHsXcDIsopRPLW0ODc9tdgoL7Vcrzgx
        t7g0L10vOT93EyMwSZ3+d/zLDsZdf5IOMQpwMCrx8FqkrowTYk0sK67MPcQowcGsJML7KGNZ
        nBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNLUrNTUwtSi2CyTBycUg2MomnsaWsZ
        jppZ8k1ZdlPfJ/TdpsI5muk3QkUv5J+z4bzzfIMyyynefXLFO7In+zyb6sKzpbEsumfeX6mr
        z6/2Ccm0iB28vWZ+2INf29+/XLzlx96bE3mNGdY6cBncy7G2KgzcXhMiKxSgW2C+o+5S7Tur
        xa/YtT/+veC79NCSo/ceaJ+6cOdUthJLcUaioRZzUXEiAMI2UllOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xe7qPc1fGGdy9q2Sx8OFdZosrX9+z
        WZyesIjJ4kTfB1aLy7vmsFm8an7EZrHi51ZGi617r7I7cHg03rjB5rH32wIWj80rtDwW73nJ
        5HG/+ziTx5JpV9k8Pm+SC2CP0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXS
        t7NJSc3JLEst0rdL0Ms4OPMjS8FCkYr/9w+wNTBuFOhi5OSQEDCR+LVvJVsXIxeHkMBSRonu
        q2/Zuxg5gBIyEsfXl0HUCEv8udbFBmILCbxmlJjX7QBSIiyQIfH7XTFIWERAWeL4+WusIGOY
        Bf4zSjw5MZUVYuYuRoljc+eBNbMJWElMbF/FCGLzCthJfD68lwXEZhFQlTg99yQTiC0qECFx
        eMcsqBpBiZMzn4DVcAoYSZw5uoodxGYWUJf4M+8SM4QtLnHryXwmCFteYvvbOcwTGIVmIWmf
        haRlFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMx23Hfm7ewXhpY/AhRgEO
        RiUeXovUlXFCrIllxZW5hxglOJiVRHgfZSyLE+JNSaysSi3Kjy8qzUktPsRoCvTcRGYp0eR8
        YKrIK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAqHyip/8ko5mK
        ZFjYr/7zhT4ONVy69S6nZx5a2GNxc17C7K+3bU4Ut78Oe/Y99Q1bd+KL33aHfH8nh3MyXnm0
        VqhfccWBq2fXMpe+nZRy4VZT/Xet3T6qD9ZsfGc/84VJmsNBtqUrfJ1fTeIxcZVSmfE5f9Uv
        6/fH3eX3JTlfsXbpVwuqv8drq8RSnJFoqMVcVJwIAKusk8/dAgAA
X-CMS-MailID: 20200429120659eucas1p22ddcaa5cd23afc8c10a331d868c40d00
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200429104825eucas1p16bf37b71a3ab3a768d1eff6c48eb61dd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200429104825eucas1p16bf37b71a3ab3a768d1eff6c48eb61dd
References: <CGME20200429104825eucas1p16bf37b71a3ab3a768d1eff6c48eb61dd@eucas1p1.samsung.com>
        <fe520316-3863-e6c4-9581-5d709f49e906@samsung.com>
        <20200429115417.GA12801@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/29/20 1:54 PM, Sam Ravnborg wrote:
> Hi Bartlomiej.
> 
> On Wed, Apr 29, 2020 at 12:48:24PM +0200, Bartlomiej Zolnierkiewicz wrote:
>>
>> powerpc allyesconfig fails like this:
>>
>> drivers/video/fbdev/controlfb.c: In function 'controlfb_mmap':
>> drivers/video/fbdev/controlfb.c:756:23: error: implicit declaration of function 'pgprot_cached_wthru'; did you mean 'pgprot_cached'? [-Werror=implicit-function-declaration]
>>   756 |   vma->vm_page_prot = pgprot_cached_wthru(vma->vm_page_prot);
>>       |                       ^~~~~~~~~~~~~~~~~~~
>>       |                       pgprot_cached
>> drivers/video/fbdev/controlfb.c:756:23: error: incompatible types when assigning to type 'pgprot_t' {aka 'struct <anonymous>'} from type 'int'
>>
>> Fix it by adding missing PPC32 dependency.
> 
> Is this really the right fix?

Yes, ifdef in the code should match driver dependencies in Kconfig:

config FB_CONTROL
        bool "Apple \"control\" display support"
        depends on (FB = y) && ((PPC_PMAC && PPC32) || COMPILE_TEST)

> Short term I htink it is OK, but I think there should be a common way
> to do the same for all archtectures so no conditional compilation is
> needed. In other words the use of pgprot_cached_wthru looks like we
> need a better abstraction.

This would be of course nice to have but won't be enough to remove
the ifdef in this particular driver.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Added Christoph to the mail as he has a good overview of the area.
> 
> 	Sam
> 
> 
>>
>> Fixes: a07a63b0e24d ("video: fbdev: controlfb: add COMPILE_TEST support")
>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Cc: Sam Ravnborg <sam@ravnborg.org>
>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>> v2: fix implicit btext_update_display() function declaration error
>>
>>  drivers/video/fbdev/controlfb.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Index: b/drivers/video/fbdev/controlfb.c
>> ===================================================================
>> --- a/drivers/video/fbdev/controlfb.c
>> +++ b/drivers/video/fbdev/controlfb.c
>> @@ -55,7 +55,7 @@
>>  #include "macmodes.h"
>>  #include "controlfb.h"
>>  
>> -#ifndef CONFIG_PPC_PMAC
>> +#if !defined(CONFIG_PPC_PMAC) || !defined(CONFIG_PPC32)
>>  #define invalid_vram_cache(addr)
>>  #undef in_8
>>  #undef out_8
> 
>
