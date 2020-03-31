Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B070C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AFF2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="UC9I5RYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbgCaJrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:47:06 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39048 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbgCaJrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:47:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id a43so24316197edf.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 02:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wO/YEClVC4bznsIBM0aKMtzyOdSIvnqNmYs0tYYay5M=;
        b=UC9I5RYMTF9x470AM1vJkHEv3YFBzuEm+FqIWOG/BDt9pFSYSGnVQjRsEFfxYkIldW
         ZscYl4LsMwSzzOTh8nIeqrzHD7Oh7pqttet3w4SCRe3OYIG7Ny361CTK6RwOOwmH0gGe
         ozxk+sP06lknqjpKHsV05924QErWHKeyTMANMO7VXzsZeK0gvVcPjNkk0S+62vwLZglR
         5CMR15ggQLeAy7lRjsTcMklLAjoU4ukEVz4Nd/sr4ayD7GynyLDYYC70Kp8JYRS3bD7R
         UDB21oAXgUKA44UJOy7qkB/qXCRijVo47sHBmX79YUxOCOykYol9sQ+A5tNwuK2/YyPw
         PHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wO/YEClVC4bznsIBM0aKMtzyOdSIvnqNmYs0tYYay5M=;
        b=gHuhq2E4JA4IyKkvBqhk13gBMlmR+HQvVxJL5NdCYIkqQdcYUQdriuIInTnG9KYbY2
         tWdD3BYqrLlENdkFJsMpaTrtU+aqmtJspNTjbpY7VGhQG02I1keySwARE7iiivKzX2kc
         yqvQmS82CRPjxUdl319jylAl7LViaSpXuyzXMVcdgwGvMa7GcqEhW03nx03l1e19+4TR
         vJqsvW4Mv6MQQnTyjc3JlSFr34MrLmstCrmxjLFKXOTQn5Z+i0lHnAzYs3aqY8e/fZ1A
         4wT3hhr6i1paudGM2xv1KKk9N13RVNofrtW++ukQqFCr3ER2HBOEFN5Kzdj/Dq3kluGR
         ZNuw==
X-Gm-Message-State: ANhLgQ3EZQAUwSPpiaNRG0gkQKBl073PllNe+v7xbW98L9G1CVd47vA3
        54QWdU7a48mY/+7vDclCYGikof+gOfDadDQRFXCWIA==
X-Google-Smtp-Source: ADFU+vvWqY2t1S0J4+IMaqLr+k2IqBAvI8NNneKhMPlo68uUyWVmxyn+o59Vbw4OGtjBIdtjhl5p3Eu+2+tXyuBD4KE=
X-Received: by 2002:a17:906:1e42:: with SMTP id i2mr14186705ejj.317.1585648023325;
 Tue, 31 Mar 2020 02:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200330141943.31696-1-yuehaibing@huawei.com>
In-Reply-To: <20200330141943.31696-1-yuehaibing@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 31 Mar 2020 02:46:52 -0700
Message-ID: <CAPcyv4jTTDHLpnLArL_YvnSr+FAVVOi0Xs4Wv3dBF-cgQrx7zw@mail.gmail.com>
Subject: Re: [PATCH -next] libnvdimm/region: Fix build error
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        jmoyer <jmoyer@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 7:23 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> On CONFIG_PPC32=3Dy build fails:
>
> drivers/nvdimm/region_devs.c:1034:14: note: in expansion of macro =E2=80=
=98do_div=E2=80=99
>   remainder =3D do_div(per_mapping, mappings);
>               ^~~~~~
> In file included from ./arch/powerpc/include/generated/asm/div64.h:1:0,
>                  from ./include/linux/kernel.h:18,
>                  from ./include/asm-generic/bug.h:19,
>                  from ./arch/powerpc/include/asm/bug.h:109,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/scatterlist.h:7,
>                  from drivers/nvdimm/region_devs.c:5:
> ./include/asm-generic/div64.h:243:22: error: passing argument 1 of =E2=80=
=98__div64_32=E2=80=99 from incompatible pointer type [-Werror=3Dincompatib=
le-pointer-types]
>    __rem =3D __div64_32(&(n), __base); \
>
> Use div_u64 instead of do_div to fix this.
>
> Fixes: 2522afb86a8c ("libnvdimm/region: Introduce an 'align' attribute")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/nvdimm/region_devs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index bf239e783940..2291f0649d27 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -564,7 +564,7 @@ static ssize_t align_store(struct device *dev,
>          * space for the namespace.
>          */
>         dpa =3D val;
> -       remainder =3D do_div(dpa, nd_region->ndr_mappings);
> +       remainder =3D div_u64(dpa, nd_region->ndr_mappings);

This is not an equivalent conversion.

    dpa =3D div_u64_rem(val, nd_region->ndr_mappings, &remainder);

>         if (!is_power_of_2(dpa) || dpa < PAGE_SIZE
>                         || val > region_size(nd_region) || remainder)
>                 return -EINVAL;
> @@ -1031,7 +1031,7 @@ static unsigned long default_align(struct nd_region=
 *nd_region)
>
>         mappings =3D max_t(u16, 1, nd_region->ndr_mappings);
>         per_mapping =3D align;
> -       remainder =3D do_div(per_mapping, mappings);
> +       remainder =3D div_u64(per_mapping, mappings);

Same problem here.
