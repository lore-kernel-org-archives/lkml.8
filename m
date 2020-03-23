Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA261C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BF6206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584943639;
	bh=ibPYCWGXC+3W4pwXBMCDZLajjZQWIs4y9VSQ1PY2kkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YWM0e+Ts6UwYW9767e+tWgvoYA2PdTDBrY6vDtbZiDHjPFkao0ywMsZg33P0Vhh8y
	 ADz65wi5W5ghKpn2mggbI4obDDGgprTLJrVOy7u4cxhlBaBuom3n0bfE88GPlXL9J8
	 t2tQNGdMWe7GYsDs1FsGmwvxnicdMZSDbKcbIvNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgCWGHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 02:07:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgCWGHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 02:07:18 -0400
Received: from localhost (unknown [171.76.96.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DD4C206C3;
        Mon, 23 Mar 2020 06:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584943637;
        bh=ibPYCWGXC+3W4pwXBMCDZLajjZQWIs4y9VSQ1PY2kkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+AKXtTiEx2F4fvV576lTkypnagA0PkvNzMXSxvZCfsQ+YIHsqHbXosnbB9ZvN8mv
         F3NhqdKp08F1Skw1MDp4NuKvE1w/xHqo5uPtiVFbcDk/CGoTaa649qlUQdGtAiFLc6
         oPfZ4DmvrU+yToy7LBmg3A4VuQ+ng8ms2q+SF7Jg=
Date:   Mon, 23 Mar 2020 11:37:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     dan.j.williams@intel.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: sprd: Set request pending flag when DMA
 controller is active
Message-ID: <20200323060713.GC72691@vkoul-mobl>
References: <02adbe4364ec436ec2c5bc8fd2386bab98edd884.1584019223.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02adbe4364ec436ec2c5bc8fd2386bab98edd884.1584019223.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-03-20, 21:26, Baolin Wang wrote:
> From: Zhenfang Wang <zhenfang.wang@unisoc.com>
> 
> On new Spreadtrum platforms, when the CPU enters idle, it will close
> the DMA controllers' clock to save power if the DMA controller is not
> busy. Moreover the DMA controller's busy signal depends on the DMA
> enable flag and the request pending flag.
> 
> When DMA controller starts to transfer data, which means we already
> set the DMA enable flag, but now we should also set the request pending
> flag, in case the DMA clock will be closed accidentally if the CPU
> can not detect the DMA controller's busy signal.

Applied, thanks

-- 
~Vinod
