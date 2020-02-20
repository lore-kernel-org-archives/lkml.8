Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3105BC11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0502220658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Eo8wXh/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgBTQD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:03:57 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37084 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgBTQD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:03:57 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01KG3pj5033413;
        Thu, 20 Feb 2020 10:03:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582214631;
        bh=DBWwwQrIgWb5ll4MlEhJxeMr2gp/IhBqGAzDjFtTYiw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Eo8wXh/P3J+QojE2/JDUIzLkUaevW44WAGjJzwXo3iCQ2vVp9RnDQsbkd4PBPgfm4
         MKP8xf2UDg2sYQob0uY7GJF/LlPZ7jS6w+UMbd+MUV3q6ZPaRi34tXFIbzlRYvK0/y
         0WDz/yl+giHxBnThjd1TrrPAvMVsu+EIztdte/pQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01KG3p3n053922
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Feb 2020 10:03:51 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 20
 Feb 2020 10:03:51 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 20 Feb 2020 10:03:51 -0600
Received: from [10.250.77.18] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01KG3oIV093156;
        Thu, 20 Feb 2020 10:03:50 -0600
Subject: Re: omap-secure.c:undefined reference to `__arm_smccc_smc'
To:     Tony Lindgren <tony@atomide.com>
CC:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
References: <202002131856.VeW4PhBJ%lkp@intel.com>
 <20200220155429.GH37466@atomide.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <55ddcd29-ed8b-529e-dd54-cbac5cf74e42@ti.com>
Date:   Thu, 20 Feb 2020 11:03:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220155429.GH37466@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/20 10:54 AM, Tony Lindgren wrote:
> Andrew,
> 
> * kbuild test robot <lkp@intel.com> [200213 10:27]:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   0bf999f9c5e74c7ecf9dafb527146601e5c848b9
>> commit: c37baa06f8a970e4a533d41f7d33e5e57de5ad25 ARM: OMAP2+: Fix undefined reference to omap_secure_init
>> date:   3 weeks ago
>> config: arm-randconfig-a001-20200213 (attached as .config)
>> compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         git checkout c37baa06f8a970e4a533d41f7d33e5e57de5ad25
>>         # save the attached .config to linux build tree
>>         GCC_VERSION=7.5.0 make.cross ARCH=arm 
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>    arch/arm/mach-omap2/omap-secure.o: In function `omap_smccc_smc':
>>>> omap-secure.c:(.text+0x94): undefined reference to `__arm_smccc_smc'
> 
> Have you looked at this one? Looks like there's still an unhandled
> randconfig build case.
> 


I've had a quick look, all the ARM config does:

select HAVE_ARM_SMCCC if CPU_V7

so I don't think this will happen in any real config, but if we want to
prevent randconfig issue this we could force ARCH_OMAP2PLUS to "depend"
on it.

Andrew


> Regards,
> 
> Tony
> 
