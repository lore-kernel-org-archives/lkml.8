Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC0CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE1420BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgIJWQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgIJWQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 18:16:09 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC32C061573;
        Thu, 10 Sep 2020 15:16:09 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A43D4135E9FF1;
        Thu, 10 Sep 2020 14:59:21 -0700 (PDT)
Date:   Thu, 10 Sep 2020 15:16:07 -0700 (PDT)
Message-Id: <20200910.151607.1755041538732050239.davem@davemloft.net>
To:     alex.dewar90@gmail.com
Cc:     kuba@kernel.org, rmk+kernel@armlinux.org.uk, mcroce@microsoft.com,
        sven.auhagen@voleatech.de, andrew@lunn.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mvpp2: ptp: Fix unused variables
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200910134915.46660-1-alex.dewar90@gmail.com>
References: <20200910134915.46660-1-alex.dewar90@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Thu, 10 Sep 2020 14:59:22 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Dewar <alex.dewar90@gmail.com>
Date: Thu, 10 Sep 2020 14:49:10 +0100

> In the functions mvpp2_isr_handle_xlg() and
> mvpp2_isr_handle_gmac_internal(), the bool variable link is assigned a
> true value in the case that a given bit of val is set. However, if the
> bit is unset, no value is assigned to link and it is then passed to
> mvpp2_isr_handle_link() without being initialised. Fix by assigning to
> link the value of the bit test.
> 
> Build-tested on x86.
> 
> Fixes: 36cfd3a6e52b ("net: mvpp2: restructure "link status" interrupt handling")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>

Applied to net-next.
