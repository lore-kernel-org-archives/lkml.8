Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62432C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35A23206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rTwbccbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFBRTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgFBRTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:19:40 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06DAC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 10:19:39 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i12so1678561pju.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 10:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+P/PZHOqotTe6Y+Kk1mMk5Kf+3c1pzP9mwcgdU+JGoA=;
        b=rTwbccbhNr+Z95ISuuwgkCHDYvEkNQT4Vd9UuTaWTq1lb/O97ewiBNMXcw+qi03VN0
         Ea8Qh0ZMlLG/xcUkP5pWfsuV6r3JYy83n0OFcchFs9Tg13KqNB/BG73v96741/uSKq1v
         CliV0gMnWhTCaYQze6RO91VEpMlQoDCcmNy7pBdSmXrIRHk9Sg1uTjuUFokmCys5IPCC
         /xKDF0u6MbT/D7vb9RVzD7/OxOsRGgA9TsikxTKbFmaERb+Z9f+mY/XrzgX8gVyLQgfW
         5nWh/E3reTBZa6zU+lKLlzfQByFSvBbuTikUS4QmcV3u2pTRuWJ8VYqN6QzC0t/FZOrb
         CNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+P/PZHOqotTe6Y+Kk1mMk5Kf+3c1pzP9mwcgdU+JGoA=;
        b=aw4ijHC1NI/w1C9pqzVCmBMnG/MnJ9IRvWmnoVht6f6u1H1ZuyQZFjL75sYcFaBHNW
         sednXtAJpcJ09W0AluSqnI4T+lRR0LamsFCiE5+w0uqENkAItNTZjC+N5eP2bGBc+0ms
         LJlYOQEHklxhQfDMJ2sNsKW61IeLBrMVzdPE0z/oHesdR8ZDf8s/P2Ey7npFyt9BCJiT
         bu80hiH1cwU3Kp+9gUHLcadgJECw87A1NZDzppNsmWpiQ5IF7aRueJ1TPhGIc5njrmmR
         3ZAZgl6VwIhTOpBhh5A5gQLXfottKHb43TndspJzVPxSW2cfy4LuytxunFtr9xoIP8JN
         Dx4Q==
X-Gm-Message-State: AOAM533+aZ864AJ7SvJzbXsZL/ZPtHezc8VMW/W6AN63R4sUfijhZkuT
        504RyUl0nMAFe9KpoOC2RJ8EeLcIFaVQGw2KMVWl9A==
X-Google-Smtp-Source: ABdhPJyXPIEMsTydqDl9Mujnk4v6UrX7J4Bb9q6ute3YXJmT68apMdBdxTMVpEgt6LwOSYk58JeerQpLjX47mcTjvBw=
X-Received: by 2002:a17:902:c686:: with SMTP id r6mr27042256plx.147.1591118378852;
 Tue, 02 Jun 2020 10:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bbd09005a6fdc6cc@google.com> <000000000000f0261a05a700adf5@google.com>
 <20200601084335.GA1667318@kroah.com> <CAAeHK+zKLBX62D1MVAkBe7Q__32-K-4FewsfvF3Z_P8SK=oAHQ@mail.gmail.com>
 <20200601122858.GA390561@kroah.com>
In-Reply-To: <20200601122858.GA390561@kroah.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 2 Jun 2020 19:19:27 +0200
Message-ID: <CAAeHK+zcGGZxkpwW050wrOUN_ksVxDJk5hfF1Vt8xZYBKqHMzQ@mail.gmail.com>
Subject: Re: WARNING in snd_usbmidi_submit_urb/usb_submit_urb
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     syzbot <syzbot+5f1d24c49c1d2c427497@syzkaller.appspotmail.com>,
        Felipe Balbi <balbi@kernel.org>, ingrassia@epigenesys.com,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 2:29 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 01, 2020 at 02:22:40PM +0200, Andrey Konovalov wrote:
> > On Mon, Jun 1, 2020 at 10:43 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Jun 01, 2020 at 12:24:03AM -0700, syzbot wrote:
> > > > syzbot has bisected this bug to:
> > > >
> > > > commit f2c2e717642c66f7fe7e5dd69b2e8ff5849f4d10
> > > > Author: Andrey Konovalov <andreyknvl@google.com>
> > > > Date:   Mon Feb 24 16:13:03 2020 +0000
> > > >
> > > >     usb: gadget: add raw-gadget interface
> > > >
> > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=164afcf2100000
> > > > start commit:   bdc48fa1 checkpatch/coding-style: deprecate 80-column warn..
> > > > git tree:       upstream
> > > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=154afcf2100000
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=114afcf2100000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=129ea1e5950835e5
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=5f1d24c49c1d2c427497
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d70cf2100000
> > > >
> > > > Reported-by: syzbot+5f1d24c49c1d2c427497@syzkaller.appspotmail.com
> > > > Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
> > > >
> > > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > >
> > > So the tool that was used to create the bug has bisected the problem to
> > > the patch that adds the tool to the kernel to test for the issue?
> > >
> > > This feels wrong...
> >
> > That's the expected result of bisection with the way it's intended to
> > work. We'll be getting more bisection results pointing to that commit
> > for old USB bugs. For new ones (that are introduced after raw-gadget),
> > the bisection should point to proper commits.
>
> Ok, can you then mute any bisection emails that are about to get sent
> out that resolve to this commit to save us the effort of just ignoring
> the thing on our end?

Sent syzbot change: https://github.com/google/syzkaller/pull/1782
