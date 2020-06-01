Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A520AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832EE2065C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591025929;
	bh=C0KobNhQsbqQyjusaD9Mru5CNdSlm9q1OMIO3NR81+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DxDpTIUpSOmbpgC9OnaCg9B0BK7sHK4zT52W29RZh4JBv+3hOHzdlsd/4Z8rwtE48
	 opkm3n5NdSrY6MUaccmLZwvF7cnJnuNc/X5uozhWWm9b8OeXSMxVEubyy5qAiirRG3
	 dz/Qom2++B22ISKDamQJYZZNTDY0y0FRAdjabpOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgFAPit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:38:49 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44654 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgFAPir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:38:47 -0400
Received: by mail-io1-f66.google.com with SMTP id p20so7311570iop.11;
        Mon, 01 Jun 2020 08:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CDM37rioFaHDwFqAto2+Bw+wARtkcLP5WD+n2feLzXw=;
        b=XZhpnvt+LDmyo6/SbHgzmIj/fg/9nUqDi+EV39SGe/7VwYObqaz722SK6eXXP5S+1o
         /8XL4KIqvoBx/CL+wN3qPVP6q/8B/Nnhsrw/PSPYIUpVti2NFlp3O1gakk7OzAaUggY1
         3aiZOEl6skvuGmMm8g2xIuLdN/ZbLGRraOUARegU5R2j2i2x38/L/JLrmMFYQOXjd/C0
         1vJGPhdqm/E6UrtZsA540qjeJ8sijEFqpzsDCL9aGWqq2ND8rdDta8fM7/SlsItj16KL
         feBDz4jlRuks5KPic638WRBertpGi7bAL1XPmZvBgDLyyjfK/1LlZdG2bEVY+2mhgAYv
         0lYg==
X-Gm-Message-State: AOAM533ZVhCirngyweFPlDdvYYkgSiyzYyuRp0m4DpnZ/FMNB6e61RlE
        z/L8On1dxBt0sa1KnH9ZLA==
X-Google-Smtp-Source: ABdhPJzFApjLBdOEoq97wU671Fuxf5SQK6949rH8EWZ5Y/LYwbVomscZOA7JDF6HRFZfUOyYrPnk7g==
X-Received: by 2002:a5d:8cc1:: with SMTP id k1mr9372757iot.123.1591025926294;
        Mon, 01 Jun 2020 08:38:46 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id v17sm7452956iln.67.2020.06.01.08.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 08:38:45 -0700 (PDT)
Received: (nullmailer pid 955608 invoked by uid 1000);
        Mon, 01 Jun 2020 15:38:44 -0000
Date:   Mon, 1 Jun 2020 09:38:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     brendanhiggins@google.com, linux-mips@vger.kernel.org,
        linux-mtd@lists.infradead.org, tglx@linutronix.de,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, andriy.shevchenko@intel.com,
        anders.roxell@linaro.org, cheol.yong.kim@intel.com, arnd@arndb.de,
        boris.brezillon@collabora.com, qi-ming.wu@intel.com,
        linux-kernel@vger.kernel.org, richard@nod.at,
        masonccyang@mxic.com.tw, vigneshr@ti.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH v11 1/2] dt-bindings: mtd: Add Nand Flash Controller
 support for Intel LGM SoC
Message-ID: <20200601153844.GA955555@bogus>
References: <20200530005117.10986-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200530005117.10986-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530005117.10986-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 May 2020 08:51:16 +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add YAML file for dt-bindings to support NAND Flash Controller
> on Intel's Lightning Mountain SoC.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  .../devicetree/bindings/mtd/intel,lgm-nand.yaml    | 99 ++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
