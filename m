Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290D2C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036E8206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594792567;
	bh=WngwdGyYHv54+sJ4atFfeahvAQwaQ/tvDayGd66RYAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o4U1wrvrT1p1+tiWF1mXBuaGVCVtYVYdSdP8zO2Nynlf8mMiWJ99Hwrc1UKz6mtAZ
	 nzfbvrJRIRSntMyESvXYpp/SP9eShB690VcxYIRecwwSmez7XZbvurJXpDBFsHz38w
	 7XqdSlZk+hVnn1TpVLD9vl2hiKmcU/Rf0ELQcAOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgGOF4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 01:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgGOF4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 01:56:05 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F184220663;
        Wed, 15 Jul 2020 05:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594792565;
        bh=WngwdGyYHv54+sJ4atFfeahvAQwaQ/tvDayGd66RYAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CWjnonOMHsVKh8pGao0XttIFQLkJfxxmoZlR5YNZnk3vP98LwQSOw2RibmmR6C/x5
         l9IGnYTZMUZ3g/uXhp8NxS8zI+LzY3gionXVHP7Slu8p4ZI5WT98LGlK+7dp37x3m8
         mscG1Z3Tu2NptPRVGEPlHkFpg2GkbQaa0bhP3njI=
Date:   Wed, 15 Jul 2020 11:26:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/14] dmaengine: pl330: Add quirk
 'arm,pl330-periph-burst'
Message-ID: <20200715055600.GV34333@vkoul-mobl>
References: <1593439555-68130-1-git-send-email-sugar.zhang@rock-chips.com>
 <1593439555-68130-5-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593439555-68130-5-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-20, 22:05, Sugar Zhang wrote:
> This patch adds the qurik to use burst transfers only
> for pl330 controller, even for request with a length of 1.
> 
> Although, the correct way should be: if the peripheral request
> length is 1, the peripheral should use SINGLE request, and then
> notify the dmac using SINGLE mode by src/dst_maxburst with 1.
> 
> For example, on the Rockchip SoCs, all the peripherals can use
> SINGLE or BURST request by setting GRF registers. it is possible
> that if these peripheral drivers are used only for Rockchip SoCs.
> Unfortunately, it's not, such as dw uart, which is used so widely,
> and we can't set src/dst_maxburst according to the SoCs' specific
> to compatible with all the other SoCs.
> 
> So, for convenience, all the peripherals are set as BURST request
> by default on the Rockchip SoCs. even for request with a length of 1.
> the current pl330 driver will perform SINGLE transfer if the client's
> maxburst is 1, which still should be working according to chapter 2.6.6
> of datasheet which describe how DMAC performs SINGLE transfers for
> a BURST request. Unfortunately, it's broken on the Rockchip SoCs,
> which support only matching transfers, such as BURST transfer for
> BURST request, SINGLE transfer for SINGLE request.
> 
> Finally, we add the quirk to specify pl330 to use burst transfers only.

Applied, thanks

-- 
~Vinod
