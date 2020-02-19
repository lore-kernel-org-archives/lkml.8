Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E16BC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4E2206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgBSSsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:48:17 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46246 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBSSsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:48:17 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8A17B15AD1979;
        Wed, 19 Feb 2020 10:48:16 -0800 (PST)
Date:   Wed, 19 Feb 2020 10:48:16 -0800 (PST)
Message-Id: <20200219.104816.1415899664142388967.davem@davemloft.net>
To:     luobin9@huawei.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        aviad.krawczyk@huawei.com, luoxianjun@huawei.com
Subject: Re: [PATCH net-next 2/2] hinic: Fix a bug of setting hw_ioctxt
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200218194013.23837-2-luobin9@huawei.com>
References: <20200218194013.23837-1-luobin9@huawei.com>
        <20200218194013.23837-2-luobin9@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 19 Feb 2020 10:48:16 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo bin <luobin9@huawei.com>
Date: Tue, 18 Feb 2020 19:40:13 +0000

> This patch fix the bug of setting hw_ioctxt failed randomly
> 
> Signed-off-by: Luo bin <luobin9@huawei.com>

This does not explain what the bug is, how you decided to fix it,
and why you decided to fix it that way.
