Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6317C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 07:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB0A205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 07:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgCOHhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 03:37:48 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36132 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgCOHhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 03:37:48 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9A848141B9DD1;
        Sun, 15 Mar 2020 00:37:46 -0700 (PDT)
Date:   Sun, 15 Mar 2020 00:37:45 -0700 (PDT)
Message-Id: <20200315.003745.329177895751390879.davem@davemloft.net>
To:     zhengdejin5@gmail.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: platform: convert to
 devm_platform_ioremap_resource
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200313144257.9351-1-zhengdejin5@gmail.com>
References: <20200313144257.9351-1-zhengdejin5@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 15 Mar 2020 00:37:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dejin Zheng <zhengdejin5@gmail.com>
Date: Fri, 13 Mar 2020 22:42:57 +0800

> Use devm_platform_ioremap_resource() to simplify code, which
> contains platform_get_resource and devm_ioremap_resource.
> 
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>

Applied, thank you.
