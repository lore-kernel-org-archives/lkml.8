Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2731FC43466
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E223B221EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589381777;
	bh=8SmbnrZ5qW6mVaqqlcGDrJ3tZhpY+ZYEC2ysujal7jE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ij4l6iMO6HXMplLfpf3ogiFQDtibl33SAtPP1fRv1XSK6bh1qupoLvMfn0+QBDSWm
	 3B5c/Zg4ITRqdF+EYm9OeoVvULDPc+lQ7OpyrHp9gCKhPo+/+8zoC19cBmfn709AUp
	 w+O+OrUCI1g70VsvI75xTEiHEoHECcScVG+/7Smw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgEMO4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:56:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728568AbgEMO4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:56:16 -0400
Received: from localhost (unknown [106.200.233.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C38E421897;
        Wed, 13 May 2020 14:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589381775;
        bh=8SmbnrZ5qW6mVaqqlcGDrJ3tZhpY+ZYEC2ysujal7jE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hEIaUiuBgsCnSQK5g+xIUyPPXcNFW2pQrMQ6AyC+U9qbRIOJRPQ+4bzTxjgKYzJRU
         uaAqcEB2jJJNGP6Pr2vyiNDGArE8MPcGbnlpjRlH4WB+DNqx1UmrhEgYjjKnhbz6Eb
         sqLje5dPSBgOMyxPp776j//znTuRnHtRiMqmtCMU=
Date:   Wed, 13 May 2020 20:26:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: at_hdmac: Replace zero-length array with
 flexible-array
Message-ID: <20200513145611.GL14092@vkoul-mobl>
References: <20200507190038.GA15272@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507190038.GA15272@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-05-20, 14:00, Gustavo A. R. Silva wrote:
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
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Applied, thanks

-- 
~Vinod
