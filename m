Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F907C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1037C20733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgBJIri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 03:47:38 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44565 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgBJIri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 03:47:38 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1j14it-0000uB-GX; Mon, 10 Feb 2020 09:47:19 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1j14ip-0000h9-Dg; Mon, 10 Feb 2020 09:47:15 +0100
Date:   Mon, 10 Feb 2020 09:47:15 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: da9062_wdt.c:undefined reference to `i2c_smbus_write_byte_data'
Message-ID: <20200210084715.4nnp7ch5mih2bdh7@pengutronix.de>
References: <202002082121.pOScaga1%lkp@intel.com>
 <14439325-fa91-9090-6dab-d63ce540aae7@infradead.org>
 <184bc727-2cb5-a3c2-38ee-83da8dbd0396@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <184bc727-2cb5-a3c2-38ee-83da8dbd0396@roeck-us.net>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:46:44 up 87 days, 5 min, 91 users,  load average: 0.05, 0.08,
 0.02
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-02-08 08:38, Guenter Roeck wrote:
> On 2/8/20 8:06 AM, Randy Dunlap wrote:
> > On 2/8/20 5:14 AM, kbuild test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   f757165705e92db62f85a1ad287e9251d1f2cd82
> > > commit: 057b52b4b3d58f4ee5944171da50f77b00a1bb0d watchdog: da9062: make restart handler atomic safe
> > > date:   12 days ago
> > > config: i386-randconfig-b001-20200208 (attached as .config)
> > > compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
> > > reproduce:
> > >          git checkout 057b52b4b3d58f4ee5944171da50f77b00a1bb0d
> > >          # save the attached .config to linux build tree
> > >          make ARCH=i386
> > > 
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >     ld: drivers/watchdog/da9062_wdt.o: in function `da9062_wdt_restart':
> > > > > da9062_wdt.c:(.text+0x1c): undefined reference to `i2c_smbus_write_byte_data'
> > > 
> > > ---
> > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > 
> > 
> > Also reported here:
> > https://lore.kernel.org/lkml/ac797eb0-9b0a-d2d3-3a40-3fbd0a8b5ee0@infradead.org/
> > 
> 
> Yes, I know, and 0-day reported it earlier as well. Unfortunately
> neither resulted in a fix. I submitted one last night; see
> https://patchwork.kernel.org/patch/11371651/.

My fault, sorry.

Regards,
  Marco

> Guenter
> 
