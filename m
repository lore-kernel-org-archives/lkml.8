Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2EDC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 480B321D90
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgIJW3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgIJW3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 18:29:11 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B99C061573;
        Thu, 10 Sep 2020 15:29:11 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8D927135EDBFA;
        Thu, 10 Sep 2020 15:12:23 -0700 (PDT)
Date:   Thu, 10 Sep 2020 15:29:09 -0700 (PDT)
Message-Id: <20200910.152909.1471891711453289735.davem@davemloft.net>
To:     lucyyan@google.com
Cc:     kuba@kernel.org, hkallweit1@gmail.com, arnd@arndb.de,
        mdf@kernel.org, leon@kernel.org, mst@redhat.com,
        vaibhavgupta40@gmail.com, netdev@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dec: de2104x: Increase receive ring size for
 Tulip
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200910190509.81755-1-lucyyan@google.com>
References: <20200910190509.81755-1-lucyyan@google.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Thu, 10 Sep 2020 15:12:23 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucy Yan <lucyyan@google.com>
Date: Thu, 10 Sep 2020 12:05:09 -0700

> Increase Rx ring size to address issue where hardware is reaching
> the receive work limit.
> 
> Before:
> 
> [  102.223342] de2104x 0000:17:00.0 eth0: rx work limit reached
> [  102.245695] de2104x 0000:17:00.0 eth0: rx work limit reached
> [  102.251387] de2104x 0000:17:00.0 eth0: rx work limit reached
> [  102.267444] de2104x 0000:17:00.0 eth0: rx work limit reached
> 
> Signed-off-by: Lucy Yan <lucyyan@google.com>

Applied, thank you.
