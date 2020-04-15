Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58C4C2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48632078B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586965766;
	bh=c5y9Y4yIDglWOG9E8enpugzXn4iH8yD0W/8RIcdt1lM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CxmS0D/zJ4f7O20FQ9RqO0+aByTln1MYQJmQkdfiS5nxve1naF39WaVaULaOOSegv
	 UBxXcK6iuqObLUkhyYvpRk2ZLseifFfWRWRZQdLU1c/Mla4kizVYi4ChQVzJzojG5S
	 QdvzcgmrrYthm9I1ah5WwdDBPnycIa+qyu+zVe/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394204AbgDOPtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393546AbgDOPtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:49:18 -0400
Received: from localhost (unknown [106.201.106.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A36492078B;
        Wed, 15 Apr 2020 15:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586965757;
        bh=c5y9Y4yIDglWOG9E8enpugzXn4iH8yD0W/8RIcdt1lM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EAmZxtzKxjkDj0JRWqMTRlT1PND4RoTQ7ntcKBwxwwdqUrYW66/zaGmxoCISjfeHG
         eY/MfDqyyGVKlFwIpBEIPool87kweImz1XSi10UaxFFCHWTCpC2HiQmsqpQLH4zSzV
         USnstUidoZL3ycUTzn8Z6EmDQzVtM55BmOSAgt84=
Date:   Wed, 15 Apr 2020 21:19:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dan.j.williams@intel.com, wangzhou1@hisilicon.com,
        qiuzhenfa@hisilicon.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: hisilicon: Fix build error without
 PCI_MSI
Message-ID: <20200415154906.GR72691@vkoul-mobl>
References: <20200328114133.17560-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200328114133.17560-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-03-20, 19:41, YueHaibing wrote:
> If PCI_MSI is not set, building fais:
> 
> drivers/dma/hisi_dma.c: In function ‘hisi_dma_free_irq_vectors’:
> drivers/dma/hisi_dma.c:138:2: error: implicit declaration of function ‘pci_free_irq_vectors’;
>  did you mean ‘pci_alloc_irq_vectors’? [-Werror=implicit-function-declaration]
>   pci_free_irq_vectors(data);
>   ^~~~~~~~~~~~~~~~~~~~
> 
> Make HISI_DMA depends on PCI_MSI to fix this.

Applied, thanks

-- 
~Vinod
