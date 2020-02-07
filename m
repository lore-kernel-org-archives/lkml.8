Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CDEC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 21:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF0822314
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 21:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgBGV6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 16:58:04 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:37262 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgBGV6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 16:58:03 -0500
Received: by mail-io1-f71.google.com with SMTP id p4so597008ioo.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 13:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=W19wD+6tfTNDp+aV2Lk+F8lK/QrKkxo/+Ppz61rvmy0=;
        b=iJHWQ0wmfCfdpKR/bwJW0sdNwoSkszuI7+HLdg8f8JNv5mzpdzLbNdi/0142Zwlg47
         EWn5Uj6n5/BKYv2AG2CIPag+5CH1Fn7VTZGht0lwwltyPeGZut0m79/EQ97c9v4+QWsf
         vNZYrB/GYtWIfb2GTkqaNN8LjyFI1AbF2GqEER4Wg37AfnMziGijS9yb687zVHciYgDP
         oHA5Vo5qZXBkPovsuf/9uDK8mauZYSVkQKvJM4U3xpp+rsktz67h6ja1OdZy1o8tN83B
         SBm6alM3DH9RSj2bDwT0spzBOUbnYhs09pJ+Vx0Vxw2l/l8R9SY+KfAizkBaa4yxPI6D
         QrRg==
X-Gm-Message-State: APjAAAUcuhb/9dUvIDYO04dktIkGKmHLeU3fyzJpAFOBEa026FzS7+RI
        figNMvlGM3Q8RKGXAja2b3iv/hXNskIQF/TmK24Luqnq1tFi
X-Google-Smtp-Source: APXvYqxVxIlLYhnPbOxSejnGOT841+/VwCnwX8a4WtJ3oEOV5qwNJPQ9lQs8cstQ3checqsjzAkOriGHYbqdsIZkXL/M2UzITXwc
MIME-Version: 1.0
X-Received: by 2002:a02:cc75:: with SMTP id j21mr492335jaq.113.1581112681695;
 Fri, 07 Feb 2020 13:58:01 -0800 (PST)
Date:   Fri, 07 Feb 2020 13:58:01 -0800
In-Reply-To: <000000000000d895bd059dffb65c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be1109059e037b83@google.com>
Subject: Re: BUG: sleeping function called from invalid context in __kmalloc
From:   syzbot <syzbot+98704a51af8e3d9425a9@syzkaller.appspotmail.com>
To:     idryomov@gmail.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 4fbc0c711b2464ee1551850b85002faae0b775d5
Author: Xiubo Li <xiubli@redhat.com>
Date:   Fri Dec 20 14:34:04 2019 +0000

    ceph: remove the extra slashes in the server path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=166a57bee00000
start commit:   90568ecf Merge tag 'kvm-5.6-2' of git://git.kernel.org/pub..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=156a57bee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=116a57bee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69fa012479f9a62
dashboard link: https://syzkaller.appspot.com/bug?extid=98704a51af8e3d9425a9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172182b5e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1590aab5e00000

Reported-by: syzbot+98704a51af8e3d9425a9@syzkaller.appspotmail.com
Fixes: 4fbc0c711b24 ("ceph: remove the extra slashes in the server path")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
