Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C2CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72BA42078D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388634AbgFXXeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 19:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388094AbgFXXen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 19:34:43 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63536C061573;
        Wed, 24 Jun 2020 16:34:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1DA8212778941;
        Wed, 24 Jun 2020 16:34:40 -0700 (PDT)
Date:   Wed, 24 Jun 2020 16:34:37 -0700 (PDT)
Message-Id: <20200624.163437.878978558101234300.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     Jisheng.Zhang@synaptics.com, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] net: phy: call phy_disable_interrupts() in
 phy_init_hw()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <7a71ba71-b6cf-653d-967d-b74f930a69c5@gmail.com>
References: <20200624112516.7fcd6677@xhacker.debian>
        <20200624.144309.110827193136110443.davem@davemloft.net>
        <7a71ba71-b6cf-653d-967d-b74f930a69c5@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 24 Jun 2020 16:34:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 24 Jun 2020 15:10:51 -0700

> Did you mean that you applied v4? It does not look like you pushed your
> local changes to net-next yet, so I cannot tell for sure.

I ended up applying v4, yes.
