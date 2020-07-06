Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367E4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 04:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B1F2074F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 04:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594011309;
	bh=HHgEftdtnQQatB3lKRzyT3NI4qdImGN8X7SFOatjkh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sb/pqCxz2ZQupL+Dztp6nFA2n7gG7oboDxTBf8upkOrgQ9ecgvB5gIUs8oE3ZIzpK
	 98y85CWHW7gqB0DlqQIsWo2WVI2fklmSpTXqr5gI11iYC5CbZ+qeaYff6i4HD0l+mX
	 DpbzROwYouLJVqNxiXVNkYXNYVxqFlUj0xqKf49U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgGFEzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 00:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbgGFEzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 00:55:07 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52AAA20739;
        Mon,  6 Jul 2020 04:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594011307;
        bh=HHgEftdtnQQatB3lKRzyT3NI4qdImGN8X7SFOatjkh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VuxmuESHGN4XvhOe+RxCqCnFO71kDipLYuiY282gq06SbYZitrK5kqbe43uuKZjx4
         zMQJEesksmcHslzNJbnHKU4TecuU31wtFDELPfCzG9Tweqsepqxdwsit2W5A8hC4Yr
         4E15ouQymuMLlEwdMCyjNfLpGWjuyuucvJdda9zY=
Date:   Mon, 6 Jul 2020 10:25:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     dan.j.williams@intel.com, angelo@sysam.it,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH v1] dmaengine: fsl-edma-common: correct DSIZE_32BYTE
Message-ID: <20200706045503.GD633187@vkoul-mobl>
References: <1593449998-32091-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593449998-32091-1-git-send-email-yibin.gong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-06-20, 00:59, Robin Gong wrote:
> Correct EDMA_TCD_ATTR_DSIZE_32BYTE define since it's broken by the below:
> '0x0005 --> BIT(3) | BIT(0))'

Applied, thanks

-- 
~Vinod
