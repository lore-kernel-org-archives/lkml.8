Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C04C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B88A20724
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgDWVvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:51:04 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:49179 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgDWVvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 17:51:04 -0400
Received: by mail-io1-f71.google.com with SMTP id z13so3169900iog.16
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 14:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Ml9eSiK6LlPOUyvXnLydA6gAwYERXzL6OHKU+KP1YiY=;
        b=JdUnYlVTm1VVreIhmAMs5bdqJsSMnYeer2K8GrieyvE7pyZcAIDONi2f4tSuAS8EPS
         t7tOYls8XT6oZgh1/XJVcIj0AZa1apMtRRkfSZ/v5ZPmqT1rFPzxiG4AyxTnD5ANeF/C
         b/bjKSYU14ozUQRapQ5CqskLmtj2DCO0PE67E4QSMVbuI9iF3B1jq73Pmj2n3HM0Smvp
         M5Pzj4bWKGg65i5/PcEQJj81r4SPtR+TSPRZ9wisyCDh2FHWSOObfxXrzwhmVHypdcOG
         hDZCpVtoQqMrobptshSjR7G3Bmz2/3AmpNYMT8rwh62V3Z04In42ozkZ8zyjjzkBOCz2
         LO0Q==
X-Gm-Message-State: AGi0PuaxQRGaQ6/szvEQknZuHO3LHz6jCmhf1mz3BqDb+xL3k/UuPWue
        T+JYogl/MqBuDXZKFuUinoEkWIMm4zK+CshU5WKlx4QorriF
X-Google-Smtp-Source: APiQypK4UYw8sKRyqAnKtLm7WUHaf5IanLWVJURM/MUD6sVdhpLw+Olc4COMhDo2kBsAQbOCbMLV8EUmTudUTHgOgygkJuzrcQst
MIME-Version: 1.0
X-Received: by 2002:a92:cece:: with SMTP id z14mr5406607ilq.147.1587678663436;
 Thu, 23 Apr 2020 14:51:03 -0700 (PDT)
Date:   Thu, 23 Apr 2020 14:51:03 -0700
In-Reply-To: <Pine.LNX.4.44L0.2004231654460.22192-100000@netrider.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c06f9105a3fc3ed2@google.com>
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=126fd687e00000

Note: testing is done by a robot and is best-effort only.
