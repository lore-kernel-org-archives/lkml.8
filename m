Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C219C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 11:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E6720679
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 11:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgASLbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 06:31:31 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47444 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgASLbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 06:31:25 -0500
Received: from localhost (unknown [62.21.130.100])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 679AD14C9286B;
        Sun, 19 Jan 2020 03:31:24 -0800 (PST)
Date:   Fri, 17 Jan 2020 04:27:40 -0800 (PST)
Message-Id: <20200117.042740.289237231026252924.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, vivien.didelot@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: bcm_sf2: Configure IMP port for 2Gb/sec
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200116205549.12353-1-f.fainelli@gmail.com>
References: <20200116205549.12353-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 19 Jan 2020 03:31:25 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 16 Jan 2020 12:55:48 -0800

> With the implementation of the system reset controller we lost a setting
> that is currently applied by the bootloader and which configures the IMP
> port for 2Gb/sec, the default is 1Gb/sec. This is needed given the
> number of ports and applications we expect to run so bring back that
> setting.
> 
> Fixes: 01b0ac07589e ("net: dsa: bcm_sf2: Add support for optional reset controller line")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

I applied this, but I should have checked the Fixes: tag before pushing
it out as it's invalid.  What tree did you get that SHA1-ID from? :-/
