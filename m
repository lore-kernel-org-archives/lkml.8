Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42106C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BD11205CB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvpjWhd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgIAIzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgIAIzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:55:08 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787E9C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 01:55:08 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id y2so511867ilp.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 01:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d8u+bBUivnnRT/2GGOxyKpzT/GBIGvxJ27fiHGNX228=;
        b=UvpjWhd8G2kPgF5D5eQHLAN6JpOZhfKgykyurIFmDoV5ERgF9W0Ckwc3WYHkEKzYSQ
         vkCVslyOGmN71UBW9T4z16Ci5K1Vw0zdUpw1LLx8r5VFk1jwLvDiYSEORzkqIghaDEzo
         mKYNXmdw3bfEDX4ohV74UZavc3L1fAiDefptKicpEtAhJaMUfSjppTikmIgXNUk4Ymw9
         JG5JL9Zss7KqLUc4dzuyblarmK9DDR7m3DmC8m8mWncTWlXfUiXe7RRAuWRjfWWH2DJ+
         Va+YzOioYSc6Bu3sNbAJQmYTMI3GjnxUwr2tNYdYkIjbEqt9DEC8T2NxxoJU5o6H2zxP
         dlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d8u+bBUivnnRT/2GGOxyKpzT/GBIGvxJ27fiHGNX228=;
        b=awC6R9HMqfxSkGWzFy1j4ZvrerncWwmAg7qLX077uD9AfiTKsQcBWcgBB/x1eVUgk/
         CwadPf9hcsY12IbTf7/rfV5TfB5U2GBLukh0J1d+G2Oqxbe0GCEqd37QEXEyRXKoYpHo
         4o8NoswfEk6P3pDqVUM+mS/OiXy41x0H/KgySVaQvrVRiXF/Kk7m9YAzpGIM507Q9scZ
         zuBNY3bK2kYC+1FirkbtGNtPYu0muJc3I21KEVTlV8G0EWzzoLHt4vn9T6gK+tmnsOTc
         Gkkj6PswSzVu7sB3JNdY6d4LmtG1FW0KIJ9kBbjny99xngEJkVNoq3xcZi7USkJfNcvW
         dXSg==
X-Gm-Message-State: AOAM5305upeagzoCBp7yB7SCu9A3EtEeQnvzf9prqimoljb4UV+cLtmL
        K70gEWfwADq+9Bq00tTes8RrNGBOZ4OeJsEnEi0=
X-Google-Smtp-Source: ABdhPJwp0CAa160ULiz0kc7ScfoUoQdYdKQDFLFkpfbxOti5zA88kx8eDPHqu5jG5O/5yyV9mb4YsNBcg7CWHvoBz2Q=
X-Received: by 2002:a92:444c:: with SMTP id a12mr419956ilm.143.1598950507394;
 Tue, 01 Sep 2020 01:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200901083326.21264-1-roger.pau@citrix.com> <20200901083326.21264-3-roger.pau@citrix.com>
In-Reply-To: <20200901083326.21264-3-roger.pau@citrix.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Tue, 1 Sep 2020 10:54:56 +0200
Message-ID: <CAM9Jb+g3=CbEC1QqdZj6ZqXZ78JsnrjPPV6+ATw7ewSCfa3b4w@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] memremap: rename MEMORY_DEVICE_DEVDAX to MEMORY_DEVICE_GENERIC
To:     Roger Pau Monne <roger.pau@citrix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>, Johannes Thumshirn
        <jthumshirn@suse.de>, Logan Gunthorpe" <logang@deltatee.com>,
        Juergen Gross <jgross@suse.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        xen-devel@lists.xenproject.org, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is in preparation for the logic behind MEMORY_DEVICE_DEVDAX also
> being used by non DAX devices.
>
> No functional change intended.
>
> Signed-off-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Acked-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: linux-nvdimm@lists.01.org
> Cc: xen-devel@lists.xenproject.org
> Cc: linux-mm@kvack.org
> ---
>  drivers/dax/device.c     | 2 +-
>  include/linux/memremap.h | 9 ++++-----
>  mm/memremap.c            | 2 +-
>  3 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> index 4c0af2eb7e19..1e89513f3c59 100644
> --- a/drivers/dax/device.c
> +++ b/drivers/dax/device.c
> @@ -429,7 +429,7 @@ int dev_dax_probe(struct device *dev)
>                 return -EBUSY;
>         }
>
> -       dev_dax->pgmap.type =3D MEMORY_DEVICE_DEVDAX;
> +       dev_dax->pgmap.type =3D MEMORY_DEVICE_GENERIC;
>         addr =3D devm_memremap_pages(dev, &dev_dax->pgmap);
>         if (IS_ERR(addr))
>                 return PTR_ERR(addr);
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 5f5b2df06e61..e5862746751b 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -46,11 +46,10 @@ struct vmem_altmap {
>   * wakeup is used to coordinate physical address space management (ex:
>   * fs truncate/hole punch) vs pinned pages (ex: device dma).
>   *
> - * MEMORY_DEVICE_DEVDAX:
> + * MEMORY_DEVICE_GENERIC:
>   * Host memory that has similar access semantics as System RAM i.e. DMA
> - * coherent and supports page pinning. In contrast to
> - * MEMORY_DEVICE_FS_DAX, this memory is access via a device-dax
> - * character device.
> + * coherent and supports page pinning. This is for example used by DAX d=
evices
> + * that expose memory using a character device.
>   *
>   * MEMORY_DEVICE_PCI_P2PDMA:
>   * Device memory residing in a PCI BAR intended for use with Peer-to-Pee=
r
> @@ -60,7 +59,7 @@ enum memory_type {
>         /* 0 is reserved to catch uninitialized type fields */
>         MEMORY_DEVICE_PRIVATE =3D 1,
>         MEMORY_DEVICE_FS_DAX,
> -       MEMORY_DEVICE_DEVDAX,
> +       MEMORY_DEVICE_GENERIC,
>         MEMORY_DEVICE_PCI_P2PDMA,
>  };
>
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 03e38b7a38f1..006dace60b1a 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -216,7 +216,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int n=
id)
>                         return ERR_PTR(-EINVAL);
>                 }
>                 break;
> -       case MEMORY_DEVICE_DEVDAX:
> +       case MEMORY_DEVICE_GENERIC:
>                 need_devmap_managed =3D false;
>                 break;
>         case MEMORY_DEVICE_PCI_P2PDMA:

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
