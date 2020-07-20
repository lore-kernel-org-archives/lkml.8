Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB66C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5927422B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595226352;
	bh=yfBTJcyyrH2HG3I5sIo8rfUoGpnlWKju/GhSCrKwek0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hizSRPvLAab+Bvd5Sx9tb4u7aXSk03a5XNN7VaJuWnHvrbch6fG3AFxEQ57bpva2M
	 KadGrqxZFRcSZwMBPSMYbC5DEIQdMHjXPbghwCeabDUzmm0iHEs3fot1KZVChnF+ta
	 zu1SyTgtlvj4GWE3z+kFgUnExf5WRv3xNT8UVIwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgGTGZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:25:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgGTGZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:25:50 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03FE621775;
        Mon, 20 Jul 2020 06:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595226350;
        bh=yfBTJcyyrH2HG3I5sIo8rfUoGpnlWKju/GhSCrKwek0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BqI77YOjr+uQQAWCUQmmNgTEMrBVTKcMKHuuQo3fiYfT5aSEtZKIDOOoqUZM05ctk
         ENadw/WpuDhAn2bW4RuXw09GehAUL3yKcXh5jRR1gI7a27qCXjNpMkOu7egPCDSTui
         v6aTrEquTDFO05cnjTuF6weF8AXgkOQdhWlrMg2Q=
Date:   Mon, 20 Jul 2020 11:55:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@codeaurora.org>,
        Jonathan McDowell <noodles@earth.li>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v10 1/2] phy: qualcomm: add qcom ipq806x dwc usb phy
 driver
Message-ID: <20200720062545.GC12965@vkoul-mobl>
References: <20200717131635.11076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717131635.11076-1-ansuelsmth@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-07-20, 15:16, Ansuel Smith wrote:
> This has lost in the original push for the dwc3 qcom driver.
> This is needed for ipq806x SoC as without this the usb ports
> doesn't work at all.

Applied both, thanks

My script found below errors with W=1, can you please send fixes for
these

drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c:140: warning: Function parameter or member 'phy_dwc3' not described in 'usb_phy_write_readback'
drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c:140: warning: Function parameter or member 'offset' not described in 'usb_phy_write_readback'
drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c:140: warning: Function parameter or member 'mask' not described in 'usb_phy_write_readback'
drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c:140: warning: Function parameter or member 'val' not described in 'usb_phy_write_readback'
drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c:182: warning: Function parameter or member 'phy_dwc3' not described in 'usb_ss_write_phycreg'
drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c:182: warning: Function parameter or member 'addr' not described in 'usb_ss_write_phycreg'
drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c:182: warning: Function parameter or member 'val' not described in 'usb_ss_write_phycreg'
drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c:219: warning: Function parameter or member 'phy_dwc3' not described in 'usb_ss_read_phycreg'
drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c:219: warning: Function parameter or member 'addr' not described in 'usb_ss_read_phycreg'
drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c:219: warning: Function parameter or member 'val' not described in 'usb_ss_read_phycreg'

-- 
~Vinod
