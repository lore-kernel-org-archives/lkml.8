Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA12C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3097620658
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="n/qvynkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgC3VJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 17:09:21 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43544 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbgC3VJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:09:20 -0400
Received: by mail-io1-f65.google.com with SMTP id x9so12977011iom.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 14:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LQMmWKFXXDNKTWX4CIpxQrEHPSRiPfMjq8jxaS3pzgU=;
        b=n/qvynkEWyNEa3pa13rLSf65JlYY1/YvcGeTiYdIJCkUnXt2SN8RSqQEyF7ow4Qkez
         zVKg8d6SSd63M/GP/5HxXc9zcwpHLIMlbML0bzAXUvwaqsX8hlR9sNQmAwsp0S9BvrDl
         e1/PmGDOOZJ0za/9tOliaroZqFdTYHy3QBmOQVAYEtAY0PvlL84DVjj3OrhZRI2sJIEF
         fQH3stLrEBImpI2kg7TWcDmyn+UiLZwQ4POfqIusIJATlVf4NPEJONpe1RC9vbK4nnUm
         /C1xpFqEPdr0pwTBt7gFG+vYxcTbjMHb67FiJnME4fn2FLD/nAPPmnS7Z3Zqe8oF+DaE
         9gHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LQMmWKFXXDNKTWX4CIpxQrEHPSRiPfMjq8jxaS3pzgU=;
        b=B4JOSLAjcYcEYvLHTlbYZ7inEFpFuhCivoLEj/5uaCVzDynmuMXzZQOIlN/ajLRYGu
         81/n54Z6r/4cEGQuCQhh1lFSSYKE8e2pGMtMEt8xsSKGrKYzuUclhYdqeR5S+VfH63yE
         dQk4yKOvI8stwlvW3gXHl9bDiXq/JZ4dyRHvBygSBECKBc3lKdSkvZ/MYyHnVcWNhQxY
         vN/eD8RDOJLipclAg7hXfvE4ILJ94Tg06vXcpPoaKmMPisACcFKSrCNIIB0AJWsBAjwO
         1sUZUxl3Es3ylyhxGiUnwvqGB+uCXPaznonvu5nd6w/F20hD6QzWvYMz9jUpMFtMekfi
         SnKQ==
X-Gm-Message-State: ANhLgQ1OL0eARdCYihE9VWYAtw4tOAGFIGlqu1MzDTd4ufpxF2iSCPBn
        9VoexgP7w8fEn/c/QLDh+DBEPsFE5cjmeHAN1pWewQ==
X-Google-Smtp-Source: ADFU+vugoIOLey6rUkU+MxImCq8tmI71KonfG/L7TeNK0h35Bd5XYB9KXHamkASGevU1KAxASzG2ttrUKQF+6lK2f9Q=
X-Received: by 2002:a05:6602:164b:: with SMTP id y11mr12569834iow.3.1585602559415;
 Mon, 30 Mar 2020 14:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1580914232.git.arindam.nath@amd.com> <a8e98fe8-25da-3ea7-a204-2fee07c6061a@amd.com>
 <20200313002524.GB13046@kudzu.us> <MN2PR12MB3232D38E30341A7D7408BED79CCB0@MN2PR12MB3232.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3232D38E30341A7D7408BED79CCB0@MN2PR12MB3232.namprd12.prod.outlook.com>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Mon, 30 Mar 2020 17:09:08 -0400
Message-ID: <CAPoiz9zBxB28nfCudr0xXYi4Lg7XRJXshTLvTM5W5uMcvw=2FQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] AMD ntb driver fixes and improvements
To:     "Nath, Arindam" <Arindam.Nath@amd.com>
Cc:     "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Jiasen Lin <linjiasen@hygon.cn>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 2:43 PM Nath, Arindam <Arindam.Nath@amd.com> wrote:
>
> > -----Original Message-----
> > From: Jon Mason <jdmason@kudzu.us>
> > Sent: Friday, March 13, 2020 05:55
> > To: Mehta, Sanju <Sanju.Mehta@amd.com>
> > Cc: Nath, Arindam <Arindam.Nath@amd.com>; S-k, Shyam-sundar <Shyam-
> > sundar.S-k@amd.com>; Dave Jiang <dave.jiang@intel.com>; Allen Hubbe
> > <allenbh@gmail.com>; Jiasen Lin <linjiasen@hygon.cn>; Mehta, Sanju
> > <Sanju.Mehta@amd.com>; linux-ntb@googlegroups.com; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH 00/15] AMD ntb driver fixes and improvements
> >
> > On Fri, Feb 07, 2020 at 04:28:53PM +0530, Sanjay R Mehta wrote:
> > >
> > >
> > > On 2/5/2020 9:24 PM, Arindam Nath wrote:
> > > > [CAUTION: External Email]
> > > >
> > > > This patch series fixes some bugs in the existing
> > > > AMD NTB driver, cleans-up code, and modifies the
> > > > code to handle NTB link-up/down events. The series
> > > > is based on Linus' tree,
> > > >
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > >
> > > > Arindam Nath (15):
> > > >   NTB: Fix access to link status and control register
> > > >   NTB: clear interrupt status register
> > > >   NTB: Enable link up and down event notification
> > > >   NTB: define a new function to get link status
> > > >   NTB: return the side info status from amd_poll_link
> > > >   NTB: set peer_sta within event handler itself
> > > >   NTB: remove handling of peer_sta from amd_link_is_up
> > > >   NTB: handle link down event correctly
> > > >   NTB: handle link up, D0 and D3 events correctly
> > > >   NTB: move ntb_ctrl handling to init and deinit
> > > >   NTB: add helper functions to set and clear sideinfo
> > > >   NTB: return link up status correctly for PRI and SEC
> > > >   NTB: remove redundant setting of DB valid mask
> > > >   NTB: send DB event when driver is loaded or un-loaded
> > > >   NTB: add pci shutdown handler for AMD NTB
> > >
> > > The patch series looks good to me. Thanks for the changes.
> > >
> > > For all the ntb_hw_amd changes:
> > >
> > > Reviewed-by: Sanjay R Mehta <sanju.mehta@amd.com>
> >
> > I had to rework the first patch, since Jiasen's patch was already in
> > my tree for a couple months.  The rest applied fine and will be in my
> > git trees on github in a couple of hours (sanity build pending).
> >
>
> Hi Jon,
>
> Just wanted to know whether the changes are in your tree now?

You should see them in my ntb branch and I'll be sending out a pull req


>
> Thanks,
> Arindam
>
> > Thanks,
> > Jon
> >
> > >
> > >
> > > >
> > > >  drivers/ntb/hw/amd/ntb_hw_amd.c | 290
> > ++++++++++++++++++++++++++------
> > > >  drivers/ntb/hw/amd/ntb_hw_amd.h |   8 +-
> > > >  2 files changed, 247 insertions(+), 51 deletions(-)
> > > >
> > > > --
> > > > 2.17.1
> > > >
