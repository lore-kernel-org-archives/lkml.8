Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8425DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5616F2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgHJOmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:42:11 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:48971 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgHJOmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:42:10 -0400
Received: by mail-il1-f198.google.com with SMTP id w8so2808888ilg.15
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 07:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OzRqCxKFuIBYd6uAIlx4xZOrodkSUu/+cChTzUG+OTk=;
        b=VDkZFQFKKwGXV4066sOwC8Y/8bUrMTE5Z5QH/EAKi70uPx9gEmo5A2zgNl6RggIKN7
         HxJbwpDLj46Ocw5ktn6Ug+I5l9IKaUKMug4aAIGv8vr4kB7EKLr/ftOF4uZQ8IcUo6T7
         pDhEj6ZSj3trCQQyRnHdClpBdQ4JLPVTeV6KayiZJRxZBJnQHsceupFith5elvB30mo5
         2GsUdQKW6LlGrXhmDZrwesBLi+GslanQbrJb5MSi60NyhDE/fa14GbkcKwsc3H4dvz6D
         +ROF4J8tnjkO5y2vGHkk0xatghlfIVs8UT4bEfhZSWyiBv1hI+68CB13Pm0QDWlZ46A7
         aVkg==
X-Gm-Message-State: AOAM532hlRSo3vHxX93+CfeqFARmmXfS8EbKC6L0caKWWtISl8B5ZrHu
        W+xFrZ9QZYShju2qMrfUXac/Ytib1ioNWJp/Z5VsY7HXoC9Y
X-Google-Smtp-Source: ABdhPJxXFLShve5fwsxHgj+zHfvKDZxlj0s2XHM3ReDwNCMkS1tJ8mZ5yZkigLmULrkVBmjKY8LGwZ7Q9j1yKl+G27H/VtFlxZ3A
MIME-Version: 1.0
X-Received: by 2002:a5e:a607:: with SMTP id q7mr17629684ioi.16.1597070529854;
 Mon, 10 Aug 2020 07:42:09 -0700 (PDT)
Date:   Mon, 10 Aug 2020 07:42:09 -0700
In-Reply-To: <20200810142441.GB299045@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d004605ac86f57b@google.com>
Subject: Re: WARNING in slab_pre_alloc_hook
From:   syzbot <syzbot+c2c3302f9c601a4b1be2@syzkaller.appspotmail.com>
To:     andreyknvl@gmail.com, andreyknvl@google.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c2c3302f9c601a4b1be2@syzkaller.appspotmail.com

Tested on:

commit:         449dc8c9 Merge tag 'for-v5.9' of git://git.kernel.org/pub/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ef84fa8ee48e528
dashboard link: https://syzkaller.appspot.com/bug?extid=c2c3302f9c601a4b1be2
compiler:       gcc (GCC) 10.1.0-syz 20200507
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ef8e52900000

Note: testing is done by a robot and is best-effort only.
