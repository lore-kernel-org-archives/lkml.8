Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62288C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4670E2067B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592324938;
	bh=JpTCvK5zFPERLoJ7+BL5bx1daTFnJ0DVQEE6Ek0j9Sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1bnD9M704HqtuVhxkZMnKuZ2yVpxefjs0cXlZ7mkaHkYxxbwRE1oi6LogMNBns5Ti
	 ih5DRzFPDyJZ8+UUd0keY7zUm2ReChlRdRBSK6uI9iql5+AjnbZQyQDffyl4SrV9ZG
	 mLU39ekHM88TV2BbjuWds0BGW2IFcqxjvW+rF70g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbgFPQ25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730324AbgFPQ24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:28:56 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61BBD2067B;
        Tue, 16 Jun 2020 16:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592324936;
        bh=JpTCvK5zFPERLoJ7+BL5bx1daTFnJ0DVQEE6Ek0j9Sw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ASEsZ+N2S3uyKyWBFvMm1ifHI1TYBo/sPDy0KmufQ3yVlLolYjItPyF7BIxI8n8AC
         iTLUVjlYAmYjjNTL465zKku9PwUEhvH+v6MRc8zPnUIRYLYSt5xGd4jHNuPbci21kM
         nK4fAiXSRNRthCzeTVEc3KrbRBndV0DOHzleUXJ4=
Date:   Tue, 16 Jun 2020 21:58:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] dmaengine: mmp_pdma: Do not warn when IRQ is
 shared by all chans
Message-ID: <20200616162852.GM2324254@vkoul-mobl>
References: <20200601192337.172869-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601192337.172869-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-06-20, 21:23, Lubomir Rintel wrote:
> When there's a single interrupt for all the DMA channels, the
> unsuccessful attempt to request separate IRQs emits useless warnings:
> 
>   [    1.370381] mmp-pdma d4000000.dma: IRQ index 1 not found
>   ...
>   [    1.412398] mmp-pdma d4000000.dma: IRQ index 15 not found
>   [    1.418308] mmp-pdma d4000000.dma: initialized 16 channels
> 
> Avoid that, treating the IRQs as optional.

Applied, thanks

-- 
~Vinod
