Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A1CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1C4D20786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgHZKhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:37:12 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:39830 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbgHZKhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:37:07 -0400
Received: by mail-il1-f197.google.com with SMTP id o1so1210583ilk.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 03:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=s+S1ybGzUd8iygNXODv3AXT+lmQWjeR11J2cV5mYm3w=;
        b=DBy20iqSkNbg/hrxqoWF8px4vxryamFXuWSd/Eg9BTuyDptqCBD5VuZTWnfXVnrkc/
         6dKkExhTUj2ADIR6kaMIYf+5bPq1zfmqidhqti7gEaU3L7aF8sUmoeoMatny4iP4zgbQ
         n6IOnoONL2ugS3mYW5iOgRqPCJMeHsndVGcsYEYekxo1Wjc8+ZysFdqHhax0U08Wkq/8
         AGQOhO0OfLfwsVFPPuhLir1Ordvh2knw0+cJc6rG+lRw8NliZ+nux86k6SNOiCgntb88
         5qtifYGtuP0uN8cNORu1y9TPnxJEsOBU5/uTbdw93hNY+yh4F7msdpN3bEuWR3bs7Zu2
         e4tQ==
X-Gm-Message-State: AOAM530gRHFtHTXOXphZSgC8hGJMYWFxOv2ERxRci3ykHdYUIZ2wlMDv
        jLSZqaXTPs7KmrTxRUtSMllQUugAHy1KN2f55i1gneX84lmP
X-Google-Smtp-Source: ABdhPJwFOkEQiQlcbrLBZrdR500P0BvYg8EmtIBu12QCrRopxNO8xUNUEPw9NT9y4coEXoVv2cQ5uxkxQoYT8AjUb6itEQrOVS2C
MIME-Version: 1.0
X-Received: by 2002:a92:9181:: with SMTP id e1mr12178268ill.274.1598438226931;
 Wed, 26 Aug 2020 03:37:06 -0700 (PDT)
Date:   Wed, 26 Aug 2020 03:37:06 -0700
In-Reply-To: <001a11441b6c6cb96c0569120042@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b636f005adc56621@google.com>
Subject: Re: KASAN: use-after-free Read in ntfs_read_locked_inode
From:   syzbot <syzbot+19b469021157c136116a@syzkaller.appspotmail.com>
To:     anton@tuxera.com, daniel@iogearbox.net, deller@gmx.de,
        dvyukov@google.com, jejb@parisc-linux.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        linux-parisc@vger.kernel.org, luto@amacapital.net, sdf@google.com,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, wad@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit f7c6cb1d9728dea9d9f131ef57303d6821afb0f8
Author: Stanislav Fomichev <sdf@google.com>
Date:   Wed Jul 29 00:31:03 2020 +0000

    bpf: Expose socket storage to BPF_PROG_TYPE_CGROUP_SOCK

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16480fa9900000
start commit:   3e968c9f Merge tag 'ext4_for_linus' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e8c053ac965e0dd
dashboard link: https://syzkaller.appspot.com/bug?extid=19b469021157c136116a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142d219b800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143029db800000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: Expose socket storage to BPF_PROG_TYPE_CGROUP_SOCK

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
