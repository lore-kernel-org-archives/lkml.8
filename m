Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B8CC433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A381F2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595841247;
	bh=MwMnaIFboN0zZbE7OkzcmNZC9GFnkloDFRLVAA63i1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ABd7twYl/IzPqxRkFjVG4FUGO3BoSmT4BPeiWxpocxSlnzpgZbKHkptelZEEa4lkV
	 pZWpavr/b8d+ZQK65n8ZBbjcNOz68xS2F7sWbfIkf4dVhpZVWwSj8V5XTCT/fxxVkt
	 z8zq+lMJtdK2UZ5YwyCx1/+3U37ccjQxoD6iW90c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgG0JOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:14:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgG0JOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:14:05 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A162120714;
        Mon, 27 Jul 2020 09:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595841245;
        bh=MwMnaIFboN0zZbE7OkzcmNZC9GFnkloDFRLVAA63i1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSK916jNG/m0MTggY2pyZGqTBTrty4JhmGtTiFb1XuoKddz4j4qfQNJBDaAtyF00o
         68b7ThshqhrlD+75pKE0SWvHKcMzfl+dhfOoc9fpxmo+wIUllw2XyM1T//HqqA4t6i
         NZvpG0CHKjHQpKayPg0eYvAjfaUjxJH9DAT+jt9o=
Date:   Mon, 27 Jul 2020 14:44:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, dan.j.williams@intel.com,
        cristian.ciocaltea@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v7 02/10] dmaengine: Actions: get rid of bit fields from
 dma descriptor
Message-ID: <20200727091401.GQ12965@vkoul-mobl>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
 <1595180527-11320-3-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595180527-11320-3-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-07-20, 23:11, Amit Singh Tomar wrote:
> At the moment, Driver uses bit fields to describe registers of the DMA
> descriptor structure that makes it less portable and maintainable, and
> Andre suugested(and even sketched important bits for it) to make use of
> array to describe this DMA descriptors instead. It gives the flexibility
> while extending support for other platform such as Actions S700.
> 
> This commit removes the "owl_dma_lli_hw" (that includes bit-fields) and
> uses array to describe DMA descriptor.

Applied, thanks

-- 
~Vinod
