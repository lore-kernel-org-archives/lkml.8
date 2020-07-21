Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B96C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ECC32077D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595327972;
	bh=U0sVikXk3qg3GuaghnJo39nR0ESWg87gR3hoWnZowRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vXJJ7gT5ak04X7MYO5htkCOjtDK6FLQ4o02F3gwHwE1b2zfWaCPhIbK6rz1xwyfIk
	 GMplxFaZ9puAJsdmKSedWEIINJp8gKXbkfe5R/S2IWmeaFYk+7sq9hrJFJETaHLHw7
	 eBIV6u2vmipsKS6PsTC6/i1mg8cneweUSx8kTDGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgGUKjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgGUKjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:39:31 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B061D20714;
        Tue, 21 Jul 2020 10:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595327970;
        bh=U0sVikXk3qg3GuaghnJo39nR0ESWg87gR3hoWnZowRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l1NCUl2MyGU/4UZJhd/gkPt2r7OxYVp+nTK1FfqXS/On9VEWNIvVe0+9tSgGzASOB
         m511F2wftLAubxbD2Rxr3RAgWBhFbFDyDVC2dibNkDxUxkxDCcYgPXX/jOsdLli5Al
         dUPt4pHAT3NI/iHYb+kCRqHr37t7mtwzlMNYStKE=
Date:   Tue, 21 Jul 2020 16:09:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Seungwon Jeon <essuuj@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2][next] phy: samsung-ufs: Fix IS_ERR argument
Message-ID: <20200721103926.GM12965@vkoul-mobl>
References: <20200720132718.GA13413@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720132718.GA13413@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-20, 08:27, Gustavo A. R. Silva wrote:
> Fix IS_ERR argument in samsung_ufs_phy_symbol_clk_init(). The proper
> argument to be passed to IS_ERR() is phy->rx1_symbol_clk.
> 
> This bug was detected with the help of Coccinelle.

Applied, thanks

-- 
~Vinod
