Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56636C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3118F2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgFJXhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgFJXhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 19:37:00 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAF6C03E96B;
        Wed, 10 Jun 2020 16:36:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EB55011F5F667;
        Wed, 10 Jun 2020 16:36:58 -0700 (PDT)
Date:   Wed, 10 Jun 2020 16:36:58 -0700 (PDT)
Message-Id: <20200610.163658.2043816131147701638.davem@davemloft.net>
To:     elder@linaro.org
Cc:     kuba@kernel.org, evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 5/5] net: ipa: warn if gsi_trans structure is too
 big
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200610195332.2612233-6-elder@linaro.org>
References: <20200610195332.2612233-1-elder@linaro.org>
        <20200610195332.2612233-6-elder@linaro.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 10 Jun 2020 16:36:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Elder <elder@linaro.org>
Date: Wed, 10 Jun 2020 14:53:32 -0500

> When the DEBUG_SPINLOCK and DEBUG_LOCK_ALLOC config options are
> enabled, sizeof(raw_spinlock_t) grows considerably (from 4 bytes
> to 56 bytes currently).  As a consequence the size of the gsi_trans
> structure exceeds 128 bytes, and this triggers a BUILD_BUG_ON()
> error.
> 
> These are useful configuration options to enable, so rather than
> causing a build failure, just issue a warning message at run time
> if the structure is larger than we'd prefer.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

Please fix the problem or prevent the build of this module in such
configurations since obviously it will fail to load successfully.

It is completely unexpected for something to fail at run time that
could be detected at build time.
