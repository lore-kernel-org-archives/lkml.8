Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5732EC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3370324653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgAUKql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:46:41 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36174 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgAUKql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:46:41 -0500
Received: from localhost (82-95-191-104.ip.xs4all.nl [82.95.191.104])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5226715C0CFC6;
        Tue, 21 Jan 2020 02:46:39 -0800 (PST)
Date:   Tue, 21 Jan 2020 11:46:37 +0100 (CET)
Message-Id: <20200121.114637.1232865870207165672.davem@davemloft.net>
To:     tanhuazhong@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        huangdaode@huawei.com, linuxarm@huawei.com, kuba@kernel.org
Subject: Re: [PATCH net-next 0/9] net: hns3: misc updates for -net-next
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1579596133-54842-1-git-send-email-tanhuazhong@huawei.com>
References: <1579596133-54842-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Jan 2020 02:46:40 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>
Date: Tue, 21 Jan 2020 16:42:04 +0800

> This series includes some misc updates for the HNS3 ethernet driver.
> 
> [patch 1] adds a limitation for the error log in the
> hns3_clean_tx_ring().
> [patch 2] adds a check for pfmemalloc flag before reusing pages
> since these pages may be used some special case.
> [patch 3] assigns a default reset type 'HNAE3_NONE_RESET' to
> VF's reset_type after initializing or reset.
> [patch 4] unifies macro HCLGE_DFX_REG_TYPE_CNT's definition into
> header file.
> [patch 5] refines the parameter 'size' of snprintf() in the
> hns3_init_module().
> [patch 6] rewrites a debug message in hclge_put_vector().
> [patch 7~9] adds some cleanups related to coding style.

Series applied, thanks.
