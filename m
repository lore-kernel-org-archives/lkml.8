Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404E1C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 23:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23AE82075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 23:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDXX7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 19:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDXX7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 19:59:41 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01EDC09B049;
        Fri, 24 Apr 2020 16:59:40 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9E2B814F7687C;
        Fri, 24 Apr 2020 16:59:40 -0700 (PDT)
Date:   Fri, 24 Apr 2020 16:59:40 -0700 (PDT)
Message-Id: <20200424.165940.41312930895498895.davem@davemloft.net>
To:     yangyingliang@huawei.com
Cc:     richardcochran@gmail.com, min.li.xe@renesas.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ptp: idt82p33: remove unnecessary comparison
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1587715428-128609-1-git-send-email-yangyingliang@huawei.com>
References: <1587715428-128609-1-git-send-email-yangyingliang@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 24 Apr 2020 16:59:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>
Date: Fri, 24 Apr 2020 16:03:48 +0800

> The type of loaddr is u8 which is always '<=' 0xff, so the
> loaddr <= 0xff is always true, we can remove this comparison.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied.
