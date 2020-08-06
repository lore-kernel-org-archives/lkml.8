Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7202C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8774B2065C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgHFApx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 20:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgHFApt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 20:45:49 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22AAC061574;
        Wed,  5 Aug 2020 17:45:48 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0B70015687A07;
        Wed,  5 Aug 2020 17:29:01 -0700 (PDT)
Date:   Wed, 05 Aug 2020 17:45:46 -0700 (PDT)
Message-Id: <20200805.174546.1898874545402901800.davem@davemloft.net>
To:     r.czerwinski@pengutronix.de
Cc:     borisp@mellanox.com, aviadye@mellanox.com,
        john.fastabend@gmail.com, daniel@iogearbox.net, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: tls: add compat for get/setsockopt
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200805122501.4856-1-r.czerwinski@pengutronix.de>
References: <20200805122501.4856-1-r.czerwinski@pengutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 05 Aug 2020 17:29:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Neither of these patches apply cleanly to net-next.  The compat handling
and TLS code has been changed quite a bit lately.

ALso, you must provide a proper header "[PATCH 0/N] ..." posting for your
patch series which explains at a high level what your patch series is doing,
how it is doing it, and why it is doing it that way.

Thank you.
