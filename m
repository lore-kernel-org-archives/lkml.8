Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A962CC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 879D62073A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgEFOIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 10:08:50 -0400
Received: from netrider.rowland.org ([192.131.102.5]:35679 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725915AbgEFOIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:08:50 -0400
Received: (qmail 14706 invoked by uid 500); 6 May 2020 10:08:49 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 May 2020 10:08:49 -0400
Date:   Wed, 6 May 2020 10:08:49 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Oliver Neukum <oneukum@suse.com>
cc:     syzbot <syzbot+be5b5f86a162a6c281e6@syzkaller.appspotmail.com>,
        <andreyknvl@google.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>, <zaitcev@redhat.com>
Subject: Re: KASAN: use-after-free Read in usblp_bulk_read
In-Reply-To: <1588756482.13662.20.camel@suse.com>
Message-ID: <Pine.LNX.4.44L0.2005061008030.13334-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020, Oliver Neukum wrote:

> Am Donnerstag, den 30.04.2020, 11:11 -0400 schrieb Alan Stern:
> 
> > KASAN is documented.  The difficulty is that this race is obviously 
> > hard to trigger, and without the ability to reproduce it we can't run 
> > diagnostics to find the underlying cause.
> > 
> > We can't even ask syzbot to try running tests for us; without a valid 
> > reproducer it won't agree to rerun the original test program.
> 
> 
> Very well. We are not going to find it without exceptional luck. Yet
> there may be a real issue, too. We simply do not know. How about the
> attached patch?

It's okay with me (apart from the typo in the patch description: "UB").

Alan Stern

