Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04630C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB29F205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7TUMxfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbgCPVow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:44:52 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39348 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732652AbgCPVow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 17:44:52 -0400
Received: by mail-pj1-f68.google.com with SMTP id d8so9373007pje.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 14:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D3D+qRAc+7oS8J6Sb2B1Mz4hpBLBqFH8O13t3FcfVa4=;
        b=n7TUMxfS05q1sAGxhXfS9KBXthw4r/gV1wXyY3/HpwXnOs+Yf4tGf5oszH9qukZVML
         Woma4yNpxC5KWOU6oTIBDHv/5/ZOV5plbE8NVxCxOmEAK+nVWI0W/MmSWVPVSwDdtLha
         skblwS0q9kA8z6T7FDwQcwTZJI1UofMPLd8rpqDlQPEwCp5TdX+CJh3xxCQGkTKFDLX6
         lxXaJPjSxD8mLnFCjTOTifmCJ5qyABOPd/kHcOZDE077fAGrmFbdZD5eUu/aC8F8FGMq
         cLG3FOnrfaRSlMtmlqvG0zr4Wtew6oQhNzY8Xm3csG5EPY3Fn56nbQAhcKNGnt+WVg7g
         inrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D3D+qRAc+7oS8J6Sb2B1Mz4hpBLBqFH8O13t3FcfVa4=;
        b=RCZsvzRWgLhMVAbnWeYVsv+eEhMRxwXQ1SEHI3jtemNVsbI6i8rt9PTvPwBR0oT6v/
         SwmcLh98k/fu+z690kzEJxywGxQzBKa3NxW/vW3TFvGvpf8ZwhEE7feLR63O1IBeJx/h
         1OEQckKsn5FLRIxoaurljv0O8ndpg7RYPM69Lxc4c0pFIJlOqLAQ61zRJwZMEoQwPrMY
         oCQ3Dr8TIUa6iJqkgT1VVDg5J4I6T+ly7XzBuDFE5szpsXKLNo2YMe9J0esNZW6D3WrZ
         izyS54jcQ0UjaqqtRT9L4zlBKeEdqY3KSzmuWsohbBTfmibvxJ/G1v5jOiWX4caGRse7
         s7JA==
X-Gm-Message-State: ANhLgQ1MwWy46aHGNFL/E5NevJE7SwhhPo8T/GvPCUcBkDa/ReChNSzD
        W+snIboXAztoSEMrIgW2EDIQvOtO
X-Google-Smtp-Source: ADFU+vs60R8/j/ZW6FCkLMviIra7UhFL+U4BLcl8OYqLfjSUIx79EqZSX89WiGJDT2CyWWVnFVsKfg==
X-Received: by 2002:a17:902:b118:: with SMTP id q24mr1265410plr.0.1584395091130;
        Mon, 16 Mar 2020 14:44:51 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id j1sm812274pfg.64.2020.03.16.14.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Mar 2020 14:44:51 -0700 (PDT)
Date:   Mon, 16 Mar 2020 14:45:06 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     robin.murphy@arm.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [RFC][PATCH] dma-mapping: align default segment_boundary_mask
 with dma_mask
Message-ID: <20200316214506.GC18970@Asurada-Nvidia.nvidia.com>
References: <20200314000007.13778-1-nicoleotsuka@gmail.com>
 <20200316124850.GB17386@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316124850.GB17386@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, Mar 16, 2020 at 01:48:50PM +0100, Christoph Hellwig wrote:
> On Fri, Mar 13, 2020 at 05:00:07PM -0700, Nicolin Chen wrote:
> > @@ -736,7 +736,7 @@ static inline unsigned long dma_get_seg_boundary(struct device *dev)
> >  {
> >  	if (dev->dma_parms && dev->dma_parms->segment_boundary_mask)
> >  		return dev->dma_parms->segment_boundary_mask;
> > -	return DMA_BIT_MASK(32);
> > +	return (unsigned long)dma_get_mask(dev);
> 
> Just thinking out loud after my reply - shouldn't we just return ULONG_MAX
> by default here to mark this as no limit?

Yea, ULONG_MAX (saying no limit) sounds good to me.
