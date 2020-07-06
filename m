Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9074C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 05:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B8420715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 05:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594012745;
	bh=l/3SWBfqpGtE5dZNa/GolLP57ayRYFrPWuRtcUTlBts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T6ZIhQ4YUWBXcwg1Nqcn/2TYPM0eI3+f/lBt8AJdXf3s3ogbQfxhcl4BY6RwWF3VA
	 RXs3XAbfq/xkI2O434q24fAA635A14Lmr030cA1zuh7RssCM89tFCIcLu+TXQ3m6Uv
	 rrFZIja+apsQvVMoaCw/7Kdlma6L64EmVeIOhVsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgGFFTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 01:19:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgGFFTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 01:19:02 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7523C20715;
        Mon,  6 Jul 2020 05:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594012742;
        bh=l/3SWBfqpGtE5dZNa/GolLP57ayRYFrPWuRtcUTlBts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HBzl0ioFoQEzJ23c5FOteCUgsCEU97fUnI1LYzCp4aYDJ7xCDQjdD+biOfroILFt9
         +RRVdqbWuRy0PqzJksFNyy0/6vAEF/ytvXFixSv8G0ndhRf3nEWvLK8lYTgNnUV63d
         JEAxKpHDm02vcJKgmUXkV8bhRZ2Guh50QO7pEAwE=
Date:   Mon, 6 Jul 2020 10:48:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     leonid.ravich@dell.com
Cc:     dmaengine@vger.kernel.org, lravich@gmail.com,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: ioat setting ioat timeout as module
 parameter
Message-ID: <20200706051858.GH633187@vkoul-mobl>
References: <20200701140849.8828-1-leonid.ravich@dell.com>
 <20200701184816.29138-1-leonid.ravich@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701184816.29138-1-leonid.ravich@dell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-07-20, 21:48, leonid.ravich@dell.com wrote:
> From: Leonid Ravich <Leonid.Ravich@emc.com>
> 
> DMA transaction time to completion  is a function of
> PCI bandwidth,transaction size and a queue depth.

space after , pls

> So hard coded value for timeouts might be wrong
> for some scenarios.

I ahve fixed above and applied

-- 
~Vinod
