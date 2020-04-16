Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1170C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F282054F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgDPUwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726725AbgDPUwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 16:52:53 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477DAC061A0C;
        Thu, 16 Apr 2020 13:52:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5B8E3118F0C0B;
        Thu, 16 Apr 2020 13:52:52 -0700 (PDT)
Date:   Thu, 16 Apr 2020 13:52:51 -0700 (PDT)
Message-Id: <20200416.135251.336715127059562428.davem@davemloft.net>
To:     yanaijie@huawei.com
Cc:     isdn@linux-pingi.de, yuehaibing@huawei.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        wangkefeng.wang@huawei.com, elfring@users.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hulkci@huawei.com
Subject: Re: [PATCH] mISDN: make dmril and dmrim static
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200415084226.23971-1-yanaijie@huawei.com>
References: <20200415084226.23971-1-yanaijie@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 16 Apr 2020 13:52:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Yan <yanaijie@huawei.com>
Date: Wed, 15 Apr 2020 16:42:26 +0800

> Fix the following sparse warning:
> 
> drivers/isdn/hardware/mISDN/mISDNisar.c:746:12: warning: symbol 'dmril'
> was not declared. Should it be static?
> drivers/isdn/hardware/mISDN/mISDNisar.c:749:12: warning: symbol 'dmrim'
> was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied, thank you.
