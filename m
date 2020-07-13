Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7D7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1972F206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbgGMPeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:34:07 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:47533 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729581AbgGMPeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:34:07 -0400
Received: by mail-il1-f200.google.com with SMTP id o2so9694606ilg.14
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 08:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=PuwK5sOU81rM/XoQcuJqMMPHQ+Gr8re6yhX7o7C4muQ=;
        b=bB6sbdWDu/vmXZQc5ekvPSilnf/IuoQjTsBPQfZG5ODDd9yh2GvfU/aRyCtDwbA/fM
         2cvA+kIzpmjqoHsRZ4enwErQRi9cjeMF1H9uQj0Gs9Wei9ZzgROVKsIQJ4f2elTXYjx/
         7CFoeCdaSyP9CxXvI1Lp+OLsMU10O+RsiHbKvw0v9Slir/eJ8kzTRqp8FtPhl/BFjl1x
         8t5qXb2JYZp7XpwCbb8H0AERE0OHges7eU9vjo4GvTOdi+z40Y3w7/HEWNr2qyHna+uA
         HpaaLVymzYyDABIZqochqTgf3RjQRpyRfOaLyUmCh21WuzDgKJsT1lT5ZmwMkp44zdfB
         nzQA==
X-Gm-Message-State: AOAM530CWBds2mWVwOw5AbC+AiiDeG/1ooLpoc0uKu80tmz3kPyAHZCw
        F5hWoaGlHA80YIA6OTQkXn/Jh+GEt0yfC8wEeKrTmek951yP
X-Google-Smtp-Source: ABdhPJydbjbFEZskX61aECXgpw3Hf5lQrLPxhVEfS8LhGnBo3W5qg9pPTvobj6Hs8ic5kEJcDP2fXDOcy5fkMgW8HBxuPOvZeySr
MIME-Version: 1.0
X-Received: by 2002:a92:1bd5:: with SMTP id f82mr225494ill.121.1594654446305;
 Mon, 13 Jul 2020 08:34:06 -0700 (PDT)
Date:   Mon, 13 Jul 2020 08:34:06 -0700
In-Reply-To: <0000000000001bbb6705aa49635a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cfc8ff05aa546b84@google.com>
Subject: Re: KASAN: use-after-free Read in userfaultfd_release (2)
From:   syzbot <syzbot+75867c44841cb6373570@syzkaller.appspotmail.com>
To:     Markus.Elfring@web.de, casey@schaufler-ca.com, dancol@google.com,
        hdanton@sina.com, jmorris@namei.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stephen.smalley.work@gmail.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit d08ac70b1e0dc71ac2315007bcc3efb283b2eae4
Author: Daniel Colascione <dancol@google.com>
Date:   Wed Apr 1 21:39:03 2020 +0000

    Wire UFFD up to SELinux

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a79d13100000
start commit:   89032636 Add linux-next specific files for 20200708
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16a79d13100000
console output: https://syzkaller.appspot.com/x/log.txt?x=12a79d13100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64a250ebabc6c320
dashboard link: https://syzkaller.appspot.com/bug?extid=75867c44841cb6373570
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c4c8db100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cbb68f100000

Reported-by: syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
Fixes: d08ac70b1e0d ("Wire UFFD up to SELinux")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
