Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BD6C4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 04:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7827A20732
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 04:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgB0E4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 23:56:01 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37160 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgB0E4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 23:56:01 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5424915B47E20;
        Wed, 26 Feb 2020 20:56:00 -0800 (PST)
Date:   Wed, 26 Feb 2020 20:55:59 -0800 (PST)
Message-Id: <20200226.205559.362242257227126401.davem@davemloft.net>
To:     aaro.koskinen@nokia.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: stmmac: fix notifier registration
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200226164901.21883-1-aaro.koskinen@nokia.com>
References: <20200226164901.21883-1-aaro.koskinen@nokia.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Feb 2020 20:56:00 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: aaro.koskinen@nokia.com
Date: Wed, 26 Feb 2020 18:49:01 +0200

> From: Aaro Koskinen <aaro.koskinen@nokia.com>
> 
> We cannot register the same netdev notifier multiple times when probing
> stmmac devices. Register the notifier only once in module init, and also
> make debugfs creation/deletion safe against simultaneous notifier call.
> 
> Fixes: 481a7d154cbb ("stmmac: debugfs entry name is not be changed when udev rename device name.")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Applied and queued up for v5.5 -stable, thanks.
