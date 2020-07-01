Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D95C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 284AC20780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgGAWas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 18:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgGAWas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 18:30:48 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754A3C08C5C1;
        Wed,  1 Jul 2020 15:30:48 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0886114959EAB;
        Wed,  1 Jul 2020 15:30:47 -0700 (PDT)
Date:   Wed, 01 Jul 2020 15:30:47 -0700 (PDT)
Message-Id: <20200701.153047.1752708672711318364.davem@davemloft.net>
To:     elder@linaro.org
Cc:     kuba@kernel.org, evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/5] net: ipa: endpoint configuration
 updates
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200630133304.1331058-1-elder@linaro.org>
References: <20200630133304.1331058-1-elder@linaro.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 01 Jul 2020 15:30:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Elder <elder@linaro.org>
Date: Tue, 30 Jun 2020 08:32:59 -0500

> This series updates code that configures IPA endpoints.  The changes
> made mainly affect access to registers that are valid only for RX, or
> only for TX endpoints.
> 
> The first three patches avoid writing endpoint registers if they are
> not defined to be valid.  The fourth patch slightly modifies the
> parameters for the offset macros used for these endpoint registers,
> to make it explicit when only some endpoints are valid.
> 
> The last patch just tweaks one line of code so it uses a convention
> used everywhere else in the driver.
> 
> Version 2 of this series eliminates some of the "assert()" comments
> that Jakub inquired about.  The ones removed will actually go away
> in an upcoming (not-yet-posted) patch series anyway.

Series applied, thanks.
