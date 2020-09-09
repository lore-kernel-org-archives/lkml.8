Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A21C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB4E20BED
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgIIVMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 17:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgIIVMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 17:12:48 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88113C061573;
        Wed,  9 Sep 2020 14:12:48 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DD8AE12987FA8;
        Wed,  9 Sep 2020 13:55:56 -0700 (PDT)
Date:   Wed, 09 Sep 2020 14:12:40 -0700 (PDT)
Message-Id: <20200909.141240.592595734266972499.davem@davemloft.net>
To:     wanghai38@huawei.com
Cc:     kuba@kernel.org, sgoutham@marvell.com, bprakash@marvell.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: cavium: Fix a bunch of kerneldoc
 parameter issues
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200909132109.71466-1-wanghai38@huawei.com>
References: <20200909132109.71466-1-wanghai38@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Wed, 09 Sep 2020 13:55:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Hai <wanghai38@huawei.com>
Date: Wed, 9 Sep 2020 21:21:09 +0800

> Rename ptp to ptp_info.
> 
> Fix W=1 compile warnings (invalid kerneldoc):
> 
> drivers/net/ethernet/cavium/common/cavium_ptp.c:94: warning: Excess function parameter 'ptp' description in 'cavium_ptp_adjfine'
> drivers/net/ethernet/cavium/common/cavium_ptp.c:141: warning: Excess function parameter 'ptp' description in 'cavium_ptp_adjtime'
> drivers/net/ethernet/cavium/common/cavium_ptp.c:163: warning: Excess function parameter 'ptp' description in 'cavium_ptp_gettime'
> drivers/net/ethernet/cavium/common/cavium_ptp.c:185: warning: Excess function parameter 'ptp' description in 'cavium_ptp_settime'
> drivers/net/ethernet/cavium/common/cavium_ptp.c:208: warning: Excess function parameter 'ptp' description in 'cavium_ptp_enable'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Applied, thanks.
