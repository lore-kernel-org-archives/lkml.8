Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F999C3F2D4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 01:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8298246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 01:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMwLsgFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgCBB5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 20:57:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44196 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgCBB5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 20:57:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id n7so2591877wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 17:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=koYzLLduUmba6eMG7bH+rQzfjIuwoi5r0ur4pym6TH0=;
        b=iMwLsgFj3K0eb1Lcry5D5853IFFEeaZzlN+Gm8eR6NfIjL9JBT0l09mkm3axL++kTN
         wwdHvxIlXCyYwTq/b/ceTWHc4NllMm193PTu4wtNnaFZtE1USN6TGxm+HAR07ForsBUF
         Yf3gUOfMmmJF7F1UFgqVMVFqaot0VI7oBvcWbcTobFRWxLW7OC/sSYMpEHVQwldGcxnA
         3+dhVbLF/zJi/Ndzy/YhAsb6daygAHLKHN0sMqwj8CI4q20YHMqn2g4n2K8uCfI36LTl
         XQ1ak8cKnCeK6hBNJAwIycTbAVKJUr1UOpFM5oUlDMLuk3dwciglUu+EeGYvB1ISIs6y
         bPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=koYzLLduUmba6eMG7bH+rQzfjIuwoi5r0ur4pym6TH0=;
        b=HC8odOZRqpB0XP0DLGtp2iC5VULy5dyG6Ft3IDrLHM9EBVcIYfOii0kTVWDUbmWX/B
         4bhtPOqOHNWuhpE60yzZQFFSKjazQdiY8DnXfyyH5biEoVVCbp+BklZQIiMlrSUrCkAT
         7sdDlPyjGzxVTC7Ttx5ycae8F/wlw7b9e55rKb0bH5SJCiKP3EM3Q8ZNf3/URsHwDT4A
         TPGOVp7gHGyRjZ79wuBhfGTIjbvvSfNex/cf3TEaQinsln9IQp2gA4XR9gFbvfo8Z0z3
         MklkrbNJ6Vx3klS/7xAnNoUPyPF51V/+kw345DJzFvChm+gf4gLXMHjTw5V21S0sZ0df
         eC0w==
X-Gm-Message-State: APjAAAXNckU4aKZCUqFQeWCKYxTUV7811T7iU0Hxf9p89Y5dP2BRP7h1
        HgFLGU117YVikIaZhkupuaoHU/3uEmMCArla+VQ=
X-Google-Smtp-Source: APXvYqxJzEwpgt1LXARvHWp3jh60dA/3V791RFq3GRpzRGZeLV7uNd3+Sak8ahmhpHu1tX1DrAWAfPoA/BGfuvBwP+4=
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr13851705wrx.182.1583114223320;
 Sun, 01 Mar 2020 17:57:03 -0800 (PST)
MIME-Version: 1.0
References: <20200226154752.24328-1-kraxel@redhat.com> <20200226154752.24328-2-kraxel@redhat.com>
 <f1afba4b-9c06-48a3-42c7-046695947e91@shipmail.org> <20200227075321.ki74hfjpnsqv2yx2@sirius.home.kraxel.org>
 <41ca197c-136a-75d8-b269-801db44d4cba@shipmail.org> <20200227105643.h4klc3ybhpwv2l3x@sirius.home.kraxel.org>
 <68a05ace-40bc-76d6-5464-2c96328874b9@shipmail.org> <20200227132137.irruicvlkxpdo3so@sirius.home.kraxel.org>
In-Reply-To: <20200227132137.irruicvlkxpdo3so@sirius.home.kraxel.org>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Mon, 2 Mar 2020 09:56:52 +0800
Message-ID: <CAKGbVbspOgJmKpuuNYTew-3LoT_Pr0rRNJVjzkd83c=UXTki1Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] drm/shmem: add support for per object caching flags.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Guillaume.Gardet@arm.com, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        gurchetansingh@chromium.org, tzimmermann@suse.de,
        noralf@tronnes.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 9:21 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > So I'd like to push patches 1+2 to -fixes and sort everything else later
> > > in -next.  OK?
> >
> > OK with me.
>
> Done.
>
> >> [ context: why shmem helpers use pgprot_writecombine + pgprot_decrypted?
> >>            we get conflicting mappings because of that, linear kernel
> >>            map vs. gem object vmap/mmap ]
>
> > Do we have any idea what drivers are actually using
> > write-combine and decrypted?
>
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
lima driver needs writecombine mapped buffer for GPU hardware
working properly due to CPU-GPU not cache coherent. Although we
haven't meet problems caused by kernel/user map conflict, but I
do admit it's a problem as I met with amdgpu+arm before.

With TTM we can control page allocated and create a pool for
writecombine pages, but seems shmem is not friendly with
writecombine pages.

Thanks,
Qiang
