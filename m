Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACB3C2BA18
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 23:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4793120721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 23:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgDCXLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 19:11:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36440 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgDCXLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 19:11:42 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B9F4B121938E3;
        Fri,  3 Apr 2020 16:11:40 -0700 (PDT)
Date:   Fri, 03 Apr 2020 16:11:39 -0700 (PDT)
Message-Id: <20200403.161139.2115986079787627095.davem@davemloft.net>
To:     gch981213@gmail.com
Cc:     netdev@vger.kernel.org, stable@vger.kernel.org,
        sean.wang@mediatek.com, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, matthias.bgg@gmail.com,
        opensource@vdorst.com, rmk+kernel@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: mt7530: fix null pointer dereferencing in
 port5 setup
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200403112830.505720-1-gch981213@gmail.com>
References: <20200403112830.505720-1-gch981213@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 03 Apr 2020 16:11:41 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuanhong Guo <gch981213@gmail.com>
Date: Fri,  3 Apr 2020 19:28:24 +0800

> The 2nd gmac of mediatek soc ethernet may not be connected to a PHY
> and a phy-handle isn't always available.
> Unfortunately, mt7530 dsa driver assumes that the 2nd gmac is always
> connected to switch port 5 and setup mt7530 according to phy address
> of 2nd gmac node, causing null pointer dereferencing when phy-handle
> isn't defined in dts.
> This commit fix this setup code by checking return value of
> of_parse_phandle before using it.
> 
> Fixes: 38f790a80560 ("net: dsa: mt7530: Add support for port 5")
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> Cc: stable@vger.kernel.org

Please do not CC: stable for networking changes, as per:

	Documentation/networking/netdev-FAQ.rstq

Applied and queued up for -stable, thank you.
