Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9723EC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761EB20730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgDHPhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:37:22 -0400
Received: from smtprelay0160.hostedemail.com ([216.40.44.160]:34386 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727173AbgDHPhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:37:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 5739A18041E93;
        Wed,  8 Apr 2020 15:37:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bone48_22e7092f25135
X-Filterd-Recvd-Size: 2637
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 Apr 2020 15:37:19 +0000 (UTC)
Message-ID: <bfa1a07f6f2046d5edac80d282cc710328d84d72.camel@perches.com>
Subject: Re: [PATCH] drm/amd/amdgpu: add prefix for pr_* prints
From:   Joe Perches <joe@perches.com>
To:     Aurabindo Pillai <mail@aurabindo.in>, alexander.deucher@amd.com,
        christian.koenig@amd.com
Cc:     avid1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 08 Apr 2020 08:35:20 -0700
In-Reply-To: <20200408133735.7679-1-mail@aurabindo.in>
References: <20200408133735.7679-1-mail@aurabindo.in>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-08 at 09:37 -0400, Aurabindo Pillai wrote:
> amdgpu uses lots of pr_* calls for printing error messages.
> With this prefix, errors shall be more obvious to the end
> use regarding its origin, and may help debugging.
> 
> Prefix format:
> 
> [xxx.xxxxx] amdgpu: ...
[]
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
[]
> @@ -28,6 +28,12 @@
>  #ifndef __AMDGPU_H__
>  #define __AMDGPU_H__
>  
> +#ifdef pr_fmt
> +#undef pr_fmt
> +#endif
> +
> +#define pr_fmt(fmt) "amdgpu: " fmt
> +
>  #include "amdgpu_ctx.h"
>  
>  #include <linux/atomic.h>

All the embedded uses of "amdgpu:" in logging
messages should also be deleted.

$ git grep -P '(?:dev_|pr_).*"amdgpu:' drivers/gpu/drm/amd/amdgpu/
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:               pr_err("amdgpu: failed to validate PT BOs\n");
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:               pr_err("amdgpu: failed to validate PD\n");
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:                       pr_err("amdgpu: failed to kmap PD, ret=%d\n", ret);
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:             pr_info("amdgpu: switched on\n");
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:             pr_info("amdgpu: switched off\n");
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:                        dev_dbg(adev->dev, "amdgpu: using MSI/MSI-X.\n");
drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c:          dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n");
drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:          pr_warn("amdgpu: No suitable DMA available\n");
drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:          pr_warn("amdgpu: No suitable DMA available\n");



