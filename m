Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0160C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39D8206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgCLVVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:21:15 -0400
Received: from smtprelay0104.hostedemail.com ([216.40.44.104]:42886 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726442AbgCLVVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 17:21:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 2207A1816BE33;
        Thu, 12 Mar 2020 21:21:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stew28_aaaec86c541a
X-Filterd-Recvd-Size: 3490
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Mar 2020 21:21:13 +0000 (UTC)
Message-ID: <dbfc7f174e4c75b74ca105e565cd3cba57b9ae73.camel@perches.com>
Subject: Re: [PATCH] Change email address for Pali =?ISO-8859-1?Q?Roh=E1r?=
From:   Joe Perches <joe@perches.com>
To:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 12 Mar 2020 14:19:29 -0700
In-Reply-To: <20200312211526.oahg6mdbvkxlkezi@pali>
References: <20200307104237.8199-1-pali@kernel.org>
         <20200312211526.oahg6mdbvkxlkezi@pali>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-12 at 22:15 +0100, Pali Rohár wrote:
> On Saturday 07 March 2020 11:42:37 Pali Rohár wrote:
> > For security reasons I stopped using gmail account and kernel address is
> > now up-to-date alias to my personal address.
> > 
> > People periodically send me emails to address which they found in source
> > code of drivers, so this change reflects state where people can contact me.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> 
> Greg, could you or someone else help me where to (re)send this patch?
> MAINTAINERS file does not specify who is maintainer of MAINTAINERS file
> itself and scripts/get_maintainer.pl did not help me too. Main entry is
> LKML list.

MAINTAINERS has no maintainer.  It's updated by many.
Andrew Morton sometimes picks up patches like this.
As a last resort, you could sent the patch to Linus Torvalds.

> As this change is across more subsystems I do not know who can take such
> patch and I do not thing it make sense to split such change into more
> patches (one for each subsystem).

You should add a .mailmap entry too.

> >  .../ABI/testing/sysfs-platform-dell-laptop       |  8 ++++----
> >  MAINTAINERS                                      | 16 ++++++++--------
> >  arch/arm/mach-omap2/omap-secure.c                |  2 +-
> >  arch/arm/mach-omap2/omap-secure.h                |  2 +-
> >  arch/arm/mach-omap2/omap-smc.S                   |  2 +-
> >  drivers/char/hw_random/omap3-rom-rng.c           |  4 ++--
> >  drivers/hwmon/dell-smm-hwmon.c                   |  4 ++--
> >  drivers/platform/x86/dell-laptop.c               |  4 ++--
> >  drivers/platform/x86/dell-rbtn.c                 |  4 ++--
> >  drivers/platform/x86/dell-rbtn.h                 |  2 +-
> >  drivers/platform/x86/dell-smbios-base.c          |  4 ++--
> >  drivers/platform/x86/dell-smbios-smm.c           |  2 +-
> >  drivers/platform/x86/dell-smbios.h               |  2 +-
> >  drivers/platform/x86/dell-smo8800.c              |  2 +-
> >  drivers/platform/x86/dell-wmi.c                  |  4 ++--
> >  drivers/power/supply/bq2415x_charger.c           |  4 ++--
> >  drivers/power/supply/bq27xxx_battery.c           |  2 +-
> >  drivers/power/supply/isp1704_charger.c           |  2 +-
> >  drivers/power/supply/rx51_battery.c              |  4 ++--
> >  fs/udf/ecma_167.h                                |  2 +-
> >  fs/udf/osta_udf.h                                |  2 +-
> >  include/linux/power/bq2415x_charger.h            |  2 +-
> >  tools/laptop/freefall/freefall.c                 |  2 +-
> >  23 files changed, 41 insertions(+), 41 deletions(-)

