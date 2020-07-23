Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DC9C433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C49BF20714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgGWSuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGWSuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 14:50:06 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4AAC0619DC;
        Thu, 23 Jul 2020 11:50:05 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2C75A13AFBAB6;
        Thu, 23 Jul 2020 11:33:20 -0700 (PDT)
Date:   Thu, 23 Jul 2020 11:50:04 -0700 (PDT)
Message-Id: <20200723.115004.624564919773772119.davem@davemloft.net>
To:     linmiaohe@huawei.com
Cc:     sam@mendozajonas.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/ncsi: use eth_zero_addr() to clear mac address
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1595502823-9672-1-git-send-email-linmiaohe@huawei.com>
References: <1595502823-9672-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 23 Jul 2020 11:33:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: linmiaohe <linmiaohe@huawei.com>
Date: Thu, 23 Jul 2020 19:13:43 +0800

> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> Use eth_zero_addr() to clear mac address insetad of memset().
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied.
