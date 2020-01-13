Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1076C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAF6207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgAMRul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:50:41 -0500
Received: from muru.com ([72.249.23.125]:50750 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgAMRuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 12:50:40 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B3D868047;
        Mon, 13 Jan 2020 17:51:21 +0000 (UTC)
Date:   Mon, 13 Jan 2020 09:50:36 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Robert Nelson <robertcnelson@gmail.com>
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OMAP DEVICE TREE SUPPORT" <linux-omap@vger.kernel.org>,
        "open list:OMAP DEVICE TREE SUPPORT" <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: dts: am335x-boneblack-common: fix memory size
Message-ID: <20200113175036.GL5885@atomide.com>
References: <20200106130909.7697-1-matwey@sai.msu.ru>
 <CAOCHtYgyN+qXXX1YeEcO+nvRFrAL1HAVVMvjfeJ5nvxVjtFKtg@mail.gmail.com>
 <CAJs94EbUL6o9sM+pwxwpqHVDkFqy7wFRirET-Vq3SNVd3grUsA@mail.gmail.com>
 <20200106210509.GF5885@atomide.com>
 <CAOCHtYhKUyUwunnWDT1CuRTpzS78d7xKq3qB3Phys7RgUZnM3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOCHtYhKUyUwunnWDT1CuRTpzS78d7xKq3qB3Phys7RgUZnM3w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Robert Nelson <robertcnelson@gmail.com> [200107 18:33]:
> On Mon, Jan 6, 2020 at 3:05 PM Tony Lindgren <tony@atomide.com> wrote:
> >
> > * Matwey V. Kornilov <matwey@sai.msu.ru> [200106 20:48]:
> > > пн, 6 янв. 2020 г. в 23:44, Robert Nelson <robertcnelson@gmail.com>:
> > > >
> > > > On Mon, Jan 6, 2020 at 7:10 AM Matwey V. Kornilov <matwey@sai.msu.ru> wrote:
> > > > >
> > > > > BeagleBone Black series is equipped with 512MB RAM
> > > > > whereas only 256MB is included from am335x-bone-common.dtsi
> > > >
> > > > FYI: While all versions from the factory are 512MB, some 3rd parties
> > > > offered 1GB reballing upgrades..
> >
> > So what's the conclusion, is it safe to bump the default size to
> > 512MB then?
> >
> > The custom ones could use their own dts file if bootloader is not
> > setting the RAM.
> 
> Yeah this is safe for factory devices. Classic u-boot will update
> these for modified boards.

OK applying into fixes thanks.

Tony
