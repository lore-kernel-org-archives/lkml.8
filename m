Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD615C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 17:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 876C22067D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 17:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="clY5g1aQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgGLRLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 13:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbgGLRLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 13:11:08 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33134C08C5DB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 10:11:08 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id k27so4958385pgm.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 10:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=igw9GVyJc+KlF33JTbERsix7Ehy8t85Hnf+jPnF/w8o=;
        b=clY5g1aQZUPDZ/vSlzPF599afT4jBIa5OIbLR3QPv+x18l7IYP33BludhEGcN/555C
         nc1iavAtbtIKMwIFiQtHm7pYIgMx/1j7CWd/12MbkV0Gp3gPV37XRiQl2HvVRt2sJK6B
         tP9+TT5pWm7ICVYH0LP9idhcWKr6u1Ti8Wml/olbjDzV1BjE2GNF3LvIbmUzgFRa/zYZ
         kBatqF9SgeTAbZbCbbWSr6AH5zHB96otkaxOfUJuH2JwvV/nTfTVicBBoNXJIcNN4gE0
         JUYxEhV3Nzc38Br98r0ktkrI9Zu/wHEd+o2h9lIDzCl2Z8AzaiBwNFdjoDYCuyXYAiAr
         1+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=igw9GVyJc+KlF33JTbERsix7Ehy8t85Hnf+jPnF/w8o=;
        b=IVbvpLLtZM1ehhTkhSdhKjtIla3uNzXC8QiDjG8sprGzUoMNeiq0VyEpu+ePVpRdV6
         /N5PigiJ4kIgpqVrLbyYzhtauEds85H5o2PlxsGYp6L8MXpKlLTCNJfU6EtpOMQl+cwG
         z19nTxEyHns5If3uLmuYupHcq+vitsV00R9Y2xOdDxgC78DPBe+SI61jKESxcCOJlrnx
         VjVHj6hwWZy0pp9V+rCCWsECo0t7LJh6Zrgeq5eBe4APQeStcz4jcfZhYG4hgIHf245s
         gpJOlCgpzDu7LR9SJitWbde+Xp7gVVDd1EwpPomVjy5kuiF5gO4eRvTNL9g8NT1Sob0Y
         JpWQ==
X-Gm-Message-State: AOAM533uHsjqfsqEpuxToBZZ+4I9ik/hj5T8AvoQz4CquL9GNDZzAp7X
        7SOz+MtVVt+R4nfPvYddtpKQO1XTKw==
X-Google-Smtp-Source: ABdhPJxEme+SN0RD5XTVuwq4YqxKc83MjOpzMzYq4rR72d80EG4HSPCgC0B2mPmyMkJoV40Qn8Ga1A==
X-Received: by 2002:a63:5c55:: with SMTP id n21mr63123519pgm.27.1594573867172;
        Sun, 12 Jul 2020 10:11:07 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6c81:c187:70f5:3123:b5de:e77f])
        by smtp.gmail.com with ESMTPSA id mu17sm13231248pjb.53.2020.07.12.10.11.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Jul 2020 10:11:06 -0700 (PDT)
Date:   Sun, 12 Jul 2020 22:41:00 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, vkoul@kernel.org, afaerber@suse.de,
        dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v5 02/10] dmaengine: Actions: get rid of bit fields from
 dma descriptor
Message-ID: <20200712171100.GE6110@Mani-XPS-13-9360>
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
 <1593701576-28580-3-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593701576-28580-3-git-send-email-amittomer25@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 08:22:48PM +0530, Amit Singh Tomar wrote:
> At the moment, Driver uses bit fields to describe registers of the DMA
> descriptor structure that makes it less portable and maintainable, and
> Andre suugested(and even sketched important bits for it) to make use of
> array to describe this DMA descriptors instead. It gives the flexibility
> while extending support for other platform such as Actions S700.
> 
> This commit removes the "owl_dma_lli_hw" (that includes bit-fields) and
> uses array to describe DMA descriptor.
> 
> Suggested-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> Changes since v4:
> 	* Reordered it from 01/10 to 02/10.
> Changes since v3:
>         * Added description for enum fields.
>         * Restored the old comment.
>         * Added detailed comment about, the way FLEN
>           and FCNT values are filled.
> Changes since v2:
>         * No change.
> Changes since v1:
>         * Defined macro for frame count value.
>         * Introduced llc_hw_flen() from patch 2/9.
>         * Removed the unnecessary line break.
> Changes since rfc:
>         * No change.
> ---
>  drivers/dma/owl-dma.c | 98 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 56 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
> index 66ef70b00ec0..948d1bead860 100644
> --- a/drivers/dma/owl-dma.c
> +++ b/drivers/dma/owl-dma.c
> @@ -120,30 +120,33 @@
>  #define BIT_FIELD(val, width, shift, newshift)	\
>  		((((val) >> (shift)) & ((BIT(width)) - 1)) << (newshift))
>  
> +/* Frame count value is fixed as 1 */
> +#define FCNT_VAL				0x1
> +
>  /**
> - * struct owl_dma_lli_hw - Hardware link list for dma transfer
> - * @next_lli: physical address of the next link list
> - * @saddr: source physical address
> - * @daddr: destination physical address
> - * @flen: frame length
> - * @fcnt: frame count
> - * @src_stride: source stride
> - * @dst_stride: destination stride
> - * @ctrla: dma_mode and linklist ctrl config
> - * @ctrlb: interrupt config
> - * @const_num: data for constant fill
> + * owl_dmadesc_offsets - Describe DMA descriptor, hardware link
> + * list for dma transfer
> + * @OWL_DMADESC_NEXT_LLI: physical address of the next link list
> + * @OWL_DMADESC_SADDR: source physical address
> + * @OWL_DMADESC_DADDR: destination physical address
> + * @OWL_DMADESC_FLEN: frame length
> + * @OWL_DMADESC_SRC_STRIDE: source stride
> + * @OWL_DMADESC_DST_STRIDE: destination stride
> + * @OWL_DMADESC_CTRLA: dma_mode and linklist ctrl config
> + * @OWL_DMADESC_CTRLB: interrupt config
> + * @OWL_DMADESC_CONST_NUM: data for constant fill
>   */
> -struct owl_dma_lli_hw {
> -	u32	next_lli;
> -	u32	saddr;
> -	u32	daddr;
> -	u32	flen:20;
> -	u32	fcnt:12;
> -	u32	src_stride;
> -	u32	dst_stride;
> -	u32	ctrla;
> -	u32	ctrlb;
> -	u32	const_num;
> +enum owl_dmadesc_offsets {
> +	OWL_DMADESC_NEXT_LLI = 0,
> +	OWL_DMADESC_SADDR,
> +	OWL_DMADESC_DADDR,
> +	OWL_DMADESC_FLEN,
> +	OWL_DMADESC_SRC_STRIDE,
> +	OWL_DMADESC_DST_STRIDE,
> +	OWL_DMADESC_CTRLA,
> +	OWL_DMADESC_CTRLB,
> +	OWL_DMADESC_CONST_NUM,
> +	OWL_DMADESC_SIZE
>  };
>  
>  /**
> @@ -153,7 +156,7 @@ struct owl_dma_lli_hw {
>   * @node: node for txd's lli_list
>   */
>  struct owl_dma_lli {
> -	struct  owl_dma_lli_hw	hw;
> +	u32			hw[OWL_DMADESC_SIZE];
>  	dma_addr_t		phys;
>  	struct list_head	node;
>  };
> @@ -318,6 +321,11 @@ static inline u32 llc_hw_ctrlb(u32 int_ctl)
>  	return ctl;
>  }
>  
> +static u32 llc_hw_flen(struct owl_dma_lli *lli)
> +{
> +	return lli->hw[OWL_DMADESC_FLEN] & GENMASK(19, 0);
> +}
> +
>  static void owl_dma_free_lli(struct owl_dma *od,
>  			     struct owl_dma_lli *lli)
>  {
> @@ -349,8 +357,9 @@ static struct owl_dma_lli *owl_dma_add_lli(struct owl_dma_txd *txd,
>  		list_add_tail(&next->node, &txd->lli_list);
>  
>  	if (prev) {
> -		prev->hw.next_lli = next->phys;
> -		prev->hw.ctrla |= llc_hw_ctrla(OWL_DMA_MODE_LME, 0);
> +		prev->hw[OWL_DMADESC_NEXT_LLI] = next->phys;
> +		prev->hw[OWL_DMADESC_CTRLA] |=
> +					llc_hw_ctrla(OWL_DMA_MODE_LME, 0);
>  	}
>  
>  	return next;
> @@ -363,8 +372,7 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
>  				  struct dma_slave_config *sconfig,
>  				  bool is_cyclic)
>  {
> -	struct owl_dma_lli_hw *hw = &lli->hw;
> -	u32 mode;
> +	u32 mode, ctrlb;
>  
>  	mode = OWL_DMA_MODE_PW(0);
>  
> @@ -405,22 +413,28 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
>  		return -EINVAL;
>  	}
>  
> -	hw->next_lli = 0; /* One link list by default */
> -	hw->saddr = src;
> -	hw->daddr = dst;
> -
> -	hw->fcnt = 1; /* Frame count fixed as 1 */
> -	hw->flen = len; /* Max frame length is 1MB */
> -	hw->src_stride = 0;
> -	hw->dst_stride = 0;
> -	hw->ctrla = llc_hw_ctrla(mode,
> -				 OWL_DMA_LLC_SAV_LOAD_NEXT |
> -				 OWL_DMA_LLC_DAV_LOAD_NEXT);
> +	lli->hw[OWL_DMADESC_CTRLA] = llc_hw_ctrla(mode,
> +						  OWL_DMA_LLC_SAV_LOAD_NEXT |
> +						  OWL_DMA_LLC_DAV_LOAD_NEXT);
>  
>  	if (is_cyclic)
> -		hw->ctrlb = llc_hw_ctrlb(OWL_DMA_INTCTL_BLOCK);
> +		ctrlb = llc_hw_ctrlb(OWL_DMA_INTCTL_BLOCK);
>  	else
> -		hw->ctrlb = llc_hw_ctrlb(OWL_DMA_INTCTL_SUPER_BLOCK);
> +		ctrlb = llc_hw_ctrlb(OWL_DMA_INTCTL_SUPER_BLOCK);
> +
> +	lli->hw[OWL_DMADESC_NEXT_LLI] = 0; /* One link list by default */
> +	lli->hw[OWL_DMADESC_SADDR] = src;
> +	lli->hw[OWL_DMADESC_DADDR] = dst;
> +	lli->hw[OWL_DMADESC_SRC_STRIDE] = 0;
> +	lli->hw[OWL_DMADESC_DST_STRIDE] = 0;
> +	/*
> +	 * Word starts from offset 0xC is shared between frame length
> +	 * (max frame length is 1MB) and frame count, where first 20
> +	 * bits are for frame length and rest of 12 bits are for frame
> +	 * count.
> +	 */
> +	lli->hw[OWL_DMADESC_FLEN] = len | FCNT_VAL << 20;
> +	lli->hw[OWL_DMADESC_CTRLB] = ctrlb;
>  
>  	return 0;
>  }
> @@ -752,7 +766,7 @@ static u32 owl_dma_getbytes_chan(struct owl_dma_vchan *vchan)
>  			/* Start from the next active node */
>  			if (lli->phys == next_lli_phy) {
>  				list_for_each_entry(lli, &txd->lli_list, node)
> -					bytes += lli->hw.flen;
> +					bytes += llc_hw_flen(lli);
>  				break;
>  			}
>  		}
> @@ -783,7 +797,7 @@ static enum dma_status owl_dma_tx_status(struct dma_chan *chan,
>  	if (vd) {
>  		txd = to_owl_txd(&vd->tx);
>  		list_for_each_entry(lli, &txd->lli_list, node)
> -			bytes += lli->hw.flen;
> +			bytes += llc_hw_flen(lli);
>  	} else {
>  		bytes = owl_dma_getbytes_chan(vchan);
>  	}
> -- 
> 2.7.4
> 
