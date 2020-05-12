Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF5BC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56573206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3vS9Aan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgELAMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 20:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728255AbgELAL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 20:11:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FE8C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 17:11:58 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id hi11so8635077pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 17:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vD9bAWKm0TsbLrMap8l5gp1TwER8GEwlHBT3cJWURJ0=;
        b=A3vS9AanzqTHedDnHkrlKHjJJPKbzJ481qfmYgNGQCT5/+iqlBJQ8sZHBLvmZMNlaD
         U8SJxFmOP31XeFbpsNsvljK9W4vgwkNLuD5GGO5+4XEe+dkEBmfjgSxdQoVYasVbTbcS
         2AwtXNhw9tdujY8v4Ka5SLlqc0Kb8TBgwMktWmcg+tsQgkPPzXv1JWqP6l5shhuk6rhh
         CxECvWV+XGhzo3dUyY2fjuShqsCCl5GJNKpKigwNxdCC40PgsGNHu8qSPIUgCG28/9Kc
         R+mCvUboHQWRekfz+AUgjpnhPf1yM8Y4oQfx1CWSaXT/gQLLI4BEMBvqFpYfTI0r8SGf
         9XqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vD9bAWKm0TsbLrMap8l5gp1TwER8GEwlHBT3cJWURJ0=;
        b=n/4+98pm3k6lLTnql2+b0hTwVLdMCIiOw005OAcXxUUmSvl9lfkkkVfupR4HoHkngf
         RD4NU60QyYSDkuVk2KBYp8AcgqM9xKnsyqGdnbMwvbXWxm9DZroko4hUOx3O0QP9Gj2E
         9On692gW+0Y6ypYpTY7/H32PTGQD+qHFpPNKTNhZwT7GIplEYQZnRRWKGyvtTkLsXYAg
         y9BoWy1X8Zu+EOh+fk64lATANEBqmHz7cY+l8Ovmwyv7EYybYN/lxdffn7/CU+blbxT/
         AI7SVZZBdmBTFDD/+AjctxaFxxA+L+lqALs1kYNbmV6pQLU3Z8PtjmSoaSJuZQV7DtxW
         fXSg==
X-Gm-Message-State: AGi0PuadVuFr6lvBRd9xeBLcinCBwP7rDbf5doh2klzGRWxpfDXHM6X5
        POMNC8id0tGY+qW281BPJOa2LA==
X-Google-Smtp-Source: APiQypLvk6MsGJTa1A0kGWCgqM1Q16u/OrBm7JPtAl8bp704ACdBitEEa1Efs7ZN7JLMElh0x+ew5g==
X-Received: by 2002:a17:90a:8a09:: with SMTP id w9mr24099337pjn.95.1589242317883;
        Mon, 11 May 2020 17:11:57 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c10sm10124975pfm.50.2020.05.11.17.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 17:11:57 -0700 (PDT)
Date:   Mon, 11 May 2020 17:10:23 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v6 4/5] remoteproc: ingenic: Added remoteproc driver
Message-ID: <20200512001023.GB5349@builder.lan>
References: <20200417170040.174319-1-paul@crapouillou.net>
 <20200417170040.174319-4-paul@crapouillou.net>
 <20200420063714.GA1868936@builder.lan>
 <WCA59Q.IXGX82YOG4GI2@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <WCA59Q.IXGX82YOG4GI2@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21 Apr 08:43 PDT 2020, Paul Cercueil wrote:

> Hi Bjorn,
> 
> Le dim. 19 avril 2020 à 23:37, Bjorn Andersson <bjorn.andersson@linaro.org>
> a écrit :
> > On Fri 17 Apr 10:00 PDT 2020, Paul Cercueil wrote:
> > 
> > >  This driver is used to boot, communicate with and load firmwares to
> > > the
> > >  MIPS co-processor found in the VPU hardware of the JZ47xx SoCs from
> > >  Ingenic.
> > > 
> > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > >  Signed-off-by: kbuild test robot <lkp@intel.com>
> > >  Signed-off-by: Julia Lawall <julia.lawall@lip6.fr>
> > 
> > Please read Documentation/process/submitting-patches.rst about
> > "Developer's Certificate of Origin".
> > 
> > I suspect that you incorporated review feedback on previous revisions
> > from kbuild and Julia, this is generally omitted from the actual commit
> > message.
> 
> Julia / kbuild sent a patch to fix an error in the driver, so my patch now
> has code from Julia / kbuild. That document clearly says that I should add
> their signed-off-by. Or what do you mean?
> 

We generally don't attribute people whom through code review affected
the outcome, unless perhaps it's significant.

But a bigger problem is that per "Developer's Certificate of Origin 1.1"
in submitting-patches.rst, what this says is:

1) You wrote the patch, in whole or in part and have the right to
   submit it to the public kernel. I.e. (a) and (d)

2) Then "kbuild test robot" claims that either it based it's
   contribution on your work, or that it forwards the unmodified work
   ((b) or (c)) and (d).

3) Then Julia again took the contribution from "kbuild test robot" and
   is claiming to follow either (b) or (c) - and (d).

Then somehow, after Julia stated that she dealt with the patch you
emailed it to me.

In order to claim that the three of you developed the patch together you
should add all three as "Co-developed-by:", in addition to the signed
off by.


But again, my recommendation is that you consider their input as "review
feedback" and just incorporate it in the patch without any additional
tags. You're still fulfilling the certificate of origin.

Regards,
Bjorn

> > >  Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > >  ---
> > > 
> > >  Notes:
> > >      v2: Remove exception for always-mapped memories
> > >      v3: - Use clk_bulk API
> > >      	- Move device-managed code to its own patch [3/4]
> > >      	- Move devicetree table right above ingenic_rproc_driver
> > >      	- Removed #ifdef CONFIG_OF around devicetree table
> > >      	- Removed .owner = THIS_MODULE in ingenic_rproc_driver
> > >      	- Removed useless platform_set_drvdata()
> > >      v4: - Add fix reported by Julia
> > >      	- Change Kconfig symbol to INGENIC_VPU_RPROC
> > >      	- Add documentation to struct vpu
> > >      	- disable_irq_nosync() -> disable_irq()
> > >      v5: No change
> > >      v6: Instead of prepare/unprepare callbacks, use PM runtime
> > > callbacks
> > > 
> > >   drivers/remoteproc/Kconfig         |   8 +
> > >   drivers/remoteproc/Makefile        |   1 +
> > >   drivers/remoteproc/ingenic_rproc.c | 282
> > > +++++++++++++++++++++++++++++
> > >   3 files changed, 291 insertions(+)
> > >   create mode 100644 drivers/remoteproc/ingenic_rproc.c
> > > 
> > >  diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > >  index fbaed079b299..31da3e6c6281 100644
> > >  --- a/drivers/remoteproc/Kconfig
> > >  +++ b/drivers/remoteproc/Kconfig
> > >  @@ -240,6 +240,14 @@ config STM32_RPROC
> > > 
> > >   	  This can be either built-in or a loadable module.
> > > 
> > >  +config INGENIC_VPU_RPROC
> > 
> > Please try to keep things alphabetically ordered.
> > 
> > >  +	tristate "Ingenic JZ47xx VPU remoteproc support"
> > >  +	depends on MIPS || COMPILE_TEST
> > >  +	help
> > >  +	  Say y or m here to support the VPU in the JZ47xx SoCs from
> > > Ingenic.
> > >  +	  This can be either built-in or a loadable module.
> > >  +	  If unsure say N.
> > >  +
> > >   endif # REMOTEPROC
> > > 
> > >   endmenu
> > [..]
> > >  diff --git a/drivers/remoteproc/ingenic_rproc.c
> > > b/drivers/remoteproc/ingenic_rproc.c
> > [..]
> > >  +/**
> > >  + * struct vpu - Ingenic VPU remoteproc private structure
> > >  + * @irq: interrupt number
> > >  + * @clks: pointers to the VPU and AUX clocks
> > 
> > aux_base is missing
> > 
> > >  + * @mem_info: array of struct vpu_mem_info, which contain the
> > > mapping info of
> > >  + *            each of the external memories
> > >  + * @dev: private pointer to the device
> > >  + */
> > >  +struct vpu {
> > >  +	int irq;
> > >  +	struct clk_bulk_data clks[2];
> > >  +	void __iomem *aux_base;
> > >  +	struct vpu_mem_info mem_info[ARRAY_SIZE(vpu_mem_map)];
> > >  +	struct device *dev;
> > >  +};
> > [..]
> > >  +static void *ingenic_rproc_da_to_va(struct rproc *rproc, u64 da,
> > > size_t len)
> > >  +{
> > >  +	struct vpu *vpu = rproc->priv;
> > >  +	void __iomem *va = NULL;
> > >  +	unsigned int i;
> > >  +
> > >  +	if (len <= 0)
> > 
> > len can't be negative (also, does it add value to check for and fail len
> > == 0?)
> > 
> > >  +		return NULL;
> > >  +
> > >  +	for (i = 0; i < ARRAY_SIZE(vpu_mem_map); i++) {
> > >  +		const struct vpu_mem_info *info = &vpu->mem_info[i];
> > >  +		const struct vpu_mem_map *map = info->map;
> > >  +
> > >  +		if (da >= map->da && (da + len) < (map->da + info->len)) {
> > >  +			va = info->base + (da - map->da);
> > >  +			break;
> > >  +		}
> > >  +	}
> > >  +
> > >  +	return (__force void *)va;
> > >  +}
> > [..]
> > >  +static struct platform_driver ingenic_rproc_driver = {
> > >  +	.probe = ingenic_rproc_probe,
> > >  +	.driver = {
> > >  +		.name = "ingenic-vpu",
> > >  +#ifdef CONFIG_PM
> > 
> > Please omit the #ifdef here.
> 
> If I do, then the PM callbacks will be compiled in even if CONFIG_PM is
> disabled. That means dead code and I see no reason why you would want that.
> 
> If you don't mind, I'd like to keep the #ifdef CONFIG_PM for now, until this
> patchset is merged: https://lkml.org/lkml/2020/4/13/582
> 
> Then it would become a one-liner:
> .pm = pm_ptr(&ingenic_rproc_pm),
> 
> Cheers,
> -Paul
> 
> > >  +		.pm = &ingenic_rproc_pm,
> > >  +#endif
> > >  +		.of_match_table = of_match_ptr(ingenic_rproc_of_matches),
> > 
> > Please omit the of_match_ptr()
> > 
> > Regards,
> > Bjorn
> > 
> > >  +	},
> > >  +};
> > >  +module_platform_driver(ingenic_rproc_driver);
> > >  +
> > >  +MODULE_LICENSE("GPL");
> > >  +MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
> > >  +MODULE_DESCRIPTION("Ingenic JZ47xx Remote Processor control
> > > driver");
> > >  --
> > >  2.25.1
> > > 
> 
> 
