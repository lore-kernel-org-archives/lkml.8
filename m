Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE2BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8138720885
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591014545;
	bh=xSWsBHkDqWQ80T1sU5xrLXTVIUlqUCziDAPCIYxDRvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qdNwVCc51SvfOFvVQzWz6vAoedMWjFeRqaQnmejgm7UiaLb1L55W+mIRvfd+e82ot
	 MXpETequ8n/AQF7Ur+2Ce/4oIKB/M4fezDlRV4qQp9bJ0CCkCAjPE6CzCrxciDx5kh
	 HEtZIarmECC57lPt9fRPRz4OMHTAHqwdiZAVW0hc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgFAM3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgFAM3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:29:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 871202077D;
        Mon,  1 Jun 2020 12:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591014540;
        bh=xSWsBHkDqWQ80T1sU5xrLXTVIUlqUCziDAPCIYxDRvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q60mwGHZYfj6pZuVQzKQS6CzxKfVhPejFWkWENd55kMRGtzASbjhC2y9kg+WjWHRB
         kr47+9ROFNCruoQ7cP23bQKsKdij5AyojfJxscgiMiJA7RDz722wb7XgTmiSghRWn6
         46jGVOIMaPYI5HPVBwbwzL6u/CaYZA/ve7L3Kt5I=
Date:   Mon, 1 Jun 2020 14:28:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     syzbot <syzbot+5f1d24c49c1d2c427497@syzkaller.appspotmail.com>,
        Felipe Balbi <balbi@kernel.org>, ingrassia@epigenesys.com,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in snd_usbmidi_submit_urb/usb_submit_urb
Message-ID: <20200601122858.GA390561@kroah.com>
References: <000000000000bbd09005a6fdc6cc@google.com>
 <000000000000f0261a05a700adf5@google.com>
 <20200601084335.GA1667318@kroah.com>
 <CAAeHK+zKLBX62D1MVAkBe7Q__32-K-4FewsfvF3Z_P8SK=oAHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+zKLBX62D1MVAkBe7Q__32-K-4FewsfvF3Z_P8SK=oAHQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 02:22:40PM +0200, Andrey Konovalov wrote:
> On Mon, Jun 1, 2020 at 10:43 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jun 01, 2020 at 12:24:03AM -0700, syzbot wrote:
> > > syzbot has bisected this bug to:
> > >
> > > commit f2c2e717642c66f7fe7e5dd69b2e8ff5849f4d10
> > > Author: Andrey Konovalov <andreyknvl@google.com>
> > > Date:   Mon Feb 24 16:13:03 2020 +0000
> > >
> > >     usb: gadget: add raw-gadget interface
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=164afcf2100000
> > > start commit:   bdc48fa1 checkpatch/coding-style: deprecate 80-column warn..
> > > git tree:       upstream
> > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=154afcf2100000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=114afcf2100000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=129ea1e5950835e5
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=5f1d24c49c1d2c427497
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d70cf2100000
> > >
> > > Reported-by: syzbot+5f1d24c49c1d2c427497@syzkaller.appspotmail.com
> > > Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
> > >
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> >
> > So the tool that was used to create the bug has bisected the problem to
> > the patch that adds the tool to the kernel to test for the issue?
> >
> > This feels wrong...
> 
> That's the expected result of bisection with the way it's intended to
> work. We'll be getting more bisection results pointing to that commit
> for old USB bugs. For new ones (that are introduced after raw-gadget),
> the bisection should point to proper commits.

Ok, can you then mute any bisection emails that are about to get sent
out that resolve to this commit to save us the effort of just ignoring
the thing on our end?

thanks,

greg k-h
