Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140A0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC007207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgERXyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 19:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgERXyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:54:21 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BF8C061A0C;
        Mon, 18 May 2020 16:54:21 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 18F9C12744688;
        Mon, 18 May 2020 16:54:21 -0700 (PDT)
Date:   Mon, 18 May 2020 16:54:20 -0700 (PDT)
Message-Id: <20200518.165420.1453190687363061777.davem@davemloft.net>
To:     opendmb@gmail.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: simplify phy_link_change arguments
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1589840639-34074-1-git-send-email-opendmb@gmail.com>
References: <1589840639-34074-1-git-send-email-opendmb@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 18 May 2020 16:54:21 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>
Date: Mon, 18 May 2020 15:23:59 -0700

> This function was introduced to allow for different handling of
> link up and link down events particularly with regard to the
> netif_carrier. The third argument do_carrier allowed the flag to
> be left unchanged.
> 
> Since then the phylink has introduced an implementation that
> completely ignores the third parameter since it never wants to
> change the flag and the phylib always sets the third parameter
> to true so the flag is always changed.
> 
> Therefore the third argument (i.e. do_carrier) is no longer
> necessary and can be removed. This also means that the phylib
> phy_link_down() function no longer needs its second argument.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Looks good, applied, thanks.
