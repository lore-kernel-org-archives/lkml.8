Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9B8C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 19:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1D920661
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 19:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgAJTcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 14:32:25 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39992 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgAJTcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 14:32:25 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7E9CA1577F52F;
        Fri, 10 Jan 2020 11:32:24 -0800 (PST)
Date:   Fri, 10 Jan 2020 11:32:23 -0800 (PST)
Message-Id: <20200110.113223.993180749814320634.davem@davemloft.net>
To:     Jose.Abreu@synopsys.com
Cc:     netdev@vger.kernel.org, Joao.Pinto@synopsys.com,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] net: stmmac: Filtering fixes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1578669661.git.Jose.Abreu@synopsys.com>
References: <cover.1578669661.git.Jose.Abreu@synopsys.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 10 Jan 2020 11:32:24 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>
Date: Fri, 10 Jan 2020 16:23:51 +0100

> Two single fixes for the L3 and L4 filtering in stmmac.
> 
> 1) Updates the internal status of RSS when disabling it in order to keep
> internal driver status consistent.
> 
> 2) Do not lets user add a filter if RSS is enabled because the filter will
> not work correctly as RSS bypasses this mechanism.

Series applied and queued up for v5.4 -stable, thanks.
