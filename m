Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E36C38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 273BF208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="TlkUwKhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgDQMMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:12:20 -0400
Received: from forward105j.mail.yandex.net ([5.45.198.248]:60906 "EHLO
        forward105j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726050AbgDQMMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:12:19 -0400
Received: from mxback4j.mail.yandex.net (mxback4j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10d])
        by forward105j.mail.yandex.net (Yandex) with ESMTP id 4F607B21D8B;
        Fri, 17 Apr 2020 15:12:16 +0300 (MSK)
Received: from myt5-aad1beefab42.qloud-c.yandex.net (myt5-aad1beefab42.qloud-c.yandex.net [2a02:6b8:c12:128:0:640:aad1:beef])
        by mxback4j.mail.yandex.net (mxback/Yandex) with ESMTP id cuuj3jBftG-CFe4FrvU;
        Fri, 17 Apr 2020 15:12:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1587125536;
        bh=jtSizO4+twdpIsx/d154x54u4OCPsuneVrmQDquqRBs=;
        h=In-Reply-To:Subject:Cc:To:From:References:Date:Message-ID;
        b=TlkUwKhYJ2Xf/4jQdKqYKhoBEYGsW4rImrnQsnUjniFW/echA8plv2aLNjbO4NFnI
         XjnuCPyCa43Jb5uCjE31X7VNt2x6fYYPKzc/vpetCFfPNL+DZXGV58lj/nl0Lt9cyb
         f3VzkF7wyrXrYC/8BB3prQamjmTSdvb+K9knQmkM=
Authentication-Results: mxback4j.mail.yandex.net; dkim=pass header.i=@maquefel.me
Received: by myt5-aad1beefab42.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id G9b4xQPTa7-CE2qoMQL;
        Fri, 17 Apr 2020 15:12:14 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Fri, 17 Apr 2020 15:11:32 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Nikita Shubin <NShubin@topcon.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] remoteproc: imx_rproc: set pc on start
Message-ID: <20200417151132.00005f8c@maquefel.me>
In-Reply-To: <20200414164519.GA24061@xps15>
References: <20200304142628.8471-1-NShubin@topcon.com>
        <20200406113310.3041-1-nikita.shubin@maquefel.me>
        <20200406113310.3041-2-nikita.shubin@maquefel.me>
        <20200414164519.GA24061@xps15>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 10:45:19 -0600
Mathieu Poirier <mathieu.poirier@linaro.org> wrote:

> Hi Nikita,
> 
> On Mon, Apr 06, 2020 at 02:33:08PM +0300, nikita.shubin@maquefel.me
> wrote:
> > In case elf file interrupt vector is not supposed to be at OCRAM_S,
> > it is needed to write elf entry point to OCRAM_S + 0x4, to boot M4
> > firmware.
> > 
> > Otherwise firmware located anywhere besides OCRAM_S won't boot.
> > 
> > The firmware must set stack poiner as first instruction:
> > 
> > Reset_Handler:
> >     ldr   sp, = __stack      /* set stack pointer */
> > 
> > Signed-off-by: Nikita Shubin <NShubin@topcon.com>
> 
> The address in the SoB has to match what is found in the "From:"
> field of the email header.  Checkpatch is complaining about that,
> something I would have expected to be fixed before sending this set
> out.
> 
> > ---
> >  drivers/remoteproc/imx_rproc.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/remoteproc/imx_rproc.c
> > b/drivers/remoteproc/imx_rproc.c index 3e72b6f38d4b..bebc58d0f711
> > 100644 --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -45,6 +45,8 @@
> >  
> >  #define IMX7D_RPROC_MEM_MAX		8
> >  
> > +#define IMX_BOOT_PC			0x4
> > +
> >  /**
> >   * struct imx_rproc_mem - slim internal memory structure
> >   * @cpu_addr: MPU virtual address of the memory region
> > @@ -85,6 +87,7 @@ struct imx_rproc {
> >  	const struct imx_rproc_dcfg	*dcfg;
> >  	struct imx_rproc_mem
> > mem[IMX7D_RPROC_MEM_MAX]; struct clk			*clk;
> > +	void __iomem			*bootreg;
> >  };
> >  
> >  static const struct imx_rproc_att imx_rproc_att_imx7d[] = {
> > @@ -162,11 +165,16 @@ static int imx_rproc_start(struct rproc
> > *rproc) struct device *dev = priv->dev;
> >  	int ret;
> >  
> > +	/* write entry point to program counter */
> > +	writel(rproc->bootaddr, priv->bootreg);
> 
> What happens on all the other IMX systems where this fix is not
> needed?  Will they continue to work properly?   

Mathieu you are totally correct imx6/imx7 use different addresses they
boot.

For imx7:
| On i.MX 7Dual/7Solo, the boot vector for the Cortex-M4 core is located
| at the start of the OCRAM_S (On Chip RAM - Secure) whose address is
| 0x0018_0000 from Cortex-A7.

For imx6:
| The Boot vector for the Cortex-M4 core is located at the start of the
| TCM_L whose address is 0x007F_8000 from the Cortex-A9. This is a
| different location than on the i.MX 7Dual/7Solo

But on imx7 0x0 is translated to 0x0018_0000 by imx_rproc_da_to_va, and
on imx7 0x0 is translated to 0x007F_8000, using imx_rproc_att_imx7d and 
imx_rproc_att_imx6sx respectively.

I have no information about IMX8 (i have found none available
publicity), but should be the same as Cortex-M boots from 0x0.

> 
> > +
> >  	ret = regmap_update_bits(priv->regmap, dcfg->src_reg,
> >  				 dcfg->src_mask, dcfg->src_start);
> >  	if (ret)
> >  		dev_err(dev, "Failed to enable M4!\n");
> >  
> > +	dev_info(&rproc->dev, "Started from 0x%x\n",
> > rproc->bootaddr); +
> >  	return ret;
> >  }
> >  
> > @@ -182,6 +190,9 @@ static int imx_rproc_stop(struct rproc *rproc)
> >  	if (ret)
> >  		dev_err(dev, "Failed to stop M4!\n");
> >  
> > +	/* clear entry points */
> > +	writel(0, priv->bootreg);
> > +
> >  	return ret;
> >  }
> >  
> > @@ -243,7 +254,8 @@ static void *imx_rproc_da_to_va(struct rproc
> > *rproc, u64 da, int len) static const struct rproc_ops
> > imx_rproc_ops = { .start		= imx_rproc_start,
> >  	.stop		= imx_rproc_stop,
> > -	.da_to_va       = imx_rproc_da_to_va,
> > +	.da_to_va	= imx_rproc_da_to_va,
> > +	.get_boot_addr	= rproc_elf_get_boot_addr,
> 
> How is this useful?  Sure it will set rproc->bootaddr in
> rproc_fw_boot() but what good does that do when it is invariably set
> again in imx_rproc_start() ? 
> 
> >  };
> >  
> >  static int imx_rproc_addr_init(struct imx_rproc *priv,
> > @@ -360,6 +372,8 @@ static int imx_rproc_probe(struct
> > platform_device *pdev) goto err_put_rproc;
> >  	}
> >  
> > +	priv->bootreg = imx_rproc_da_to_va(rproc, IMX_BOOT_PC,
> > sizeof(u32)); +
> >  	/*
> >  	 * clk for M4 block including memory. Should be
> >  	 * enabled before .start for FW transfer.
> > -- 
> > 2.25.1
> > 

