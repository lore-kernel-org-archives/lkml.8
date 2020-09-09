Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6EFC10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC3520BED
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgIIVSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 17:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbgIIVSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 17:18:20 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934B5C061573;
        Wed,  9 Sep 2020 14:18:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2D6351298996A;
        Wed,  9 Sep 2020 14:01:30 -0700 (PDT)
Date:   Wed, 09 Sep 2020 14:18:16 -0700 (PDT)
Message-Id: <20200909.141816.1252192721360649086.davem@davemloft.net>
To:     zhangchangzhong@huawei.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, kuba@kernel.org, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: dwmac-intel-plat: remove
 redundant null check before clk_disable_unprepare()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1599660540-25295-1-git-send-email-zhangchangzhong@huawei.com>
References: <1599660540-25295-1-git-send-email-zhangchangzhong@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Wed, 09 Sep 2020 14:01:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Changzhong <zhangchangzhong@huawei.com>
Date: Wed, 9 Sep 2020 22:09:00 +0800

> Because clk_prepare_enable() and clk_disable_unprepare() already checked
> NULL clock parameter, so the additional checks are unnecessary, just
> remove them.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>

Applied.
