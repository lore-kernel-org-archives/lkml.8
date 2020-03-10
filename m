Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A83C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3324120637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgCJA5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 20:57:05 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:42919 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbgCJA5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 20:57:04 -0400
Received: by mail-il1-f200.google.com with SMTP id j88so5488999ilg.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 17:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=LYm5Iby0moxVQ3MIVViH9TGv1Wc+3G3kH6N8E5ebnTE=;
        b=GgklFzJ4kDMZF3v0TIp+TNonnvdVLxckFB3dlMtjUprxwqZTPL5CGCogwNRbq0fAF9
         dYmKu7YVMkvfx1ak9Bypz9Co1En/AA3nN5+Eod/rsprNEPnkPlCQ6Dmmd2zDjQ8L4sJj
         9hLaLHePBTAPP17OdPXaSVdKP83BrhmIcokg+tvD/R+so8Z1gb/LM5eI4csuEO/hifPI
         BPmVM6fs0yXvyaOM6FLXoEeM8TNqmjF4dy/ilotYCT8ffeJQxP7qnRK2jfSlGpuzfpzM
         Z4sJ+2YvRymV5wH0TWBZwyP1cIz/JmTLr7Gi2tmB3cJmaMnu0nIImNnqXlWuZabn23pc
         mEQQ==
X-Gm-Message-State: ANhLgQ1Oz3zC5doNqu55Nn36Hn3CgL5uAr4Ul5n0JYxFKzF3FTvE/oiR
        nT99TEKQcijEwyKULt32HUFNON6EZ7QjsLvCzmzCyEiyGKBr
X-Google-Smtp-Source: ADFU+vsO07X2AYCKTvab5N7cNSC601aCG4vt7PzApUl9ze4ga8n/fz5NIF4Ffi3z5mMRBJnLnNodZUm/iOqnfNwJed5i3tLZZFAN
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f43:: with SMTP id y3mr17890487ilj.174.1583801822243;
 Mon, 09 Mar 2020 17:57:02 -0700 (PDT)
Date:   Mon, 09 Mar 2020 17:57:02 -0700
In-Reply-To: <000000000000ce8d2305a03b0988@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002735905a07599be@google.com>
Subject: Re: INFO: trying to register non-static key in uhid_char_release
From:   syzbot <syzbot+8357fbef0d7bb602de45@syzkaller.appspotmail.com>
To:     benjamin.tissoires@redhat.com, dh.herrmann@googlemail.com,
        ebiggers@kernel.org, hdanton@sina.com, jikos@kernel.org,
        jkorsnes@cisco.com, jkosina@suse.cz, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 84a4062632462c4320704fcdf8e99e89e94c0aba
Author: Johan Korsnes <jkorsnes@cisco.com>
Date:   Fri Jan 17 12:08:36 2020 +0000

    HID: core: increase HID report buffer size to 8KiB

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=113098b1e00000
start commit:   2c523b34 Linux 5.6-rc5
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=133098b1e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=153098b1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5295e161cd85b82
dashboard link: https://syzkaller.appspot.com/bug?extid=8357fbef0d7bb602de45
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b439c3e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16dc6fb5e00000

Reported-by: syzbot+8357fbef0d7bb602de45@syzkaller.appspotmail.com
Fixes: 84a406263246 ("HID: core: increase HID report buffer size to 8KiB")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
