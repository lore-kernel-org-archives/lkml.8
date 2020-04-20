Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53618C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33CDB2078E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587366738;
	bh=xmp2pU3RNE4pr1Ih5vZDQepEAmdemu2mXawUuujDOY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kBK7wbmvF7WI5q3f0IKn3pghDyqPCFCoLo15H/a1B4lVsq1fSA1fxyjzRkTA7Ep8b
	 uCLjGNgiCAU1fmIPprnR40CREUxbQcM6VLItH7ESd6M+SP7Vlr26Bh4u0Uh1yNbiWx
	 k7bMTCHDpLhKj0Sa7bRWiQ7yvdP6Eh0vbFm95SJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgDTHMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTHMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 03:12:17 -0400
Received: from localhost (unknown [171.61.106.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8E16206E9;
        Mon, 20 Apr 2020 07:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587366736;
        bh=xmp2pU3RNE4pr1Ih5vZDQepEAmdemu2mXawUuujDOY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DZ0NmxhVZhMWlJBq51+bYc9KbAiIhoWZud5Xop9HpuJLReMuFy+FDfO0w54j9he2D
         g80QpRhottoQtlpQ9EOdlte9Xu5yvdHdeAFTOUx33h7RRfFIP6ppq+G3qRBt4XtFyQ
         LALOpWE40Dm9wCvR/rkv2WTPYcnaZzID3sGhvWFQ=
Date:   Mon, 20 Apr 2020 12:42:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] soundwire: intel: Make sdw_intel_init static
Message-ID: <20200420071212.GV72691@vkoul-mobl>
References: <20200410115708.27708-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410115708.27708-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-04-20, 19:57, YueHaibing wrote:
> Fix sparse warning:
> 
> drivers/soundwire/intel_init.c:193:6: warning:
>  symbol 'sdw_intel_init' was not declared. Should it be static?

Applied, thanks

-- 
~Vinod
