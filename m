Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025C0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D36C32073E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592899780;
	bh=RmyJ82t4G4pZWa40AMFtfjcgoaWtdCWYC96UkmoiQjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZJ7LaEXKoJ9Zt4rlXgJvsXOXFsARUX4C9LHfmI0ZYdB67agbVC/FQvN8e3ojNGZ5C
	 eCW7HkN5nCaYCBLxP9tSHluWO0wtPxwPrgPgjT8aQyZiMUhEAb002bSbNnriquP4xT
	 9K4Ocibc9agiknvBbYKF6+jcOELVjyNL0aNeyV1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbgFWIJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:09:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731158AbgFWIJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:09:39 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20CE420716;
        Tue, 23 Jun 2020 08:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592899779;
        bh=RmyJ82t4G4pZWa40AMFtfjcgoaWtdCWYC96UkmoiQjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UljooBB81yM7ijLuOhpq3XMwNdRJGOOOSzAr+ei4jw7Qd1B6TcgZxEd0AhviZ1X0R
         dqMrO44V/YcTy+/3HWUhE3rC5NQXjr9eqvgKpg5V7/dXIuVzZ9AS2speRMzYgxXmFq
         xTJXZKO5YX/Xlm3S/XrtXScFAEs20htPNFPNCihM=
Date:   Tue, 23 Jun 2020 13:39:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] arm64: dts: qcom: Enable SM8250 remoteprocs
Message-ID: <20200623080933.GQ2324254@vkoul-mobl>
References: <20200622222747.717306-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622222747.717306-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-06-20, 15:27, Bjorn Andersson wrote:
> With the driver code in place, add the necessary dts nodes to enable three of
> the remoteprocs found on Qualcomm SM8250 and finally enable the missing
> QCOM_IPCC driver in defconfig.

All look great to me:

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
