Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D525DC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BF12072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgCEUFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:05:41 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56144 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgCEUFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:05:41 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7B9B015BE9269;
        Thu,  5 Mar 2020 12:05:40 -0800 (PST)
Date:   Thu, 05 Mar 2020 12:05:39 -0800 (PST)
Message-Id: <20200305.120539.348892699293645794.davem@davemloft.net>
To:     tanhuazhong@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com, kuba@kernel.org, shenjian15@huawei.com
Subject: Re: [PATCH net] net: hns3: fix a not link up issue when fibre port
 supports autoneg
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1583372873-26924-1-git-send-email-tanhuazhong@huawei.com>
References: <1583372873-26924-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 05 Mar 2020 12:05:40 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>
Date: Thu, 5 Mar 2020 09:47:53 +0800

> From: Jian Shen <shenjian15@huawei.com>
> 
> When fibre port supports auto-negotiation, the IMP(Intelligent
> Management Process) processes the speed of auto-negotiation
> and the  user's speed separately.
> For below case, the port will get a not link up problem.
> step 1: disables auto-negotiation and sets speed to A, then
> the driver's MAC speed will be updated to A.
> step 2: enables auto-negotiation and MAC gets negotiated
> speed B, then the driver's MAC speed will be updated to B
> through querying in periodical task.
> step 3: MAC gets new negotiated speed A.
> step 4: disables auto-negotiation and sets speed to B before
> periodical task query new MAC speed A, the driver will  ignore
> the speed configuration.
> 
> This patch fixes it by skipping speed and duplex checking when
> fibre port supports auto-negotiation.
> 
> Fixes: 22f48e24a23d ("net: hns3: add autoneg and change speed support for fibre port")
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>

Applied and queued up for -stable, thanks.
