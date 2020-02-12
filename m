Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4F2C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA2D2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581513146;
	bh=ULaONeH94zlU1vOo5QKGOovqZntE9NYsR47psm0uNPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cfb9obhBlBbfxHVR7zc6I7laOve1qhgL0gJFOPfXSoPlFSVExe8FYwuXGf+f2tEgq
	 BWglryt5gwMaX7OuosOwGZldAxFcFDihOdNPYgXdH4DIbvDXD8ain9KFfvnyZcxXQp
	 lks+NGsDRyKm87yQxQhNVxOW2CstgJubOpQpT/jA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgBLNMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 08:12:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgBLNMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 08:12:24 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EAA02073C;
        Wed, 12 Feb 2020 13:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581513144;
        bh=ULaONeH94zlU1vOo5QKGOovqZntE9NYsR47psm0uNPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uVgAJwq8I/Nvyyl74jG9qwgTMgBmL+Untudl8d6PHcgjdA6TPwIH7w34tld2vdA1p
         McywUR/Tal4dzgSAdHbK05+kCtCJNnMWmwFK2ec/vp6IcztXiusA0LaNBWkU+909sr
         7JC0XsRwsEZSQGmO0BSUrxfuHaRRBcnfO1+aZ/w8=
Date:   Wed, 12 Feb 2020 08:12:23 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [stable 4.19][PATCH 0/3] stable: Candidates for 4.19.y
Message-ID: <20200212131223.GB32735@sasha-vm>
References: <20200210171827.29693-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200210171827.29693-1-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:18:24AM -0700, Mathieu Poirier wrote:
>Please consider for 4.19.y - applies cleanly on 4.19.102.
>
>All three patches are already in 5.4.y so no need to apply them there as well.
>
>Thanks,
>Mathieu
>
>Boris Brezillon (1):
>  spi: spi-mem: Add extra sanity checks on the op param
>
>Brandon Maier (1):
>  gpio: zynq: Report gpio direction at boot
>
>Shubhrajyoti Datta (1):
>  serial: uartps: Add a timeout to the tx empty wait
>
> drivers/gpio/gpio-zynq.c           | 23 +++++++++++++
> drivers/spi/spi-mem.c              | 54 ++++++++++++++++++++++++++----
> drivers/tty/serial/xilinx_uartps.c | 14 +++++---
> 3 files changed, 81 insertions(+), 10 deletions(-)

I've queued them up, thank you.

-- 
Thanks,
Sasha
