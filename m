Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45B3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 760B920884
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgGCViN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 17:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgGCViM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:38:12 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D636AC061794;
        Fri,  3 Jul 2020 14:38:12 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 254161553106C;
        Fri,  3 Jul 2020 14:38:12 -0700 (PDT)
Date:   Fri, 03 Jul 2020 14:37:48 -0700 (PDT)
Message-Id: <20200703.143748.1707914643708890824.davem@davemloft.net>
To:     elder@linaro.org
Cc:     kuba@kernel.org, evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: ipa: fix HOLB timer register use
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200703212335.465355-1-elder@linaro.org>
References: <20200703212335.465355-1-elder@linaro.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 03 Jul 2020 14:38:12 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Elder <elder@linaro.org>
Date: Fri,  3 Jul 2020 16:23:33 -0500

> The function ipa_reg_init_hol_block_timer_val() generates the value
> to write into the HOL_BLOCK_TIMER endpoint configuration register,
> to represent a given timeout value (in microseconds).  It only
> supports a timer value of 0 though, in part because that's
> sufficient, but mainly because there was some confusion about
> how the register is formatted in newer hardware.
> 
> I got clarification about the register format, so this series fixes 
> ipa_reg_init_hol_block_timer_val() to work for any supported delay
> value.
> 
> The delay is based on the IPA core clock, so determining the value
> to write for a given period requires access to the current core
> clock rate.  So the first patch just creates a new function to
> provide that.

Series applied, thank you.
