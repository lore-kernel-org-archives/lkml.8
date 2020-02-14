Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031CAC3B194
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 03:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5A9222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 03:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581651608;
	bh=I0SXNiBQ/dripHcfy1hs98Y2yp5mekzCc8CsjZHMorE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FbPcOl2WGjylZPBPMTfJvg9ZD1DPoqDR0fB3saRF5ZujorBmcyOkJw4mHY4nOqQzv
	 A0dKV9DRjK/ZzPoz+tZoli3rNNPc1GUL6dqhvmRK+1fiPljEOj/pHHH4mGgx0dfw3C
	 w0EKd7rXG6Ra/QUYZ0XHcfSKplVj9XeXI/e79FHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgBNDkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 22:40:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:50390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbgBNDkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 22:40:08 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1877D206ED;
        Fri, 14 Feb 2020 03:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581651607;
        bh=I0SXNiBQ/dripHcfy1hs98Y2yp5mekzCc8CsjZHMorE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wsBFkoUyopb2IzuOGEMS+azX9KztOzdQ1MH2po6DGegBegDhUCpGl01XzC2Fn0wJI
         JtEhGZuV27oje32ofd3z8Xe4Tqsyu/eYjFSrqrI+N6Jzirw/lSjtAmjUAlS04Vyxlt
         4nhdVGKlvPZYd+11f9gG9JDmo2la7hNvwX+qUhkg=
Date:   Fri, 14 Feb 2020 11:40:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: dts: ls1088a: support eMMC HS200 speed mode for
 RDB board
Message-ID: <20200214034001.GR22842@dragon>
References: <20200204040928.32320-1-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204040928.32320-1-yangbo.lu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 12:09:28PM +0800, Yangbo Lu wrote:
> This patch is to add eMMC HS200 speed mode support on ls1088ardb
> whose controller and peripheral circut support such capability.
> And clocks dts property is needed for driver to get peripheral
> clock value used for this speed mode.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied, thanks.
