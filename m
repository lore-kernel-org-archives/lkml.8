Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085FCC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4A2320663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbgEDReL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729549AbgEDReK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:34:10 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922B2C061A0E;
        Mon,  4 May 2020 10:34:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E8138148FE64F;
        Mon,  4 May 2020 10:34:09 -0700 (PDT)
Date:   Mon, 04 May 2020 10:34:09 -0700 (PDT)
Message-Id: <20200504.103409.787413834519966204.davem@davemloft.net>
To:     mmrmaximuzz@gmail.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] stmmac: fix pointer check after utilization in
 stmmac_interrupt
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200504062639.GA11585@maxim-hplinux>
References: <20200504062639.GA11585@maxim-hplinux>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 04 May 2020 10:34:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Petrov <mmrmaximuzz@gmail.com>
Date: Mon, 4 May 2020 09:26:43 +0300

> The paranoidal pointer check in IRQ handler looks very strange - it
> really protects us only against bogus drivers which request IRQ line
> with null pointer dev_id. However, the code fragment is incorrect
> because the dev pointer is used before the actual check which leads
> to undefined behavior. Remove the check to avoid confusing people
> with incorrect code.
> 
> Signed-off-by: Maxim Petrov <mmrmaximuzz@gmail.com>

Applied, thanks.
