Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D741C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D87AF20792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595353347;
	bh=4OevMx9uMIoav+Swk+McjWTokdsX9C23mmK745+ZYTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rEemvem5Elp+tamqfUiRyqpj7B+AgSO+xgAsEysTqa/NcvdRd424UDufQiMUdvy9T
	 i/LNhYT8rmOlHzEdMC9OHRNr5yXGCNCUIADIGzOrsETPYs3M2qaZbNL6REKrKyMSPy
	 c0KW1znH1UimfXUeNjZlwuaIcwxGo42OMYKpwigk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbgGURmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730383AbgGURmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:42:12 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6DCE20792;
        Tue, 21 Jul 2020 17:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595353331;
        bh=4OevMx9uMIoav+Swk+McjWTokdsX9C23mmK745+ZYTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZKg7+l7gcgWou1XcZJ5oNSObkAqLRyTwRH31sSOxQU2cbpeo1xatMahyrj+RmqUR+
         lGnRc3eHI3whFeY3qqr74SAsl3hvE1T/27x1CVaS2nnC/u9LBTi4y9bF5XAqdTYaiB
         T5xKCUyPfZEOsisos2rwt3DmIsHEmoIFBT3vgTt8=
Date:   Tue, 21 Jul 2020 23:12:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] phy: qualcomm: fix setting of tx_deamp_3_5db when
 device property read fails
Message-ID: <20200721174207.GP12965@vkoul-mobl>
References: <20200721150613.416876-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721150613.416876-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-07-20, 16:06, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently when reading of the device property for "qcom,tx-deamp_3_5db"
> fails the default is being assigned incorrectly to phy_dwc3->rx_eq. This
> looks like a copy-n-paste error and in fact should be assigning the
> default instead to phy_dwc3->tx_deamp_3_5db

Applied, thanks

-- 
~Vinod
