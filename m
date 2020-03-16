Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345E3C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EE320663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732600AbgCPUhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:37:06 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:53163 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732486AbgCPUhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 16:37:05 -0400
Received: by mail-il1-f200.google.com with SMTP id d2so14965994ilf.19
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 13:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=1hH1v+Hs6ExwOL7AfjVRT/RqaQ0mSQnFpD6JFW1tz+I=;
        b=truSzvmoc0tge4792Sd1xAX7mYWoMv/7pBD2Hs3f7sLSvtoQEpO5WEDhI/HPMOB2lZ
         AgQa47RjkPfj9u0VXtRw+O3rZsRQlZwLXARxVCqxe010iP81FV7ctwS3tlzIVNJc+3cu
         yGZok6goq/LL4G+pITimpjkQ2FlIBAuwN/8zXJgR1ldeafv941ujxetUKV7BPSVftlNm
         mbkFCtfs4RjiqUkFOwEMNtR8KAck6bSNo19W2iG7Dk7S4GrhDMzkrB+AorHtG2tyqHRr
         BO38arMINXQ1gynRqkR01Vm8t/5VG1aFN13tXB1Qywf5G+Oy/d2Yet9T5POHTnbdtHDG
         pcvQ==
X-Gm-Message-State: ANhLgQ3OKbjd2SA6gQF/RNkpFIPSUuYYS+rohrvRbYveKrFau8Ofk+mW
        PQ1zIaJAnvb2P/7Ew1AioEUkviU0ZEYDb+jEmIDvxMzTQiNF
X-Google-Smtp-Source: ADFU+vs5BTmNxfX+DRGldsrsvnJV06VNfn+AsRVzOB9z+p6kQcf3sjK3v84T6pJ1Ez7LwBfk7CSAu9s6QRJmdMon1TgVX09wHH8C
MIME-Version: 1.0
X-Received: by 2002:a5d:8555:: with SMTP id b21mr857105ios.200.1584391024933;
 Mon, 16 Mar 2020 13:37:04 -0700 (PDT)
Date:   Mon, 16 Mar 2020 13:37:04 -0700
In-Reply-To: <0000000000003a2af3059905d1dc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a06e005a0fec8cc@google.com>
Subject: Re: INFO: task hung in paste_selection
From:   syzbot <syzbot+a172213a651850d94cf2@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, jslaby@suse.cz,
        linux-kernel@vger.kernel.org, okash.khawaja@gmail.com,
        samuel.thibault@ens-lyon.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit e8c75a30a23c6ba63f4ef6895cbf41fd42f21aa2
Author: Jiri Slaby <jslaby@suse.cz>
Date:   Fri Feb 28 11:54:06 2020 +0000

    vt: selection, push sel_lock up

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14aada1de00000
start commit:   ae4b064e Merge tag 'afs-fixes-20191211' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=a172213a651850d94cf2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bf312ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116cce46e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: vt: selection, push sel_lock up

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
