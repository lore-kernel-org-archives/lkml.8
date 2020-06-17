Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D921C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8254208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgFQGq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:46:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:41678 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgFQGqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 02:46:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4D5E1AC22;
        Wed, 17 Jun 2020 06:46:58 +0000 (UTC)
Date:   Wed, 17 Jun 2020 08:46:53 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Stefan Wahren <wahrenst@gmx.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v1] ARM: bcm2835: Fix integer overflow in
 rpi_firmware_print_firmware_revision()
Message-ID: <20200617064652.GR31238@alley>
References: <20200616163139.4229-1-andriy.shevchenko@linux.intel.com>
 <1e504c53d632b4f175f69782d1e38f0030dc9055.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e504c53d632b4f175f69782d1e38f0030dc9055.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-06-16 18:42:00, Nicolas Saenz Julienne wrote:
> On Tue, 2020-06-16 at 19:31 +0300, Andy Shevchenko wrote:
> > time64_t is 64-bit width type, we are not supposed to supply lesser ones
> > as in the case of rpi_firmware_print_firmware_revision() after the commit
> > 4a60f58ee002 ("ARM: bcm2835: Switch to use %ptT"). Use temporary variable
> > of time64_t type to correctly handle lesser types.
> > 
> > Fixes: 4a60f58ee002 ("ARM: bcm2835: Switch to use %ptT")
> > Reported-by: Stefan Wahren <wahrenst@gmx.net>
> > Reported-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Petr Mladek <pmladek@suse.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > ---
> 
> Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Revieved-by: Petr Mladek <pmladek@suse.com>

> If this doesn't fit the printk tree I don't mind taking it trough the rpi soc
> tree.
> 
> I'll also update the MAINTAINERS file so the firmware driver isn't orphaned.

I agree with Sergey that this should better go via SOC tree.

That said, feel free to ask to take it via printk tree. It has caused
the regression after all ;-)

Best Regards,
Petr
