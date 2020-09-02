Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065D7C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E030C20767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIBTzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgIBTy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 15:54:59 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAD3C061244;
        Wed,  2 Sep 2020 12:54:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A041D15634E01;
        Wed,  2 Sep 2020 12:38:11 -0700 (PDT)
Date:   Wed, 02 Sep 2020 12:54:57 -0700 (PDT)
Message-Id: <20200902.125457.278933270676031062.davem@davemloft.net>
To:     efremov@linux.com
Cc:     opendmb@gmail.com, f.fainelli@gmail.com, kuba@kernel.org,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: bcmgenet: fix mask check in
 bcmgenet_validate_flow()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200902111845.9915-1-efremov@linux.com>
References: <20200902111845.9915-1-efremov@linux.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Wed, 02 Sep 2020 12:38:12 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>
Date: Wed,  2 Sep 2020 14:18:45 +0300

> VALIDATE_MASK(eth_mask->h_source) is checked twice in a row in
> bcmgenet_validate_flow(). Add VALIDATE_MASK(eth_mask->h_dest)
> instead.
> 
> Fixes: 3e370952287c ("net: bcmgenet: add support for ethtool rxnfc flows")
> Cc: stable@vger.kernel.org
> Signed-off-by: Denis Efremov <efremov@linux.com>

Please do not CC: stable for networking patches.

Applied and queued up for -stable, thank you.
