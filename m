Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD84AC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06F620650
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387940AbgCLGEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 02:04:04 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56020 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387767AbgCLGED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 02:04:03 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A3A6C14CCCAE8;
        Wed, 11 Mar 2020 23:04:02 -0700 (PDT)
Date:   Wed, 11 Mar 2020 23:04:02 -0700 (PDT)
Message-Id: <20200311.230402.1496009558967017193.davem@davemloft.net>
To:     mklntf@gmail.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: platform: Fix misleading interrupt error
 msg
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200306163848.5910-1-mklntf@gmail.com>
References: <20200306163848.5910-1-mklntf@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 11 Mar 2020 23:04:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Fuchs <mklntf@gmail.com>
Date: Fri,  6 Mar 2020 17:38:48 +0100

> Not every stmmac based platform makes use of the eth_wake_irq or eth_lpi
> interrupts. Use the platform_get_irq_byname_optional variant for these
> interrupts, so no error message is displayed, if they can't be found.
> Rather print an information to hint something might be wrong to assist
> debugging on platforms which use these interrupts.
> 
> Signed-off-by: Markus Fuchs <mklntf@gmail.com>

What do you mean the error message is misleading right now?

It isn't printing anything out at the moment in this situation.
