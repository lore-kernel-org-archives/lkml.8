Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D7FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A932074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="h0SJbmV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgE2S2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2S2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:28:45 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C679AC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 11:28:45 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f18so3159775qkh.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 11:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rlk86kD0Y7ZOuChtwAZS53JYDyHUYd9q2w1SiVXgwbo=;
        b=h0SJbmV2uzmAUrZfGfMgUPc46S/5zrVSX6Cb0OR+d5wx+0QPaLV5Miv1wVCt1J3sz5
         RotknK3P1E7fEZ6COa2LeUNBaMEvS/3KBfZglnMyx4CfHMxndG1WYgJUv376z4dBoO5p
         xOhxktzrIxtXcPw/40+4DbiZbMaIXdrGv7hrEgZ2UJxDu3WNCm0iGOuf2VtkRTeI+PVo
         CiCx2385cqyh6nDsgkh8ElmHtAdqUGWD9pOT4nOxOWpxUOM/TpOuY3uHG23me5NorhQF
         4e/YbcSMdcRxpdpH2yKTL6LzHRh6716lDEvT/kTUc1Q0P6hufI+8knm4kNi/Dd3KzfJN
         GNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rlk86kD0Y7ZOuChtwAZS53JYDyHUYd9q2w1SiVXgwbo=;
        b=iFDeRejSyhRmH4pjw1AWLTiSnwOenCrsbWux7rMDe2dG18XKBlBZ1UDuL2adtRRgmE
         n9LnbAlbmVKShbZm0HVCeepLQgaItviUv4cW7fR1duuAQkuTjCJegtECOdpcwyqOAYRz
         yC3ns02M6w6HxFjuuSwH3Bw7z5ryCz8Dr9Bjz3qqTFEp/W3FubqNsuMkEAFhFcdEgXO+
         kMhcoSTzqzqva9ezKX4MlOyUJi6jEJ+w4wVrN6fGMWeloVX6QvZRXAZ0IELLYQsOSddR
         Ey8NDqYuovuldwb6gbgdlyjL33rZdWGlt0gwkQS0ZnsJtDLBa5o9jc3wXg+yPhedTWLv
         Qf5Q==
X-Gm-Message-State: AOAM533Pkrm5qZtOYUVLyQ295KhY0CDnMFWbrG8M/UmHtD7/CMnubZ8G
        8MrjM5K3Ynohkzw6OeOni+ecxBaDf08=
X-Google-Smtp-Source: ABdhPJyzFCE2FvOpDacsYiCwEegwzE2n8yyVo/63fObTpaWl8qYNnIcz7Ue211P3mhfmAuCC9bWKsw==
X-Received: by 2002:a05:620a:200a:: with SMTP id c10mr8881132qka.218.1590776925083;
        Fri, 29 May 2020 11:28:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id p6sm1121953qtd.91.2020.05.29.11.28.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 11:28:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jejkK-0004oP-1k; Fri, 29 May 2020 15:28:44 -0300
Date:   Fri, 29 May 2020 15:28:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] IB/hfi1: fix spelling mistake "enought" -> "enough"
Message-ID: <20200529182844.GA18470@ziepe.ca>
References: <20200528110709.400935-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528110709.400935-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:07:09PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/hfi1/chip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
