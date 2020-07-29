Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99BBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B24B1207F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4uqbyW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgG2ILS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2ILR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:11:17 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B89C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 01:11:17 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id qc22so8587949ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 01:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/t5pNySee6OqbzQZAWjwnDIE2zX5dn9rOcmBRRLPlS8=;
        b=J4uqbyW3DPYAUqprlCh0mjjkrOfnI1IdYmwCrBeG2W65C0YQh0YigGyEcTMv9TDaop
         8+QysujUGb0/8unyd0iqLKEwEdc946YOUxRiSlm+RU1Ju8vBvRUSPN8is8QDCRFOQx0E
         SrNfNRy2JCfDMO8HUm6w/dPrM/FCBnhiGt2SpsQmanyif6KVet48HHt2I/wtjtHg07PB
         MUhZCuQoOZjS8OxmXiOwvfKOwxIEWCGnNRk+cgVlTVcyQ+VqfXZ1t0757ByUglvRoyIo
         gf//kssY6kJxGZ8ArKMzAwR1m2pPRFra3X1mxkjgLJKRwhmPPHIk8xtAbCIX5cB1L0U8
         lW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=/t5pNySee6OqbzQZAWjwnDIE2zX5dn9rOcmBRRLPlS8=;
        b=eJx8EDy29T7lTgVgJzcmpNnaJNSqHoiVK2lgsw5rO8viqCzwsH2pd3bTZ4AoaM0SDh
         4YxPrHDfJeLTptYHQv4dxNf/TF7MzTp4189lYfqXiJ7LM1iW/Etfmy3HZu4FY/kR4wQY
         xQ0V4eFS6i00dF2p4VrKdnInZF0R3072hLEC9OvoK7mVBphQthFWh6j+01VevC9l1jlA
         R7P05xvHjHGB8J0A7QMztbQyLZEwFTKy9sSO82zBDdb7RfBpGw4EGxHPD0pWcywhkpj6
         01x6PcSeK2IZLbyhgrVJ1USMbQPSlqRL3U438b68ya8EEDEMnqLLHU6JM35CzHv7wkEb
         wtGg==
X-Gm-Message-State: AOAM533yPgtrwMsPH00gDVBskZpg4g3Sjpp+VE87w+hyeDWflFnoQRFe
        2xugpFSRwlf3jrbMrYKm6+Q=
X-Google-Smtp-Source: ABdhPJx/ggMPCH51IrftsK9y1cPgkhUv+R069m7jS3KRVy9umySSHs81sjQixsJujPoFa5MRXG/wNw==
X-Received: by 2002:a17:906:a253:: with SMTP id bi19mr28201798ejb.338.1596010276279;
        Wed, 29 Jul 2020 01:11:16 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id v2sm1166890edb.95.2020.07.29.01.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 01:11:15 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [Linux-kernel-mentees] [PATCH] drm/amdgpu: Prevent
 kernel-infoleak in amdgpu_info_ioctl()
To:     Peilin Ye <yepeilin.cs@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Trek <trek00@inbox.ru>, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Evan Quan <evan.quan@amd.com>, Leo Liu <leo.liu@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Xiaojie Yuan <xiaojie.yuan@amd.com>
References: <20200728192924.441570-1-yepeilin.cs@gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <30b2a31f-77c2-56c1-ecde-875c6eea99d5@gmail.com>
Date:   Wed, 29 Jul 2020 10:11:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728192924.441570-1-yepeilin.cs@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 28.07.20 um 21:29 schrieb Peilin Ye:
> Compiler leaves a 4-byte hole near the end of `dev_info`, causing
> amdgpu_info_ioctl() to copy uninitialized kernel stack memory to userspace
> when `size` is greater than 356.
>
> In 2015 we tried to fix this issue by doing `= {};` on `dev_info`, which
> unfortunately does not initialize that 4-byte hole. Fix it by using
> memset() instead.
>
> Cc: stable@vger.kernel.org
> Fixes: c193fa91b918 ("drm/amdgpu: information leak in amdgpu_info_ioctl()")
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

I can't count how many of those we have fixed over the years.

At some point we should probably document that using "= {}" or "= { 0 }" 
in the kernel is a really bad idea and should be avoided.

Thanks,
Christian.

> ---
> $ pahole -C "drm_amdgpu_info_device" drivers/gpu/drm/amd/amdgpu/amdgpu_kms.o
> struct drm_amdgpu_info_device {
> 	__u32                      device_id;            /*     0     4 */
> 	__u32                      chip_rev;             /*     4     4 */
> 	__u32                      external_rev;         /*     8     4 */
> 	__u32                      pci_rev;              /*    12     4 */
> 	__u32                      family;               /*    16     4 */
> 	__u32                      num_shader_engines;   /*    20     4 */
> 	__u32                      num_shader_arrays_per_engine; /*    24     4 */
> 	__u32                      gpu_counter_freq;     /*    28     4 */
> 	__u64                      max_engine_clock;     /*    32     8 */
> 	__u64                      max_memory_clock;     /*    40     8 */
> 	__u32                      cu_active_number;     /*    48     4 */
> 	__u32                      cu_ao_mask;           /*    52     4 */
> 	__u32                      cu_bitmap[4][4];      /*    56    64 */
> 	/* --- cacheline 1 boundary (64 bytes) was 56 bytes ago --- */
> 	__u32                      enabled_rb_pipes_mask; /*   120     4 */
> 	__u32                      num_rb_pipes;         /*   124     4 */
> 	/* --- cacheline 2 boundary (128 bytes) --- */
> 	__u32                      num_hw_gfx_contexts;  /*   128     4 */
> 	__u32                      _pad;                 /*   132     4 */
> 	__u64                      ids_flags;            /*   136     8 */
> 	__u64                      virtual_address_offset; /*   144     8 */
> 	__u64                      virtual_address_max;  /*   152     8 */
> 	__u32                      virtual_address_alignment; /*   160     4 */
> 	__u32                      pte_fragment_size;    /*   164     4 */
> 	__u32                      gart_page_size;       /*   168     4 */
> 	__u32                      ce_ram_size;          /*   172     4 */
> 	__u32                      vram_type;            /*   176     4 */
> 	__u32                      vram_bit_width;       /*   180     4 */
> 	__u32                      vce_harvest_config;   /*   184     4 */
> 	__u32                      gc_double_offchip_lds_buf; /*   188     4 */
> 	/* --- cacheline 3 boundary (192 bytes) --- */
> 	__u64                      prim_buf_gpu_addr;    /*   192     8 */
> 	__u64                      pos_buf_gpu_addr;     /*   200     8 */
> 	__u64                      cntl_sb_buf_gpu_addr; /*   208     8 */
> 	__u64                      param_buf_gpu_addr;   /*   216     8 */
> 	__u32                      prim_buf_size;        /*   224     4 */
> 	__u32                      pos_buf_size;         /*   228     4 */
> 	__u32                      cntl_sb_buf_size;     /*   232     4 */
> 	__u32                      param_buf_size;       /*   236     4 */
> 	__u32                      wave_front_size;      /*   240     4 */
> 	__u32                      num_shader_visible_vgprs; /*   244     4 */
> 	__u32                      num_cu_per_sh;        /*   248     4 */
> 	__u32                      num_tcc_blocks;       /*   252     4 */
> 	/* --- cacheline 4 boundary (256 bytes) --- */
> 	__u32                      gs_vgt_table_depth;   /*   256     4 */
> 	__u32                      gs_prim_buffer_depth; /*   260     4 */
> 	__u32                      max_gs_waves_per_vgt; /*   264     4 */
> 	__u32                      _pad1;                /*   268     4 */
> 	__u32                      cu_ao_bitmap[4][4];   /*   272    64 */
> 	/* --- cacheline 5 boundary (320 bytes) was 16 bytes ago --- */
> 	__u64                      high_va_offset;       /*   336     8 */
> 	__u64                      high_va_max;          /*   344     8 */
> 	__u32                      pa_sc_tile_steering_override; /*   352     4 */
>
> 	/* XXX 4 bytes hole, try to pack */
>
> 	__u64                      tcc_disabled_mask;    /*   360     8 */
>
> 	/* size: 368, cachelines: 6, members: 49 */
> 	/* sum members: 364, holes: 1, sum holes: 4 */
> 	/* last cacheline: 48 bytes */
> };
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index a8c47aecd342..0047da06041f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -707,9 +707,10 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
>   		return n ? -EFAULT : 0;
>   	}
>   	case AMDGPU_INFO_DEV_INFO: {
> -		struct drm_amdgpu_info_device dev_info = {};
> +		struct drm_amdgpu_info_device dev_info;
>   		uint64_t vm_size;
>   
> +		memset(&dev_info, 0, sizeof(dev_info));
>   		dev_info.device_id = dev->pdev->device;
>   		dev_info.chip_rev = adev->rev_id;
>   		dev_info.external_rev = adev->external_rev_id;

