Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E48C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D11E20BED
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgIIVSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 17:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgIIVSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 17:18:11 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C357FC061755;
        Wed,  9 Sep 2020 14:18:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 317651298996A;
        Wed,  9 Sep 2020 14:01:23 -0700 (PDT)
Date:   Wed, 09 Sep 2020 14:18:09 -0700 (PDT)
Message-Id: <20200909.141809.1126103759466611241.davem@davemloft.net>
To:     zhangchangzhong@huawei.com
Cc:     kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: pxa168_eth: remove redundant null check
 before clk_disable_unprepare()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1599660397-25077-1-git-send-email-zhangchangzhong@huawei.com>
References: <1599660397-25077-1-git-send-email-zhangchangzhong@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Wed, 09 Sep 2020 14:01:23 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Changzhong <zhangchangzhong@huawei.com>
Date: Wed, 9 Sep 2020 22:06:37 +0800

> Because clk_prepare_enable() and clk_disable_unprepare() already checked
> NULL clock parameter, so the additional checks are unnecessary, just
> remove them.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>

Applied.
