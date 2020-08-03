Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C75CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4D762073E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgHCW4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgHCW4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:56:22 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D4DC06174A;
        Mon,  3 Aug 2020 15:56:22 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6A81B1277863F;
        Mon,  3 Aug 2020 15:39:36 -0700 (PDT)
Date:   Mon, 03 Aug 2020 15:56:20 -0700 (PDT)
Message-Id: <20200803.155620.24081918672300506.davem@davemloft.net>
To:     tianjia.zhang@linux.alibaba.com
Cc:     irusskikh@marvell.com, kuba@kernel.org, mstarovoitov@marvell.com,
        dbezrukov@marvell.com, ndanilov@marvell.com,
        Pavel.Belous@aquantia.com, Alexander.Loktionov@aquantia.com,
        Dmitrii.Tarakanov@aquantia.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@alibaba.com
Subject: Re: [PATCH] net: ethernet: aquantia: Fix wrong return value
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200802111537.5292-1-tianjia.zhang@linux.alibaba.com>
References: <20200802111537.5292-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Aug 2020 15:39:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Date: Sun,  2 Aug 2020 19:15:37 +0800

> In function hw_atl_a0_hw_multicast_list_set(), when an invalid
> request is encountered, a negative error code should be returned.
> 
> Fixes: bab6de8fd180b ("net: ethernet: aquantia: Atlantic A0 and B0 specific functions")
> Cc: David VomLehn <vomlehn@texas.net>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Applied, thank you!
