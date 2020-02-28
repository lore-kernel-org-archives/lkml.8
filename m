Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB497C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBB120732
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="dXA4qckv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgB1LPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:15:48 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:55063 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgB1LPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:15:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id ACB013F81C;
        Fri, 28 Feb 2020 12:15:46 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=dXA4qckv;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id d-1Dvl-SzUOP; Fri, 28 Feb 2020 12:15:45 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 3BB2B3F36B;
        Fri, 28 Feb 2020 12:15:43 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 8CA7C3600E5;
        Fri, 28 Feb 2020 12:15:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1582888543; bh=ArwgEIDl33P4ZVBnnUz1ZjkbHAQUFSsMubAJIywx/Dw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dXA4qckvxvs38papKi+Rq7RwtKShCBkWbmM74jOvNle/S8S8SMggwZ3W2PAfgRoHF
         3Z5Gf+870LYx97tW/GupcjknFHKl77ofdAqxwSmYdkK5KNwLBJeMGr2o6VAIiDSlOW
         N3SsxKv0uZx3szrA6HRq85S1yEs6lpRNOQMNF+yg=
Subject: Re: [PATCH] drm/shmem: drop pgprot_decrypted()
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20200228104723.18757-1-kraxel@redhat.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <997a1baa-dc71-47d3-6e93-4dc953844d68@shipmail.org>
Date:   Fri, 28 Feb 2020 12:15:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200228104723.18757-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/20 11:47 AM, Gerd Hoffmann wrote:
> Was added by commit 95cf9264d5f3 ("x86, drm, fbdev: Do not specify
> encrypted memory for video mappings"), then it was kept through various
> changes.
>
> While vram actually needs decrypted mappings this is not correct for
> shmem gem objects which live in main memory not io memory, so remove the
> call.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   drivers/gpu/drm/drm_gem_shmem_helper.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index aad9324dcf4f..df31e5782eed 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -548,7 +548,6 @@ int drm_gem_shmem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
>   	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
>   	if (!shmem->map_cached)
>   		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> -	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
>   	vma->vm_ops = &drm_gem_shmem_vm_ops;
>   
>   	return 0;

Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>

Thanks,

Thomas


