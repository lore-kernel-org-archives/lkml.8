Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF398C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D57762065F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgHXNlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgHXNlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 09:41:04 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DA9C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 06:41:04 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 963F6128286FD;
        Mon, 24 Aug 2020 06:24:17 -0700 (PDT)
Date:   Mon, 24 Aug 2020 06:41:03 -0700 (PDT)
Message-Id: <20200824.064103.1912127912340710662.davem@davemloft.net>
To:     linmiaohe@huawei.com
Cc:     johannes.berg@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netlink: remove duplicated
 nla_need_padding_for_64bit() check
From:   David Miller <davem@davemloft.net>
In-Reply-To: <51bd2b4c5f4549488de08bdcf6daae23@huawei.com>
References: <51bd2b4c5f4549488de08bdcf6daae23@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Aug 2020 06:24:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: linmiaohe <linmiaohe@huawei.com>
Date: Mon, 24 Aug 2020 11:58:24 +0000

> friendly ping :)

Networking patches must be posted to netdev@vger.kernel.org, so please
resubmit this properly.

Thank you.
