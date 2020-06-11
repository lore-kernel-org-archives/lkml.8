Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9735CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 00:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F592074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 00:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgFKAZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 20:25:05 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:51183 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgFKAZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 20:25:04 -0400
Received: by mail-il1-f197.google.com with SMTP id k63so137987ilg.17
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 17:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5h8mXCxAyDZSlKXtJUEYKqhTlNYUsrPeduOrUEGY4RQ=;
        b=kXNCwWa0qHTyIbbIdhU9fm1i4yu8HJV+uq+NaIHozrmMWBmqT2djXye4ZDBlljmvci
         SSV4IxNYBPo/KYvTOR+8p5tbfLLpXXN2gJDCLy09QV/JX90KBPROgTozM5bpG95eW5v8
         /AdTOUH9SaH6ev6adoN/ZgR1YbOfMm/kjnDbiz7xLpncoQzeP5/XZbKSAEiBT1kWOZGW
         1bWy9b5nSrYAJDkrRRERhlSi97LVeVxEDYElCXzkt3rSeV9+nFuX59tj2NopED2R+fYN
         6XLlGm8XPyzFbMLMub7TgU811iEYSyaaNhMNKYRbDC3Yi3EnKupYH81hs03j6sAS6EQ5
         ZnGA==
X-Gm-Message-State: AOAM532PbII5VYQLEIlqD6RFUKeQ1nt6QHgJLHwYGqybgm8KyaQhtDOv
        U+z7J2xoJuoKDrz86kV/LwEXr2YxB6/SMyKmGYUiDGJMUNwQ
X-Google-Smtp-Source: ABdhPJyrMgQvz66Vb9aVe5TnjxkkUv8YU1EGJlD+BgcZtIAC9MgHdnop0BgRS67Ewa1mFKkjCYM2u6Us3ThS9zyTBpDa96B8JLeb
MIME-Version: 1.0
X-Received: by 2002:a05:6638:406:: with SMTP id q6mr800041jap.125.1591835102980;
 Wed, 10 Jun 2020 17:25:02 -0700 (PDT)
Date:   Wed, 10 Jun 2020 17:25:02 -0700
In-Reply-To: <20200610220710.GL1347934@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dab72f05a7c3fd77@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 generic_perform_write (2)
From:   syzbot <syzbot+bca9799bf129256190da@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, akpm@linux-foundation.org,
        dan.j.williams@intel.com, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+bca9799bf129256190da@syzkaller.appspotmail.com

Tested on:

commit:         5749fe5a ext4: avoid race conditions when remounting with ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=175fcaead7a60c3f
dashboard link: https://syzkaller.appspot.com/bug?extid=bca9799bf129256190da
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
