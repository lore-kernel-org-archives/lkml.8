Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CEDC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 06:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABB0206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 06:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCIG6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 02:58:06 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:55704 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgCIG6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 02:58:05 -0400
Received: by mail-il1-f199.google.com with SMTP id p7so6743033ilr.22
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 23:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3vbHTdYQ67mib1pqhw7RfSE7n4B7fPNmRK2m1Cb8iPU=;
        b=SdlW65lGl19tcXiGRQHFtUnaANjDmIb/FXrs/qF9dITBW2kExO/j5eEJ6e4++GIPPT
         UXN//CRS9wReOoFmnZH3Nx16GB3hjEA4ulHxK4chRRrFr6P9qRTIRrjNAgrOuf9g9vVx
         xzkfylGJ2t2tV/irWn+c0uYCfCKEtBUwvAiWdz9eQmqu7hpNy80Pgvg6LYQgoVyyHEiO
         db/hB4GQw6ZXKFLsoyzPyOBfP5P7opT1qENqBE87er43DNOxZ/erIuIHnoO+ib1rf9Px
         E4lYv2Y6KjS3oNIHKVMDctiMiLOJlsvQb4hBbYdJCw+0ybCeFRJ9nIJhhEBnKyGv/p/4
         2DYA==
X-Gm-Message-State: ANhLgQ3zcLv0Kqw9Jf1rpci1eQ08xqAcOjPiqL2Wmxu119yJgNM6Y7Vi
        7q71v1anpmGnm9sUDsQlFyOSnF/cji/hLF7h7n4Y1rMLH+/g
X-Google-Smtp-Source: ADFU+vtRpURm6U4wUgm5w3Q/LMCwhNNEMjTRsTn2XqAL2qLJHVJT0lEdDhwiPvd5cYSVN+QMhS0AUF7kTWiMSzfA+d9Rg3PvE9EA
MIME-Version: 1.0
X-Received: by 2002:a5d:9bc8:: with SMTP id d8mr12563436ion.142.1583737083027;
 Sun, 08 Mar 2020 23:58:03 -0700 (PDT)
Date:   Sun, 08 Mar 2020 23:58:03 -0700
In-Reply-To: <000000000000161ee805a039a49e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000406a7f05a066861d@google.com>
Subject: Re: possible deadlock in siw_create_listen
From:   syzbot <syzbot+3fbea977bd382a4e6140@syzkaller.appspotmail.com>
To:     ast@kernel.org, bmt@zurich.ibm.com, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dledford@redhat.com,
        dsahern@gmail.com, hawk@kernel.org, jakub.kicinski@netronome.com,
        jgg@ziepe.ca, jiri@mellanox.com, johannes.berg@intel.com,
        john.fastabend@gmail.com, kafai@fb.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        mkubecek@suse.cz, netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit bfcccfe78b361f5f6ef48554aed5bcd30c72f67f
Author: Jakub Kicinski <jakub.kicinski@netronome.com>
Date:   Tue Nov 5 21:26:11 2019 +0000

    netdevsim: drop code duplicated by a merge

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=166d11c3e00000
start commit:   425c075d Merge branch 'tun-debug'
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=156d11c3e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=116d11c3e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=598678fc6e800071
dashboard link: https://syzkaller.appspot.com/bug?extid=3fbea977bd382a4e6140
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e3df31e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163d0439e00000

Reported-by: syzbot+3fbea977bd382a4e6140@syzkaller.appspotmail.com
Fixes: bfcccfe78b36 ("netdevsim: drop code duplicated by a merge")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
