Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6F6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 066372070E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgGXX5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 19:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGXX5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 19:57:24 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F4BC0619D3;
        Fri, 24 Jul 2020 16:57:23 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2E89612756FCF;
        Fri, 24 Jul 2020 16:40:38 -0700 (PDT)
Date:   Fri, 24 Jul 2020 16:57:22 -0700 (PDT)
Message-Id: <20200724.165722.526735468993909990.davem@davemloft.net>
To:     dinghao.liu@zju.edu.cn
Cc:     kjlu@umn.edu, sgoutham@marvell.com, lcherian@marvell.com,
        gakula@marvell.com, jerinj@marvell.com, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] octeontx2-af: Fix use of uninitialized pointer bmap
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200724080657.19182-1-dinghao.liu@zju.edu.cn>
References: <20200724080657.19182-1-dinghao.liu@zju.edu.cn>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 24 Jul 2020 16:40:38 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>
Date: Fri, 24 Jul 2020 16:06:57 +0800

> If req->ctype does not match any of NIX_AQ_CTYPE_CQ,
> NIX_AQ_CTYPE_SQ or NIX_AQ_CTYPE_RQ, pointer bmap will remain
> uninitialized and be accessed in test_bit(), which can lead
> to kernal crash.

This can never happen.

> Fix this by returning an error code if this case is triggered.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

I strongly dislike changes like this.

Most callers of nix_lf_hwctx_disable() inside of rvu_nix.c set
req->ctype to one of the handled values.

The only other case, rvu_mbox_handler_nix_hwctx_disable(), is a
completely unused function and should be removed.

There is no functional problem in this code at all.

It is not possible show a code path where the stated problem can
actually occur.
