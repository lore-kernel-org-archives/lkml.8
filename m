Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40A7C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2744206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gx00LFe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgAJQqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:46:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37148 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbgAJQqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:46:18 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so1401358pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 08:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Uld6qOjyUjE2LTXOlgxIe9R0z9puILcSA94rP9mPRA=;
        b=gx00LFe3OFs7maYoP84n7LVW0q+yrcDlKbPCAx38cjU06EL2pZ6no5yntzGpToms6K
         qcInPPtKurkfkYnbWLA2XArjm+0vzmU8C9E9oZNYJlRkgTL6PVKG7XoIPdFADK+bTHtF
         QNzH22kV89dRp0wCPc+Ckwj+9KqZK/TuolqHhQHLgKrDwhMqSa+Rd0RVYys5ie+aDTGy
         ig9voZZ7tATFJoOaTBkqYBXpNbxepzE+jAoFD5nefNLzAIfBggUnRBGFohh1M2Ggsc5U
         UUIuesgxDVK7yL4RJsIJWii+1qjJ7fOd+4HlM8mkEiVSXv7Uy3PsF+43idlKUjHhSsUL
         EfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Uld6qOjyUjE2LTXOlgxIe9R0z9puILcSA94rP9mPRA=;
        b=ljZKj0Y/F3e7DPIp/kSe0rTGp/3jypzdO/vJKKxxMNsVkJpsmoA9ich6fROawT/9zQ
         fz3QOR5cns9OkU+gGrud5XiCRDTF1gT/xdNl9GgfYIMDsHJMIbpVCGm6cn1NaFKGHyj4
         gCAt9khbdekN/7iMPHGcVQAokY3ynvUJ5wcL8tc5Gpe7scwMMfNMWhUpDkIxAHI7JmDc
         7I2F4488qSDOio4aGaVFu4+lhhnLMWgQPIRwqZG/dzRjvb30H/IvVQY6QP2uG2FJFo4O
         7ePLDAGNlr8XtZJo8EV9oOdskKJQbBAzPFw4P9PUhjpfRjUOiRvUwka3GDZSUjBQsTDz
         jJDg==
X-Gm-Message-State: APjAAAVWgd85dtZzbMjP9jyGFwkwBsvjJhijYQusGwKIHW2eB+fnwfQ3
        KNKS04mKqR+1SX19JgugOs3du+rV6WOGZuMoS4ZVFg==
X-Google-Smtp-Source: APXvYqzaKaewj7VEqnvZxX6GtAGknaUrdNmjcSy1AfuFyOIs1iRmq/K9VnWovCJRW0kaLrH9b+ZZwlSzPgHQwU73OHg=
X-Received: by 2002:a63:358a:: with SMTP id c132mr5568414pga.286.1578674777669;
 Fri, 10 Jan 2020 08:46:17 -0800 (PST)
MIME-Version: 1.0
References: <0000000000001b53f8059ba5431a@google.com> <Pine.LNX.4.44L0.2001091142281.1307-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.2001091142281.1307-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 10 Jan 2020 17:46:06 +0100
Message-ID: <CAAeHK+x5psxWYNvgfxBiLoQt-o3n+-t_ZhLxueRJ8bHsv=Pmbg@mail.gmail.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (2)
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+10e5f68920f13587ab12@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        ingrassia@epigenesys.com, LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 5:46 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, 8 Jan 2020, syzbot wrote:
>
> > Hello,
> >
> > syzbot has tested the proposed patch and the reproducer did not trigger
> > crash:
> >
> > Reported-and-tested-by:
> > syzbot+10e5f68920f13587ab12@syzkaller.appspotmail.com
> >
> > Tested on:
> >
> > commit:         ecdf2214 usb: gadget: add raw-gadget interface
> > git tree:       https://github.com/google/kasan.git
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b06a019075333661
> > dashboard link: https://syzkaller.appspot.com/bug?extid=10e5f68920f13587ab12
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > patch:          https://syzkaller.appspot.com/x/patch.diff?x=1583963ee00000
> >
> > Note: testing is done by a robot and is best-effort only.
>
> I'm at a loss for a way to track this down any farther.  The difference
> between this patch and the previous was very small and almost entirely
> confined to actions that take place _after_ the bug condition has been
> detected.
>
> If this is indeed caused by a race, it would be nice to know that the
> two racing threads are doing.  One of them we can see in the log output
> (it's calling usb_control_msg) but the other is a mystery.

I've tried to reproduce this manually, but failed :( I don't think
there's anything else we can do with this. Let's close this bug,
there's a chance syzbot comes up with a better reproducer.

#syz invalid
