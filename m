Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951F3C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B1F24656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="TBt3N1CI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbgB0NpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:45:06 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:31464 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbgB0No4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:44:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id D06D83FFFB;
        Thu, 27 Feb 2020 14:44:53 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=TBt3N1CI;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O5L8o1vP0Boy; Thu, 27 Feb 2020 14:44:53 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id E48103FFFD;
        Thu, 27 Feb 2020 14:44:50 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 37648360058;
        Thu, 27 Feb 2020 14:44:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1582811090; bh=p0O7qg1HiipCWvP8nqnWxIx54P4BETutHnljdfP1p4g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TBt3N1CISeDTPgqNL1GPofJuBmCLEkHqs3jzcw52LvvJObksVGsOaFWLIcQGsf9nx
         mM5EA0rdFeR797YWf0ZuD0TGmFkywxVEIKm5Jr8GP/u/oylaEnn9oz3E3XZdB3Egj7
         74AZzV8/36LXlBZ9MtjWJCkNzH5ImvJ3iXeAYX2M=
Subject: Re: [PATCH v5 1/3] drm/shmem: add support for per object caching
 flags.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Guillaume.Gardet@arm.com,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        gurchetansingh@chromium.org, tzimmermann@suse.de, yuq825@gmail.com,
        noralf@tronnes.org, robh@kernel.org
References: <20200226154752.24328-1-kraxel@redhat.com>
 <20200226154752.24328-2-kraxel@redhat.com>
 <f1afba4b-9c06-48a3-42c7-046695947e91@shipmail.org>
 <20200227075321.ki74hfjpnsqv2yx2@sirius.home.kraxel.org>
 <41ca197c-136a-75d8-b269-801db44d4cba@shipmail.org>
 <20200227105643.h4klc3ybhpwv2l3x@sirius.home.kraxel.org>
 <68a05ace-40bc-76d6-5464-2c96328874b9@shipmail.org>
 <20200227132137.irruicvlkxpdo3so@sirius.home.kraxel.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <78eb099e-020f-91d1-672e-15176bf12cd4@shipmail.org>
Date:   Thu, 27 Feb 2020 14:44:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200227132137.irruicvlkxpdo3so@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/27/20 2:21 PM, Gerd Hoffmann wrote:
>    Hi,
>
>>> So I'd like to push patches 1+2 to -fixes and sort everything else later
>>> in -next.  OK?
>> OK with me.
> Done.
>
>>> [ context: why shmem helpers use pgprot_writecombine + pgprot_decrypted?
>>>             we get conflicting mappings because of that, linear kernel
>>>             map vs. gem object vmap/mmap ]
>> Do we have any idea what drivers are actually using
>> write-combine and decrypted?
> drivers/gpu/drm# find -name Kconfig* -print | xargs grep -l DRM_GEM_SHMEM_HELPER
> ./lima/Kconfig
> ./tiny/Kconfig
> ./cirrus/Kconfig
> ./Kconfig
> ./panfrost/Kconfig
> ./udl/Kconfig
> ./v3d/Kconfig
> ./virtio/Kconfig
>
> virtio needs cached.
> cirrus+udl should be ok with cached too.
>
> Not clue about the others (lima, tiny, panfrost, v3d).  Maybe they use
> write-combine just because this is what they got by default from
> drm_gem_mmap_obj().  Maybe they actually need that.  Trying to Cc:
> maintainters (and drop stable@).
>
> On decrypted: I guess that is only relevant for virtual machines, i.e.
> virtio-gpu and cirrus?
>
> virtio-gpu needs it, otherwise the host can't show the virtual display.
> cirrus bounces everything via blits to vram, so it should be ok without
> decrypted.  I guess that implies we should make decrypted configurable.

Decrypted here is clearly incorrect and violates the SEV spec, 
regardless of a config option.
The only correct way is currently to use dma_alloc_coherent() and 
mmap_coherent() to allocate decrypted memory and then use the 
pgprot_decrypted flag.

Since the same page is aliased with two physical addresses (one 
encrypted and one decrypted) switching memory from one to the other 
needs extensive handling even to flush stale vmaps...

So if virtio-gpu needs it for some bos, it should move away from shmem 
for those bos.

/Thomas



>
> cheers,
>    Gerd


