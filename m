Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08A7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3BF3207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgHSXXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 19:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgHSXXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 19:23:37 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5764BC061757;
        Wed, 19 Aug 2020 16:23:37 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D20EF11DB315F;
        Wed, 19 Aug 2020 16:06:50 -0700 (PDT)
Date:   Wed, 19 Aug 2020 16:23:36 -0700 (PDT)
Message-Id: <20200819.162336.2039523481783485574.davem@davemloft.net>
To:     min.li.xe@renesas.com
Cc:     richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] ptp: ptp_clockmatrix: use i2c_master_send for
 i2c write
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1597761682-31111-1-git-send-email-min.li.xe@renesas.com>
References: <1597761682-31111-1-git-send-email-min.li.xe@renesas.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 19 Aug 2020 16:06:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <min.li.xe@renesas.com>
Date: Tue, 18 Aug 2020 10:41:22 -0400

> From: Min Li <min.li.xe@renesas.com>
> 
> The old code for i2c write would break on some controllers, which fails
> at handling Repeated Start Condition. So we will just use i2c_master_send
> to handle write in one transanction.
> 
> Changes since v1:
> - Remove indentation change
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>

Applied, thank you.
