Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89214C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6225420657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589826454;
	bh=vUexAKayig7hoQMTXHum2daB+jiGgP2Hd7w/7txXwSI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nIKfyxfCu9y+B3pwWyfvLsM4x+rmJdwwrXMPy9TksQSN6IqFQgkIWBNcWWyH+prHX
	 bSqs2BvQ8Uab9sXf9sA41JmXwXWdfRJ5xz8UBQ7xfnITvkARO2PRfysa7QqfGYznGv
	 ofZ+dQiloi5vNEGf/mRwOz7X5LhYBYCJlMZf11qE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbgERS1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731371AbgERS1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:27:25 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B2272065F;
        Mon, 18 May 2020 18:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589826444;
        bh=vUexAKayig7hoQMTXHum2daB+jiGgP2Hd7w/7txXwSI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jeqK2OJ6xFtqCNfN1ky7GwcFDsbDnhDlARUGcXd/rWqLG1sHGTSJARhdKe+3y/LCJ
         iHQseL6fG/6OqBdVnTsWEvNhB2EfPTXY6ZLceYvCD96AeJXHNC9pFJjEvD/JUuZCZd
         A1LlsKRgjQyaubXUtHLYEOujo3EDZJKJna3WYR0Q=
Received: by mail-oi1-f169.google.com with SMTP id l6so4016667oic.9;
        Mon, 18 May 2020 11:27:24 -0700 (PDT)
X-Gm-Message-State: AOAM530tR//h4pBrj2MsZ7gQmZ9F+cw2JY5PmF1z/eJDmmxADz0RC5fy
        AXxf9nDEkvr1tzkMXQMJGbBUgellaU+OgbpHYg==
X-Google-Smtp-Source: ABdhPJx3fgeoOHAumedf5oacXjRoxMizojAOnq9MnOT4ZX6kWsKK8ZqiKg8ShKAj1LLh0Vm4moDpvYl9CG1Oub20DaY=
X-Received: by 2002:aca:1904:: with SMTP id l4mr523744oii.106.1589826443359;
 Mon, 18 May 2020 11:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200513104615.7905-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200513104615.7905-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200514125709.GA8436@bogus> <dc51e6af-bda8-d8b9-1782-f5c4d5d3fed7@linux.intel.com>
In-Reply-To: <dc51e6af-bda8-d8b9-1782-f5c4d5d3fed7@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 18 May 2020 12:27:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJxqdi2MmyHZteMOpx5yy_o+ZxaqGHMUV7aCknWWQ0ptg@mail.gmail.com>
Message-ID: <CAL_JsqJxqdi2MmyHZteMOpx5yy_o+ZxaqGHMUV7aCknWWQ0ptg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: mtd: Add Nand Flash Controller
 support for Intel LGM SoC
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Vignesh R <vigneshr@ti.com>,
        "hauke.mehrtens" <hauke.mehrtens@intel.com>,
        devicetree@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        cheol.yong.kim@intel.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 8:08 PM Ramuthevar, Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> Hi Rob,
>
> On 14/5/2020 8:57 pm, Rob Herring wrote:
> > On Wed, 13 May 2020 18:46:14 +0800, Ramuthevar,Vadivel MuruganX wrote:
> >> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> >>
> >> Add YAML file for dt-bindings to support NAND Flash Controller
> >> on Intel's Lightning Mountain SoC.
> >>
> >> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> >> ---
> >>   .../devicetree/bindings/mtd/intel,lgm-nand.yaml    | 83 ++++++++++++++++++++++
> >>   1 file changed, 83 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
> >>
> >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/intel,lgm-nand.example.dt.yaml: nand-controller@e0f00000: 'dmas' is a dependency of 'dma-names'
> >
> > See https://patchwork.ozlabs.org/patch/1289160
> >
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure dt-schema is up to date:
> >
> > pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> >
> > Please check and re-submit.
> Thank you very much for review comments...
> I didn't find build errors, successfully built.

You need to build without DT_SCHEMA_FILES set or be on 5.7-rc (you
should be on a current -rcX at least for any patch submission). This
comes from the core schema.

Rob
