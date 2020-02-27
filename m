Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FA8C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A4724692
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgB0TIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:08:48 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43792 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbgB0TIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:08:47 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0A23B120F52B7;
        Thu, 27 Feb 2020 11:08:47 -0800 (PST)
Date:   Thu, 27 Feb 2020 11:08:44 -0800 (PST)
Message-Id: <20200227.110844.200001983503824389.davem@davemloft.net>
To:     luobin9@huawei.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        luoxianjun@huawei.com
Subject: Re: [PATCH net v1 0/3] hinic:BugFixes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200227063444.2143-1-luobin9@huawei.com>
References: <20200227063444.2143-1-luobin9@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 27 Feb 2020 11:08:47 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo bin <luobin9@huawei.com>
Date: Thu, 27 Feb 2020 06:34:41 +0000

> the bug fixed in patch #2 has been present since the first commit.
> the bugs fixed in patch #1 and patch #3 have been present since the
> following commits:
> patch #1: 352f58b0d9f2 ("net-next/hinic: Set Rxq irq to specific cpu for NUMA")
> patch #3: 421e9526288b ("hinic: add rss support")

Series applied and queued up for -stable, thanks.
