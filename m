Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3775FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B0B246BB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgB1Nex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:34:53 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:36909 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgB1New (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:34:52 -0500
Received: by mail-il1-f197.google.com with SMTP id z79so3339207ilf.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 05:34:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=P2ODn0VgFvyiKsD70cUH3M74/ayRtotvviO7aFfvm90=;
        b=PB1gdCsH1yMTn1srgpkkQhW8EFKxKo0Ku9S9V89Un664y/oK26cUb9Hk4lQu6UnXOH
         YJS7fsla0Rjl+ut0aA71bY2ATlvDsef2bkIQ/KwN/5rq0oFCJthOnanC0BOz5QRWrnNj
         JOXMNEN/ByG5oETef3QKCVXln3BFRj/NG224DXqkKuHm81VcK9cHUxrB5Gj/QaSwYdCG
         2+hOJnzp3ajdjiSCmIZ6EvZ29ROJNNRaUspwgYZg3ZXnnTW7cXQN/hz390epmmMLzl/v
         RWoO38AzWQLSJZz3ycHWSzlzIx7DG+wqW1fnrRO4nGiYqe9R6v6+VcTTLF2YOHBkSUxJ
         nL3g==
X-Gm-Message-State: APjAAAVc9mxN1HCcuwXWUlMeCXhUgNYSFeHP4nf+Tugp7UUNNCvW8A+l
        NIvkvASPwXGWxgDlR1oYqVRDmNobEn0r80iYehiJGH3M8K1c
X-Google-Smtp-Source: APXvYqwmN2kKuxPJSbIHtBy3JQ++QfG738jlmTXSZEZc21gUcEGvXA99Nd0C4Sg2sMovrsTArsupj40HpcX9Bef9Lzj4vecxJPw7
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:df2:: with SMTP id m18mr4289443ilj.56.1582896890344;
 Fri, 28 Feb 2020 05:34:50 -0800 (PST)
Date:   Fri, 28 Feb 2020 05:34:50 -0800
In-Reply-To: <6590a26d-8234-67a8-16e0-6391da6765d9@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd7845059fa2e6dc@google.com>
Subject: Re: Re: possible deadlock in tty_unthrottle
From:   syzbot <syzbot+26183d9746e62da329b8@syzkaller.appspotmail.com>
To:     Jiri Slaby <jslaby@suse.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 27. 02. 20, 9:39, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following crash on:
>> 
>> HEAD commit:    f8788d86 Linux 5.6-rc3 git tree:       upstream 
>> console output:
>> https://syzkaller.appspot.com/x/log.txt?x=1102d22de00000 kernel
>> config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f 
>> dashboard link:
>> https://syzkaller.appspot.com/bug?extid=26183d9746e62da329b8 
>> compiler:       clang version 10.0.0
>> (https://github.com/llvm/llvm-project/
>> c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
>> 
>> Unfortunately, I don't have any reproducer for this crash yet.
>> 
>> IMPORTANT: if you fix the bug, please add the following tag to the
>> commit: Reported-by:
>> syzbot+26183d9746e62da329b8@syzkaller.appspotmail.com
>
> So trying below, but there is no reproducer for the issue, so I am not
> sure if it triggers any action at all.
>
> #syz test:

This crash does not have a reproducer. I cannot test it.

> git://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git vc_sel
>
> thanks,
> -- 
> js
> suse labs
