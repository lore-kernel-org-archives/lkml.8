Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A583DC33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 17:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8644F206E6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 17:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgBARIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 12:08:04 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:48087 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgBARIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 12:08:04 -0500
Received: by mail-io1-f69.google.com with SMTP id 13so6396506iof.14
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 09:08:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tymJqtHu6iGLng33McHVxrI0IJhfSzLoBxSmgMc7RDs=;
        b=tJB6ZK7eVxyx7Y9ATMn+1R/PJzySSXpv/Sr6W7GtaJT/Qs/7HAH/lzP+g0t+cPLeTW
         wEKUNPovyTPlcM90lixOkmDA564GFoY1YJ9rTQkvFbYA4dCZRhugOTceCXOYQcvDZCpL
         ebFL5sSTf7nq+ORTB4h7MSiRDnu13my+M46p04nsPf5xfaImGnw+VkAwkfWIfNtJAx7w
         nsjtvBDWiz4jhI7Dx/GG+HcXyLScpvOJX1Bbpqv4b0mXyWr+qOP0sZ0tI990kdejiTTS
         H7+TdmypQ/cTvy72gHtLG93lRiGKXudqNTMInabD5lCFzU5Kg1PXzJIOWI8rg7lekysY
         ryTg==
X-Gm-Message-State: APjAAAXIGgIXZwxPl9S4wHs7C763lDZlDiLjCB+a/Skk5J11+nwh9zDM
        w7F5FZ8qj4Xjs3iesuaSP5yx3NPkO9VYZiELmEo5EJS0bg17
X-Google-Smtp-Source: APXvYqwepjCYJGI2J8ce5amIo8ruFAk8py8FuCjyu9SckBqGRIYGuJ+otdYXZhBwXMfqF4VWM3BgDWyoXjY1iNw3hTcQzL5vQlyt
MIME-Version: 1.0
X-Received: by 2002:a6b:b8c1:: with SMTP id i184mr9146827iof.68.1580576882237;
 Sat, 01 Feb 2020 09:08:02 -0800 (PST)
Date:   Sat, 01 Feb 2020 09:08:02 -0800
In-Reply-To: <000000000000b926cf059d7c6552@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b26dc059d86bb54@google.com>
Subject: Re: general protection fault in path_openat
From:   syzbot <syzbot+190005201ced78a74ad6@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit d0cb50185ae942b03c4327be322055d622dc79f6
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun Jan 26 14:29:34 2020 +0000

    do_last(): fetch directory ->i_mode and ->i_uid before it's too late

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a8d8b5e00000
start commit:   ccaaaf6f Merge tag 'mpx-for-linus' of git://git.kernel.org..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15a8d8b5e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11a8d8b5e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=879390c6b09ccf66
dashboard link: https://syzkaller.appspot.com/bug?extid=190005201ced78a74ad6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1674c776e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1565e101e00000

Reported-by: syzbot+190005201ced78a74ad6@syzkaller.appspotmail.com
Fixes: d0cb50185ae9 ("do_last(): fetch directory ->i_mode and ->i_uid before it's too late")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
