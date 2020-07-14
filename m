Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC54C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 23:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B47142071B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 23:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgGNXPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 19:15:10 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:52764 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgGNXPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 19:15:09 -0400
Received: by mail-il1-f198.google.com with SMTP id o17so114376ilt.19
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 16:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=y4iEWtfU0KeH/HIu2aGf4JNxF8z33lh3eOzOWOGJp8c=;
        b=bKrJ2EkOzvPciWRn4nm0rN3CwpNZUElbKOdkc4RFHYIhiiwLd7FYCwzIlrb5ODOIY9
         /gFb9uxru516QrbLNuYhnZ0+Cdahse43Ym8JyTcdZ6GJDqJETS0IMJsov7aKDMht7i0L
         zUc+HvKBF5BhFAcb9g07XTcSZqx+DkAGtPR9IGp/AJr2D/ZwF679/94tepNbl/Z6wYSH
         s7jNIeduFhHcG5cVxxL3MASbfmXFGVg3VUeveXhuteaq7fxmLeV8ZyU7JuhIuJRgV6mt
         vQ4USVnBWeIKzFBqo4v42da5w0OWryF4NsZiVUpLFw3dZkwqneP1WAoJvFpVawJLCfB3
         6i+Q==
X-Gm-Message-State: AOAM532PFqS8VgyjMz5IyZAiXIWQ317CZqOpePMxdmp+NZUATx+6MM2f
        WuMYrVTz2sqL85RN0XidbQSD6jyH891EH333YwtXyOG0Hdeb
X-Google-Smtp-Source: ABdhPJzfIFFcizVg12hR+hNQck2LRndW+7B2KWWZoAqBVlSMjhnFcb+cKydgja6nAeyP//6r0JVKHznfXB7ulbcFhzayU6bf3/s6
MIME-Version: 1.0
X-Received: by 2002:a6b:d301:: with SMTP id s1mr7292773iob.146.1594768508659;
 Tue, 14 Jul 2020 16:15:08 -0700 (PDT)
Date:   Tue, 14 Jul 2020 16:15:08 -0700
In-Reply-To: <0000000000005f350105aa0af108@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000752cbc05aa6efa98@google.com>
Subject: Re: WARNING in __kernel_write
From:   syzbot <syzbot+e6f77e16ff68b2434a2c@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, ericvh@gmail.com, hch@infradead.org,
        hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, lucho@ionkov.net, nazard@nazar.ca,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 81238b2cff1469ff5b94390d026cd075105d6dcd
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu May 7 17:33:03 2020 +0000

    fs: implement kernel_write using __kernel_write

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10d829bf100000
start commit:   be978f8f Add linux-next specific files for 20200713
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12d829bf100000
console output: https://syzkaller.appspot.com/x/log.txt?x=14d829bf100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fe4fccb94cbc1a6
dashboard link: https://syzkaller.appspot.com/bug?extid=e6f77e16ff68b2434a2c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fe004f100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d35f33100000

Reported-by: syzbot+e6f77e16ff68b2434a2c@syzkaller.appspotmail.com
Fixes: 81238b2cff14 ("fs: implement kernel_write using __kernel_write")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
