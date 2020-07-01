Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D107C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0855320771
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgGABSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgGABSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:18:14 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B6AC061755;
        Tue, 30 Jun 2020 18:18:14 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B2D761280A787;
        Tue, 30 Jun 2020 18:18:13 -0700 (PDT)
Date:   Tue, 30 Jun 2020 18:18:12 -0700 (PDT)
Message-Id: <20200630.181812.668194154450687064.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     kuba@kernel.org, vaibhavgupta40@gmail.com, pcnet32@frontier.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] amd8111e: Mark PM functions as
 __maybe_unused
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200630210034.3624587-1-natechancellor@gmail.com>
References: <20200630210034.3624587-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 30 Jun 2020 18:18:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Tue, 30 Jun 2020 14:00:33 -0700

> In certain configurations without power management support, the
> following warnings happen:
> 
> ../drivers/net/ethernet/amd/amd8111e.c:1623:12: warning:
> 'amd8111e_resume' defined but not used [-Wunused-function]
>  1623 | static int amd8111e_resume(struct device *dev_d)
>       |            ^~~~~~~~~~~~~~~
> ../drivers/net/ethernet/amd/amd8111e.c:1584:12: warning:
> 'amd8111e_suspend' defined but not used [-Wunused-function]
>  1584 | static int amd8111e_suspend(struct device *dev_d)
>       |            ^~~~~~~~~~~~~~~~
> 
> Mark these functions as __maybe_unused to make it clear to the compiler
> that this is going to happen based on the configuration, which is the
> standard for these types of functions.
> 
> Fixes: 2caf751fe080 ("amd8111e: Convert to generic power management")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.
