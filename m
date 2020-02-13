Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73165C3B18B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E85222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581601711;
	bh=/IHqvSUkvs0D3yRKY8By6Mz5f1a+ORpk6w/6mSnRabE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dMe5tPLx/KBVX5i2hTLJsDeK3r7duTfSxPG7/TkBnpm3P/ONXHZF5o72YNLx0j8j1
	 nCT3xMjek/y7o8JVSnRS1Jsi0A0L8I4QYxfAc71GIqYVu7iCdodVcDVO0DbG/XgIBA
	 45au/9G2VEwilfROshE0OhS7AGevysl9q0CEQps8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbgBMNsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:48:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729953AbgBMNsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:48:30 -0500
Received: from localhost (unknown [106.201.58.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6366217F4;
        Thu, 13 Feb 2020 13:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581601709;
        bh=/IHqvSUkvs0D3yRKY8By6Mz5f1a+ORpk6w/6mSnRabE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C+zaM2sdYl5E/4jZrsJTTk/z36kElAu2W/FSAchIBvkMCqkgdkT7L3o9cSBdApCU9
         Z2Nob6jLdrxK4DEY1JTBCIFJH8AqLy5nHBapyQBpyespZigNqI7mYTweWrduyenEfn
         y1GqU++GENV7EU0KsTdgDizP7gyd36plWGD15oN4=
Date:   Thu, 13 Feb 2020 19:18:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dave.jiang@intel.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: idxd: remove set but not used variable
 'group'
Message-ID: <20200213134825.GG2618@vkoul-mobl>
References: <20200211135335.55924-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211135335.55924-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-02-20, 21:53, YueHaibing wrote:
> drivers/dma/idxd/sysfs.c: In function engine_group_id_store:
> drivers/dma/idxd/sysfs.c:419:29: warning: variable group set but not used [-Wunused-but-set-variable]
> 
> It is not used, so remove it.

Applied, thanks

-- 
~Vinod
