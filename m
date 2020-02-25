Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F786C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8D921744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbgBYTKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 14:10:32 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48774 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgBYTKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 14:10:31 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0C11313B48C3E;
        Tue, 25 Feb 2020 11:10:31 -0800 (PST)
Date:   Tue, 25 Feb 2020 11:10:30 -0800 (PST)
Message-Id: <20200225.111030.1608169659746789536.davem@davemloft.net>
To:     aaro.koskinen@nokia.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: move notifier block to private data
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200225111615.17964-1-aaro.koskinen@nokia.com>
References: <20200225111615.17964-1-aaro.koskinen@nokia.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 25 Feb 2020 11:10:31 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: aaro.koskinen@nokia.com
Date: Tue, 25 Feb 2020 13:16:15 +0200

> From: Aaro Koskinen <aaro.koskinen@nokia.com>
> 
> Move notifier block to private data. Otherwise notifier code will complain
> about double register with multiple stmmac instances.
> 
> Fixes: 481a7d154cbb ("stmmac: debugfs entry name is not be changed when udev rename device name.")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

This doesn't make any sense.

We need only one instance of the stmmac notifier registered, no matter how many
stmmac devices are probed.

Please change it such that we only call register_notifier() once (when the first
stmmac device is probed) and only unregister_notifier() when the last one is
removed.
