Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD554C35280
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 06:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B76208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 06:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589093305;
	bh=Jt2ZmI4jxEXSvlstEfwyzyeZhTT/glbADv+7sZp1TwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ieoice44IKKY8KuJ0PAM8fz0/YR3pQxuhXUHM/eNRur8Srej1sEFVRAkGAUgcp7Sx
	 SGcw0oORuFYBcBp1fUg/uassQELl0OLyVQNpeMngzYZ+k7Y5IwuXuFmxqQatlAs0N6
	 s/2PvDSx7+ol0qkT1pvaBgK+Y4U6wPTxtiUXHlZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgEJGsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 02:48:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgEJGsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 02:48:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF9B120746;
        Sun, 10 May 2020 06:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589093303;
        bh=Jt2ZmI4jxEXSvlstEfwyzyeZhTT/glbADv+7sZp1TwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RxXU+/m2DIjg87amFaxqurQLKs8quLyPScABwqfg6oUVQYOgHAk22GwA8BT4I/ZOg
         vo0hj6YZunBgBahCuG69MHoD4rN8o9pa80PXNORzq+RacX1jBiDvZEbEBVs5N6nWCn
         /tH+qpAMgsDVE0olYy6weZqNYg1ccGSbjgU9K6nQ=
Date:   Sun, 10 May 2020 08:48:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rananta@codeaurora.org
Cc:     jslaby@suse.com, andrew@daynix.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: hvc: Fix data abort due to race in hvc_open
Message-ID: <20200510064819.GB3400311@kroah.com>
References: <20200428032601.22127-1-rananta@codeaurora.org>
 <20200506094851.GA2787548@kroah.com>
 <98bbe7afabf48d8e8fe839fdc9e836a5@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98bbe7afabf48d8e8fe839fdc9e836a5@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 06:30:56PM -0700, rananta@codeaurora.org wrote:
> On 2020-05-06 02:48, Greg KH wrote:
> > On Mon, Apr 27, 2020 at 08:26:01PM -0700, Raghavendra Rao Ananta wrote:
> > > Potentially, hvc_open() can be called in parallel when two tasks calls
> > > open() on /dev/hvcX. In such a scenario, if the
> > > hp->ops->notifier_add()
> > > callback in the function fails, where it sets the tty->driver_data to
> > > NULL, the parallel hvc_open() can see this NULL and cause a memory
> > > abort.
> > > Hence, serialize hvc_open and check if tty->private_data is NULL
> > > before
> > > proceeding ahead.
> > > 
> > > The issue can be easily reproduced by launching two tasks
> > > simultaneously
> > > that does nothing but open() and close() on /dev/hvcX.
> > > For example:
> > > $ ./simple_open_close /dev/hvc0 & ./simple_open_close /dev/hvc0 &
> > > 
> > > Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
> > > ---
> > >  drivers/tty/hvc/hvc_console.c | 16 ++++++++++++++--
> > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/tty/hvc/hvc_console.c
> > > b/drivers/tty/hvc/hvc_console.c
> > > index 436cc51c92c3..ebe26fe5ac09 100644
> > > --- a/drivers/tty/hvc/hvc_console.c
> > > +++ b/drivers/tty/hvc/hvc_console.c
> > > @@ -75,6 +75,8 @@ static LIST_HEAD(hvc_structs);
> > >   */
> > >  static DEFINE_MUTEX(hvc_structs_mutex);
> > > 
> > > +/* Mutex to serialize hvc_open */
> > > +static DEFINE_MUTEX(hvc_open_mutex);
> > >  /*
> > >   * This value is used to assign a tty->index value to a hvc_struct
> > > based
> > >   * upon order of exposure via hvc_probe(), when we can not match it
> > > to
> > > @@ -346,16 +348,24 @@ static int hvc_install(struct tty_driver
> > > *driver, struct tty_struct *tty)
> > >   */
> > >  static int hvc_open(struct tty_struct *tty, struct file * filp)
> > >  {
> > > -	struct hvc_struct *hp = tty->driver_data;
> > > +	struct hvc_struct *hp;
> > >  	unsigned long flags;
> > >  	int rc = 0;
> > > 
> > > +	mutex_lock(&hvc_open_mutex);
> > > +
> > > +	hp = tty->driver_data;
> > > +	if (!hp) {
> > > +		rc = -EIO;
> > > +		goto out;
> > > +	}
> > > +
> > >  	spin_lock_irqsave(&hp->port.lock, flags);
> > >  	/* Check and then increment for fast path open. */
> > >  	if (hp->port.count++ > 0) {
> > >  		spin_unlock_irqrestore(&hp->port.lock, flags);
> > >  		hvc_kick();
> > > -		return 0;
> > > +		goto out;
> > >  	} /* else count == 0 */
> > >  	spin_unlock_irqrestore(&hp->port.lock, flags);
> > 
> > Wait, why isn't this driver just calling tty_port_open() instead of
> > trying to open-code all of this?
> > 
> > Keeping a single mutext for open will not protect it from close, it will
> > just slow things down a bit.  There should already be a tty lock held by
> > the tty core for open() to keep it from racing things, right?
> The tty lock should have been held, but not likely across ->install() and
> ->open() callbacks, thus resulting in a race between hvc_install() and
> hvc_open(),

How?  The tty lock is held in install, and should not conflict with
open(), otherwise we would be seeing this happen in all tty drivers,
right?

> where hvc_install() sets a data and the hvc_open() clears it. hvc_open()
> doesn't
> check if the data was set to NULL and proceeds.

What data is being set that hvc_open is checking?

And you are not grabbing a lock in your install callback, you are only
serializing your open call here, I don't see how this is fixing anything
other than perhaps slowing down your codepaths.

As an arument why this isn't correct, can you answer why this same type
of change wouldn't be required for all tty drivers in the tree?

thanks,

greg k-h
