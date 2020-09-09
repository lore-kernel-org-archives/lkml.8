Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E967C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 22:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6176208FE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 22:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgIIWPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 18:15:33 -0400
Received: from lists.nic.cz ([217.31.204.67]:49558 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgIIWPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 18:15:30 -0400
Received: from localhost (unknown [IPv6:2a0e:b107:ae1:0:3e97:eff:fe61:c680])
        by mail.nic.cz (Postfix) with ESMTPSA id 0B3EC140A73;
        Thu, 10 Sep 2020 00:15:27 +0200 (CEST)
Date:   Thu, 10 Sep 2020 00:15:26 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     netdev@vger.kernel.org, linux-leds@vger.kernel.org,
        Dan Murphy <dmurphy@ti.com>,
        =?UTF-8?B?T25kxZllag==?= Jirman <megous@megous.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next + leds v2 2/7] leds: add generic API for LEDs
 that can be controlled by hardware
Message-ID: <20200910001526.48a978c4@nic.cz>
In-Reply-To: <20200909214009.GA16084@ucw.cz>
References: <20200909162552.11032-1-marek.behun@nic.cz>
        <20200909162552.11032-3-marek.behun@nic.cz>
        <20200909204815.GB20388@amd>
        <20200909232016.138bd1db@nic.cz>
        <20200909214009.GA16084@ucw.cz>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Sep 2020 23:40:09 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> > > 
> > > 80 columns :-) (and please fix that globally, at least at places where
> > > it is easy, like comments).
> > >   
> > 
> > Linux is at 100 columns now since commit bdc48fa11e46, commited by
> > Linus. See
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/scripts/checkpatch.pl?h=v5.9-rc4&id=bdc48fa11e46f867ea4d75fa59ee87a7f48be144
> > There was actually an article about this on Phoronix, I think.  
> 
> It is not. Checkpatch no longer warns about it, but 80 columns is
> still preffered, see Documentation/process/coding-style.rst . Plus,
> you want me to take the patch, not Linus.

Very well, I shall rewrap it to 80 columns :)

Marek
