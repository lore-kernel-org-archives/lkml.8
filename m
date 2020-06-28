Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C894C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 00:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A71720768
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 00:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgF1Aw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 20:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgF1Aw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 20:52:26 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58611C061794;
        Sat, 27 Jun 2020 17:52:26 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A823613C43B4D;
        Sat, 27 Jun 2020 17:52:25 -0700 (PDT)
Date:   Sat, 27 Jun 2020 17:52:24 -0700 (PDT)
Message-Id: <20200627.175224.2220574097858458030.davem@davemloft.net>
To:     luobin9@huawei.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        luoxianjun@huawei.com, yin.yinshi@huawei.com,
        cloud.wangxiaoyun@huawei.com, chiqijun@huawei.com
Subject: Re: [PATCH net-next v3 0/5] hinic: add some ethtool ops support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200627065242.26761-1-luobin9@huawei.com>
References: <20200627065242.26761-1-luobin9@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 27 Jun 2020 17:52:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo bin <luobin9@huawei.com>
Date: Sat, 27 Jun 2020 14:52:37 +0800

> patch #1: support to set and get pause params with
>           "ethtool -A/a" cmd
> patch #2: support to set and get irq coalesce params with
>           "ethtool -C/c" cmd
> patch #3: support to do self test with "ethtool -t" cmd
> patch #4: support to identify physical device with "ethtool -p" cmd
> patch #5: support to get eeprom information with "ethtool -m" cmd

In general,  I want you to decrease the amount of log messages.

You should only use them when the device or the kernel does something
unexpected which should be notifier to the user.

Kernel log messages are not for informating the user of limitations
of what they can perform with "ethtool".

For example, when setting pause paramenters, you complain in the logs
if the autonet setting is different.

This is completely inappropriate.

Then in patch #2 you have these crazy macros that print out state
changes with netdev_info().  That is also inappropriate.  The user
gets a success status, and they can query the settings later if
they like as well.

Please stop abusing kernel log messaging, it isn't a framework for
giving more detailed ethtool command result statuses.

Thank you.
