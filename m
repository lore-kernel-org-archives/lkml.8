Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEBCC35DE4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABD12084E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgBXXjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:39:21 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40196 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgBXXjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:39:21 -0500
Received: from localhost (unknown [50.226.181.18])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 49B1012543265;
        Mon, 24 Feb 2020 15:39:20 -0800 (PST)
Date:   Mon, 24 Feb 2020 15:39:17 -0800 (PST)
Message-Id: <20200224.153917.813576310969410957.davem@davemloft.net>
To:     a.fatoum@pengutronix.de
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        kernel@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: ethernet: stmmac: demote warnings about
 missing optional clocks
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200224172956.28744-1-a.fatoum@pengutronix.de>
References: <20200224172956.28744-1-a.fatoum@pengutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Feb 2020 15:39:20 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Mon, 24 Feb 2020 18:29:54 +0100

> The specification of a "eth-ck" and a "ptp_ref" clock is optional per
> the binding and the driver handles them gracefully.
> Demote the output to an info message accordingly.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Applied.
