Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DA2C433EC
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77D9B206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594826970;
	bh=w224y4zQtuziefarpEq2K02a19xs7z0MtgELxkxpHSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ig36t8fhtA6GqcOlywWTSpLPvvGA+WkLNB/iDFEJd3vOnNZOXUXmdOnioB7VZH68n
	 KNZdvJAEiloMfeYlgkPMthG1EOnm9TF2ncgBCzaykbowDbYBhWAxmKqJVaBihU6lgm
	 yQipTpePzfzwwb7jfYX+lejGfRl74vUAbWzoaKjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgGOP33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:29:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgGOP32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:29:28 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6A1F20663;
        Wed, 15 Jul 2020 15:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594826967;
        bh=w224y4zQtuziefarpEq2K02a19xs7z0MtgELxkxpHSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NnMResrGwntYqTu85JCMCftD3amBBe1dQl9U8xdxSz16hSyFCguKjdaL6ZYwc5ppR
         8T7s7C55+5GUQEkqIXoVq5B47PAmH4Q1ZcenBoF+Twqq/+gaViC0iT6LgdjPtYbdLF
         OwLqB0WLndwAn2qja9L+GP9zukwEUUbcxAGLTG9k=
Date:   Wed, 15 Jul 2020 20:59:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 00/17] Rid W=1 warnings in DMA
Message-ID: <20200715152923.GB52592@vkoul-mobl>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 14-07-20, 12:15, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> After these patches are applied, the build system no longer
> complains about any W=0 nor W=1 level warnings in drivers/dma.
> 
> Hurrah!

Yes indeed, thanks for fixing these up. I have changed the subsystem
name to dmaengine: and applied all

-- 
~Vinod
