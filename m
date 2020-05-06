Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CD1C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 234EE2073A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBtT3US2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgEFNzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725966AbgEFNzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:55:42 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D51DC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 06:55:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h4so2697090wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 06:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+3oAtPFs43ESjLsbZr3Dpn642+6yy2HyqbhMQ/uWkgQ=;
        b=QBtT3US2wB0+P6qkUKEHcf+qSYLvrcyiOywAusoUhWPzr+yVeCq3cKgKK1janaInDI
         dfja6C/g2al0FlC939i/E6rMEXPK6b+QAxogY2/5mxCX8F8zNn0l+X7vS9+K+4Ul93Sx
         K9NBGbnft+iPVBlXY5Scy5cJ6o3XdgR2f2OYVh+Yj9vGvLm0CqyshvS9n7SSAsj71eLs
         wILnnLs1o3F5G1sqJwlCOjJTjcU2fcuP38XwFTRBf0inWlXKgCq/uICcR3YtO+vFNDtm
         O+Iq4NvrvxUoMyQufUEU6bYrHeMt46/YA8wSAVLZSBtZFdTe26OjpYFEmGnfWJdSlSQ9
         uNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+3oAtPFs43ESjLsbZr3Dpn642+6yy2HyqbhMQ/uWkgQ=;
        b=hhOjDbZjpfXfj02GSkktEXHTxpgla2Cejmr3+QVovWoQwAVuk72pjRGTycAWBwR5p0
         145hZT0bdTLsMB+koP2bu1fJEUGUQ2ZlbbPN4d9WDSQWXwoktUgMe8O35+J3AzXFxRla
         8zoJ5VWa+SCinhruTvMF0y1qlXBPJKVxeaTX2WRJFhDSoBfTW8nhIk1Z9mwJOE+axACZ
         ekT/MzQlTN0M2DvjfF+qLp6WWGsMMSTKaovORqSzm+J0OucnKk83KORsVIaPaJuMmsIu
         u0rXJNSemsU1nGj+fyNbiR6jGWIZozR+aUmLSU1LrylKC4yTwJejMWK/8rAkpyo3GwoI
         DHWg==
X-Gm-Message-State: AGi0PuZ7aiPmlLyZRTRsM2tzab0h0VtgEQFAb1j78cksPeCtrPACZ/b+
        d0s7fk6C9qsBGY43tR/EjRW1e3oyYyUnIgaFamGc0/JZPks=
X-Google-Smtp-Source: APiQypJOGE3rBsb/5sZNtnJekxBb8v8ckBwOqmMu2T2KcXkbgMCt9aqXpQAg4pdJ9tFju7ov96os4f3GqWLY0f4F8LQ=
X-Received: by 2002:a1c:7f91:: with SMTP id a139mr4338753wmd.164.1588773340849;
 Wed, 06 May 2020 06:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200504190227.18269-1-david@redhat.com> <20200504190227.18269-4-david@redhat.com>
In-Reply-To: <20200504190227.18269-4-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 6 May 2020 15:55:29 +0200
Message-ID: <CAM9Jb+h0VKOU5dSZ7ChzW_Z=tG+UGq-cY7ePPRQpFS1-GHZOgg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] device-dax: Add memory via add_memory_driver_managed()
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm@lists.01.org, kexec@lists.infradead.org,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Currently, when adding memory, we create entries in /sys/firmware/memmap/
> as "System RAM". This will lead to kexec-tools to add that memory to the
> fixed-up initial memmap for a kexec kernel (loaded via kexec_load()). The
> memory will be considered initial System RAM by the kexec'd kernel and
> can no longer be reconfigured. This is not what happens during a real
> reboot.
>
> Let's add our memory via add_memory_driver_managed() now, so we won't
> create entries in /sys/firmware/memmap/ and indicate the memory as
> "System RAM (kmem)" in /proc/iomem. This allows everybody (especially
> kexec-tools) to identify that this memory is special and has to be treated
> differently than ordinary (hotplugged) System RAM.
>
> Before configuring the namespace:
>         [root@localhost ~]# cat /proc/iomem
>         ...
>         140000000-33fffffff : Persistent Memory
>           140000000-33fffffff : namespace0.0
>         3280000000-32ffffffff : PCI Bus 0000:00
>
> After configuring the namespace:
>         [root@localhost ~]# cat /proc/iomem
>         ...
>         140000000-33fffffff : Persistent Memory
>           140000000-1481fffff : namespace0.0
>           148200000-33fffffff : dax0.0
>         3280000000-32ffffffff : PCI Bus 0000:00
>
> After loading kmem before this change:
>         [root@localhost ~]# cat /proc/iomem
>         ...
>         140000000-33fffffff : Persistent Memory
>           140000000-1481fffff : namespace0.0
>           150000000-33fffffff : dax0.0
>             150000000-33fffffff : System RAM
>         3280000000-32ffffffff : PCI Bus 0000:00
>
> After loading kmem after this change:
>         [root@localhost ~]# cat /proc/iomem
>         ...
>         140000000-33fffffff : Persistent Memory
>           140000000-1481fffff : namespace0.0
>           150000000-33fffffff : dax0.0
>             150000000-33fffffff : System RAM (kmem)
>         3280000000-32ffffffff : PCI Bus 0000:00
>
> After a proper reboot:
>         [root@localhost ~]# cat /proc/iomem
>         ...
>         140000000-33fffffff : Persistent Memory
>           140000000-1481fffff : namespace0.0
>           148200000-33fffffff : dax0.0
>         3280000000-32ffffffff : PCI Bus 0000:00
>
> Within the kexec kernel before this change:
>         [root@localhost ~]# cat /proc/iomem
>         ...
>         140000000-33fffffff : Persistent Memory
>           140000000-1481fffff : namespace0.0
>           150000000-33fffffff : System RAM
>         3280000000-32ffffffff : PCI Bus 0000:00
>
> Within the kexec kernel after this change:
>         [root@localhost ~]# cat /proc/iomem
>         ...
>         140000000-33fffffff : Persistent Memory
>           140000000-1481fffff : namespace0.0
>           148200000-33fffffff : dax0.0
>         3280000000-32ffffffff : PCI Bus 0000:00
>
> /sys/firmware/memmap/ before this change:
>         0000000000000000-000000000009fc00 (System RAM)
>         000000000009fc00-00000000000a0000 (Reserved)
>         00000000000f0000-0000000000100000 (Reserved)
>         0000000000100000-00000000bffdf000 (System RAM)
>         00000000bffdf000-00000000c0000000 (Reserved)
>         00000000feffc000-00000000ff000000 (Reserved)
>         00000000fffc0000-0000000100000000 (Reserved)
>         0000000100000000-0000000140000000 (System RAM)
>         0000000150000000-0000000340000000 (System RAM)
>
> /sys/firmware/memmap/ after a proper reboot:
>         0000000000000000-000000000009fc00 (System RAM)
>         000000000009fc00-00000000000a0000 (Reserved)
>         00000000000f0000-0000000000100000 (Reserved)
>         0000000000100000-00000000bffdf000 (System RAM)
>         00000000bffdf000-00000000c0000000 (Reserved)
>         00000000feffc000-00000000ff000000 (Reserved)
>         00000000fffc0000-0000000100000000 (Reserved)
>         0000000100000000-0000000140000000 (System RAM)
>
> /sys/firmware/memmap/ after this change:
>         0000000000000000-000000000009fc00 (System RAM)
>         000000000009fc00-00000000000a0000 (Reserved)
>         00000000000f0000-0000000000100000 (Reserved)
>         0000000000100000-00000000bffdf000 (System RAM)
>         00000000bffdf000-00000000c0000000 (Reserved)
>         00000000feffc000-00000000ff000000 (Reserved)
>         00000000fffc0000-0000000100000000 (Reserved)
>         0000000100000000-0000000140000000 (System RAM)
>
> kexec-tools already seem to basically ignore any System RAM that's not
> on top level when searching for areas to place kexec images - but also
> for determining crash areas to dump via kdump. Changing the resource name
> won't have an impact.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/dax/kmem.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 3d0a7e702c94..5a645a24e359 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -65,7 +65,13 @@ int dev_dax_kmem_probe(struct device *dev)
>         new_res->flags = IORESOURCE_SYSTEM_RAM;
>         new_res->name = dev_name(dev);
>
> -       rc = add_memory(numa_node, new_res->start, resource_size(new_res));
> +       /*
> +        * Ensure that future kexec'd kernels will not treat this as RAM
> +        * automatically.
> +        */
> +       rc = add_memory_driver_managed(numa_node, new_res->start,
> +                                      resource_size(new_res),
> +                                      "System RAM (kmem)");
>         if (rc) {
>                 release_resource(new_res);
>                 kfree(new_res);
> --

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.25.3
>
