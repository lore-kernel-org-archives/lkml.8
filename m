Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3CBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5581206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyGs6QFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgGMJRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgGMJRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:17:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3102C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 02:17:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q15so12570081wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 02:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zVWNX6jCL5YsApWi0gzjueoWHB7cS6uF1CrE5V+21Hk=;
        b=QyGs6QFD5HNi46nVYCHY3dHWgLUTO5IYVC2Qo8Xb5zJhA35GtHo/WUagZHRyokC+BM
         NsvACHPtZTjAKemBzxP28+W+gbAjZnrWyzN5py/yAE8tDcnr3s5nJCgkKsnoZr7S42n+
         8JX52vdIf7+usHlGHKzVyaW1QyvV4HgzlVO/9LToxIR4ethmcAXyhT96KxlKKnuI0f6w
         OeJXi/Hx5nLDphl7PZZVmXzWMrrrJ8I+jJwbG53qEPCUrT1HzQ7Xspd7EcZApHLHR5UI
         jKrL9rRGDKjoV4OHvGH4umRUyFdiozAKG+aK+6Evv1qsdWK6JwyR0nWFJ6pjZ1mOx7lR
         J9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zVWNX6jCL5YsApWi0gzjueoWHB7cS6uF1CrE5V+21Hk=;
        b=l4yKjPCwY+7jZ9NyxEo30+liG8DqAg/vRClj6jplV0ijDg3kE04RzSJ7m0EmGjjpE8
         RSaOppUTEIaa68ej5MMETlAltsqXvdatqHAeOxZBlpjQ1cIHgbXVNBYxAjdpyVHWx52z
         7vFRt8dY+bZJpf0MGQZWcDgW9wS4ntCtrRPhRW3P0wI32CrRHJAxqVavoZVeXcOvRhRO
         p4Ww38Mmy39mc8FoMb7J4a475DZ95qPqAcGCnXq1ZtOgIPaIJUVgZTJ+AZPoJsc2ZXcy
         x/y53+RJdeMFIa0G7HYyWx//jEO4LrT7W0U/Us9Ui+qoQiSzy7EcYK1kw0jbHCYzu7Qz
         ziBg==
X-Gm-Message-State: AOAM531ccDcHnTEBchCi1I0ovS8OUX1zKA4s8Z38x27UiOD40QISP6Dg
        rICHPVHu4k8rYf8GPwnrczy6UQ==
X-Google-Smtp-Source: ABdhPJxjpfdalXpGMYDzUxakshD9mtDyjOt6mXoXT6N6bvIa2DhgMFAiHm5CzZPMP/Xuovz6Zf0HaA==
X-Received: by 2002:a1c:a7c4:: with SMTP id q187mr17564334wme.0.1594631831206;
        Mon, 13 Jul 2020 02:17:11 -0700 (PDT)
Received: from dell ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id e23sm20860866wme.35.2020.07.13.02.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 02:17:10 -0700 (PDT)
Date:   Mon, 13 Jul 2020 10:17:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH 1/2] mfd: intel-m10-bmc: add Max10 BMC chip support for
 Intel FPGA PAC
Message-ID: <20200713091708.GC3500@dell>
References: <1594614896-16606-1-git-send-email-yilun.xu@intel.com>
 <1594614896-16606-2-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594614896-16606-2-git-send-email-yilun.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020, Xu Yilun wrote:

> This patch implements the basic functions of the BMC chip for some Intel
> FPGA PCIe Acceleration Cards (PAC). The BMC is implemented using the
> intel max10 CPLD.
> 
> This BMC chip is connected to FPGA by a SPI bus. To provide reliable
> register access from FPGA, an Avalon Memory-Mapped (Avmm) transaction
> protocol over the SPI bus is used between host and slave.
> 
> This driver implements the basic register access with the regmap framework.
> The mfd cells array is empty now as a placeholder.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  .../ABI/testing/sysfs-driver-intel-m10-bmc         |  15 +
>  drivers/mfd/Kconfig                                |  13 +
>  drivers/mfd/Makefile                               |   3 +
>  drivers/mfd/intel-m10-bmc-main.c                   | 176 ++++

>  drivers/mfd/intel-spi-avmm.c                       | 904 +++++++++++++++++++++

This does not belong in MFD.

Please consider moving it to drivers/spi.

>  drivers/mfd/intel-spi-avmm.h                       |  35 +
>  include/linux/mfd/intel-m10-bmc.h                  |  57 ++
>  7 files changed, 1203 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
>  create mode 100644 drivers/mfd/intel-m10-bmc-main.c
>  create mode 100644 drivers/mfd/intel-spi-avmm.c
>  create mode 100644 drivers/mfd/intel-spi-avmm.h
>  create mode 100644 include/linux/mfd/intel-m10-bmc.h

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
