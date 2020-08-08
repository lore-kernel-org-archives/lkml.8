Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DBBC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 12:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D07020759
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 12:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596891588;
	bh=R/UBo6YQMScKcK3JGjcn2fU1IcxXF92oGNdPeAXLDCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2PnxHNmyLCZdXGuYOBrTM9t0emZtli9j44Dm7/mFEsCxL3w2ZCU8KNcpk7OnEc6GI
	 KYcFaDb8VJXiwxoQwmYSYIdy/DUduXKKPeS6Gt+F098zIf+U1I/MoJHkTcT97bFkLb
	 BNcC29QsaEALcGNjK86mRSUNJgdW7nkX74NOdVwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgHHM7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 08:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgHHM7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 08:59:46 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A2BB206E2;
        Sat,  8 Aug 2020 12:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596891584;
        bh=R/UBo6YQMScKcK3JGjcn2fU1IcxXF92oGNdPeAXLDCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fuih21lpdwSAASmUXSIt16p6O3nro+HWi0CZub5pXJ2WNUIAM+ciHAO2it9xpB6BX
         fIt3SIqeMc8MKyBsgWQ5xwa4707vLRj6AHROxw6Pdy3Y4mN5odqWnIHSvdapc2lzOi
         t4nzSxORQYwkF9swpNvwxhQKdlF3IsNjwlk6+ARU=
Date:   Sat, 8 Aug 2020 18:29:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     kernel test robot <lkp@intel.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/dma/pl330.c:2981:9: warning: Identical condition 'ret',
 second condition is always false
Message-ID: <20200808125940.GR12965@vkoul-mobl>
References: <202008081010.0bKKNfQp%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008081010.0bKKNfQp%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-08-20, 10:53, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   30185b69a2d533c4ba6ca926b8390ce7de495e29
> commit: a39cddc9e3775100100a4272feed64faac831be9 dmaengine: pl330: Drop boilerplate code for suspend/resume
> date:   8 months ago
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> cppcheck warnings: (new ones prefixed by >>)
> 
> >> drivers/dma/pl330.c:2981:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
>     return ret;
>            ^
>    drivers/dma/pl330.c:2976:6: note: first condition
>     if (ret)
>         ^
>    drivers/dma/pl330.c:2981:9: note: second condition
>     return ret;

This one could be fixed by making this as return 0, but is harmless


>            ^
> >> drivers/dma/pl330.c:2798:23: warning: Variable 'desc->rqcfg.brst_len' is reassigned a value before the old one has been used. [redundantAssignment]
>     desc->rqcfg.brst_len = get_burst_len(desc, len);
>                          ^
>    drivers/dma/pl330.c:2796:24: note: Variable 'desc->rqcfg.brst_len' is reassigned a value before the old one has been used.
>      desc->rqcfg.brst_len = 1;
>                           ^
>    drivers/dma/pl330.c:2798:23: note: Variable 'desc->rqcfg.brst_len' is reassigned a value before the old one has been used.
>     desc->rqcfg.brst_len = get_burst_len(desc, len);

This one actually seems like a bug. Reading the code I think
get_burst_len() should be called first before checking if burst size is
smaller and setting to 1 in that case

Sugar Zhang, Marek Szyprowski can you folks check this?

>                          ^
> 
> vim +/ret +2981 drivers/dma/pl330.c
> 
> 42bc9cf45939c2 Boojin Kim          2011-09-02  2753  
> b3040e40675ec2 Jassi Brar          2010-05-23  2754  static struct dma_async_tx_descriptor *
> b3040e40675ec2 Jassi Brar          2010-05-23  2755  pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
> b3040e40675ec2 Jassi Brar          2010-05-23  2756  		dma_addr_t src, size_t len, unsigned long flags)
> b3040e40675ec2 Jassi Brar          2010-05-23  2757  {
> b3040e40675ec2 Jassi Brar          2010-05-23  2758  	struct dma_pl330_desc *desc;
> b3040e40675ec2 Jassi Brar          2010-05-23  2759  	struct dma_pl330_chan *pch = to_pchan(chan);
> f5636854f3fcee Maninder Singh      2015-05-26  2760  	struct pl330_dmac *pl330;
> b3040e40675ec2 Jassi Brar          2010-05-23  2761  	int burst;
> b3040e40675ec2 Jassi Brar          2010-05-23  2762  
> 4e0e6109a1cc18 Rob Herring         2011-07-25  2763  	if (unlikely(!pch || !len))
> b3040e40675ec2 Jassi Brar          2010-05-23  2764  		return NULL;
> b3040e40675ec2 Jassi Brar          2010-05-23  2765  
> f5636854f3fcee Maninder Singh      2015-05-26  2766  	pl330 = pch->dmac;
> f5636854f3fcee Maninder Singh      2015-05-26  2767  
> b3040e40675ec2 Jassi Brar          2010-05-23  2768  	desc = __pl330_prep_dma_memcpy(pch, dst, src, len);
> b3040e40675ec2 Jassi Brar          2010-05-23  2769  	if (!desc)
> b3040e40675ec2 Jassi Brar          2010-05-23  2770  		return NULL;
> b3040e40675ec2 Jassi Brar          2010-05-23  2771  
> b3040e40675ec2 Jassi Brar          2010-05-23  2772  	desc->rqcfg.src_inc = 1;
> b3040e40675ec2 Jassi Brar          2010-05-23  2773  	desc->rqcfg.dst_inc = 1;
> 9dc5a315fe515e Lars-Peter Clausen  2014-07-06  2774  	desc->rqtype = DMA_MEM_TO_MEM;
> b3040e40675ec2 Jassi Brar          2010-05-23  2775  
> b3040e40675ec2 Jassi Brar          2010-05-23  2776  	/* Select max possible burst size */
> f6f2421c0a1cb6 Lars-Peter Clausen  2014-07-06  2777  	burst = pl330->pcfg.data_bus_width / 8;
> b3040e40675ec2 Jassi Brar          2010-05-23  2778  
> 137bd11090d89b Jon Medhurst        2014-11-07  2779  	/*
> 137bd11090d89b Jon Medhurst        2014-11-07  2780  	 * Make sure we use a burst size that aligns with all the memcpy
> 137bd11090d89b Jon Medhurst        2014-11-07  2781  	 * parameters because our DMA programming algorithm doesn't cope with
> 137bd11090d89b Jon Medhurst        2014-11-07  2782  	 * transfers which straddle an entry in the DMA device's MFIFO.
> 137bd11090d89b Jon Medhurst        2014-11-07  2783  	 */
> 137bd11090d89b Jon Medhurst        2014-11-07  2784  	while ((src | dst | len) & (burst - 1))
> b3040e40675ec2 Jassi Brar          2010-05-23  2785  		burst /= 2;
> b3040e40675ec2 Jassi Brar          2010-05-23  2786  
> b3040e40675ec2 Jassi Brar          2010-05-23  2787  	desc->rqcfg.brst_size = 0;
> b3040e40675ec2 Jassi Brar          2010-05-23  2788  	while (burst != (1 << desc->rqcfg.brst_size))
> b3040e40675ec2 Jassi Brar          2010-05-23  2789  		desc->rqcfg.brst_size++;
> b3040e40675ec2 Jassi Brar          2010-05-23  2790  
> 137bd11090d89b Jon Medhurst        2014-11-07  2791  	/*
> 137bd11090d89b Jon Medhurst        2014-11-07  2792  	 * If burst size is smaller than bus width then make sure we only
> 137bd11090d89b Jon Medhurst        2014-11-07  2793  	 * transfer one at a time to avoid a burst stradling an MFIFO entry.
> 137bd11090d89b Jon Medhurst        2014-11-07  2794  	 */
> 137bd11090d89b Jon Medhurst        2014-11-07  2795  	if (desc->rqcfg.brst_size * 8 < pl330->pcfg.data_bus_width)
> 137bd11090d89b Jon Medhurst        2014-11-07  2796  		desc->rqcfg.brst_len = 1;
> 137bd11090d89b Jon Medhurst        2014-11-07  2797  
> b3040e40675ec2 Jassi Brar          2010-05-23 @2798  	desc->rqcfg.brst_len = get_burst_len(desc, len);
> ae128293d97404 Krzysztof Kozlowski 2015-06-15  2799  	desc->bytes_requested = len;
> b3040e40675ec2 Jassi Brar          2010-05-23  2800  
> b3040e40675ec2 Jassi Brar          2010-05-23  2801  	desc->txd.flags = flags;
> b3040e40675ec2 Jassi Brar          2010-05-23  2802  
> b3040e40675ec2 Jassi Brar          2010-05-23  2803  	return &desc->txd;
> b3040e40675ec2 Jassi Brar          2010-05-23  2804  }
> b3040e40675ec2 Jassi Brar          2010-05-23  2805  
> f6f2421c0a1cb6 Lars-Peter Clausen  2014-07-06  2806  static void __pl330_giveback_desc(struct pl330_dmac *pl330,
> 52a9d179109c50 Chanho Park         2013-08-09  2807  				  struct dma_pl330_desc *first)
> 52a9d179109c50 Chanho Park         2013-08-09  2808  {
> 52a9d179109c50 Chanho Park         2013-08-09  2809  	unsigned long flags;
> 52a9d179109c50 Chanho Park         2013-08-09  2810  	struct dma_pl330_desc *desc;
> 52a9d179109c50 Chanho Park         2013-08-09  2811  
> 52a9d179109c50 Chanho Park         2013-08-09  2812  	if (!first)
> 52a9d179109c50 Chanho Park         2013-08-09  2813  		return;
> 52a9d179109c50 Chanho Park         2013-08-09  2814  
> f6f2421c0a1cb6 Lars-Peter Clausen  2014-07-06  2815  	spin_lock_irqsave(&pl330->pool_lock, flags);
> 52a9d179109c50 Chanho Park         2013-08-09  2816  
> 52a9d179109c50 Chanho Park         2013-08-09  2817  	while (!list_empty(&first->node)) {
> 52a9d179109c50 Chanho Park         2013-08-09  2818  		desc = list_entry(first->node.next,
> 52a9d179109c50 Chanho Park         2013-08-09  2819  				struct dma_pl330_desc, node);
> f6f2421c0a1cb6 Lars-Peter Clausen  2014-07-06  2820  		list_move_tail(&desc->node, &pl330->desc_pool);
> 52a9d179109c50 Chanho Park         2013-08-09  2821  	}
> 52a9d179109c50 Chanho Park         2013-08-09  2822  
> f6f2421c0a1cb6 Lars-Peter Clausen  2014-07-06  2823  	list_move_tail(&first->node, &pl330->desc_pool);
> 52a9d179109c50 Chanho Park         2013-08-09  2824  
> f6f2421c0a1cb6 Lars-Peter Clausen  2014-07-06  2825  	spin_unlock_irqrestore(&pl330->pool_lock, flags);
> 52a9d179109c50 Chanho Park         2013-08-09  2826  }
> 52a9d179109c50 Chanho Park         2013-08-09  2827  
> b3040e40675ec2 Jassi Brar          2010-05-23  2828  static struct dma_async_tx_descriptor *
> b3040e40675ec2 Jassi Brar          2010-05-23  2829  pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> db8196df4bb6f1 Vinod Koul          2011-10-13  2830  		unsigned int sg_len, enum dma_transfer_direction direction,
> 185ecb5f4fd439 Alexandre Bounine   2012-03-08  2831  		unsigned long flg, void *context)
> b3040e40675ec2 Jassi Brar          2010-05-23  2832  {
> b3040e40675ec2 Jassi Brar          2010-05-23  2833  	struct dma_pl330_desc *first, *desc = NULL;
> b3040e40675ec2 Jassi Brar          2010-05-23  2834  	struct dma_pl330_chan *pch = to_pchan(chan);
> b3040e40675ec2 Jassi Brar          2010-05-23  2835  	struct scatterlist *sg;
> 1b9bb715e7c4c1 Boojin Kim          2011-09-02  2836  	int i;
> b3040e40675ec2 Jassi Brar          2010-05-23  2837  
> cd072515215ccc Thomas Abraham      2011-10-24  2838  	if (unlikely(!pch || !sgl || !sg_len))
> b3040e40675ec2 Jassi Brar          2010-05-23  2839  		return NULL;
> b3040e40675ec2 Jassi Brar          2010-05-23  2840  
> 445897cbc9d3e2 Vinod Koul          2018-10-25  2841  	pl330_config_write(chan, &pch->slave_config, direction);
> 445897cbc9d3e2 Vinod Koul          2018-10-25  2842  
> 4d6d74e2209654 Robin Murphy        2017-05-19  2843  	if (!pl330_prep_slave_fifo(pch, direction))
> 4d6d74e2209654 Robin Murphy        2017-05-19  2844  		return NULL;
> b3040e40675ec2 Jassi Brar          2010-05-23  2845  
> b3040e40675ec2 Jassi Brar          2010-05-23  2846  	first = NULL;
> b3040e40675ec2 Jassi Brar          2010-05-23  2847  
> b3040e40675ec2 Jassi Brar          2010-05-23  2848  	for_each_sg(sgl, sg, sg_len, i) {
> b3040e40675ec2 Jassi Brar          2010-05-23  2849  
> b3040e40675ec2 Jassi Brar          2010-05-23  2850  		desc = pl330_get_desc(pch);
> b3040e40675ec2 Jassi Brar          2010-05-23  2851  		if (!desc) {
> f6f2421c0a1cb6 Lars-Peter Clausen  2014-07-06  2852  			struct pl330_dmac *pl330 = pch->dmac;
> b3040e40675ec2 Jassi Brar          2010-05-23  2853  
> f6f2421c0a1cb6 Lars-Peter Clausen  2014-07-06  2854  			dev_err(pch->dmac->ddma.dev,
> b3040e40675ec2 Jassi Brar          2010-05-23  2855  				"%s:%d Unable to fetch desc\n",
> b3040e40675ec2 Jassi Brar          2010-05-23  2856  				__func__, __LINE__);
> f6f2421c0a1cb6 Lars-Peter Clausen  2014-07-06  2857  			__pl330_giveback_desc(pl330, first);
> b3040e40675ec2 Jassi Brar          2010-05-23  2858  
> b3040e40675ec2 Jassi Brar          2010-05-23  2859  			return NULL;
> b3040e40675ec2 Jassi Brar          2010-05-23  2860  		}
> b3040e40675ec2 Jassi Brar          2010-05-23  2861  
> b3040e40675ec2 Jassi Brar          2010-05-23  2862  		if (!first)
> b3040e40675ec2 Jassi Brar          2010-05-23  2863  			first = desc;
> b3040e40675ec2 Jassi Brar          2010-05-23  2864  		else
> b3040e40675ec2 Jassi Brar          2010-05-23  2865  			list_add_tail(&desc->node, &first->node);
> b3040e40675ec2 Jassi Brar          2010-05-23  2866  
> db8196df4bb6f1 Vinod Koul          2011-10-13  2867  		if (direction == DMA_MEM_TO_DEV) {
> b3040e40675ec2 Jassi Brar          2010-05-23  2868  			desc->rqcfg.src_inc = 1;
> b3040e40675ec2 Jassi Brar          2010-05-23  2869  			desc->rqcfg.dst_inc = 0;
> 4d6d74e2209654 Robin Murphy        2017-05-19  2870  			fill_px(&desc->px, pch->fifo_dma, sg_dma_address(sg),
> 4d6d74e2209654 Robin Murphy        2017-05-19  2871  				sg_dma_len(sg));
> b3040e40675ec2 Jassi Brar          2010-05-23  2872  		} else {
> b3040e40675ec2 Jassi Brar          2010-05-23  2873  			desc->rqcfg.src_inc = 0;
> b3040e40675ec2 Jassi Brar          2010-05-23  2874  			desc->rqcfg.dst_inc = 1;
> 4d6d74e2209654 Robin Murphy        2017-05-19  2875  			fill_px(&desc->px, sg_dma_address(sg), pch->fifo_dma,
> 4d6d74e2209654 Robin Murphy        2017-05-19  2876  				sg_dma_len(sg));
> b3040e40675ec2 Jassi Brar          2010-05-23  2877  		}
> b3040e40675ec2 Jassi Brar          2010-05-23  2878  
> 1b9bb715e7c4c1 Boojin Kim          2011-09-02  2879  		desc->rqcfg.brst_size = pch->burst_sz;
> 1d48745b192a7a Frank Mori Hess     2018-04-18  2880  		desc->rqcfg.brst_len = pch->burst_len;
> 9dc5a315fe515e Lars-Peter Clausen  2014-07-06  2881  		desc->rqtype = direction;
> aee4d1fac88725 Robert Baldyga      2015-02-11  2882  		desc->bytes_requested = sg_dma_len(sg);
> b3040e40675ec2 Jassi Brar          2010-05-23  2883  	}
> b3040e40675ec2 Jassi Brar          2010-05-23  2884  
> b3040e40675ec2 Jassi Brar          2010-05-23  2885  	/* Return the last desc in the chain */
> b3040e40675ec2 Jassi Brar          2010-05-23  2886  	desc->txd.flags = flg;
> b3040e40675ec2 Jassi Brar          2010-05-23  2887  	return &desc->txd;
> b3040e40675ec2 Jassi Brar          2010-05-23  2888  }
> b3040e40675ec2 Jassi Brar          2010-05-23  2889  
> b3040e40675ec2 Jassi Brar          2010-05-23  2890  static irqreturn_t pl330_irq_handler(int irq, void *data)
> b3040e40675ec2 Jassi Brar          2010-05-23  2891  {
> b3040e40675ec2 Jassi Brar          2010-05-23  2892  	if (pl330_update(data))
> b3040e40675ec2 Jassi Brar          2010-05-23  2893  		return IRQ_HANDLED;
> b3040e40675ec2 Jassi Brar          2010-05-23  2894  	else
> b3040e40675ec2 Jassi Brar          2010-05-23  2895  		return IRQ_NONE;
> b3040e40675ec2 Jassi Brar          2010-05-23  2896  }
> b3040e40675ec2 Jassi Brar          2010-05-23  2897  
> ca38ff133eb85b Lars-Peter Clausen  2013-07-15  2898  #define PL330_DMA_BUSWIDTHS \
> ca38ff133eb85b Lars-Peter Clausen  2013-07-15  2899  	BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED) | \
> ca38ff133eb85b Lars-Peter Clausen  2013-07-15  2900  	BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
> ca38ff133eb85b Lars-Peter Clausen  2013-07-15  2901  	BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
> ca38ff133eb85b Lars-Peter Clausen  2013-07-15  2902  	BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | \
> ca38ff133eb85b Lars-Peter Clausen  2013-07-15  2903  	BIT(DMA_SLAVE_BUSWIDTH_8_BYTES)
> ca38ff133eb85b Lars-Peter Clausen  2013-07-15  2904  
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2905  #ifdef CONFIG_DEBUG_FS
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2906  static int pl330_debugfs_show(struct seq_file *s, void *data)
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2907  {
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2908  	struct pl330_dmac *pl330 = s->private;
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2909  	int chans, pchs, ch, pr;
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2910  
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2911  	chans = pl330->pcfg.num_chan;
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2912  	pchs = pl330->num_peripherals;
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2913  
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2914  	seq_puts(s, "PL330 physical channels:\n");
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2915  	seq_puts(s, "THREAD:\t\tCHANNEL:\n");
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2916  	seq_puts(s, "--------\t-----\n");
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2917  	for (ch = 0; ch < chans; ch++) {
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2918  		struct pl330_thread *thrd = &pl330->channels[ch];
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2919  		int found = -1;
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2920  
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2921  		for (pr = 0; pr < pchs; pr++) {
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2922  			struct dma_pl330_chan *pch = &pl330->peripherals[pr];
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2923  
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2924  			if (!pch->thread || thrd->id != pch->thread->id)
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2925  				continue;
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2926  
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2927  			found = pr;
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2928  		}
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2929  
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2930  		seq_printf(s, "%d\t\t", thrd->id);
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2931  		if (found == -1)
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2932  			seq_puts(s, "--\n");
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2933  		else
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2934  			seq_printf(s, "%d\n", found);
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2935  	}
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2936  
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2937  	return 0;
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2938  }
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2939  
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2940  DEFINE_SHOW_ATTRIBUTE(pl330_debugfs);
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2941  
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2942  static inline void init_pl330_debugfs(struct pl330_dmac *pl330)
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2943  {
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2944  	debugfs_create_file(dev_name(pl330->ddma.dev),
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2945  			    S_IFREG | 0444, NULL, pl330,
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2946  			    &pl330_debugfs_fops);
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2947  }
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2948  #else
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2949  static inline void init_pl330_debugfs(struct pl330_dmac *pl330)
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2950  {
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2951  }
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2952  #endif
> b45aef3aef6361 Katsuhiro Suzuki    2019-03-17  2953  
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2954  /*
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2955   * Runtime PM callbacks are provided by amba/bus.c driver.
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2956   *
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2957   * It is assumed here that IRQ safe runtime PM is chosen in probe and amba
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2958   * bus driver will only disable/enable the clock in runtime PM callbacks.
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2959   */
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2960  static int __maybe_unused pl330_suspend(struct device *dev)
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2961  {
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2962  	struct amba_device *pcdev = to_amba_device(dev);
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2963  
> a39cddc9e37751 Ulf Hansson         2019-12-05  2964  	pm_runtime_force_suspend(dev);
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2965  	amba_pclk_unprepare(pcdev);
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2966  
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2967  	return 0;
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2968  }
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2969  
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2970  static int __maybe_unused pl330_resume(struct device *dev)
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2971  {
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2972  	struct amba_device *pcdev = to_amba_device(dev);
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2973  	int ret;
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2974  
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2975  	ret = amba_pclk_prepare(pcdev);
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2976  	if (ret)
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2977  		return ret;
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2978  
> a39cddc9e37751 Ulf Hansson         2019-12-05  2979  	pm_runtime_force_resume(dev);
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2980  
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18 @2981  	return ret;
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2982  }
> b816ccc5c01fb7 Krzysztof Kozlowski 2014-11-18  2983  
> 
> :::::: The code at line 2981 was first introduced by commit
> :::::: b816ccc5c01fb7fe1fb001ff7aa5aa7e5a8aa76b ARM: 8206/1: dmaengine: pl330: Add PM sleep support
> 
> :::::: TO: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> :::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

-- 
~Vinod
