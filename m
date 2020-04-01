Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A44C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF322077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="IfBVo0qt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbgDAItk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:49:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41837 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgDAItk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:49:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id v1so28673967edq.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 01:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7+9v32j9cPB3QX5vXPFoTYuOQMb+jFtKmzdafzKlXc=;
        b=IfBVo0qtkzx0IwrTLjMKGmOczvAfIcGCXFrucXhdytTeaMv3LlGABrbnLscvf6EhPu
         ZipNSAsdlrGbSXI2CqQreu8FxLOGRWD8tJDVQkXpETIdmXHwd+Xv1jp44fy/mtTN32kt
         fVa09PGK306kWlrf3zKeHF07SGJb0bHLqW0CIkn37zcb7BIrEg+bNikwEXJacTI+GagZ
         hpxLEcN73/j3YUhCKXBElj08nNWzPs0hV3h929pXH5yevZyR1Cqzb0EOT5jcy3jgbKE7
         d2Ahuxp5GjmVR/tbuNADZWn5ZmlTpD668O9WqG3hIA5ukj8ZWJtmtna2sM5J2LzKH6Sn
         jAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7+9v32j9cPB3QX5vXPFoTYuOQMb+jFtKmzdafzKlXc=;
        b=hr/GhO4OZcxRFAhVLtuxDBVa4e3hmR1XMHh08Ps0lovoUglw1wCyjWTmQ2C4WCFE3j
         bbMd9/JqvSh0OOTde0C56K07XgQYpG+Jx43nq3DIZAFgd+Mlt0UU4HDgZbqpi9fxa1K3
         ezTlw8jGXVfqFQgzUMehidYjiZa/BsVPkhE4+9kNqJIUnYky7mJLNo/lC0h5yxLKHFW1
         yogpnQJSFtsBc2Q5kXRp4EHCcJS16CuZMuyLvkM7eO7jl2Ogr7YQ3XnI+vzD2qbHmSiV
         xFz3mgwAHB4yI2Ui990xqzaiQXcQs1XMN0JomTC6ovz3Uxfy4toDBWb1PNhuJIRveS9v
         +LdA==
X-Gm-Message-State: ANhLgQ1ZIPR57qG7hqy0cDnKaFCJjN2mo8KmCuBQFH7GsIB7kqMLo74Z
        NSx+Eth+H1imGMR+rDV76NREEU0ht2o+m3CyQZ5oqw==
X-Google-Smtp-Source: ADFU+vvi5v9sHbdO0IWcuuBEvZqkCqjH7pX1tPN0HKLi97q9NYRu1C93IYlcqCprR6w1SOFMCMFSMzwhs34udzF7ni0=
X-Received: by 2002:a17:906:1e42:: with SMTP id i2mr18635550ejj.317.1585730979486;
 Wed, 01 Apr 2020 01:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-9-alastair@d-silva.org>
In-Reply-To: <20200327071202.2159885-9-alastair@d-silva.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 1 Apr 2020 01:49:28 -0700
Message-ID: <CAPcyv4j4_owxEVjanwH5TiuMMJB3CaMannDzpXnaHedX7LuarQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/25] ocxl: Emit a log message showing how much LPC
 memory was detected
To:     "Alastair D'Silva" <alastair@d-silva.org>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva <alastair@d-silva.org> wrote:
>
> This patch emits a message showing how much LPC memory & special purpose
> memory was detected on an OCXL device.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Acked-by: Andrew Donnellan <ajd@linux.ibm.com>
> ---
>  drivers/misc/ocxl/config.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
> index a62e3d7db2bf..69cca341d446 100644
> --- a/drivers/misc/ocxl/config.c
> +++ b/drivers/misc/ocxl/config.c
> @@ -568,6 +568,10 @@ static int read_afu_lpc_memory_info(struct pci_dev *dev,
>                 afu->special_purpose_mem_size =
>                         total_mem_size - lpc_mem_size;
>         }
> +
> +       dev_info(&dev->dev, "Probed LPC memory of %#llx bytes and special purpose memory of %#llx bytes\n",
> +                afu->lpc_mem_size, afu->special_purpose_mem_size);

A patch for a single log message is too fine grained for my taste,
let's squash this into another patch in the series.

> +
>         return 0;
>  }
>
> --
> 2.24.1
>
