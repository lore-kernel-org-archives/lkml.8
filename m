Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B03EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56960207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgENIjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:39:40 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:7709 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbgENIjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:39:40 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 14 May 2020 01:39:35 -0700
Received: from [0.0.0.0] (oddjob.vmware.com [10.253.4.32])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 24D28B2723;
        Thu, 14 May 2020 04:39:35 -0400 (EDT)
Subject: Re: [Linux-graphics-maintainer] [PATCH] drm/vmwgfx: Return true in
 function vmw_fence_obj_signaled()
To:     Jason Yan <yanaijie@huawei.com>,
        <linux-graphics-maintainer@vmware.com>, <thellstrom@vmware.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <sumit.semwal@linaro.org>,
        <chris@chris-wilson.co.uk>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linaro-mm-sig@lists.linaro.org>
References: <20200507110714.37589-1-yanaijie@huawei.com>
From:   Roland Scheidegger <sroland@vmware.com>
Message-ID: <0b30cc20-95d4-009b-6c77-f1119d396e8b@vmware.com>
Date:   Thu, 14 May 2020 10:39:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20200507110714.37589-1-yanaijie@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Received-SPF: None (EX13-EDG-OU-001.vmware.com: sroland@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've pulled that into our tree, thanks!

Roland

Am 07.05.20 um 13:07 schrieb Jason Yan:
> Fix the following coccicheck warning:
> 
> drivers/gpu/drm/vmwgfx/vmwgfx_fence.c:518:9-10: WARNING: return of 0/1
> in function 'vmw_fence_obj_signaled' with return type bool
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> index 178a6cd1a06f..0f8d29397157 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> @@ -515,7 +515,7 @@ bool vmw_fence_obj_signaled(struct vmw_fence_obj *fence)
>  	struct vmw_fence_manager *fman = fman_from_fence(fence);
>  
>  	if (test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->base.flags))
> -		return 1;
> +		return true;
>  
>  	vmw_fences_update(fman);
>  
> 

