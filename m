Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5AAC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC8522527
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9ETdmVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbgIHP4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 11:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730934AbgIHPyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:54:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A8DC06179B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 05:05:29 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z4so18845504wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 05:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Dzf69p8DNT8Do9xrYpRbV+rMbyUvt/wN7daUUl+w+dg=;
        b=H9ETdmVI8BId28iTo3Zu6qZv/+rGY229afKm5vV9Z+QenIhPAYxe/hPK1MKwCytWBK
         j+Swk/rQsA7HSQjpSSmBUAOk40qoVfixEMbApR0gBkPQwERqpE2tmezN0hKDu+49PsEU
         KuBSdprN9XyHpjMBbsFidVMN6XaS/7sBEiVM6TUZ57yjMeM4M7Gy3J0fNzw9nb0XKZPB
         r8hAGwUB3HcJMtgMYYziVeThu5YWAmAJkiIk5UoZS97dVAsyN7LkHJBkaJtm9tlRVdbE
         IsqtUrErv531hDeDmm9Cay2noqilnb/a0iaT99OlepdJBI7V4Zs/pLpPINiYDcy1hLwt
         8NFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Dzf69p8DNT8Do9xrYpRbV+rMbyUvt/wN7daUUl+w+dg=;
        b=X1yIIFVNsS6S+IBqhCXG0k+MIjTNwQxRlRbLgj7Ao/nOORuTck8G4mbTh9QNgIsUco
         sDoPfNQfI1J73FeQFmHBCN2tBnNO1FPLS6ki05igKLVFXuz8lxXkBJrsEvpk1j22w3CX
         yDV8JJjHNfwDFtAEVLVUkCHF6zATSObQ+ADh0TQF3rJElhTfzw6sdTda1NcBB/RGIzU2
         rW05uQjh2Nh6iwFVtowNNo+mDb5P1t8tqMqalRwy56mzieL3DhQ1Qt0z8ToSHoBdVjGh
         nuG07YC/bhblf1QkvrdzHRMaRmLM+YivUBda1dWw/ZqABmodE2b4Tasec+N3uhqEWw7T
         HTxQ==
X-Gm-Message-State: AOAM531zMnD262RHHY+VVUjGxLN8cTBxN44HLXR/I8XdQgJvEMaE/bUZ
        1aH9PKK1ytD427mFue/5XkGK3hvTE8md+g==
X-Google-Smtp-Source: ABdhPJzzWcd0zTBjjYKwVxdn9+AR5zPayy2PhXx2uYvGZTGzGsGUFprCVJHUkyMp1UqcejiPTa0XgQ==
X-Received: by 2002:adf:dcd1:: with SMTP id x17mr28367403wrm.150.1599566727894;
        Tue, 08 Sep 2020 05:05:27 -0700 (PDT)
Received: from dell ([91.110.221.179])
        by smtp.gmail.com with ESMTPSA id h5sm33702555wrt.31.2020.09.08.05.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 05:05:27 -0700 (PDT)
Date:   Tue, 8 Sep 2020 13:05:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, mdf@kernel.org
Subject: Re: [PATCH v5] mfd: intel-m10-bmc: add Intel MAX 10 BMC chip support
 for Intel FPGA PAC
Message-ID: <20200908120524.GR4400@dell>
References: <1599491813-20819-1-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1599491813-20819-1-git-send-email-yilun.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Sep 2020, Xu Yilun wrote:

> This patch implements the basic functions of the BMC chip for some Intel
> FPGA PCIe Acceleration Cards (PAC). The BMC is implemented using the
> Intel MAX 10 CPLD.
> 
> This BMC chip is connected to the FPGA by a SPI bus. To provide direct
> register access from the FPGA, the "SPI slave to Avalon Master Bridge"
> (spi-avmm) IP is integrated in the chip. It converts encoded streams of
> bytes from the host to the internal register read/write on the Avalon
> bus. So This driver uses the regmap-spi-avmm for register accessing.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v2: Split out the regmap-spi-avmm part.
>     Rename the file intel-m10-bmc-main.c to intel-m10-bmc.c, cause
>      there is only one source file left for this module now.
> v3: Add the sub devices in mfd_cell.
>     Some minor fixes.
> v4: No change.
> v5: Changes the names of mfd_cell.
>     Use ATTRIBUTE_GROUPS() to simplify the code.
>     Use the generic 'ddata' for the instance of struct intel_m10bmc.
>     More comments to clarify the function check_m10bmc_version().
>     Some minor fixes.
> ---
>  .../ABI/testing/sysfs-driver-intel-m10-bmc         |  15 ++
>  drivers/mfd/Kconfig                                |  13 ++
>  drivers/mfd/Makefile                               |   2 +
>  drivers/mfd/intel-m10-bmc.c                        | 162 +++++++++++++++++++++
>  include/linux/mfd/intel-m10-bmc.h                  |  56 +++++++
>  5 files changed, 248 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
>  create mode 100644 drivers/mfd/intel-m10-bmc.c
>  create mode 100644 include/linux/mfd/intel-m10-bmc.h

Please see my replies for v4.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
