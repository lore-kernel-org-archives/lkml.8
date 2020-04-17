Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7918C3815B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB9F221E9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbgDQJXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:23:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36530 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730226AbgDQJXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:23:20 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0F167F3F89FD44370F11;
        Fri, 17 Apr 2020 17:23:18 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.7) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Apr 2020
 17:23:07 +0800
Subject: Re: [PATCH] ALSA: au88x0: remove some dead code
To:     Takashi Iwai <tiwai@suse.de>
CC:     <perex@perex.cz>, <tiwai@suse.com>, <hariprasad.kelam@gmail.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
References: <20200417092232.13371-1-yanaijie@huawei.com>
 <s5ho8rqbhz1.wl-tiwai@suse.de>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <3caeb0e2-0f4a-3f98-07e9-dd8f78a33dc3@huawei.com>
Date:   Fri, 17 Apr 2020 17:23:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <s5ho8rqbhz1.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.213.7]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/4/17 17:05, Takashi Iwai 写道:
> On Fri, 17 Apr 2020 11:22:32 +0200,
> Jason Yan wrote:
>>
>> Fix the following gcc warning:
>>
>> sound/pci/au88x0/au88x0_a3ddata.c:62:25: warning: ‘A3dHrirDImpulse’
>> defined but not used [-Wunused-const-variable=]
>>   static const a3d_Hrtf_t A3dHrirDImpulse = {
>>                           ^~~~~~~~~~~~~~~
>> sound/pci/au88x0/au88x0_a3ddata.c:50:25: warning: ‘A3dHrirSatTest’
>> defined but not used [-Wunused-const-variable=]
>>   static const a3d_Hrtf_t A3dHrirSatTest = {
>>                           ^~~~~~~~~~~~~~
>> sound/pci/au88x0/au88x0_a3ddata.c:33:25: warning: ‘A3dHrirOnes’ defined
>> but not used [-Wunused-const-variable=]
>>   static const a3d_Hrtf_t A3dHrirOnes = {
>>                           ^~~~~~~~~~~
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> 
> I'd rather keep them but disable with #if 0, if it's only about the
> minor compiler warnings.
> 
> The whole code is a result of reverse engineering and those dead code
> are simply there just because of lack of testing.  Removing makes it
> impossible for retesting (if any).
> 

Actually you can easily recover the code from git history.

Anyway, it's all your choice.

Thanks,

Jason

> 
> thanks,
> 
> Takashi
> 
>> ---
>>   sound/pci/au88x0/au88x0_a3d.c     | 23 -------------------
>>   sound/pci/au88x0/au88x0_a3ddata.c | 38 -------------------------------
>>   2 files changed, 61 deletions(-)
>>
>> diff --git a/sound/pci/au88x0/au88x0_a3d.c b/sound/pci/au88x0/au88x0_a3d.c
>> index 2db183f8826a..4d3b79a34c69 100644
>> --- a/sound/pci/au88x0/au88x0_a3d.c
>> +++ b/sound/pci/au88x0/au88x0_a3d.c
>> @@ -512,31 +512,8 @@ static void a3dsrc_ProgramPipe(a3dsrc_t * a)
>>   	/* Single spike leads to identity transfer function. */
>>   	a3dsrc_SetHrtfCurrent(a, A3dHrirImpulse, A3dHrirImpulse);
>>   	a3dsrc_SetHrtfTarget(a, A3dHrirImpulse, A3dHrirImpulse);
>> -
>> -	/* Test: Sounds saturated. */
>> -	//a3dsrc_SetHrtfCurrent(a, A3dHrirSatTest, A3dHrirSatTest);
>> -	//a3dsrc_SetHrtfTarget(a, A3dHrirSatTest, A3dHrirSatTest);
>>   }
>>   
>> -/* VDB = Vortex audio Dataflow Bus */
>> -#if 0
>> -static void a3dsrc_ClearVDBData(a3dsrc_t * a, unsigned long aa)
>> -{
>> -	vortex_t *vortex = (vortex_t *) (a->vortex);
>> -
>> -	// ((aa >> 2) << 8) - (aa >> 2)
>> -	hwwrite(vortex->mmio,
>> -		a3d_addrS(a->slice, A3D_SLICE_VDBDest) + (a->source << 2), 0);
>> -	hwwrite(vortex->mmio,
>> -		a3d_addrS(a->slice,
>> -			  A3D_SLICE_VDBDest + 4) + (a->source << 2), 0);
>> -	/*
>> -	   hwwrite(vortex->mmio, 0x19c00 + (((aa>>2)*255*4)+aa)*8, 0);
>> -	   hwwrite(vortex->mmio, 0x19c04 + (((aa>>2)*255*4)+aa)*8, 0);
>> -	 */
>> -}
>> -#endif
>> -
>>   /* A3D HwSource stuff. */
>>   
>>   static void vortex_A3dSourceHw_Initialize(vortex_t * v, int source, int slice)
>> diff --git a/sound/pci/au88x0/au88x0_a3ddata.c b/sound/pci/au88x0/au88x0_a3ddata.c
>> index 18623cb6bc52..cc41ea67a6d3 100644
>> --- a/sound/pci/au88x0/au88x0_a3ddata.c
>> +++ b/sound/pci/au88x0/au88x0_a3ddata.c
>> @@ -30,44 +30,6 @@ static const a3d_Hrtf_t A3dHrirImpulse = {
>>   	0, 0, 0
>>   };
>>   
>> -static const a3d_Hrtf_t A3dHrirOnes = {
>> -	0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff,
>> -	0x7fff,
>> -	0x7fff,
>> -	0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff,
>> -	0x7fff,
>> -	0x7fff,
>> -	0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff,
>> -	0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff,
>> -	0x7fff,
>> -	0x7fff,
>> -	0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff,
>> -	0x7fff,
>> -	0x7fff,
>> -	0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff
>> -};
>> -
>> -static const a3d_Hrtf_t A3dHrirSatTest = {
>> -	0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff, 0x7fff,
>> -	0x7fff,
>> -	0x7fff,
>> -	0x8001, 0x8001, 0x8001, 0x8001, 0x8001, 0x8001, 0x8001, 0x8001,
>> -	0x8001,
>> -	0x8001,
>> -	0x7fff, 0x0000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>> -	0, 0, 0,
>> -	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
>> -};
>> -
>> -static const a3d_Hrtf_t A3dHrirDImpulse = {
>> -	0, 0x7fff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>> -	0, 0, 0,
>> -	0, 0, 0, 0,
>> -	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>> -	0, 0, 0,
>> -	0, 0, 0
>> -};
>> -
>>   static const a3d_ItdDline_t A3dItdDlineZeros = {
>>   	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>>   	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
>> -- 
>> 2.21.1
>>
> 
> .
> 

