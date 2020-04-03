Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36279C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 22:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080CC206F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 22:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgDCW7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 18:59:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35966 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgDCW7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 18:59:35 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2530B121938E5;
        Fri,  3 Apr 2020 15:59:34 -0700 (PDT)
Date:   Fri, 03 Apr 2020 15:59:30 -0700 (PDT)
Message-Id: <20200403.155930.1942213327887906330.davem@davemloft.net>
To:     jszhang3@mail.ustc.edu.cn
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: dwmac1000: fix out-of-bounds mac address
 reg setting
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200403102329.0690d7b2@xhacker>
References: <20200403102329.0690d7b2@xhacker>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 03 Apr 2020 15:59:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Date: Fri, 3 Apr 2020 10:23:29 +0800

> From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> 
> Commit 9463c4455900 ("net: stmmac: dwmac1000: Clear unused address
> entries") cleared the unused mac address entries, but introduced an
> out-of bounds mac address register programming bug -- After setting
> the secondary unicast mac addresses, the "reg" value has reached
> netdev_uc_count() + 1, thus we should only clear address entries
> if (addr < perfect_addr_number)
> 
> Fixes: 9463c4455900 ("net: stmmac: dwmac1000: Clear unused address entries")
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied and queued up for -stable, thanks.
