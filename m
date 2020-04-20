Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69609C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45631206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgDTTSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726079AbgDTTSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:18:38 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169C8C061A0C;
        Mon, 20 Apr 2020 12:18:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 850AA127F7217;
        Mon, 20 Apr 2020 12:18:37 -0700 (PDT)
Date:   Mon, 20 Apr 2020 12:18:36 -0700 (PDT)
Message-Id: <20200420.121836.238070928454325786.davem@davemloft.net>
To:     zhengdejin5@gmail.com
Cc:     f.fainelli@gmail.com, timur@kernel.org,
        kstewart@linuxfoundation.org, hkallweit1@gmail.com,
        tglx@linutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] net: ethernet: dnet: convert to
 devm_platform_get_and_ioremap_resource
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200419120253.25742-1-zhengdejin5@gmail.com>
References: <20200419120253.25742-1-zhengdejin5@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 20 Apr 2020 12:18:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dejin Zheng <zhengdejin5@gmail.com>
Date: Sun, 19 Apr 2020 20:02:53 +0800

> use devm_platform_get_and_ioremap_resource() to simplify code, which
> contains platform_get_resource() and devm_ioremap_resource(), it also
> get the resource for use by the following code.
> 
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>

Applied, thanks.
