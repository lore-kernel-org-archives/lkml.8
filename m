Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1D0C5ACBF
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABD9205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584239072;
	bh=qgg7WrnvRyYwWJnUtOh7aYkmAMkwN0LJEDyWXZeOOyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yNVfGzq9bHX+KONi6cFUEW2JQcZwNKmdXgIfD1cjHpTZacDTJ0fwCjOxIBAgushLN
	 iC/7XpTlZSyBF2IZ1qc+X7VAqWZ9piv3/5114tZ1/GEjQR57e6k9pTmHiLbGq2r3O1
	 2f7Ge9/WXaqvdiFVvu6FXfaQdrhtuJEJl0YMuTVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgCOCYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727949AbgCOCYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:24:15 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CF412076B;
        Sat, 14 Mar 2020 12:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584189352;
        bh=qgg7WrnvRyYwWJnUtOh7aYkmAMkwN0LJEDyWXZeOOyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yFsIb53KtqiL9/2/7M1bXjavMsvmNgnLnL4zmAQqzR9vivGrsYC+D5KKlwU6oQH+m
         KOxA1A+rjt4RGGhTZ1XOpguhpG5Bc8Lio1N6R3Lmybm70LYO/md8PEXgBNlj72bt8i
         jW0VdW+AI27mrciJeKuSTD41F7pVfE/AGUMnBX+k=
Received: by pali.im (Postfix)
        id A60F9A98; Sat, 14 Mar 2020 13:35:49 +0100 (CET)
Date:   Sat, 14 Mar 2020 13:35:49 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change email address for Pali =?utf-8?B?Um9ow6Fy?=
Message-ID: <20200314123549.new6pjdmn6dvile6@pali>
References: <20200307104237.8199-1-pali@kernel.org>
 <20200312211526.oahg6mdbvkxlkezi@pali>
 <dbfc7f174e4c75b74ca105e565cd3cba57b9ae73.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbfc7f174e4c75b74ca105e565cd3cba57b9ae73.camel@perches.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 March 2020 14:19:29 Joe Perches wrote:
> On Thu, 2020-03-12 at 22:15 +0100, Pali Rohár wrote:
> > On Saturday 07 March 2020 11:42:37 Pali Rohár wrote:
> > > For security reasons I stopped using gmail account and kernel address is
> > > now up-to-date alias to my personal address.
> > > 
> > > People periodically send me emails to address which they found in source
> > > code of drivers, so this change reflects state where people can contact me.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > ---
> > 
> > Greg, could you or someone else help me where to (re)send this patch?
> > MAINTAINERS file does not specify who is maintainer of MAINTAINERS file
> > itself and scripts/get_maintainer.pl did not help me too. Main entry is
> > LKML list.
> 
> MAINTAINERS has no maintainer.  It's updated by many.
> Andrew Morton sometimes picks up patches like this.
> As a last resort, you could sent the patch to Linus Torvalds.

Hi Joe! Thank you for reply and clarification of status. I'm adding
Andrew to the loop.

Andrew, could you pick up this patch?

> > As this change is across more subsystems I do not know who can take such
> > patch and I do not thing it make sense to split such change into more
> > patches (one for each subsystem).
> 
> You should add a .mailmap entry too.
> 
> > >  .../ABI/testing/sysfs-platform-dell-laptop       |  8 ++++----
> > >  MAINTAINERS                                      | 16 ++++++++--------
> > >  arch/arm/mach-omap2/omap-secure.c                |  2 +-
> > >  arch/arm/mach-omap2/omap-secure.h                |  2 +-
> > >  arch/arm/mach-omap2/omap-smc.S                   |  2 +-
> > >  drivers/char/hw_random/omap3-rom-rng.c           |  4 ++--
> > >  drivers/hwmon/dell-smm-hwmon.c                   |  4 ++--
> > >  drivers/platform/x86/dell-laptop.c               |  4 ++--
> > >  drivers/platform/x86/dell-rbtn.c                 |  4 ++--
> > >  drivers/platform/x86/dell-rbtn.h                 |  2 +-
> > >  drivers/platform/x86/dell-smbios-base.c          |  4 ++--
> > >  drivers/platform/x86/dell-smbios-smm.c           |  2 +-
> > >  drivers/platform/x86/dell-smbios.h               |  2 +-
> > >  drivers/platform/x86/dell-smo8800.c              |  2 +-
> > >  drivers/platform/x86/dell-wmi.c                  |  4 ++--
> > >  drivers/power/supply/bq2415x_charger.c           |  4 ++--
> > >  drivers/power/supply/bq27xxx_battery.c           |  2 +-
> > >  drivers/power/supply/isp1704_charger.c           |  2 +-
> > >  drivers/power/supply/rx51_battery.c              |  4 ++--
> > >  fs/udf/ecma_167.h                                |  2 +-
> > >  fs/udf/osta_udf.h                                |  2 +-
> > >  include/linux/power/bq2415x_charger.h            |  2 +-
> > >  tools/laptop/freefall/freefall.c                 |  2 +-
> > >  23 files changed, 41 insertions(+), 41 deletions(-)
> 
