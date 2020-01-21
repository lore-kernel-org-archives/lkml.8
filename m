Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A5EC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9865524653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579620037;
	bh=9sf2KtTQ+oqPfeZznL8DIC/Lpfwzai3l/60AOvslJ28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lg6PpsSf4YeHeDFwQYTTOP0nYcIfUnj+pc84M/gAeL13i16IRgkwqE9anH+8MKdRW
	 uyp4uCfecbfvZe9mUrRYXqekX13AVEaT9EYsrfIweGfrEgdZYpvZjtKwtU6+X/mvuB
	 FejUxDN26V9V9VSH6gTcOrfJPNh4W04V/gslRwkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgAUPUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:20:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgAUPUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:20:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FA3524125;
        Tue, 21 Jan 2020 15:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579620034;
        bh=9sf2KtTQ+oqPfeZznL8DIC/Lpfwzai3l/60AOvslJ28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VzAKX1g/i2A6DEwN9YAYPt3JSdB72Z9S0V5tpNBv4yNgDO8XRar9EUv18K88wZxCN
         cRm+ww02Vir1xWhB41bD9unI0uV/NvGGWHIu8cJCltpdQQFr5jzmb/fLNqw69NDXGe
         2xllSSY9HLW1tRCz0OQYjbKeHsflRunBKkTieG/o=
Date:   Tue, 21 Jan 2020 16:20:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     jens.wiklander@linaro.org, tee-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: optee: Fix compilation issue.
Message-ID: <20200121152031.GA572414@kroah.com>
References: <20200110122807.49617-1-vincenzo.frascino@arm.com>
 <8fa0e5b3-6e88-3fa2-9e16-046350cc752b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fa0e5b3-6e88-3fa2-9e16-046350cc752b@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 02:23:02PM +0000, Vincenzo Frascino wrote:
> Hi Greg,
> 
> I sent the fix below few days ago to the optee maintaners but I did not get any
> answer. Could you please pick it up?

	 $ ./scripts/get_maintainer.pl --file drivers/tee/optee/Kconfig
	Jens Wiklander <jens.wiklander@linaro.org> (maintainer:OP-TEE DRIVER)
	tee-dev@lists.linaro.org (open list:OP-TEE DRIVER)
	linux-kernel@vger.kernel.org (open list)

This should go through Jens, why me?

greg k-h
