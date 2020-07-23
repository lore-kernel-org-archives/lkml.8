Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA48C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FEFD22B43
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgGWIm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:42:57 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2513 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbgGWIm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:42:57 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id CAA78D7CF743FE7D3470;
        Thu, 23 Jul 2020 09:42:55 +0100 (IST)
Received: from localhost (10.52.125.229) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 23 Jul
 2020 09:42:55 +0100
Date:   Thu, 23 Jul 2020 09:41:34 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     David Gow <davidgow@google.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Dike <jdike@addtoit.com>, <rafael@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Richard Weinberger <richard@nod.at>,
        Brendan Higgins <brendanhiggins@google.com>,
        <kunit-dev@googlegroups.com>,
        linux-um <linux-um@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] platform: ioremap: Build iomap functions even
 without HAS_IOMEM
Message-ID: <20200723094134.0000432d@Huawei.com>
In-Reply-To: <20200721054528.2556267-1-davidgow@google.com>
References: <20200721054528.2556267-1-davidgow@google.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.229]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 22:45:28 -0700
David Gow <davidgow@google.com> wrote:

> A number of drivers use devm_platform_ioremap_resource(), but do not (or
> did not) explicitly depend on IOMEM[1,2]. Given that the only platform
> without HAS_IOMEM seems to be UML, and it has sufficient stubs for
> devm_platform_ioremap_resource() and its dependencies to build, we can
> remove the HAS_IOMEM requirement here, rather than playing whack-a-mole
> with different drivers which don't try to build against ARCH=um.
> 
> The reason this works at the moment is that stub ioremap and iounmap
> functions were added to UML to support this sort-of thing[3]. This
> particular change doesn't require adding any additional stubs, but there
> is possibly room in the future to stub out the remaining iomem functions
> (or to provide mock implementations for testing), and get rid of
> HAS_IOMEM entirely.
> 
> [1]: https://lkml.org/lkml/2020/6/30/176
> [2]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1e7468bd9d30a21e059af477106dc5588ae52dff
> [3]:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1405627.html

Hi David,

I don't quite follow why we change when iomap_copy.c is built.
Was this just a case of there not seeming to be any reason to protect it
or is there a direct dependency on something in there that I'm missing?

Otherwise looks good to me.

Jonathan

> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  drivers/base/platform.c | 2 --
>  lib/Makefile            | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index c0d0a5490ac6..628dde6675cf 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -61,7 +61,6 @@ struct resource *platform_get_resource(struct platform_device *dev,
>  }
>  EXPORT_SYMBOL_GPL(platform_get_resource);
>  
> -#ifdef CONFIG_HAS_IOMEM
>  /**
>   * devm_platform_get_and_ioremap_resource - call devm_ioremap_resource() for a
>   *					    platform device and get resource
> @@ -135,7 +134,6 @@ devm_platform_ioremap_resource_byname(struct platform_device *pdev,
>  	return devm_ioremap_resource(&pdev->dev, res);
>  }
>  EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
> -#endif /* CONFIG_HAS_IOMEM */
>  
>  /**
>   * platform_get_irq_optional - get an optional IRQ for a device
> diff --git a/lib/Makefile b/lib/Makefile
> index b1c42c10073b..35c21af33b93 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -115,7 +115,7 @@ obj-y += math/ crypto/
>  
>  obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
>  obj-$(CONFIG_GENERIC_PCI_IOMAP) += pci_iomap.o
> -obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
> +obj-y += iomap_copy.o devres.o
>  obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
>  obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
>  


