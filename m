Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD53C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 23:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBF620719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 23:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgCXXqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 19:46:14 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37998 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgCXXqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 19:46:14 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 593C8159F6E5E;
        Tue, 24 Mar 2020 16:46:13 -0700 (PDT)
Date:   Tue, 24 Mar 2020 16:46:12 -0700 (PDT)
Message-Id: <20200324.164612.1971775620100257616.davem@davemloft.net>
To:     andre.przywara@arm.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, opendmb@gmail.com
Subject: Re: [PATCH] net: PHY: bcm-unimac: Fix clock handling
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200324161010.81107-1-andre.przywara@arm.com>
References: <20200324161010.81107-1-andre.przywara@arm.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 24 Mar 2020 16:46:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Przywara <andre.przywara@arm.com>
Date: Tue, 24 Mar 2020 16:10:10 +0000

> The DT binding for this PHY describes an *optional* clock property.
> Due to a bug in the error handling logic, we are actually ignoring this
> clock *all* of the time so far.
> 
> Fix this by using devm_clk_get_optional() to handle this clock properly.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Applied with Fixes tag added and Subject line corrected.

Thanks.
