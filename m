Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEA2C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 21:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9E0120885
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 21:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388542AbgEXVxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 17:53:06 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:56567 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388349AbgEXVxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 17:53:05 -0400
Received: by mail-io1-f70.google.com with SMTP id s126so5376446iod.23
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 14:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=W2XSpdpI4imP3oFttp3ea6rQjy1+gsYM/fLbimKy0J8=;
        b=kHmZk4Z12khc+xl8RDd44oT2jLCxeqljXJdOfz3EMlSqylyz3q2RQ/bEp37oMTxUm1
         0yTva0OSmu5wW9gqJxV0nhXGM9UkuyTTF1UL2uBwsufFV/av2fF2k7dzc+OKxuSXYrEd
         YIOEKlBdp1BCBUwuG0KO5GveYMgSu9uzzwKc/srEEryFhoid1STNy0vYQUX/EYoslgTl
         YD03wkLmL5OwEowwjoiyN2FHMQwfkJn7RLH85gXAzxYUdmGPxmYoMxMLQZUBxk5HDFx6
         fK5wCwfNCUOuJgVrYaZWsKVibJ0bJ9rpff65TtlJKQnw3pAdZF6rfGzZNXbujr7IB3RF
         xUBQ==
X-Gm-Message-State: AOAM533f8pAywbUtEpVBqOtLemEW8Qnvl0wU+VVRqh08gSqMLAf1+Hkd
        WASVsw93Il35DyY1YgqT9QRqEjkvlAhfaNNWpAov7Q8A+waX
X-Google-Smtp-Source: ABdhPJxqwdoquD6CD1t/4vURcXUY094C2cwyZVIZOKx/NGCIbF4xF4jKrwBVk0W6TIG38UReDIw9O+Vu9CfgTfvRCzjbz4MkjNyl
MIME-Version: 1.0
X-Received: by 2002:a92:885c:: with SMTP id h89mr22924691ild.16.1590357183712;
 Sun, 24 May 2020 14:53:03 -0700 (PDT)
Date:   Sun, 24 May 2020 14:53:03 -0700
In-Reply-To: <000000000000cd404e058c9de28b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000537605a66be3a8@google.com>
Subject: Re: WARNING in dlfb_submit_urb/usb_submit_urb
From:   syzbot <syzbot+53ce4a4246d0fe0fee34@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, balbi@kernel.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        ingrassia@epigenesys.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit c61769bd4777a922952aed0d042a2572e5bd9b74
Author: Andrey Konovalov <andreyknvl@google.com>
Date:   Thu May 7 17:06:57 2020 +0000

    usb: raw-gadget: support stalling/halting/wedging endpoints

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14add53c100000
start commit:   051143e1 Merge tag 'apparmor-pr-2020-05-21' of git://git.k..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16add53c100000
console output: https://syzkaller.appspot.com/x/log.txt?x=12add53c100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3368ce0cc5f5ace
dashboard link: https://syzkaller.appspot.com/bug?extid=53ce4a4246d0fe0fee34
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15be3ad6100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1559676e100000

Reported-by: syzbot+53ce4a4246d0fe0fee34@syzkaller.appspotmail.com
Fixes: c61769bd4777 ("usb: raw-gadget: support stalling/halting/wedging endpoints")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
