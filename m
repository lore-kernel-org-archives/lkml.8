Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E25C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43A812076E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597641246;
	bh=77Rm1fGtPTOXYyKtAN3oFCpTJOZdKNpRD/Ale7YoeX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wnn9/a6MJsk2DUo9fr6jjA6Nebay7AthKqYKK4drj5iZ23Wf4uWaqZ9Z5asTrQu6B
	 VjGuRqO/aJ9ac5UdMU5qZe6CDLcALXtEOYBCmgTkfEDa61NHB84HJT2HTmu2tfWbG1
	 54JsYJ1ei8TfHjM8af/geGOUJTXKOq0V512t6bGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgHQFOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 01:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgHQFOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 01:14:05 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDA2A2072E;
        Mon, 17 Aug 2020 05:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597641244;
        bh=77Rm1fGtPTOXYyKtAN3oFCpTJOZdKNpRD/Ale7YoeX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nu+PLLbTsUgZAKnti/ShRTe4i+RlzLnX5fZLv1S+/hnvVoxG2+oCM0CMhYQ75LFvV
         Snu8X9YZZwVY+mk4kYrwDJt0hFJzj7VZfHcFAVJZvyxb3vfiSDayg5zLjX5jWHaMxa
         Enq7YPfeeRp+pwvPO2Zs76QOXpwr2RIY/KSpZDHg=
Date:   Mon, 17 Aug 2020 10:43:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Drop of_match_ptr to fix
 -Wunused-const-variable
Message-ID: <20200817051359.GE2639@vkoul-mobl>
References: <20200728170939.28278-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728170939.28278-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-07-20, 19:09, Krzysztof Kozlowski wrote:
> The of_device_id is included unconditionally by of.h header and used
> in the driver as well.  Remove of_match_ptr to fix W=1 compile test
> warning with !CONFIG_OF:
> 
>     drivers/dma/ti/omap-dma.c:1892:34: warning: 'omap_dma_match' defined but not used [-Wunused-const-variable=]
>      1892 | static const struct of_device_id omap_dma_match[] = {

Applied, thanks

-- 
~Vinod
