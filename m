Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521BEC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C9B821473
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587450755;
	bh=jGAXJeWr5/6Veu9ibsJ8kj+D/t6QSaGx2nZQeS1ZQ4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kkQZfDyNQRXcZ9Wt5Pgg4bA1xGV+FS4iXRHgP8iZSM2jUeEvRWiON92cRRIWthVH2
	 tSvXAxjyGhyz3XRQRM9Jy7LN/YIlBMZBtLGn8V2SnhJwb7t+aSyQKjQH2a/j8bb6Rb
	 OeHoRBv0k+CUd+y17hs8BmxiAm+io2IcKzs/IL80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgDUGce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:32:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgDUGce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 02:32:34 -0400
Received: from localhost (unknown [106.51.105.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E84520CC7;
        Tue, 21 Apr 2020 06:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587450753;
        bh=jGAXJeWr5/6Veu9ibsJ8kj+D/t6QSaGx2nZQeS1ZQ4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vwOqag6wb29NRdxLivPUWe3pHAyoPJlJUaGgrXf4ftS/CCq5ZbvlEwIvvBzMaa469
         PQ6CGbgjrGZJHS9yRcYjuQeJEZIZn/BawwhaChxy8Ro6gmEGEe6cAY5CRp7IQC8OHA
         R5JVwM9Qs+BNjgspjy0NA3thORgLpKpd226a8dN0=
Date:   Tue, 21 Apr 2020 12:02:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] phy: qcom: qmp: Add SM8250 UFS PHY
Message-ID: <20200421063229.GC72691@vkoul-mobl>
References: <20200415060745.740193-1-bjorn.andersson@linaro.org>
 <20200420214958.GA23753@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420214958.GA23753@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-20, 16:49, Rob Herring wrote:
> On Tue, 14 Apr 2020 23:07:45 -0700, Bjorn Andersson wrote:
> > The SM8250 UFS PHY can run off the same initialization sequence as
> > SM8150, but add the compatible to allow future changes.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 5 +++++
> >  drivers/phy/qualcomm/phy-qcom-qmp.c                    | 3 +++
> >  2 files changed, 8 insertions(+)
> > 
> 
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Vinod Koul <vkoul@kernel.org>
Tested-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
