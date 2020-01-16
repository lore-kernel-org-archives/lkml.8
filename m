Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29433C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA552075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="wxS4mTiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388063AbgAPUrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:47:55 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:47007 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbgAPUry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 15:47:54 -0500
Received: by mail-lf1-f67.google.com with SMTP id f15so16594256lfl.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 12:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ovKSezuHy9BrgOvF3ho5HLPHiCKwhToO8nK8UOTwvQA=;
        b=wxS4mTiWEYJBq7u21w7MjK/oe9sdxL05CHPtMjtAGObtFS38tWr6mXDv/SHbI/Wa42
         a8CTFpUzBBxok9qa5ZaXjQ/JwAuiL9FLyeg7KoH/ONAI+aqpv2RB/MtFzGsXLEfq4IzC
         kc+h3gdkkHxcRLD9WPYJS5hRzeYluHlX0jqYT4/2OGj+ichhulOkpdAwhKBzDYh6PeEv
         Ee6r+GOvXP0lkYK/GNTzbyutkaxOsTyzXkJKdDihQDw7tcqvXlDBea+uoLMrvWOoeBEa
         uIrkc1CvYNGYq+qaKlBctVrP/U/hrhCGaUk+cKx+DoTNfk3mYrFbdylA/HMhxqKyoB/K
         lnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ovKSezuHy9BrgOvF3ho5HLPHiCKwhToO8nK8UOTwvQA=;
        b=IGt+s6sksoGo/sdYL8QpMKkMS4gXuVz8y2ekTqMrPadEWrTGRp/P7Q4eyUYrdt3htT
         wIhILMYZnet3XjHgV1a8UVxcJZ3dSa7ZjYPvwvMbbZXbYUIMCxLaYMV99wl8lPvINoDi
         qpbAHaqc2uzYIV/J18vsLT/JXw90DeiF7ecrfSWXjTFw2oWmLwR3m4AUwYHkbcUJLkoG
         EC3ql5gLQyj7w6gy84R+qucJ1FSadw/oWH+erzv4vfhZWBg/rt5gAo6l5IxP5deMDzof
         dwuvVkwQfvVUc+UNX2xGEtMYpXZ2tMply5FIqxRqGs7hB2C71766Sq7TDALWvHf7qL18
         IaIQ==
X-Gm-Message-State: APjAAAUGrLoSD804OSIk4QiGTQwLltE7X+RW92LNtMi0X0ZI98Y/Mp9A
        pCiWZiiWCiSWecpy8XuMFK5zIA==
X-Google-Smtp-Source: APXvYqxjR7eQUQF49+zK358oCGTlgWyvRxTBJUPbwfprX4mG0FlxFLhsrRdNA49i+107ryJLCnNvkQ==
X-Received: by 2002:a19:7701:: with SMTP id s1mr3487368lfc.180.1579207672393;
        Thu, 16 Jan 2020 12:47:52 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id l7sm10929614lfc.80.2020.01.16.12.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 12:47:51 -0800 (PST)
Date:   Thu, 16 Jan 2020 12:47:43 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     arm@kernel.org, soc@kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [GIT PULL] soc/fsl drivers changes for next(v5.6)
Message-ID: <20200116204743.uwyo2mjvhj46vgxq@localhost>
References: <1578608351-23289-1-git-send-email-leoyang.li@nxp.com>
 <20200116183932.qltqdtreeg4d2zq7@localhost>
 <CADRPPNQm2ZK+trtKCo2Mjr+ga2vKCR4hWMoFXd3AMMxRQZ_4ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADRPPNQm2ZK+trtKCo2Mjr+ga2vKCR4hWMoFXd3AMMxRQZ_4ZA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 01:14:07PM -0600, Li Yang wrote:
> On Thu, Jan 16, 2020 at 12:41 PM Olof Johansson <olof@lixom.net> wrote:
> >
> > Hi,
> >
> > On Thu, Jan 09, 2020 at 04:19:11PM -0600, Li Yang wrote:
> > > Hi soc maintainers,
> > >
> > > Please merge the following new changes for soc/fsl drivers.
> > >
> > > Regards,
> > > Leo
> > >
> > >
> > > The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
> > >
> > >   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.6
> > >
> > > for you to fetch changes up to 6e62bd36e9ad85a22d92b1adce6a0336ea549733:
> > >
> > >   soc: fsl: qe: remove set but not used variable 'mm_gc' (2020-01-08 16:02:48 -0600)
> > >
> > > ----------------------------------------------------------------
> > > NXP/FSL SoC driver updates for v5.6
> > >
> > > QUICC Engine drivers
> > > - Improve the QE drivers to be compatible with ARM/ARM64/PPC64
> > > architectures
> > > - Various cleanups to the QE drivers
> >
> > This branch contains a cross-section of drivers, including those who are
> > normally sent to other maintainers/subsystems. I don't see dependencies that
> > make them a requirement/easier to merge through the SoC tree at this time --
> > for example the ucc_uart driver updates are mostly independent cleanups.
> >
> > Am I missing some aspect here, or should those just be merged through
> > drivers/tty as other driver changes there? At the very least, we expect drivers
> > that aren't merged through the normal path to have acks from those maintainers.
> >
> > Mind following up on that? Thanks!
> 
> Hi Olof,
> 
> Some of the driver cleanups are dependent to core QE changes.  Some
> maybe not but could have contextual dependency with other patches.  I
> will be easier to have them all go in from the same place.  We have
> collected the ack and confirmation from all the related maintainers.
> For the ucc_uart it is not a formal ack.  Quoted the confirmation from
> Greg below:

Ok, getting that in the pull request (tag) would be useful for future cases.

Merging. Thanks!

-Olof
