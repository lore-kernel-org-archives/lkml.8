Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142EEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D879A2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9mBEPMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgESIEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 04:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgESIEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:04:11 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BF6C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 01:04:11 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j21so6018629pgb.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 01:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O2zoxhUyUqiWwrDiEGQZbkYeTI0CYRs6GAWetfHo0bg=;
        b=e9mBEPMQ0AUKXiVv6+8gNZ2aWsCuCjKVPBjqX6F5gwBw+h27EYog/x5NlQPfAiXYlI
         03roQ6Y7fY0Mr35Acfxhx+O5DqQZMhaFDvh3/MEzwRH48z/bGM9d+jECtBYGYIpJr8Rj
         XoXf5sqZwBgloS+gXi+C6vmOHKH5axCgDnaltURufW0wHuX5cX8Au5A5SNxMfWCPpJal
         0PBBuTv1qkJO/uqlelwkYS8PW648WYKV+h2NxEPKwNk5P6sByIsMat+lvhi3V1ME3isQ
         DQFl78EWOfeU/kK5klVhXDDb9IMr0A2kMvFwbqSPSJTyCbhiWwyCWbamAqJA4SNryXBn
         PHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O2zoxhUyUqiWwrDiEGQZbkYeTI0CYRs6GAWetfHo0bg=;
        b=ddYseOeR95cMncbi84uaMxWx9f7JNvdH589i7Kf9J7NFmH7vWMpCtXgmUpMjQ6d4l3
         QwJ976zIX+kMgbe/3FRs5wKKdawobII60u/X72NIQtTyad8juhEAT5RH/JaeV15wQV+i
         gMI1K/xV0rhE1kkyj3FGWgT0RM9AautnWPFVHw1AR0An+SBjczXcTWYhHyKD8E4tDEMb
         mWXKple6bZWnzTEtGTpUuxdZKRPndJJRSoc0C/3+CHQc9zcQ31HdC1SYfVEu7h61bAo1
         xwEgcJDfoJr9yyDHLwikurs4ynjMM52V8uz0Py93y5XXSYN+A8tnOYxec59/UqKU1Su5
         PgQw==
X-Gm-Message-State: AOAM532gawMmU+lVrVpAaT+5d/eHhvrVFtvOsJELLVvkOL1aR2wNt6Ev
        NXu5hRBGsap+inK2wQ2/BEU=
X-Google-Smtp-Source: ABdhPJzBikFNZW3Se7/rIga3Nfq04GryxnXf1z1a0E8FsB6PR9y8xSqM/jy3KbjUkRk9UwqXUitMdw==
X-Received: by 2002:a62:3441:: with SMTP id b62mr12752428pfa.225.1589875450728;
        Tue, 19 May 2020 01:04:10 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id v75sm1510501pjb.35.2020.05.19.01.04.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 01:04:10 -0700 (PDT)
Date:   Tue, 19 May 2020 01:04:08 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     robin.murphy@arm.com, m.szyprowski@samsung.com, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [RFC/RFT][PATCH v2] dma-mapping: set default
 segment_boundary_mask to ULONG_MAX
Message-ID: <20200519080408.GA15325@Asurada-Nvidia>
References: <20200406210643.20665-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406210643.20665-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin/Christoph,

This v2 was sent a while ago. I know that we had a concern,
yet will we have a closure whether merging it or not?

Thanks!
Nic

On Mon, Apr 06, 2020 at 02:06:43PM -0700, Nicolin Chen wrote:
> The default segment_boundary_mask was set to DMA_BIT_MAKS(32)
> a decade ago by referencing SCSI/block subsystem, as a 32-bit
> mask was good enough for most of the devices.
> 
> Now more and more drivers set dma_masks above DMA_BIT_MAKS(32)
> while only a handful of them call dma_set_seg_boundary(). This
> means that most drivers have a 4GB segmention boundary because
> DMA API returns a 32-bit default value, though they might not
> really have such a limit.
> 
> The default segment_boundary_mask should mean "no limit" since
> the device doesn't explicitly set the mask. But a 32-bit mask
> certainly limits those devices capable of 32+ bits addressing.
> 
> So this patch sets default segment_boundary_mask to ULONG_MAX.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Changelog:
> v1->v2
>  * Followed Robin's comments to revise the commit message by
>    dropping one paragraph of not-entirely-true justification
>    (no git-diff level change, so please ack if you tested v1)
> 
>  include/linux/dma-mapping.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 330ad58fbf4d..ff8cefe85f30 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -736,7 +736,7 @@ static inline unsigned long dma_get_seg_boundary(struct device *dev)
>  {
>  	if (dev->dma_parms && dev->dma_parms->segment_boundary_mask)
>  		return dev->dma_parms->segment_boundary_mask;
> -	return DMA_BIT_MASK(32);
> +	return ULONG_MAX;
>  }
>  
>  static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
> -- 
> 2.17.1
> 
