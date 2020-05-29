Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BC9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6115520721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgE2Msz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:48:55 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:42116 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgE2Msz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:48:55 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6BCBB1C0389; Fri, 29 May 2020 14:48:53 +0200 (CEST)
Date:   Fri, 29 May 2020 14:48:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mausb-host-devel@displaylink.com
Subject: Re: [External] Re: [PATCH v5 0/8] Add MA USB Host driver
Message-ID: <20200529124843.GA1339@bug>
References: <20200327152614.26833-1-vladimir.stankovic@displaylink.com>
 <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
 <20200428110459.GB1145239@kroah.com>
 <b14a2f71-3931-8d32-43a1-cbf52add48bb@displaylink.com>
 <20200430200238.GB3843398@kroah.com>
 <f0a4432e-d14a-0108-7d6e-edb648b6393f@displaylink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0a4432e-d14a-0108-7d6e-edb648b6393f@displaylink.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>> MA USB protocol used by MA USB Host driver has been implemented in
> >>>> accordance with MA USB Specification Release 1.0b.
> >>>
> >>> Is that a USB-released spec?
> >> Correct, document is being maintained by USB IF and is publicly available.
> >> However, I just noticed a typo, correct version is 1.0a. Will correct.
> >>
> >> In short, MA USB Specification defines an MA USB protocol that performs USB
> >> communication via any communication medium. As such, it defines how to pack
> >> USB data within MA USB payload, and how to communicate with remote MA USB device.

Ok

> >> Userspace code is not publicly available. However, in short, it's purpose is
> >> twofold, to provide interface to application layer, and to prepare MA USB packets
> >> that will be used by remote device.
> > 
> > So you want us to take a one-off char-driver kernel code for a closed
> > source userspace application for a public spec?  That feels really
> > really odd, if not actually against a few licenses.  I hate to ask it,
> > but are your lawyers ok with this?

More importantly... does that work?

Userland is okay for communication setup, but if userspace is involved with every packet
being sent... It will deadlock.

One example: attach mass storage device over MUSB, put swap there; what happens if your
userland helper is now swapped out?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
