Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8844AC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6362A2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgAPNAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:00:33 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38334 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAPNAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:00:33 -0500
Received: from localhost (82-95-191-104.ip.xs4all.nl [82.95.191.104])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 219D2159F919A;
        Thu, 16 Jan 2020 05:00:30 -0800 (PST)
Date:   Thu, 16 Jan 2020 05:00:29 -0800 (PST)
Message-Id: <20200116.050029.2278636258736479115.davem@davemloft.net>
To:     alobakin@dlink.ru
Cc:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        john@phrozen.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: tag_qca: fix doubled Tx statistics
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200115085652.12586-1-alobakin@dlink.ru>
References: <20200115085652.12586-1-alobakin@dlink.ru>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 16 Jan 2020 05:00:32 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <alobakin@dlink.ru>
Date: Wed, 15 Jan 2020 11:56:52 +0300

> DSA subsystem takes care of netdev statistics since commit 4ed70ce9f01c
> ("net: dsa: Refactor transmit path to eliminate duplication"), so
> any accounting inside tagger callbacks is redundant and can lead to
> messing up the stats.
> This bug is present in Qualcomm tagger since day 0.
> 
> Fixes: cafdc45c949b ("net-next: dsa: add Qualcomm tag RX/TX handler")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>

Applied and queued up for -stable.
