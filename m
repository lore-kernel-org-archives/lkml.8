Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F56C10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6984620732
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584945024;
	bh=lGY0/B9v5kKP+fRPvrlnERsifU+J0PKOjNa0Qax8RwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=leUaM7S/Qk5JYrvNQ74GetkX5pKEHRzr3QQbud2Ja7tzdH17rwggT3STMnau+aL2I
	 UbWlePLe3hZo5htDGvQMycS04CsXdX95RD9n6IfSfULkLDtfLTClAJPDWxqHdtew4P
	 4ACbg4kVzwD3gur7fT5bkmZrAXwlyKIuSH7g9qzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgCWGaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 02:30:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgCWGaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 02:30:22 -0400
Received: from localhost (unknown [171.76.96.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A3C7206F8;
        Mon, 23 Mar 2020 06:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584945022;
        bh=lGY0/B9v5kKP+fRPvrlnERsifU+J0PKOjNa0Qax8RwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hean15XoxKID8EY5Tcazr5zdTf2itcveXgy7ln0MhQEq/cw4Y8eD1o4vaYOT3ybHx
         LIhmVLjoK2Td2QTKupu4GYQujTftHLWPvpooT+mKjt2Fh/CzvBsTKXpjfwvXIYEsg+
         nfWucFwKKsNmJl/qjPtwKU7Up2adbDbp7bcHrrEA=
Date:   Mon, 23 Mar 2020 12:00:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com,
        dan.j.williams@intel.com, thierry.reding@gmail.com,
        swarren@wwwdotorg.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        digetx@gmail.com
Subject: Re: [PATCH -next] dmaengine: tegra-apb: mark PM functions as
 __maybe_unused
Message-ID: <20200323063014.GG72691@vkoul-mobl>
References: <20200320071337.59756-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320071337.59756-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-20, 15:13, YueHaibing wrote:
> When CONFIG_PM is disabled, gcc warning this:
> 
> drivers/dma/tegra20-apb-dma.c:1587:12: warning: 'tegra_dma_runtime_resume' defined but not used [-Wunused-function]
> drivers/dma/tegra20-apb-dma.c:1578:12: warning: 'tegra_dma_runtime_suspend' defined but not used [-Wunused-function]
> 
> Make it as __maybe_unused to fix the warnings,
> also remove unneeded function declarations.

Applied, thanks

-- 
~Vinod
