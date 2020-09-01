Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94DFC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 18:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C43C020767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 18:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbgIASpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 14:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIASpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 14:45:16 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEBFC061244;
        Tue,  1 Sep 2020 11:45:16 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6302913630BBC;
        Tue,  1 Sep 2020 11:28:28 -0700 (PDT)
Date:   Tue, 01 Sep 2020 11:45:14 -0700 (PDT)
Message-Id: <20200901.114514.1056023202431606476.davem@davemloft.net>
To:     dev@ooseel.net
Cc:     kuba@kernel.org, akpm@linux-foundation.org,
        mchehab+huawei@kernel.org, gustavoars@kernel.org,
        pablo@netfilter.org, lukas@wunner.de, adobriyan@gmail.com,
        niu_xilei@163.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pktgen: fix error message with wrong function name
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200901130449.15422-1-dev@ooseel.net>
References: <20200901130449.15422-1-dev@ooseel.net>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Tue, 01 Sep 2020 11:28:28 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leesoo Ahn <dev@ooseel.net>
Date: Tue,  1 Sep 2020 22:04:47 +0900

> Error on calling kthread_create_on_node prints wrong function name,
> kernel_thread.
> 
> Signed-off-by: Leesoo Ahn <dev@ooseel.net>

Applied with Fixes: tag added.
