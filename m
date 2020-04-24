Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB69C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B14842075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgDXTcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:32:06 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:38554 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXTcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:32:05 -0400
Received: by mail-il1-f200.google.com with SMTP id u11so11410243ilg.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 12:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vA7Hj07TAr42CqeEpKdo2ArIABvLEDSOmjr35bxOqYk=;
        b=kwlGEgIU29Gkyf7re+Nk/N7a412ZSSsV0PJOlV6g/fnuwQciaqEDZhQJ4n9p+68GhM
         U6pKmZuyl8/wIOdtFLkJUZtGoUyaf8BXKFd7bkVtIUxiH7hgnxcqfqnMj3t3P+D6rDqL
         cleaurJNjuPBwmrAWw2KUcDv/IVPZfmuR98YjbHoBx9k7sxeaj0Xa8vAmExBZnKF/6+x
         coWakTCc9mxyWQsMA5hpztJs1pRplQPMTii+sp+2EZFwUxPHRHWxkUT79TSeA+0SJxcj
         FjSmSLg7+gAUSnyg7rEy/QJK1b9bmOZwWxr8dKdPpSAdDY+FfwOPzdlFDGGuj+IK7JuG
         9+0A==
X-Gm-Message-State: AGi0PuYkAGmMJB5xvQvpRyOmBX5oYXDC4rnjGlMHVNJdDorT+aGevXO5
        Ck5rAZtGpfkmFdvBACRQfqAlIij74trvIKL59kEGChHmDZp5
X-Google-Smtp-Source: APiQypIjA6RvuhP8WE5NS5VHcMG7z2cPwvLAODZjpQt6NcmRh+vcAX3PNIes9BadXSxMx0IyZf4f8vwRvOzENlSCONhfZNGzZl0S
MIME-Version: 1.0
X-Received: by 2002:a05:6638:f92:: with SMTP id h18mr10148653jal.115.1587756722804;
 Fri, 24 Apr 2020 12:32:02 -0700 (PDT)
Date:   Fri, 24 Apr 2020 12:32:02 -0700
In-Reply-To: <Pine.LNX.4.44L0.2004241456070.17162-100000@netrider.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073e03705a40e6b38@google.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (3)
From:   syzbot <syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        ingrassia@epigenesys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com

Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
dashboard link: https://syzkaller.appspot.com/bug?extid=db339689b2101f6f6071
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17d37144100000

Note: testing is done by a robot and is best-effort only.
