Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867FAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0F124125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579601163;
	bh=by/ZFP+d2IFD++mSGmVgfuhVMux5YdwvzjSotswQIBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JU2BU100PltqvfXvJTGJ5+8C2IgXNT8Yl3HJG4SMy84II5iaQIv8CAXUKy5+n/xX1
	 l7MMm0UGiB6/iHkqetR3S7Jsd02QLENRsYhlLzk819mAKlbrFGlnDd2tQ1sZm2utC9
	 mnyV/2J9ZinyqqUtHnF4cqn5sdVbxDM5+GdKU+6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgAUKGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:06:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbgAUKGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:06:02 -0500
Received: from localhost (unknown [171.76.119.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0B2720882;
        Tue, 21 Jan 2020 10:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579601161;
        bh=by/ZFP+d2IFD++mSGmVgfuhVMux5YdwvzjSotswQIBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CCoZRaJNRW05YlM3J56kx+KwtlOrhJYGGsuccGejlCeLkt0fWrqPQxbXF5Yzgh4My
         pRddkMj6MvdcVfCgcYQ5zXrhQopmKitl/2N3CTgU/Oc4h3PiaxuKe9R67u0ltBwqsp
         64H8w0Cmteb7LujxWMbnn5OkB9d3QYiJ5oWyxzNo=
Date:   Tue, 21 Jan 2020 15:35:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, psodagud@codeaurora.org,
        tsoni@codeaurora.org, jshriram@codeaurora.org, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Add device tree and clock drivers for SM8250 SoC
Message-ID: <20200121100557.GO2841@vkoul-mobl>
References: <1579217994-22219-1-git-send-email-vnkgutta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579217994-22219-1-git-send-email-vnkgutta@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-01-20, 15:39, Venkata Narendra Kumar Gutta wrote:
> This series adds device tree support and clock drivers support
> for SM8250 SoC.
> As part of the device tree, the sm8250 dts file has basic nodes
> like CPU, PSCI, intc, timer and clock controller.
> 
> Required clock controller driver and RPMH cloks are added to
> support peripherals like USB.
> 
> All this configuration is added to support SM8250 to boot up to the
> serial console.
> 
> This patchset depends on one of the RPMH clock driver fix
> https://patchwork.kernel.org/patch/11318949/

Whole series:

Tested-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
