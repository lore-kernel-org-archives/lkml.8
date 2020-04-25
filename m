Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93E3C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 18:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0306206D4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 18:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgDYSMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 14:12:44 -0400
Received: from netrider.rowland.org ([192.131.102.5]:50711 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726061AbgDYSMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 14:12:44 -0400
Received: (qmail 29597 invoked by uid 500); 25 Apr 2020 14:12:42 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Apr 2020 14:12:42 -0400
Date:   Sat, 25 Apr 2020 14:12:42 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Oliver Neukum <oneukum@suse.com>
cc:     Pete Zaitcev <zaitcev@redhat.com>, Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+be5b5f86a162a6c281e6@syzkaller.appspotmail.com>,
        <andreyknvl@google.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in usblp_bulk_read
In-Reply-To: <1587835881.19130.3.camel@suse.com>
Message-ID: <Pine.LNX.4.44L0.2004251410050.29378-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020, Oliver Neukum wrote:

> Am Donnerstag, den 23.04.2020, 12:29 -0400 schrieb Alan Stern:
> > On Thu, 23 Apr 2020, Oliver Neukum wrote:
> 
> > The only suspicious thing I see is that usblp_resume() calls 
> > handle_bidir() without first acquiring any mutex.  But resume shouldn't 
> > race with disconnect.
> 
> Right.
> 
> > The only other place where read URBs get submitted is under
> > usblp_read(), which does acquire the mutex
> 
> Right.
> 
> >  and checks for disconnection
> > while holding it.
> 
> Where? It should, but I do not see where it does so.

usblp_read() calls usblp_rwait_and_lock(), which calls usblp_rtest(), 
which returns -ENODEV if usblp->present is clear.

Alan Stern

