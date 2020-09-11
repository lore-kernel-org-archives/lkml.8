Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C514C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B6E7221E3
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgIKIeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:34:37 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2808 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbgIKIed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:34:33 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id A585381FAEA908607A43;
        Fri, 11 Sep 2020 09:34:31 +0100 (IST)
Received: from localhost (10.52.125.200) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Fri, 11 Sep
 2020 09:34:31 +0100
Date:   Fri, 11 Sep 2020 09:32:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 26/30] iio: iio.h: fix a warning at the kernel-doc
 markup
Message-ID: <20200911093256.000047e1@Huawei.com>
In-Reply-To: <d8f2275c438c459ede4e6fba03ce719cc6ad898b.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
        <d8f2275c438c459ede4e6fba03ce719cc6ad898b.1599660067.git.mchehab+huawei@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.200]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Sep 2020 16:10:57 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> There's a warning at iio.h kernel-doc markup:
> 
> 	./include/linux/iio/iio.h:644: WARNING: Unknown target name: "devm".
> 
> Because it is using {devm_}foo notation. Well, this is not
> a valid kernel-doc notation. Also, it prevents creating hyperlinks
> to other documentation functions.
> 
> So, replace it to a better notation.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Not much going on in that file at the moment, so fine if Jon picks this
up directly.

Jonathan


> ---
>  include/linux/iio/iio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index e2df67a3b9ab..f1daaba9e706 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -641,7 +641,7 @@ static inline struct iio_dev *iio_device_get(struct iio_dev *indio_dev)
>   *
>   * This utility must be called between IIO device allocation
>   * (via devm_iio_device_alloc()) & IIO device registration
> - * (via {devm_}iio_device_register()).
> + * (via iio_device_register() and devm_iio_device_register())).
>   * By default, the device allocation will also assign a parent device to
>   * the IIO device object. In cases where devm_iio_device_alloc() is used,
>   * sometimes the parent device must be different than the device used to


