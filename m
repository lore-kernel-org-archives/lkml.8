Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD477C3B18B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E8620873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581604481;
	bh=mt/wBV75C0JFyp9Jp5NJAMBeePDKaAfR/fqnojQNLA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PsyJGxpBq1wzkqo+SHAyDiEi/R8kkHD41/mO88LqJ5woOwPraiqSlYsV7VeEOrxTT
	 b8PsWEYj7gjGqWTGo/3TR6S9uJGkay97sucXhoir7Of5ATtG1e8reHd5vlUzGJdL4M
	 UECizXCk/5hhedyfYPJS2ad+2mSyIWux5F/I2b4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgBMOel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:34:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:48462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgBMOek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:34:40 -0500
Received: from localhost (unknown [106.201.58.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD48024673;
        Thu, 13 Feb 2020 14:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581604479;
        bh=mt/wBV75C0JFyp9Jp5NJAMBeePDKaAfR/fqnojQNLA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uyvSVb57nyYaFp0FTteX2g7KVlTIRAi1q6Yp8rBqBFyBLrZugZvocsrEQpnRO0Wrm
         BHwmZvHealztvCTSEIXt4liEt7OEQT8/4hvtTWf3liE+ujdrkScy3vD03bV2xPIfw5
         6n4gohOeD4/OZYU6vs7OzYX3Axb9gfNpVPcCQU6Q=
Date:   Thu, 13 Feb 2020 20:04:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dave.jiang@intel.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: idxd: remove set but not used variable
 'idxd_cdev'
Message-ID: <20200213143435.GI2618@vkoul-mobl>
References: <20200210151855.55044-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210151855.55044-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-02-20, 23:18, YueHaibing wrote:
> drivers/dma/idxd/cdev.c: In function idxd_cdev_open:
> drivers/dma/idxd/cdev.c:77:20: warning:
>  variable idxd_cdev set but not used [-Wunused-but-set-variable]

Applied, thanks

-- 
~Vinod
