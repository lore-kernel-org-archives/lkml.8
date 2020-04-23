Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165DEC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E440C21582
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587625992;
	bh=jeyB3Dt0FQciAvhMCVO+jCM/8D9TOYTCBw5oFM3absE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ol/2l8aN04vWT8FI/Jlz0g/XC+So1SaSPx/SUHxLXCUr09JVSkFtu+L9rsts9hB4g
	 LIqMKeUV0+W7Jfh5uZpdflo3pjxlMy3OseXRJMqGzFEj82JA5yU+j63E/TyWonWQO3
	 gyKy2Cag7ERdug3boLv9WItEKmhApFRSjAz+Zz9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgDWHNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:13:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgDWHNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:13:12 -0400
Received: from localhost (unknown [49.207.59.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1011D208E4;
        Thu, 23 Apr 2020 07:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587625991;
        bh=jeyB3Dt0FQciAvhMCVO+jCM/8D9TOYTCBw5oFM3absE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uA92uIDP10TgUXjNcolSXCL9hvaoMe60Hu8ZcVU2xfQOIsoq/HgyXXXpj7xvJ3S3N
         9sEOJOK3+0+FHRvvHX/Ocu4srKa0X6HrJcGt8A5mLwYDmTxxw6+6nuBMOj9Q7P7vQu
         sT2xJ7cPeRswUoj9OxezJYqX0akh2BRpuL4eAqxU=
Date:   Thu, 23 Apr 2020 12:43:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dmaengine: mmp_tdma: Do not ignore slave config
 validation errors
Message-ID: <20200423071307.GX72691@vkoul-mobl>
References: <20200419164912.670973-1-lkundrak@v3.sk>
 <20200419164912.670973-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419164912.670973-2-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-04-20, 18:49, Lubomir Rintel wrote:
> With an invalid dma_slave_config set previously,
> mmp_tdma_prep_dma_cyclic() would detect an error whilst configuring the
> channel, but proceed happily on:
> 
>   [  120.756530] mmp-tdma d42a0800.adma: mmp_tdma: unknown burst size.

Applied to fixes, thanks

-- 
~Vinod
