Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6F9C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 08:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9D52063A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 08:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgF1IuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 04:50:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:36504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgF1IuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 04:50:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 554A2B133;
        Sun, 28 Jun 2020 08:50:12 +0000 (UTC)
Subject: Re: [PATCH] efi: avoid error message when booting under Xen
To:     xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Peter Jones <pjones@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20200610141052.13258-1-jgross@suse.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <094be567-2c82-7d5b-e432-288286c6c3fb@suse.com>
Date:   Sun, 28 Jun 2020 10:50:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610141052.13258-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On 10.06.20 16:10, Juergen Gross wrote:
> efifb_probe() will issue an error message in case the kernel is booted
> as Xen dom0 from UEFI as EFI_MEMMAP won't be set in this case. Avoid
> that message by calling efi_mem_desc_lookup() only if EFI_PARAVIRT
> isn't set.
> 
> Fixes: 38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes when mapping the FB")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>   drivers/video/fbdev/efifb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 65491ae74808..f5eccd1373e9 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -453,7 +453,7 @@ static int efifb_probe(struct platform_device *dev)
>   	info->apertures->ranges[0].base = efifb_fix.smem_start;
>   	info->apertures->ranges[0].size = size_remap;
>   
> -	if (efi_enabled(EFI_BOOT) &&
> +	if (efi_enabled(EFI_BOOT) && !efi_enabled(EFI_PARAVIRT) &&
>   	    !efi_mem_desc_lookup(efifb_fix.smem_start, &md)) {
>   		if ((efifb_fix.smem_start + efifb_fix.smem_len) >
>   		    (md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT))) {
> 

