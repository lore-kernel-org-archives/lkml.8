Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCF0C43459
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91D9120656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnBLXKs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732818AbgG1Tbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732685AbgG1Tbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:31:34 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D06C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:31:34 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o22so15529881qtt.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UjriuwUrFe3JnfpGcdrsyLfiemXOEMJgHirDygAb170=;
        b=DnBLXKs29zvI1lqMHtzOQmUYICRL0HV7SdVxAYUWpDzp+OeQNWAsihxrWRmrLqx5hw
         V/mz4yk8dR+/HiOKLkukQF+iH/1wV+lXCEU5IpLdFR+Nr4KvMDIOV4IpAaa4Sc1a6cI5
         uEZO4sFf0YAiOi8NlYlVXqof05YNkMYlNhcHzOKDtCcZgqKaN6JLihS+FXwhlVssJ5nC
         ZFXXkrQW6Ck691VYbNY77aXTTJSUE5cW+/D4gUKH18Q3ilU7/qdTfRP2V7nhHjvdKcId
         H4TbmeefL4EYTkjGeTSy9mhEGEPi9HlVpoHAxyxY/VcwiFn4Ff4lVcQlgQoqlJlIfzS/
         UcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UjriuwUrFe3JnfpGcdrsyLfiemXOEMJgHirDygAb170=;
        b=NEr5ukZ+4QYwBvyBHOa9oLNo37Ui2EnKS2tquI0cTuBQtSmmQBI/yPh0UVTGe0Kc0S
         MeqYPIEVLB3AkIFnst+E90eMgi0ZNTv6BoEQ549FUexLdUfLRJT8H2FUS1MCrZidMuyU
         u/uBl64humFVm6TgZQs1aST7Wd/WEIZ32rv3Zo9xJxecQD1DS3Zkjj/d4urvVCtpLj/X
         zVmzQr+Al5KHKbwRghnBYcHWN4mBqqcqfTiSvO9LL+9b503CkNJ2q0YqDGyYlv7IbwcM
         DoHxoueXZjHjKyBMmgle8ofGaTiEdtDejiTC+41BlpaYOQOkTyKqUmr5RtEVg7iYSuf5
         bsYQ==
X-Gm-Message-State: AOAM532q7Vt6ydMzlBOYJg06sMrfzm0QvY/lQbulOlqVXLmqQta9xh+Z
        QMmdtYolAgklK89HzJpiCQ==
X-Google-Smtp-Source: ABdhPJwlAVn0RKlarj2u/vVBCsz1lO9982RRjCktsDisJ/Vchh3TVzj5DBbDoXFoTnmL0GLH7OmGGA==
X-Received: by 2002:ac8:6f4a:: with SMTP id n10mr24304675qtv.363.1595964693541;
        Tue, 28 Jul 2020 12:31:33 -0700 (PDT)
Received: from localhost.localdomain (c-76-119-149-155.hsd1.ma.comcast.net. [76.119.149.155])
        by smtp.gmail.com with ESMTPSA id k48sm21410544qtc.14.2020.07.28.12.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:31:33 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Evan Quan <evan.quan@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Xiaojie Yuan <xiaojie.yuan@amd.com>,
        =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
        Trek <trek00@inbox.ru>, Leo Liu <leo.liu@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH] drm/amdgpu: Prevent kernel-infoleak in amdgpu_info_ioctl()
Date:   Tue, 28 Jul 2020 15:29:24 -0400
Message-Id: <20200728192924.441570-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiler leaves a 4-byte hole near the end of `dev_info`, causing
amdgpu_info_ioctl() to copy uninitialized kernel stack memory to userspace
when `size` is greater than 356.

In 2015 we tried to fix this issue by doing `= {};` on `dev_info`, which
unfortunately does not initialize that 4-byte hole. Fix it by using
memset() instead.

Cc: stable@vger.kernel.org
Fixes: c193fa91b918 ("drm/amdgpu: information leak in amdgpu_info_ioctl()")
Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
$ pahole -C "drm_amdgpu_info_device" drivers/gpu/drm/amd/amdgpu/amdgpu_kms.o
struct drm_amdgpu_info_device {
	__u32                      device_id;            /*     0     4 */
	__u32                      chip_rev;             /*     4     4 */
	__u32                      external_rev;         /*     8     4 */
	__u32                      pci_rev;              /*    12     4 */
	__u32                      family;               /*    16     4 */
	__u32                      num_shader_engines;   /*    20     4 */
	__u32                      num_shader_arrays_per_engine; /*    24     4 */
	__u32                      gpu_counter_freq;     /*    28     4 */
	__u64                      max_engine_clock;     /*    32     8 */
	__u64                      max_memory_clock;     /*    40     8 */
	__u32                      cu_active_number;     /*    48     4 */
	__u32                      cu_ao_mask;           /*    52     4 */
	__u32                      cu_bitmap[4][4];      /*    56    64 */
	/* --- cacheline 1 boundary (64 bytes) was 56 bytes ago --- */
	__u32                      enabled_rb_pipes_mask; /*   120     4 */
	__u32                      num_rb_pipes;         /*   124     4 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	__u32                      num_hw_gfx_contexts;  /*   128     4 */
	__u32                      _pad;                 /*   132     4 */
	__u64                      ids_flags;            /*   136     8 */
	__u64                      virtual_address_offset; /*   144     8 */
	__u64                      virtual_address_max;  /*   152     8 */
	__u32                      virtual_address_alignment; /*   160     4 */
	__u32                      pte_fragment_size;    /*   164     4 */
	__u32                      gart_page_size;       /*   168     4 */
	__u32                      ce_ram_size;          /*   172     4 */
	__u32                      vram_type;            /*   176     4 */
	__u32                      vram_bit_width;       /*   180     4 */
	__u32                      vce_harvest_config;   /*   184     4 */
	__u32                      gc_double_offchip_lds_buf; /*   188     4 */
	/* --- cacheline 3 boundary (192 bytes) --- */
	__u64                      prim_buf_gpu_addr;    /*   192     8 */
	__u64                      pos_buf_gpu_addr;     /*   200     8 */
	__u64                      cntl_sb_buf_gpu_addr; /*   208     8 */
	__u64                      param_buf_gpu_addr;   /*   216     8 */
	__u32                      prim_buf_size;        /*   224     4 */
	__u32                      pos_buf_size;         /*   228     4 */
	__u32                      cntl_sb_buf_size;     /*   232     4 */
	__u32                      param_buf_size;       /*   236     4 */
	__u32                      wave_front_size;      /*   240     4 */
	__u32                      num_shader_visible_vgprs; /*   244     4 */
	__u32                      num_cu_per_sh;        /*   248     4 */
	__u32                      num_tcc_blocks;       /*   252     4 */
	/* --- cacheline 4 boundary (256 bytes) --- */
	__u32                      gs_vgt_table_depth;   /*   256     4 */
	__u32                      gs_prim_buffer_depth; /*   260     4 */
	__u32                      max_gs_waves_per_vgt; /*   264     4 */
	__u32                      _pad1;                /*   268     4 */
	__u32                      cu_ao_bitmap[4][4];   /*   272    64 */
	/* --- cacheline 5 boundary (320 bytes) was 16 bytes ago --- */
	__u64                      high_va_offset;       /*   336     8 */
	__u64                      high_va_max;          /*   344     8 */
	__u32                      pa_sc_tile_steering_override; /*   352     4 */

	/* XXX 4 bytes hole, try to pack */

	__u64                      tcc_disabled_mask;    /*   360     8 */

	/* size: 368, cachelines: 6, members: 49 */
	/* sum members: 364, holes: 1, sum holes: 4 */
	/* last cacheline: 48 bytes */
};

 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index a8c47aecd342..0047da06041f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -707,9 +707,10 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
 		return n ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_DEV_INFO: {
-		struct drm_amdgpu_info_device dev_info = {};
+		struct drm_amdgpu_info_device dev_info;
 		uint64_t vm_size;
 
+		memset(&dev_info, 0, sizeof(dev_info));
 		dev_info.device_id = dev->pdev->device;
 		dev_info.chip_rev = adev->rev_id;
 		dev_info.external_rev = adev->external_rev_id;
-- 
2.25.1

