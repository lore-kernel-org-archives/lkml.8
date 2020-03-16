Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073BCC10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 00:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FF52051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 00:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgCPAD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 20:03:29 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42644 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729065AbgCPAD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 20:03:29 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BA7AA12110416;
        Sun, 15 Mar 2020 17:03:28 -0700 (PDT)
Date:   Sun, 15 Mar 2020 17:03:28 -0700 (PDT)
Message-Id: <20200315.170328.914330398423949706.davem@davemloft.net>
To:     andrew@lunn.ch
Cc:     zhengdejin5@gmail.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 1/2] net: stmmac: use readl_poll_timeout()
 function in init_systime()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200315182504.GA8524@lunn.ch>
References: <20200315150301.32129-1-zhengdejin5@gmail.com>
        <20200315150301.32129-2-zhengdejin5@gmail.com>
        <20200315182504.GA8524@lunn.ch>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 15 Mar 2020 17:03:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 15 Mar 2020 19:25:04 +0100

> It is normal to just return whatever error code readl_poll_timeout()
> returned.

Agreed.
