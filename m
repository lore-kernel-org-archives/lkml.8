Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396FAC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 06:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0374D20737
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 06:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599115912;
	bh=zFFH5ijjXx/9/g9VnmjQZzmuX1E42UObUA1luskXeVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nh5nhWFiOWaI6uAdP+kk/dy0T50eeShkvpLccoeznqeTy8sO2BKqug3+vcNwe6osd
	 y0SUChqpZD74W35dXBVVg6zYNyvXEMzKctNdY+AkwWehcBSUjZ4gfXianJJTjzafbH
	 OfV108GtoHTMyzL03CdxPjMKQRWQ4YK1eO2u5LWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgICGvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 02:51:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgICGvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 02:51:49 -0400
Received: from localhost (unknown [122.171.179.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3D3C2071B;
        Thu,  3 Sep 2020 06:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599115909;
        bh=zFFH5ijjXx/9/g9VnmjQZzmuX1E42UObUA1luskXeVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mk2etaz+5KErHJgg8iv9HxYh97mxJCiyFiXckORgFiV1I9wrwUWey3RuE+WQEA8n7
         HKG6wf8vrifwJ+Semcv2CbnKr0nH1PmsSrKFEZgRJE1JZEQAjlCjdwNTixibUGnnJk
         2+zM5AHSgsgXAQN1WZ6OAfWpb8/vvwDVdTbNGnlw=
Date:   Thu, 3 Sep 2020 12:21:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH] dmaengine: Mark dma_request_slave_channel() deprecated
Message-ID: <20200903065145.GF2639@vkoul-mobl>
References: <20200828110507.22407-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828110507.22407-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-20, 14:05, Peter Ujfalusi wrote:
> New drivers should use dma_request_chan() instead
> dma_request_slave_channel()
> 
> dma_request_slave_channel() is a simple wrapper for dma_request_chan()
> eating up the error code for channel request failure and makes deferred
> probing impossible.
> 
> Move the dma_request_slave_channel() into the header as inline function,
> mark it as deprecated.

Applied, thanks

-- 
~Vinod
