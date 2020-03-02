Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29632C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0AD246B9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583140476;
	bh=UbuSb7l91NmV7WlYukEACby2rjjpfKz6X4KPoH9f3fM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FJiVq/WDPOnkuTLlT/bF+T4JnFjgES646tolIs9XTyvvElYDVEQDrveR1BZzl9b6z
	 ExDz0v8GLPfyN6QfIj061GRHdYoWWi7OfySBu4+Y4szWFKnvkxGSS1oP0Z0Gb1fEY1
	 9eQpNuWeLQ7U/uxj0zGcjj2AzpsPE2mReTQkQbcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgCBJOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:14:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgCBJOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:14:34 -0500
Received: from localhost (unknown [171.76.77.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21AEC246B4;
        Mon,  2 Mar 2020 09:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583140474;
        bh=UbuSb7l91NmV7WlYukEACby2rjjpfKz6X4KPoH9f3fM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qgl+4iy5i1PreV+s3vnOUafNyOnJ2mw0E8QyGLfSNJMSJuo4NMbEOYYjPOI6l1woL
         f2z8sROJFu9dxT15jXYC2GIU+tMG+ltGvpFEnQZs5VMiRZ1XzoJfDZhUHHTjAbm0Pe
         PV7BKBJj8S+f8sIeCAup/0SipYJeeMSiSMeibwH4=
Date:   Mon, 2 Mar 2020 14:44:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, grygorii.strashko@ti.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] dmaengine: ti: k3-udma: Support for per channel atype
Message-ID: <20200302091428.GI4148@vkoul-mobl>
References: <20200218143126.11361-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218143126.11361-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-02-20, 16:31, Peter Ujfalusi wrote:
> Hi,
> 
> The series is on top of the 5.6 update patches:
> https://lore.kernel.org/lkml/20200214091441.27535-1-peter.ujfalusi@ti.com/
> 
> UDMA channels have ATYPE property which tells UDMA on how to treat the pointers
> within descriptors (and TRs).
> The ATYPE defined for j721e are:
> 0: pointers are physical addresses (no translation)
> 1: pointers are intermediate addresses (PVU)
> 2: pointers are virtual addresses (SMMU)
> 
> When Linux is booting within a virtualized environment channels must have the
> ATYPE configured correctly to be able to access memory (ATYPE == 0 is not
> allowed).
> The ATYPE can be different for channels and their ATYPE depends on which
> endpoint they are servicing, but it is not hardwired.
> 
> In order to be able to tell the driver the ATYPE for the channel we need to
> extend the dma-cells in case the device is going to be used in virtualized
> setup.
> 
> Non virtualized setups can still use dma-cells == 1.
> 
> If dma-cells == 2, then the UDMA node must have ti,udma-atype property which
> is used for non slave channels (where no DT binding is exist for a channel).

Applied, thanks

-- 
~Vinod
