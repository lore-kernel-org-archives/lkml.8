Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692E1C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 04:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442A22072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 04:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgCTEAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 00:00:33 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46598 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTEAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 00:00:32 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E2440158F78E4;
        Thu, 19 Mar 2020 21:00:29 -0700 (PDT)
Date:   Thu, 19 Mar 2020 21:00:26 -0700 (PDT)
Message-Id: <20200319.210026.1097328564068541611.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     dchickles@marvell.com, leonro@mellanox.com, sburla@marvell.com,
        fmanlunas@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        hulkci@huawei.com
Subject: Re: [PATCH net-next] liquidio: remove set but not used variable 's'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200319120743.28056-1-yuehaibing@huawei.com>
References: <20200306023254.61731-1-yuehaibing@huawei.com>
        <20200319120743.28056-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 19 Mar 2020 21:00:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 19 Mar 2020 12:07:43 +0000

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ethernet/cavium/liquidio/lio_main.c: In function 'octeon_chip_specific_setup':
> drivers/net/ethernet/cavium/liquidio/lio_main.c:1378:8: warning:
>  variable 's' set but not used [-Wunused-but-set-variable]
> 
> It's not used since commit b6334be64d6f ("net/liquidio: Delete driver version assignment")
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
