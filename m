Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD7CC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1030B20771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbgGWBLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733203AbgGWBLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 21:11:21 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5784BC0619DC;
        Wed, 22 Jul 2020 18:11:21 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 005FE126B58BC;
        Wed, 22 Jul 2020 17:54:35 -0700 (PDT)
Date:   Wed, 22 Jul 2020 18:11:20 -0700 (PDT)
Message-Id: <20200722.181120.968186222045330532.davem@davemloft.net>
To:     gustavoars@kernel.org
Cc:     siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] tg3: Avoid the use of one-element array
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200722184358.GA15694@embeddedor>
References: <20200722184358.GA15694@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 22 Jul 2020 17:54:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Date: Wed, 22 Jul 2020 13:43:58 -0500

> One-element arrays are being deprecated[1]. Replace the one-element
> array with a simple value type 'u32 reserved2'[2], once it seems
> this is just a placeholder for alignment.
> 
> [1] https://github.com/KSPP/linux/issues/79
> [2] https://github.com/KSPP/linux/issues/86
> 
> Tested-by: kernel test robot <lkp@intel.com>
> Link: https://github.com/GustavoARSilva/linux-hardening/blob/master/cii/0-day/tg3-20200718.md
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied, thank you.
