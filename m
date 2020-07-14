Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7B9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44813217BA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgGNAMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 20:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGNAMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 20:12:07 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC8BC061755;
        Mon, 13 Jul 2020 17:12:07 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 01C7512981398;
        Mon, 13 Jul 2020 17:12:05 -0700 (PDT)
Date:   Mon, 13 Jul 2020 17:12:05 -0700 (PDT)
Message-Id: <20200713.171205.730061541247000028.davem@davemloft.net>
To:     elder@linaro.org
Cc:     kuba@kernel.org, evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ipa: fix kerneldoc comments
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200713122418.505734-1-elder@linaro.org>
References: <20200713122418.505734-1-elder@linaro.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 Jul 2020 17:12:06 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Elder <elder@linaro.org>
Date: Mon, 13 Jul 2020 07:24:18 -0500

> This commit affects comments (and in one case, whitespace) only.
> 
> Throughout the IPA code, return statements are documented using
> "@Return:", whereas they should use "Return:" instead.  Fix these
> mistakes.
> 
> In function definitions, some parameters are missing their comment
> to describe them.  And in structure definitions, some fields are
> missing their comment to describe them.  Add these missing
> descriptions.
> 
> Some arguments changed name and type along the way, but their
> descriptions were not updated (an endpoint pointer is now used in
> many places that previously used an endpoint ID).  Fix these
> incorrect parameter descriptions.
> 
> In the description for the ipa_clock structure, one field had a
> semicolon instead of a colon in its description.  Fix this.
> 
> Add a missing function description for ipa_gsi_endpoint_data_empty().
> 
> All of these issues were identified when building with "W=1".
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

Applied, thanks Alex.
