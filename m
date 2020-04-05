Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6E5C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 07:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546B82072F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 07:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586071946;
	bh=uxJFsqHw4FMXwzJ8lGsDQw5mgJwOHY1JB3yeEsk4k6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ij7pf4d/5Zqzt1RFGktaOwW8V4LmFnP7Es96s+kwGxfk0bbvHMElc/4CMsrUTfAFl
	 3LQtF86WpKBxhUm+TtVo0lPVIyKT7Yy7N58ekx39BjYrnexIJVJo0vw5oROz9HcGx4
	 O8fyBzgDVYRMCIdTG8NhD2XeEawgTI4CATocQKH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgDEHcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 03:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbgDEHcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 03:32:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 440C42072F;
        Sun,  5 Apr 2020 07:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586071939;
        bh=uxJFsqHw4FMXwzJ8lGsDQw5mgJwOHY1JB3yeEsk4k6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DCl1GoRCD/Rx2VQQtXD5hnFB5LQit3vR4Am5qmD4WI9e7YRWFSVKmQksYYa+Kntxo
         9hVdssY+pEF22w+r7QCVRlIRBsFLGPeZyNlkK5jd3K+EC9+dfIQ0pX//VZZKdzWUgP
         Nb0OtnMlkuMe7k4/jTSkyX3oi6V8T8brjcyCCZHo=
Date:   Sun, 5 Apr 2020 09:32:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Taehee Yoo <ap420073@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, rafael@kernel.org,
        j.vosburgh@gmail.com, vfalico@gmail.com,
        Andy Gospodarek <andy@greyhouse.net>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, mitch.a.williams@intel.com
Subject: Re: [PATCH net v2 2/3] net: core: add netdev_class_has_file_ns()
 helper function
Message-ID: <20200405073212.GA1551960@kroah.com>
References: <20200404141909.26399-1-ap420073@gmail.com>
 <20200404155122.GD1476305@kroah.com>
 <CAMArcTVdn7FcfX-BCnZ+LUzdct4yj2BLyhpTu832_VGt_O+xWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMArcTVdn7FcfX-BCnZ+LUzdct4yj2BLyhpTu832_VGt_O+xWA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 05, 2020 at 02:18:22AM +0900, Taehee Yoo wrote:
> On Sun, 5 Apr 2020 at 00:51, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> 
> Hi Greg,
> Thank you for your review!
> 
> > On Sat, Apr 04, 2020 at 02:19:09PM +0000, Taehee Yoo wrote:
> > > This helper function is to check whether the class file "/sys/class/net/*"
> > > is existing or not.
> > > In the next patch, this helper function will be used.
> > >
> > > Reported-by: syzbot+830c6dbfc71edc4f0b8f@syzkaller.appspotmail.com
> > > Fixes: b76cdba9cdb2 ("[PATCH] bonding: add sysfs functionality to bonding (large)")
> > > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > > ---
> > >
> > > v1 -> v2:
> > >  - use class_has_file_ns(), which is introduced by the first patch.
> > >
> > >  include/linux/netdevice.h | 2 +-
> > >  net/core/net-sysfs.c      | 6 ++++++
> > >  2 files changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index 130a668049ab..a04c487c0975 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -4555,7 +4555,7 @@ int netdev_class_create_file_ns(const struct class_attribute *class_attr,
> > >                               const void *ns);
> > >  void netdev_class_remove_file_ns(const struct class_attribute *class_attr,
> > >                                const void *ns);
> > > -
> > > +bool netdev_class_has_file_ns(const char *name, const void *ns);
> > >  static inline int netdev_class_create_file(const struct class_attribute *class_attr)
> > >  {
> > >       return netdev_class_create_file_ns(class_attr, NULL);
> > > diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> > > index cf0215734ceb..8a20d658eff0 100644
> > > --- a/net/core/net-sysfs.c
> > > +++ b/net/core/net-sysfs.c
> > > @@ -1914,6 +1914,12 @@ void netdev_class_remove_file_ns(const struct class_attribute *class_attr,
> > >  }
> > >  EXPORT_SYMBOL(netdev_class_remove_file_ns);
> > >
> > > +bool netdev_class_has_file_ns(const char *name, const void *ns)
> > > +{
> > > +     return class_has_file_ns(&net_class, name, ns);
> > > +}
> > > +EXPORT_SYMBOL(netdev_class_has_file_ns);
> >
> > Again, this feels broken, it can not solve a race condition.
> >
> 
> This function is considered to be used under rtnl mutex and
> I assume that no one could use "/sys/class/net/*" outside of rtnl mutex.
> So, I think it returns the correct information under rtnl mutex.

But you are creating a globally exported function that can be called
from anywhere, and as such, is not useful because it has no locking or
hints of how to use it correctly at all.

Again, don't push this "solution" down to sysfs to solve, you know if
you have a device that is not cleaned up yet, so don't try to
rename/create a device of the same name before that is finished.

thanks,

greg k-h
