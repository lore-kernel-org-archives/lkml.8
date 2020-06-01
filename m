Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A26C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AFCB2077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GEqCpbt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgFAMWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgFAMWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:22:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C1FC03E97C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 05:22:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q24so5032201pjd.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 05:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5WblPyCQMgiUPSfQdaJDJi/2Nnr45CAxqcOyPOJ5sw=;
        b=GEqCpbt2JdwVvrCF269QlWpY8lPvZ5UB/fgAOV+R017RjNo8RdKmxZ/TQx7Iz4d/LE
         Ys+C3lVDLeDdQqWaQhZnglU6fW2+Znx0apCj7+XG5xGDnUZ8Vz2z8kCVaiM6ccpl8F6X
         x1d0EwUV9lK9FIV5gaTHppKeLE++Rq5lwS1lfLh9KeZHjO6IiM1e4GoLWFLUGTXZ6pia
         ishs8w0vT8amCJ7Qv9RRkL5XMEeDN3Jufqf4xM5Xa0zk1FPGqgqY0djs2dKdBhujJBWR
         V2alOmQD9Q57SxhVBO9C7mHSOW8LNcnWZcVX3CXNbqmXWWUoAbxmaUXyNPPlx/0Fy+xu
         Vchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5WblPyCQMgiUPSfQdaJDJi/2Nnr45CAxqcOyPOJ5sw=;
        b=LrEXYKyEoLxT5bYAtG+L0psImyAIx7UEhMKna03vp93hMDBsWSDjaio+BAq+uX8BSk
         EeCZFQpW1oAVIDXCfjzSb0YF+BapNHBcMR/Nhx8TzrcHsWWrqeFRRlYMtKvjk9/sz93f
         /TPbCA0+aPUD8OeO+iKZ96ir23uGElw1MWsEqgWh2/3y5F7MAv5Wcbn/G4ESDkmE6rVA
         aQDunkq29oBlDbrVelL564x6PTXbjQdK0Uz5APzFl9gKZEWCRotm2mRvItdPTr+edy54
         CPIKeEDy5i+2fZ/jyLCjqIqpf+ayYZAVzPQsQ0WjjOzfaSsOPYdEZ7PoFLmPLNE9khQG
         YU1Q==
X-Gm-Message-State: AOAM532ZbrqQOpQIjKKp0UvXMbHJQ5eCxYU6iLGvQj83aAEz8G+E6PLU
        Wu0OaIHUjDW2KtqpAOKg0+IEpNeeb9fBObsBcGLi2A==
X-Google-Smtp-Source: ABdhPJx+/5rbMpGCygYe3CCdV+5hlw8qvYoOLgCqPy9eqo5gQ0j42yoxY6rcIDprN65ahcgQQuqStDsfZ7FcE8PDIOs=
X-Received: by 2002:a17:902:7b89:: with SMTP id w9mr18402765pll.252.1591014171041;
 Mon, 01 Jun 2020 05:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bbd09005a6fdc6cc@google.com> <000000000000f0261a05a700adf5@google.com>
 <20200601084335.GA1667318@kroah.com>
In-Reply-To: <20200601084335.GA1667318@kroah.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 1 Jun 2020 14:22:40 +0200
Message-ID: <CAAeHK+zKLBX62D1MVAkBe7Q__32-K-4FewsfvF3Z_P8SK=oAHQ@mail.gmail.com>
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

On Mon, Jun 1, 2020 at 10:43 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 01, 2020 at 12:24:03AM -0700, syzbot wrote:
> > syzbot has bisected this bug to:
> >
> > commit f2c2e717642c66f7fe7e5dd69b2e8ff5849f4d10
> > Author: Andrey Konovalov <andreyknvl@google.com>
> > Date:   Mon Feb 24 16:13:03 2020 +0000
> >
> >     usb: gadget: add raw-gadget interface
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=164afcf2100000
> > start commit:   bdc48fa1 checkpatch/coding-style: deprecate 80-column warn..
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=154afcf2100000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=114afcf2100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=129ea1e5950835e5
> > dashboard link: https://syzkaller.appspot.com/bug?extid=5f1d24c49c1d2c427497
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d70cf2100000
> >
> > Reported-by: syzbot+5f1d24c49c1d2c427497@syzkaller.appspotmail.com
> > Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> So the tool that was used to create the bug has bisected the problem to
> the patch that adds the tool to the kernel to test for the issue?
>
> This feels wrong...

That's the expected result of bisection with the way it's intended to
work. We'll be getting more bisection results pointing to that commit
for old USB bugs. For new ones (that are introduced after raw-gadget),
the bisection should point to proper commits.
