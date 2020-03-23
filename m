Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC345C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9023B20409
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgCWQSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:18:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:58066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbgCWQSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:18:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 650F2ABC7;
        Mon, 23 Mar 2020 16:18:12 +0000 (UTC)
Message-ID: <1584980280.27949.20.camel@suse.de>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
From:   Oliver Neukum <oneukum@suse.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 23 Mar 2020 17:18:00 +0100
In-Reply-To: <Pine.LNX.4.44L0.2003231151390.24254-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.2003231151390.24254-100000@netrider.rowland.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 23.03.2020, 11:54 -0400 schrieb Alan Stern:
> On Mon, 23 Mar 2020, Oliver Neukum wrote:
> 
> > Am Montag, den 23.03.2020, 14:38 +0000 schrieb Qais Yousef:
> > > Hi
> > > 
> > > I've hit the following lockdep warning when I trigger hibernate on arm64
> > > platform (Juno-r2)
> > > 
> > > 
> > > 	echo suspend > /sys/power/disk
> > > 	echo disk > /sys/power/state
> > > 
> > > I only had a usb flash drive attached to it. Let me know if you need more info.
> > 
> > Hi,
> > 
> > that is not a lockdep issue, but the hub driver is not properly killing
> > its URB presumably. Yet, the driver looks correct to me. Please use
> > the additional patch and activate dynamic debugging for usbcore.
> 
> Was the USB flash drive being used as a swap device for holding the 
> hibernation image?  That's not likely to work very well.  At least, I 
> doubt that it has been tested very much.

Right, but this is good. We are getting a test for something that needs
work. It does not really matetr why STD fails.

> This diagnostic was suggested by the runtime PM error that occurred 
> when the system was trying to store the hibernation image.  That's 
> probably when the hub driver's URB got restarted.

AFAICT hub_quiesce() unconditionally calls usb_kill_urb(). So I'd like
to verify that case is really triggered.

	Regards
		Oliver

