Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0315C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C636A2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="YiYCYDVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgAQSL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:11:56 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46443 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgAQSLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:11:55 -0500
Received: by mail-io1-f67.google.com with SMTP id t26so27021577ioi.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 10:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pihRMUVPHOuetXPQB62i/znalvf4yuPPPZW6nrkenRs=;
        b=YiYCYDVLfijh0VBDaOrzuQu0kkrp7uU5HKIcT7fScOno85GNhEF++toFH+s5pPItOG
         cGhvvowM9J8eBxYgIhqHvHiJHd7Wv8LEOH1QARwrueRijAKUrFdflJXJZjg7ilhX9wAO
         t3zQna4c8b+XzpB52VkLOYbvtAMuoTgm1qc1MJlf1KNnapF93hpg3dGhmEtD2mr+BRYO
         6S0Yp2siDHvU9/eVLYKTOQ2iZEhI9KKQxT5NJQciIAlx9XZoH0VEGtYtD/ZqcJfoVQOO
         6UG1srhq33t1FaLPpdv6GptGvuqV7PpqGrLiSYCrTC14q1h0Js/hAFje3j8TNEBhOK9v
         H3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pihRMUVPHOuetXPQB62i/znalvf4yuPPPZW6nrkenRs=;
        b=XntfTQv5eYHH29emQYqnKoHFoibkApUfZrxpNEQ83QIWOKGfM3BT1vJdHFqlUNvTx/
         Zz2rza+QB3Hch364AFlM8nH6I8aPDSlJdcrJb43fRNRRFOtT+NXogZudpm8owFYAIC6H
         44Lsau0zTbHC4sUn3oNkkih1/6SpVOacGsK2VtEsdRh4AFsxktdm+Z6tY7WqGeohuoy+
         tJ3p/8UrPV0vqIk0MWU/vrO8Qg4ZVqUQhUMMoKCfTwYbhfQHW6+BCVLFPc3vOpx6AOx4
         beKUqiXut1m2ignx7+jr4d2WyY0gNQP6aHWnN8Ys0r/WhuV/Ap4t6n5crKVnuuWhTBMH
         ncBQ==
X-Gm-Message-State: APjAAAUw83aayjKdF4IvcDiaVe5GvZAC2fgg5ooV6saqhVtwzQn7VULA
        51c96yureISzwblgR+PjTW36PmwwpbnKt5xEPy3R0w==
X-Google-Smtp-Source: APXvYqyn+Z0s4+oQK4CAzP3vyOMtqUmmJDDi66iqhyQJpT6lPCntXFrjPUzzVDBaoiSvrrYPkZbNTmnmB0uE+DmUf7w=
X-Received: by 2002:a02:6957:: with SMTP id e84mr33315769jac.11.1579284714979;
 Fri, 17 Jan 2020 10:11:54 -0800 (PST)
MIME-Version: 1.0
References: <1579205259-4845-1-git-send-email-santosh.shilimkar@oracle.com>
 <20200117000358.fe7ew4vvnz4yxbzj@localhost> <148b6ec3-6a8e-ced8-41b3-3dffd5528ed6@oracle.com>
In-Reply-To: <148b6ec3-6a8e-ced8-41b3-3dffd5528ed6@oracle.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 17 Jan 2020 10:11:43 -0800
Message-ID: <CAOesGMiWL93ypL_4xqfqgwfVSOKtu8UqerzxV=Zr-aUkLp+rBw@mail.gmail.com>
Subject: Re: [GIT_PULL] SOC: TI Keystone Ring Accelerator driver for v5.6
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc:     SoC Team <soc@kernel.org>, ARM-SoC Maintainers <arm@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 9:05 PM <santosh.shilimkar@oracle.com> wrote:
>
> On 1/16/20 4:03 PM, Olof Johansson wrote:
> > Hi,
> >
> > On Thu, Jan 16, 2020 at 12:07:39PM -0800, Santosh Shilimkar wrote:
> >> Its bit late for pull request, but if possible, please pull it to
> >> soc drivers tree.
> >>
> >> The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
> >>
> >>    Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
> >>
> >> are available in the git repository at:
> >>
> >>    git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers_soc_for_5.6
> >>
> >> for you to fetch changes up to 3277e8aa2504d97e022ecb9777d784ac1a439d36:
> >>
> >>    soc: ti: k3: add navss ringacc driver (2020-01-15 10:07:27 -0800)
> >>
> >> ----------------------------------------------------------------
> >> SOC: TI Keystone Ring Accelerator driver
> >>
> >> The Ring Accelerator (RINGACC or RA) provides hardware acceleration to
> >> enable straightforward passing of work between a producer and a consumer.
> >> There is one RINGACC module per NAVSS on TI AM65x SoCs.
> >
> > This driver doesn't seem to have exported symbols, and no in-kernel
> > users. So how will it be used?
> >
> > Usually we ask to hold off until the consuming side/drivers are also ready.
> >
> The other patches getting merged via Vinod's tree. The combined series
> is split into couple of series. Vinod is going to pull this branch
> and apply rest of the patchset. And then couple of additional consumer
> drivers will get posted.

Ok -- might have been useful to get that in the tag description for
context. Something to consider next time.

> > Also, is there a reason this is under drivers/soc/ instead of somewhere more
> > suitable in the drivers subsystem? It's not "soc glue code" in the same way as
> > drivers/soc was intended originally.
> >
> These kind of SOC IP drivers, we put into drivers/soc/ because of lack
> of specific subsystem where they fit in. Navigator was also similar example.

Hmm. At some point we'll have to push the brakes on this, since
drivers/soc can't become a catch-all for random stuff like the old
mach directories were. But it's tricky to tell just when -- sometimes
you have to let the mess show up too.

I'll merge this when I do the next pass (today, likely).

-Olof
