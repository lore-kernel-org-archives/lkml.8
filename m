Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63A7C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B503620659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgBEJXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:23:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:49454 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbgBEJXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:23:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6C2ACB1F7;
        Wed,  5 Feb 2020 09:23:48 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id D53B2E03A8; Wed,  5 Feb 2020 10:23:45 +0100 (CET)
Date:   Wed, 5 Feb 2020 10:23:45 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>, davem@davemloft.ne,
        jeffrey.t.kirsher@intel.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ido Schimmel <idosch@mellanox.com>,
        Jouni Hogander <jouni.hogander@unikie.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Eric Dumazet <edumazet@google.com>,
        Wang Hai <wanghai26@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Li RongQing <lirongqing@baidu.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] net-sysfs: Ensure begin/complete are called in
 speed_show() and duplex_show()
Message-ID: <20200205092345.GA14294@unicorn.suse.cz>
References: <20200205081616.18378-1-kai.heng.feng@canonical.com>
 <20200205081616.18378-2-kai.heng.feng@canonical.com>
 <20200205090638.GS10400@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205090638.GS10400@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 11:06:38AM +0200, Andy Shevchenko wrote:
> On Wed, Feb 05, 2020 at 04:16:16PM +0800, Kai-Heng Feng wrote:
> > Device like igb gets runtime suspended when there's no link partner. We
> > can't get correct speed under that state:
> > $ cat /sys/class/net/enp3s0/speed
> > 1000
> > 
> > In addition to that, an error can also be spotted in dmesg:
> > [  385.991957] igb 0000:03:00.0 enp3s0: PCIe link lost
> > 
> > It's because the igb device doesn't get runtime resumed before calling
> > get_link_ksettings().
> > 
> > So let's use a new helper to call begin() and complete() like what
> > dev_ethtool() does, to runtime resume/suspend or power up/down the
> > device properly.
> > 
> > Once this fix is in place, igb can show the speed correctly without link
> > partner:
> > $ cat /sys/class/net/enp3s0/speed
> > -1
> 
> What is the meaning of -1? Does it tells us "Hey, something is bad in hardware
> I can't tell you the speed" or does it imply anything else?

It's SPEED_UNKNOWN constant printed with "%d" template.

> Wouldn't be better to report 0?
> 
> Where is the documentation part of this ABI change?

It's not an ABI change, /sys/class/net/*/speed already shows -1 when the
device reports SPEED_UNKNOWN. The only change is that after this patch,
igb driver reports SPEED_UNKNOWN rather than an outdated value if there
is no link.

Michal
