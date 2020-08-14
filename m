Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AF5C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B77920771
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597392623;
	bh=GWLrJ17LSi9ENmiXBDDYk6ial/Mnc2VzSOX8AbjhtOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r7nlJ2nyG+5QpW2+1q+QYp/NfQHdjY07xK3Zf2hbfAENbeJoEct/lgZVYXK0zaEvc
	 q1UAYc63oUZW7Jf+0ezeMuj7eNJod+/Tynk08obtd24DMlKnnvO19obwAqtjMRUqZM
	 uxH+GwNtPRBOBl89AOkVxO/zh5vN65RdEUUKgbCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgHNIKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 04:10:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgHNIKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 04:10:20 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E25402068E;
        Fri, 14 Aug 2020 08:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597392620;
        bh=GWLrJ17LSi9ENmiXBDDYk6ial/Mnc2VzSOX8AbjhtOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJOiXMiaHEwjEQelAMQ8G+aZFbOD+7PEpblIEm0NYumPT6Ktndcau+KQBZGAeNJih
         tbyxwZwoyL654jBVI2aseWKhA9a5L/eLFAzf+0G73fWtORjAdt/OhHxM4B90CRmb9d
         zEncbtw3Cnh3segZ3pHafI9UkvdG05tT3xWnuYHs=
Received: by pali.im (Postfix)
        id CAC2DBD5; Fri, 14 Aug 2020 10:10:17 +0200 (CEST)
Date:   Fri, 14 Aug 2020 10:10:17 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>, y.linux@paritcher.com
Subject: Re: [PATCH v4 0/3] platform/x86: dell-wmi: new keys
Message-ID: <20200814081017.tmgun4asdg3nv455@pali>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <cover.1591811549.git.y.linux@paritcher.com>
 <7fb650f568b44eb78e37aa8a534a69d7@AUSX13MPC105.AMER.DELL.COM>
 <CAHp75VdEtHfGavFBaC9Y2=bzX5pAeLqnssBE1owudRv9pKDAXw@mail.gmail.com>
 <20200713072912.ibpojadruifdgnu2@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200713072912.ibpojadruifdgnu2@pali>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 July 2020 09:29:12 Pali Rohár wrote:
> On Thursday 09 July 2020 22:29:42 Andy Shevchenko wrote:
> > On Wed, Jun 10, 2020 at 10:23 PM <Mario.Limonciello@dell.com> wrote:
> > >
> > > > -----Original Message-----
> > > > From: Y Paritcher <y.linux@paritcher.com>
> > > > Sent: Wednesday, June 10, 2020 12:57 PM
> > > > To: Pali Rohár
> > > > Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
> > > > Matthew Garrett; Limonciello, Mario
> > > > Subject: [PATCH v4 0/3] platform/x86: dell-wmi: new keys
> > > >
> > > >
> > > > [EXTERNAL EMAIL]
> > > >
> > > > change since v3:
> > > >     No code changes.
> > > >     Update commit message to reflect info given by Mario at dell.
> > > >
> > > > Is there anything more i have to do for the patches that were reviewed
> > > > or will they be picked up by the maintainers?
> > > > Thanks
> > > >
> > > > Y Paritcher (3):
> > > >   platform/x86: dell-wmi: add new backlight events
> > > >   platform/x86: dell-wmi: add new keymap type 0x0012
> > > >   platform/x86: dell-wmi: add new dmi mapping for keycode 0xffff
> > > >
> > > >  drivers/platform/x86/dell-wmi.c | 28 +++++++++++++++++++++++++---
> > > >  1 file changed, 25 insertions(+), 3 deletions(-)
> > > >
> > > > --
> > > > 2.27.0
> > >
> > > Andy,
> > >
> > > The whole series looks good to me now.  You can put this on the patches
> > > when they're swooped up.
> > >
> > > Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>
> > >
> > > However I would like to note there was a comment that you had a direct question
> > > asked by Pali that probably got lost in the thread.  This was on patch 3/3 on v3.
> > > I think it's worth answering as it could dictate a follow up patch to change behavior.
> > >
> > > The summary of my argument which led to his is nested somewhere in the thread was that
> > > to most users this isn't useful since they can't act on it.  IE they can't use something
> > > like setkeycodes and go on their merry way.  The user who could act on it by coming
> > > to upstream and submitting questions and patches is more technical and having them
> > > use dyndbg to turn on the messages about unknown shouldn't be a big deal.
> > >
> > > > I'm not sure, but I thought that
> > > > throwing warning or info message is the correct solution. Driver cannot
> > > > handle something, so it inform about it, instead of silently dropping
> > > > event. Same behavior I'm seeing in other kernel drivers.
> > >
> > > > But looks like that you and Mario have opposite opinion, that kernel
> > > > should not log unknown events and rather should drop them.
> > >
> > > > I would like to have behavior of dell-wmi same as in other drivers for
> > > > consistency, so the best would be to ask WMI/platform maintainers. They
> > > > could have opinion how to handle these problem globally.
> > >
> > > > ...
> > >
> > > > Darren & Andy, could you please say something to this, what do you think
> > > > about silently dropping events/actions which are currently unknown for
> > > > dell-wmi driver? It is better to log them or not? Currently we are
> > > > logging them.
> > >
> > > Can you please advise which way you would rather have the subsystem go?
> > 
> > Seems Pali is okay with this version, so everything is settled I suppose.
> > I will add it to my queue, thanks!
> 
> Hello Andy! Yes, I'm fine with this patch series, but question how to
> handle these "unknown" events still remains.

Hello Andy! This question for platform-x86 maintainers is still open.
Could you look at it?
