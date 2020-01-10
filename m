Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9614C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9920520838
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578642375;
	bh=8ADsNC4aByvOIz1Pl29Go90LRKxU6fl1luPK7QjlgWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nCkeK2SSI2KI9VZaF+UUBXOHvmqo4Icaz3s4hV4hp+IkFYxkGcMqYpzYz7d0Z7pdg
	 jOoxx0LDxgBYsQ7SHIUl4L3fwU3YMgfkYP/bG2WecxqBAnW0wUea29YYaEkjCpX5VQ
	 TpAK4mzUzIg5BfLZ1ZxtnXtTmUWsReLN0sGNmsR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgAJHqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:46:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgAJHqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:46:14 -0500
Received: from localhost (unknown [223.226.110.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A90E42080D;
        Fri, 10 Jan 2020 07:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578642373;
        bh=8ADsNC4aByvOIz1Pl29Go90LRKxU6fl1luPK7QjlgWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=szWnKRft82X+GbunxqZ3pu0hXwcVAwCZLFfKRZY8Mke2USKX8z12JHL8OM04UP8l5
         YA0KCp8m78f1vFwR3rqz7fdSW3q3FPj0/Q1Ho/RskDr2UQF7lw/bUHH01L380L582g
         m1uhyeN0AwP2HJWXyDuigxX3uTQobOINIUkw70Hs=
Date:   Fri, 10 Jan 2020 13:16:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next][V2] dmaengine: ti: omap-dma: don't allow a null
 od->plat pointer to be dereferenced
Message-ID: <20200110074605.GD2818@vkoul-mobl>
References: <20200109131953.157154-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109131953.157154-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-01-20, 13:19, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently when the call to dev_get_platdata returns null the driver issues
> a warning and then later dereferences the null pointer.  Avoid this issue
> by returning -ENODEV errror rather when the platform data is null and

s/errror/error :) never thought would correct Colin on spelling :)

With the typo fixes:

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
