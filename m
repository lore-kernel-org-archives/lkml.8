Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F54C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CBE5206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgDTSFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgDTSE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:04:58 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162DEC061A0C;
        Mon, 20 Apr 2020 11:04:58 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AEC6C127D24B0;
        Mon, 20 Apr 2020 11:04:57 -0700 (PDT)
Date:   Mon, 20 Apr 2020 11:04:57 -0700 (PDT)
Message-Id: <20200420.110457.1973494798475106373.davem@davemloft.net>
To:     yanaijie@huawei.com
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        tglx@linutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hulkci@huawei.com
Subject: Re: [PATCH] net: hns: use true,false for bool variables
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200418084212.26012-1-yanaijie@huawei.com>
References: <20200418084212.26012-1-yanaijie@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 20 Apr 2020 11:04:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Yan <yanaijie@huawei.com>
Date: Sat, 18 Apr 2020 16:42:12 +0800

> Fix the following coccicheck warning:
> 
> drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c:700:2-8: WARNING:
> Assignment of 0/1 to bool variable
> drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c:702:2-8: WARNING:
> Assignment of 0/1 to bool variable
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied to net-next.
