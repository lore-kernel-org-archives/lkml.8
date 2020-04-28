Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B5DC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91F12206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588049742;
	bh=bJ2GA1cKnRxJvK/h1+T9DCVtgtktPWAAKYcd7I1gnpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qc0Yr+eRequASiRCozK6EH7mbFLU8VMQ7TMlswltLwEcfqb+VpGzc/BpIoYKjhRfd
	 FQnHLhnSNMXjmXBedqqqc3P4rUJ4bWAhTsMvA3K39nw0t30KplwuUe8sYcciuCSZTl
	 +vc/Gso/tzo1yNpMLUULqAyiN7UI2LHfx65q0A7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgD1Ezl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 00:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgD1Ezl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 00:55:41 -0400
Received: from localhost (unknown [106.51.110.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3517C20661;
        Tue, 28 Apr 2020 04:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588049741;
        bh=bJ2GA1cKnRxJvK/h1+T9DCVtgtktPWAAKYcd7I1gnpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nDdkMYnUzH3RqTO30Cf7BScxO6W+DRjTMKLRBs6rhtKXpuMGOy3QLMqLaPW7g9YPe
         N9xRxCT6ergYAN5u6zkpKyirNx7pXoN/mtvNIbZ80Apmui0Ie1mmB6yAA640Y26UjI
         5CTkyPu5yL1AOqHetXg09XMQzRHgVNuKzdeZq/wE=
Date:   Tue, 28 Apr 2020 10:25:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: qualcomm: usb-hs-28nm: Prepare clocks in init
Message-ID: <20200428045536.GX56386@vkoul-mobl.Dlink>
References: <20200408012854.3070187-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408012854.3070187-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-04-20, 18:28, Bjorn Andersson wrote:
> The AHB clock must be on for qcom_snps_hsphy_init() to be able to write
> the initialization sequence to the hardware, so move the clock
> enablement to phy init and exit.

Applied, thanks

-- 
~Vinod
