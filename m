Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD44C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B34C20DD4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgE0Huv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 03:50:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:26882 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729052AbgE0Huv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:50:51 -0400
IronPort-SDR: 3uy32QUucIHLtGejPXkWZ2q42sGwXz4/iyqLcTjkldXoPubihR64PypBXWT04JUVmmyBsZ5hbE
 K4tKLhHeZazw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 00:50:51 -0700
IronPort-SDR: E5Y9xuRKb8X3ShZJyxnR79KZTMbPXDDgAk31HobFS6tuXpzAr+bXwb6LE//aLgtkLHr7T5KU0Q
 Vofb0TRSZe8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,440,1583222400"; 
   d="scan'208";a="375952418"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 27 May 2020 00:50:48 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 27 May 2020 10:50:48 +0300
Date:   Wed, 27 May 2020 10:50:48 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] kobject: send KOBJ_REMOVE uevent when the object is
 removed from sysfs
Message-ID: <20200527075048.GD3284396@kuha.fi.intel.com>
References: <20200524153041.2361-1-gregkh@linuxfoundation.org>
 <20200524153041.2361-2-gregkh@linuxfoundation.org>
 <CAKdAkRShA2sAMH12H_zpCm=9XJn_yEcnAaaZhLgvhaUMxC-EMw@mail.gmail.com>
 <20200526055806.GA2576013@kroah.com>
 <CAJZ5v0ii+hMh5DCuYuuO9auFHD0GLxmOVR1FoDmCwrNEnh9gMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ii+hMh5DCuYuuO9auFHD0GLxmOVR1FoDmCwrNEnh9gMw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 10:26:23AM +0200, Rafael J. Wysocki wrote:
> On Tue, May 26, 2020 at 7:58 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, May 25, 2020 at 03:49:01PM -0700, Dmitry Torokhov wrote:
> > > On Sun, May 24, 2020 at 8:34 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > It is possible for a KOBJ_REMOVE uevent to be sent to userspace way
> > > > after the files are actually gone from sysfs, due to how reference
> > > > counting for kobjects work.  This should not be a problem, but it would
> > > > be good to properly send the information when things are going away, not
> > > > at some later point in time in the future.
> > > >
> > > > Before this move, if a kobject's parent was torn down before the child,
> > >
> > > ^^^^ And this is the root of the problem and what has to be fixed.
> >
> > I fixed that in patch one of this series.  Turns out the user of the
> > kobject was not even expecting that to happen.
> >
> > > > when the call to kobject_uevent() happened, the parent walk to try to
> > > > reconstruct the full path of the kobject could be a total mess and cause
> > > > crashes.  It's not good to try to tear down a kobject tree from top
> > > > down, but let's at least try to not to crash if a user does so.
> > >
> > > One can try, but if we keep proper reference counting then kobject
> > > core should take care of actually releasing objects in the right
> > > order. I do not think you should keep this patch, and instead see if
> > > we can push call to kobject_put(kobj->parent) into kobject_cleanup().
> >
> > I tried that, but there was a _lot_ of underflow errors reported, so
> > there's something else happening.  Or my attempt was incorrect :)
> 
> So it looks like there is something in there that's been overlooked so far.
> 
> I'll try to look at the Guenter's traces and figure out what went
> wrong after the Heikki's patch.

At least one problem with that patch was that I was releasing the
parent reference unconditionally.

thanks,

-- 
heikki
