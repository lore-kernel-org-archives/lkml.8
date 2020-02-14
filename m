Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8558BC3B194
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A0E222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581655278;
	bh=wVKIdBrd3Ac8mi+gtYfIqNH2CSIDdbp5qmT4y6oqSA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KIvlTfQANQmIjQ7N3RnKPlt2jPZhkbS9w9ePU6mdMR3mphmOiqTztfVblfHMU/z5/
	 +FIZRIO3qr7xX/kLi78inXxploA+pHP/udi6SMKKvFqfg9e2QNtub7erLHQ0LBbM6F
	 J8UxMrBTK0t43o3R/yCm75L9achIpwo8J6TQ8Jzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgBNElR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 23:41:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbgBNElR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 23:41:17 -0500
Received: from localhost (unknown [106.201.58.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 012DB20848;
        Fri, 14 Feb 2020 04:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581655276;
        bh=wVKIdBrd3Ac8mi+gtYfIqNH2CSIDdbp5qmT4y6oqSA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kppw4Om6KioykAquIfylJ6LG1JLLkC7m/rRJdBCuv0ZYFAtG/6izAPbssYhvS09Z7
         FiIgrg4U6JpgLZTQbEpML+xmKPOJERRuCtVxdSxZznL6TMhSmnbrmxoMlRczT9Rqmy
         jFS+20r9ULd6tzkVXJ1vBjYu4WRlvrHhNFi3X6R8=
Date:   Fri, 14 Feb 2020 10:11:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: linux-next: build warning after merge of the slave-dma tree
Message-ID: <20200214044112.GT2618@vkoul-mobl>
References: <20200214110039.51369fae@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214110039.51369fae@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On 14-02-20, 11:00, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the slave-dma tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> drivers/dma/sun4i-dma.c: In function 'sun4i_dma_prep_dma_cyclic':
> drivers/dma/sun4i-dma.c:30:51: warning: statement with no effect [-Wunused-value]
>    30 | #define SUN4I_DMA_CFG_SRC_ADDR_MODE(mode) ((mode) << 5)
>       |                                           ~~~~~~~~^~~~~
> drivers/dma/sun4i-dma.c:701:8: note: in expansion of macro 'SUN4I_DMA_CFG_SRC_ADDR_MODE'
>   701 |        SUN4I_DMA_CFG_SRC_ADDR_MODE(linear_mode);
>       |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Introduced by commit
> 
>   6ebb827f7aad ("dmaengine: sun4i: use 'linear_mode' in sun4i_dma_prep_dma_cyclic")

Thanks for the report, I confirm this and the fix is on the way :)

> Please do not ignore/dismiss new warnings ... this one points out a real issue.

Sure!

-- 
~Vinod
