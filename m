Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8F4C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 22:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6277720792
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 22:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgFMW3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 18:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFMW3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 18:29:31 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF69C03E96F;
        Sat, 13 Jun 2020 15:29:31 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9DFC011F5F637;
        Sat, 13 Jun 2020 15:29:30 -0700 (PDT)
Date:   Sat, 13 Jun 2020 15:29:30 -0700 (PDT)
Message-Id: <20200613.152930.1679140276381230351.davem@davemloft.net>
To:     wang.yi59@zte.com.cn
Cc:     kuba@kernel.org, mst@redhat.com, hkallweit1@gmail.com,
        snelson@pensando.io, andriy.shevchenko@linux.intel.com,
        xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn, liao.pingfang@zte.com.cn
Subject: Re: [PATCH v3] net: atm: Remove the error message according to the
 atomic context
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1592028206-19557-1-git-send-email-wang.yi59@zte.com.cn>
References: <1592028206-19557-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 13 Jun 2020 15:29:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yi Wang <wang.yi59@zte.com.cn>
Date: Sat, 13 Jun 2020 14:03:26 +0800

> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Looking into the context (atomic!) and the error message should be dropped.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> ---
> Changes in v3: remove {} as there is only one statement left.

Applied, thank you.
