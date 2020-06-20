Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365DFC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE9A22265
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592672123;
	bh=jh+Dtd6XxyvfeBpJwr5NXJeG+cGq9HQ6DALEAl2vhK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ndI2OyzAfHI6UrYqVo0OOhKCnm8MlJ3dsdXNltepLbJluWkoksjFtPH0c4mQxxCYP
	 WEUa1B7ioy07jxxNGjXfsUZ+A/aR7mj2gCLP+ksQ4P7P5X3SvWrGbAQ52Tq4ZUVxvf
	 CiYluOUDxF6v4EIJecF7EmjKqi0fvRPZNey52VsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgFTQzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgFTQzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:55:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63B9C206C1;
        Sat, 20 Jun 2020 16:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592672120;
        bh=jh+Dtd6XxyvfeBpJwr5NXJeG+cGq9HQ6DALEAl2vhK8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JPRzqSsXNNflaSN9W1VKLjKK2Tr5YQxLrly67XS/Qe764zuYMr+E9uH1bYZASM9Hv
         nA9zxaJ/PEbaeWS/EdE2E8sgv8IGN1OZPB2q9h/1cC4du8Aj50MfGUkH/37NFIzkO8
         b6E2rydpktC6hsBzvJSxhwYRnDREOCga+4RJ/QHw=
Date:   Sat, 20 Jun 2020 17:55:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     lee.jones@linaro.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        matthias.bgg@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, dmurphy@ti.com, lgirdwood@gmail.com,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Subject: Re: [PATCH v2 0/4] dt-bindings: mfd: Add bindings for the Mediatek
 MT6360
Message-ID: <20200620175512.1e11d12c@archlinux>
In-Reply-To: <1592567631-20363-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1592567631-20363-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 19:53:47 +0800
Gene Chen <gene.chen.richtek@gmail.com> wrote:

> This patch series add mt6360 sub-device adc/regulator and
> fix mfd architecture and add dt-binding document

Hi Gene

Please make sure you include linux-iio@vger.kernel.org in the cc list
for any iio related series.  For now I'll take a quick look at the
ADC driver patch (and +cc the list for my reply)

Thanks,

Jonathan

> 
> changelogs between v1 & v2
> - adjust binding document schema include mfd/adc/regulator
> - adc: use IIO_CHAN_INFO_PROCESSED only
> - adc: use devm_iio_triggered_buffer_setup
> - adc: use use s64 to record timestamp
> - regulator: merge regmap to mfd driver for r/w with crc
> 
> Gene Chen (4)
>   dt-bindings: mfd: Add bindings for the Mediatek MT6360
>   mfd: mt6360: implement i2c R/W with CRC
>   iio: adc: mt6360: Add ADC driver for MT6360
>   regulator: mt6360: Add support for MT6360 regulator
> 
>  Documentation/devicetree/bindings/mfd/mt6360.txt |  122 +++++
>  drivers/iio/adc/Kconfig                          |   11 
>  drivers/iio/adc/Makefile                         |    1 
>  drivers/iio/adc/mt6360-adc.c                     |  388 ++++++++++++++++
>  drivers/mfd/Kconfig                              |    1 
>  drivers/mfd/mt6360-core.c                        |  541 +++++++++++++++--------
>  drivers/regulator/Kconfig                        |    9 
>  drivers/regulator/Makefile                       |    1 
>  drivers/regulator/mt6360-regulator.c             |  485 ++++++++++++++++++++
>  include/dt-bindings/mfd/mt6360.h                 |   15 
>  include/linux/mfd/mt6360.h                       |  240 ----------
>  11 files changed, 1389 insertions(+), 425 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mt6360.txt
>  create mode 100644 include/dt-bindings/mfd/mt6360.h
>  delete mode 100644 include/linux/mfd/mt6360.h
>  create mode 100644 drivers/iio/adc/mt6360-adc.c
>  create mode 100644 drivers/regulator/mt6360-regulator.c

