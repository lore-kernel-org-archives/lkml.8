Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7890C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865C7218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581605227;
	bh=IJM+d8BHIo1ecjezWzI+cgzldKp7LTQuJBrLkNmTyE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B+Kn7YJy1gS0kS4ultEYSRPEkqhmeCf+0x4osixhum8lLhg3tO1Xg6iDxDfjgEvSj
	 H4dc60V5fxKFt946Gv6oNjpWBT+Rnv59w0upoFnq29xsVxL/Y8kq+jhLj3mSCzelSR
	 +sDNvbVFPt5ZL97uEg2owc0KS7whRYZEnMTFTigI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgBMOrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:47:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbgBMOrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:47:06 -0500
Received: from localhost (unknown [106.201.58.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C7952073C;
        Thu, 13 Feb 2020 14:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581605226;
        bh=IJM+d8BHIo1ecjezWzI+cgzldKp7LTQuJBrLkNmTyE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DpXQAJCk0y2hfgzNK2jmZ/1c3/l4bAoC0mUR/JVcUYOzi8W+WAlDiUrKsaixUt/Vu
         gfHgkE94J3Opo/IrVyCV1KaTjCpQmiJ+9nlZ2tgJMenOh91zP39K5w9HoJoNaDobvP
         3eOdNNFovirzrozTAolV910odfKtmAkxBwCduEP0=
Date:   Thu, 13 Feb 2020 20:17:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Replace zero-length array with
 flexible-array member
Message-ID: <20200213144702.GN2618@vkoul-mobl>
References: <20200213003925.GA6906@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213003925.GA6906@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-02-20, 18:39, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Applied, thanks

-- 
~Vinod
