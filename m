Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E483C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DF522522
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbgAOWLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:11:54 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60740 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgAOWLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 17:11:53 -0500
Received: from localhost (unknown [62.21.130.100])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7BEF5143243AE;
        Wed, 15 Jan 2020 14:11:50 -0800 (PST)
Date:   Wed, 15 Jan 2020 14:11:48 -0800 (PST)
Message-Id: <20200115.141148.1200825018921054560.davem@davemloft.net>
To:     Jose.Abreu@synopsys.com
Cc:     netdev@vger.kernel.org, Joao.Pinto@synopsys.com,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexey.Brodkin@synopsys.com, Vineet.Gupta1@synopsys.com,
        linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH net 0/4] net: stmmac: Fix selftests in Synopsys AXS101
 board
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1579017787.git.Jose.Abreu@synopsys.com>
References: <cover.1579017787.git.Jose.Abreu@synopsys.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 15 Jan 2020 14:11:52 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>
Date: Tue, 14 Jan 2020 17:09:20 +0100

> Set of fixes for sefltests so that they work in Synopsys AXS101 board.
 ...

Applied patches 1-3, it looks like patch 4 went into another tree.
