Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93247C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 23:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AC3220767
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 23:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589670493;
	bh=aSDJYt65gfHwTP2ldHRow9dEQtOjPVrtphZuiHCOv+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LOSitbFAyYax9uI1W2LaeHM3KCY+4D3W5rWqHnym/PE77dAiSmZX5UA41nDyjwaKm
	 oed3PD25eENMzVyYXIfMXGVbo5tr7Ap7bs1bva5FZKBRA71x6JEo+KR5JgIdqfUToZ
	 BYXkRIVzESEeFmeOUkdF8E/mRQrIkYR0CkyR8s0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgEPXIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 19:08:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbgEPXIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 19:08:12 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A20AE206F9;
        Sat, 16 May 2020 23:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589670491;
        bh=aSDJYt65gfHwTP2ldHRow9dEQtOjPVrtphZuiHCOv+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lp2MEMtfg1F7hSlTTWsT0/U06cieH89hqYRyiJX6PSkA2VCB92yBtD+eKPWMMxYuU
         fO+rHmXGcbez1FqhKZS9cSfijfPSp/W7CEyA6MC7e1i9xgf7E/glxoiLQp24ft7SOP
         B9FiTVUu+5i0kfjksRcPG62OaosFduiLT1l2ga9g=
Date:   Sat, 16 May 2020 19:08:10 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Marek =?utf-8?B?T2zFocOhaw==?= <marek.olsak@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH AUTOSEL 5.6 33/50] drm/amdgpu: bump version for
 invalidate L2 before SDMA IBs
Message-ID: <20200516230810.GH29995@sasha-vm>
References: <20200507142726.25751-1-sashal@kernel.org>
 <20200507142726.25751-33-sashal@kernel.org>
 <349b2cb9-71f9-a0cd-aceb-308512d7501a@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <349b2cb9-71f9-a0cd-aceb-308512d7501a@daenzer.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 06:11:17PM +0200, Michel Dänzer wrote:
>On 2020-05-07 4:27 p.m., Sasha Levin wrote:
>> From: Marek Olšák <marek.olsak@amd.com>
>>
>> [ Upstream commit 9017a4897a20658f010bebea825262963c10afa6 ]
>>
>> This fixes GPU hangs due to cache coherency issues.
>> Bump the driver version. Split out from the original patch.
>>
>> Signed-off-by: Marek Olšák <marek.olsak@amd.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>> Tested-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 42f4febe24c6d..8d45a2b662aeb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -85,9 +85,10 @@
>>   * - 3.34.0 - Non-DC can flip correctly between buffers with different pitches
>>   * - 3.35.0 - Add drm_amdgpu_info_device::tcc_disabled_mask
>>   * - 3.36.0 - Allow reading more status registers on si/cik
>> + * - 3.37.0 - L2 is invalidated before SDMA IBs, needed for correctness
>>   */
>>  #define KMS_DRIVER_MAJOR	3
>> -#define KMS_DRIVER_MINOR	36
>> +#define KMS_DRIVER_MINOR	37
>>  #define KMS_DRIVER_PATCHLEVEL	0
>>
>>  int amdgpu_vram_limit = 0;
>>
>
>This requires the parent commit fdf83646c0542ecfb9adc4db8f741a1f43dca058
>"drm/amdgpu: invalidate L2 before SDMA IBs (v2)". KMS_DRIVER_MINOR is
>bumped to signal to userspace the fix in that commit is present.

I've grabbed the commit you've pointed out as well as ce73516d42c9
("drm/amdgpu: simplify padding calculations (v2)") to make the backport
apply cleanly, thank you!

-- 
Thanks,
Sasha
