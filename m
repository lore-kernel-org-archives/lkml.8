Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46368C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177FF20746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584102914;
	bh=i/t72OmKWsLrwARwJcvgA70p5Pnob77bxl0WH2IjCks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fQE6/nqPxvs3CvQKSwLn1FaJZQDkfDeKDeOeGJLtxSx8l+H5iGanqmPi2X6NQM0zU
	 89rBK2vwWAQUxxOVAoYat1ycCtnXdPfwbuAyl1IYpgd6uBHi8dhQnTsG87/Bv/5iMY
	 BWVBZCn3C0BsGghu0vDJP6GvBVa5SdlD5YftVySA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgCMMfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbgCMMfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:35:12 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC59F20724;
        Fri, 13 Mar 2020 12:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584102911;
        bh=i/t72OmKWsLrwARwJcvgA70p5Pnob77bxl0WH2IjCks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JlGNzfJmTWFvrzLg6M0B5VNMOJXtqRboPUEyyppSFI8Dq/y55h+SoBEYG5yo0e7rF
         meRSsTW4ht0H53ZliQlaiw0zI98nfZhv2ew6vGIJpTwj+doo3KYdXaXCW0Ex5/8VvQ
         3gcUpzXbmlKaHhGsNtF6HPpp9neC2Ofdx0U1JhG8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jCjWw-00CTv2-5B; Fri, 13 Mar 2020 12:35:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Mar 2020 12:35:10 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org,
        Nianyao Tang <tangnianyao@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] irqchip/gic-v4: Fix non-stick page size error for setup
 GITS_BASER
In-Reply-To: <9a00642020fe660e005045913b57fd20@kernel.org>
References: <1584089195-63897-1-git-send-email-zhangshaokun@hisilicon.com>
 <9a00642020fe660e005045913b57fd20@kernel.org>
Message-ID: <02159eb7ba2667e3ddea658ff4b3cb92@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: zhangshaokun@hisilicon.com, linux-kernel@vger.kernel.org, tangnianyao@huawei.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-13 12:00, Marc Zyngier wrote:

[...]

The astute reader will have noticed that I've sent the wrong patch:

> +static int its_probe_baser_psz(struct its_node *its, struct its_baser 
> *baser)
> +{
> +	u64 psz = SZ_64K;
> +
> +	while (psz) {
> +		u64 val, gpsz;
> +
> +		val = its_read_baser(its, baser);
> +		val &= ~GITS_BASER_PAGE_SIZE_MASK;
> +
> +		switch (psz) {
> +		case SZ_64K:
> +			gpsz = GITS_BASER_PAGE_SIZE_64K;
> +			break;
> +		case SZ_16K:
> +			gpsz = GITS_BASER_PAGE_SIZE_16K;
> +			break;
> +		case SZ_4K:
> +		default:
> +			gpsz = GITS_BASER_PAGE_SIZE_4K;
> +			break;
> +		}
> +
> +		gpz >>= GITS_BASER_PAGE_SIZE_SHIFT;

s/gpz/gpsz/

Sorry for the noise,

         M.
-- 
Jazz is not dead. It just smells funny...
