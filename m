Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD95C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABBE82080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OjNoGqET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbgFSHfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbgFSHfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:35:43 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B204CC0613EE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 00:35:42 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id di13so4004016qvb.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 00:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/QVsIo7vdI5nrnidTNBTw9fDsdx+LmCSq0aA9pEJ+Hw=;
        b=OjNoGqEThpZ14D6dW65mu1r/3BbDoLfceJW3AhJNJkGniqtrx4SHa191/YoBO3zzv3
         Yit54iY7uh8j5Fz32NYvZmHZ7oP36BSn8Qmo83+Bmbq73MaobK2V4E6szrvMIzT1+b2e
         cF5hfy/epr8ZTjb7JYoMJsmvMwFvtrhSyJLOpFGjdlVpIMPoyHY6gAQ5G7UcXQ+XuOkQ
         AS+mRaX2d2RNkziLIeK4+dJ2lho6xZKfoYLWspVHNywPjeJLzgALaDDQAk73RGSLrwGM
         Y0GJbNxJ83v5qGNeRRLq8D2312g+U+pYuFTZJL4rhoKoUcNpOzTpuInqxM7VryoLfvKk
         algg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/QVsIo7vdI5nrnidTNBTw9fDsdx+LmCSq0aA9pEJ+Hw=;
        b=Y2KKWRO7u6xZALbxiPD4xWhDldbAnAmEOz7SFDd5isT80C0ihu9eWiup7pXwrPHPZT
         AQ7X7g7aWG/pWcQ8mV7MLHsI391ZMFXpBRAWnkcFkbXksH5vUT1gzs6nWtk8v/JglAvZ
         iJXXkbLIOuq2UMRyGrmcOBY1RwK5MRrebCa7bwzGMEkYK5glo4VOpUU3QLORiF7y+9w3
         dTpq+ENWEuxbRK8idoqMafYGc4rRyuiNukPgFot1NGuLYn6uF1HL3GPc5yyO1nMGsCJy
         niCb+danoCmnlyUNU6FBIEI0rc6iizKdx0sY7VINckHyoEwjEz1k0vPPyF9SiRxQPkM3
         3xzQ==
X-Gm-Message-State: AOAM533I66YEp8NNIr6SKyVUZM/M7Jhi+zJplx2t1HOjSb+KL/3A8Iiy
        tGbmqBFlZh+J8CqneO3U/0bAzcv2As4ptnU/jGbz1A==
X-Google-Smtp-Source: ABdhPJyoRnMo+OvlO+KW1lDs//Lq6KD/mmkJQFVdqrH9wLhknIfgxoNtMdnIv3TZeR87OMxQCbFC3hcRdZfJHiHv3xk=
X-Received: by 2002:a05:6214:1342:: with SMTP id b2mr7654724qvw.80.1592552141501;
 Fri, 19 Jun 2020 00:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000004a76305a8624d22@google.com> <20200619070527.GA544353@kroah.com>
In-Reply-To: <20200619070527.GA544353@kroah.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 19 Jun 2020 09:35:30 +0200
Message-ID: <CACT4Y+YEYT17HH=vh9XtRi7uRiY=db6u-L0dRYs7msF1jNX5Xw@mail.gmail.com>
Subject: Re: INFO: trying to register non-static key in is_dynamic_key
To:     Greg KH <greg@kroah.com>, syzkaller <syzkaller@googlegroups.com>
Cc:     syzbot <syzbot+42bc0d31b9a21faebdf8@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Borislav Petkov <bp@alien8.de>, devel@etsukata.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 9:07 AM Greg KH <greg@kroah.com> wrote:
>
> On Thu, Jun 18, 2020 at 02:17:15PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    b791d1bd Merge tag 'locking-kcsan-2020-06-11' of git://git..
> > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13f305a9100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=16c2467d4b6dbee2
> > dashboard link: https://syzkaller.appspot.com/bug?extid=42bc0d31b9a21faebdf8
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136ad566100000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10138f7a100000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+42bc0d31b9a21faebdf8@syzkaller.appspotmail.com
> >
> > INFO: trying to register non-static key.
> > the code is fine but needs lockdep annotation.
>
> Why is INFO: triggering syzbot?

This is a kernel bug, no?

And there are lots of other kernel bug types that start with INFO:
https://github.com/google/syzkaller/blob/master/pkg/report/linux.go#L1302

The rules to understand when linux kernel has bugged are insanely
complex in syzkaller:
https://github.com/google/syzkaller/blob/master/pkg/report/linux.go#L914-L1685
(+hundreds of hardcoded function names and file names above).
