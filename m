Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B5FC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AFE20784
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbgDASYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:24:39 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37600 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732842AbgDASYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:24:38 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BE177120F528E;
        Wed,  1 Apr 2020 11:24:37 -0700 (PDT)
Date:   Wed, 01 Apr 2020 11:24:37 -0700 (PDT)
Message-Id: <20200401.112437.352921007353455717.davem@davemloft.net>
To:     xianfengting221@163.com
Cc:     aelior@marvell.com, skalluru@marvell.com,
        GR-everest-linux-l2@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bnx2x: correct a comment mistake in grammar
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200401124050.19742-1-xianfengting221@163.com>
References: <20200401124050.19742-1-xianfengting221@163.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 01 Apr 2020 11:24:38 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hu Haowen <xianfengting221@163.com>
Date: Wed,  1 Apr 2020 20:40:50 +0800

> It is not right in grammar to spell "Its not". The right one is "It's
> not".
> 
> And this line is also over 80 characters. So I broke it into two lines
> as well in order to make that line not be more than 80 characters.
> 
> Signed-off-by: Hu Haowen <xianfengting221@163.com>

Applied.
