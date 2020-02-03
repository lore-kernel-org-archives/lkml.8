Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3E1C3524C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 04:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016CA20842
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 04:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580703575;
	bh=IH7MZ7wfVCS98XcAo+WOXS9G/+El1YXtx/1W25OAr+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vh2DU0bKHwtLnKEvWndu+68CMf8QXCyG2LLFar3xTkJjqx4vPLrh0S7SFcn8A+Vf+
	 kUNYBtW8PSzVEPNPeZvNiT2OJ2qH2RjeD2qQzwQ5ZJj1naanHPYeETmVtBy0VebI1e
	 jzpOQqYQDmZetu/U5A/nEJ58Vlfnv9eJ7Py7q5iQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgBCETe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 23:19:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbgBCETe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 23:19:34 -0500
Received: from localhost (unknown [223.226.103.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 013602073C;
        Mon,  3 Feb 2020 04:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580703573;
        bh=IH7MZ7wfVCS98XcAo+WOXS9G/+El1YXtx/1W25OAr+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bz/72cVcnoviSQTRjp0qwJH35Q19OHlEbGx8zZ4lazlmtLV/piMohBmFgk2fYXeF4
         Z3PYhThdmMtp6rUwYhTRPaLjiimerkyOpPorNc5pzS07bk2nGwtewL9LIiRijdTPY1
         qOfj2wXkmu2NdJHp1OtcEsprnjPEJ5PSV4yKpO8Y=
Date:   Mon, 3 Feb 2020 09:49:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, geert@linux-m68k.org
Subject: Re: [PATCH v2 1/2] dmaengine: Cleanups for the slave <-> channel
 symlink support
Message-ID: <20200203041929.GM2841@vkoul-mobl>
References: <20200131093859.3311-1-peter.ujfalusi@ti.com>
 <20200131093859.3311-2-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131093859.3311-2-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-01-20, 11:38, Peter Ujfalusi wrote:
> No need to use goto to jump over the
> return chan ? chan : ERR_PTR(-EPROBE_DEFER);
> We can just revert the check and return right there.
> 
> Do not fail the channel request if the chan->name allocation fails, but
> print a warning about it.
> 
> Change the dev_err to dev_warn if sysfs_create_link() fails as it is not
> fatal.
> 
> Only attempt to remove the DMA_SLAVE_NAME symlink if it is created - or it
> was attempted to be created.

Applied, thanks

-- 
~Vinod
