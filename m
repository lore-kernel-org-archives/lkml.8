Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B5AC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F6A20775
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599117860;
	bh=45bOe8xPSLyWjxEwmT3mkQGrBEyK6yq7uVCdNkbtkkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bULLyqRg91eQ2e/e8YZQYunyoDxG5sLhmH9loiII65t5pP9eakJ3nIHCfzREP3i9C
	 RuzBCqUvD02HSqsSZ8wbm7/3/Uh4mPGIR/E55EdIQcHHTREDUzM17h+FNV3aNS3nPX
	 ILO5s6mE1S/KHUhkSIKmxq5p3MmX0xfF7PeIcR+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgICHYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 03:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbgICHYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 03:24:16 -0400
Received: from localhost (unknown [122.171.179.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B827420737;
        Thu,  3 Sep 2020 07:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599117855;
        bh=45bOe8xPSLyWjxEwmT3mkQGrBEyK6yq7uVCdNkbtkkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tGAY22wqMMrWBvOVSGJADzyX+M5ip3jvRe+CCum/aS8D7wq3pBhD4eur1rDeuzXH1
         TeaGc858A9c7VZ3058FK2c5zcz7obB9Gah8hcQynZL0/yar5fVdkLj5SP31j0d4KML
         xlSer+WT4O+lqO2BYhma66BvB8nUxgfG3XMT2Ymk=
Date:   Thu, 3 Sep 2020 12:54:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, lokeshvutla@ti.com, nm@ti.com
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Update rchan_oes_offset for
 am654 SYSFW ABI 3.0
Message-ID: <20200903072411.GL2639@vkoul-mobl>
References: <20200831091019.25273-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831091019.25273-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-08-20, 12:10, Peter Ujfalusi wrote:
> SYSFW ABI 3.0 has changed the rchan_oes_offset value for am654 to support
> SR2.
> 
> Since the kernel now needs SYSFW API 3.0 to work because the merged irqchip
> update, we need to also update the am654 rchan_oes_offset.

Applied to fixes, thanks

-- 
~Vinod
