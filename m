Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462E6C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B6321744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbgBYJOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:14:16 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49455 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgBYJOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:14:16 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1j6WI9-0000M3-RI; Tue, 25 Feb 2020 10:14:13 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1j6WI7-0003OX-5f; Tue, 25 Feb 2020 10:14:11 +0100
Date:   Tue, 25 Feb 2020 10:14:11 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: linux-next: build failure after merge of the pinctrl tree
Message-ID: <20200225091411.gfzgjq3wn5ap4aij@pengutronix.de>
References: <20200225122100.34284341@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225122100.34284341@canb.auug.org.au>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:47:56 up 102 days, 6 min, 121 users,  load average: 0.01, 0.08,
 0.08
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thanks for the report and sorry for the build issue.

On 20-02-25 12:21, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the pinctrl tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> ERROR: "gpiochip_get_desc" [drivers/pinctrl/pinctrl-da9062.ko] undefined!
> 
> Caused by commit
> 
>   56cc3af4e8c8 ("pinctrl: da9062: add driver support")
> 
> I used the pinctrl tree from next-20200224 for today.

I'm the first user of this function within a driver and the functions
lacks of EXPORT_SYMBOL_GPL() currently.

@Linus
Shall I send a patch to address this or do you prepared a patch already?

Regards,
  Marco

> -- 
> Cheers,
> Stephen Rothwell
