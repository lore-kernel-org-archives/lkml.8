Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A09BC10F25
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 03:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE912467E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 03:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCJDNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 23:13:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35216 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgCJDNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 23:13:37 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0603212199AD3;
        Mon,  9 Mar 2020 20:13:35 -0700 (PDT)
Date:   Mon, 09 Mar 2020 20:13:33 -0700 (PDT)
Message-Id: <20200309.201333.1206993515171228717.davem@davemloft.net>
To:     Jose.Abreu@synopsys.com
Cc:     netdev@vger.kernel.org, Joao.Pinto@synopsys.com,
        peppe.cavallaro@st.com, alexandre.torgue@st.com, kuba@kernel.org,
        mcoquelin.stm32@gmail.com, linux@armlinux.org.uk, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/8] net: Add support for Synopsys DesignWare
 XPCS
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1583742615.git.Jose.Abreu@synopsys.com>
References: <cover.1583742615.git.Jose.Abreu@synopsys.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 09 Mar 2020 20:13:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>
Date: Mon,  9 Mar 2020 09:36:19 +0100

> This adds support for Synopsys DesignWare XPCS in net subsystem and
> integrates it into stmmac.
> 
> At 1/8, we start by removing the limitation of stmmac selftests that needed
> a PHY to pass all the tests.
> 
> Then at 2/8 we use some helpers in stmmac so that some code can be
> simplified.
> 
> At 3/8, we fallback to dev_fwnode() so that PCI based setups wich may
> not have CONFIG_OF can still use FW node.
> 
> At 4/8, we adapt stmmac to the new PHYLINK changes as suggested by Russell
> King.
> 
> We proceed by doing changes in PHYLINK in order to support XPCS: At 5/8 we
> add some missing speeds that USXGMII supports and at 6/8 we check if
> Autoneg is supported after initial parameters are validated.
> 
> Support for XPCS is finally introduced at 7/8, along with the usage of it
> in stmmac driver at 8/8.

Series applied, thank you.
