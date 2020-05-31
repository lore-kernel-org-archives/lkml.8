Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAB2C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 00:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B35020776
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 00:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgEaAsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 20:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbgEaAsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 20:48:35 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E143DC03E969;
        Sat, 30 May 2020 17:48:34 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B8888128DAB18;
        Sat, 30 May 2020 17:48:33 -0700 (PDT)
Date:   Sat, 30 May 2020 17:48:32 -0700 (PDT)
Message-Id: <20200530.174832.1916030317168148988.davem@davemloft.net>
To:     luobin9@huawei.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        luoxianjun@huawei.com, yin.yinshi@huawei.com,
        cloud.wangxiaoyun@huawei.com
Subject: Re: [PATCH net-next v3] hinic: add set_channels ethtool_ops support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200529181150.3183-1-luobin9@huawei.com>
References: <20200529181150.3183-1-luobin9@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 30 May 2020 17:48:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo bin <luobin9@huawei.com>
Date: Fri, 29 May 2020 18:11:50 +0000

> add support to change TX/RX queue number with ethtool -L ethx combined
> 
> Signed-off-by: Luo bin <luobin9@huawei.com>

Luo, I am not applying any of your patches until you fix the time on
your computer.

This causes a lot of issues and slows down my workflow because it
causes your patch submissions to be placed deep in my patchwork
backlog because patchwork entries is ordered by date.

Therefore, please fix the date on your computer and resubmit your
changes.

Thank you.
