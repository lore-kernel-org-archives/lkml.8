Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC52C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49FAA20663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgFVPuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:50:18 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:29100 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728293AbgFVPuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:50:18 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 22 Jun 2020 08:50:16 -0700
Received: from [0.0.0.0] (oddjob.vmware.com [10.253.4.32])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id EACDCB2759;
        Mon, 22 Jun 2020 11:50:15 -0400 (EDT)
Subject: Re: [PATCH][next] drm/vmwgfx: Use struct_size() helper
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20200617215144.GA15547@embeddedor>
From:   Roland Scheidegger <sroland@vmware.com>
Message-ID: <4064d1be-a181-039a-5423-34054b631c87@vmware.com>
Date:   Mon, 22 Jun 2020 17:50:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617215144.GA15547@embeddedor>
Content-Type: text/plain; charset="utf-8"
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Received-SPF: None (EX13-EDG-OU-001.vmware.com: sroland@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've commited this to our next branch, thanks!
(I'm actually kind of impressed this can be found automatically...)

Roland

Am 17.06.20 um 23:51 schrieb Gustavo A. R. Silva:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> index 126f93c0b0b8..3914bfee0533 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> @@ -1969,7 +1969,7 @@ static int vmw_surface_dirty_alloc(struct vmw_resource *res)
>  		num_mip = 1;
>  
>  	num_subres = num_layers * num_mip;
> -	dirty_size = sizeof(*dirty) + num_subres * sizeof(dirty->boxes[0]);
> +	dirty_size = struct_size(dirty, boxes, num_subres);
>  	acc_size = ttm_round_pot(dirty_size);
>  	ret = ttm_mem_global_alloc(vmw_mem_glob(res->dev_priv),
>  				   acc_size, &ctx);
> 

