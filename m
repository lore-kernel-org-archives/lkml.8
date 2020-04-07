Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0F6C2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE892075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgDGVIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:08:06 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:48676 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgDGVIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:08:05 -0400
Received: by mail-io1-f69.google.com with SMTP id w10so4238223iod.15
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 14:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WcamevgV8aJ2+1jjTqeYsPnyyqndOfJut4ANxNQo7II=;
        b=PlCwhW4raXijD8dBgPt25S43z13MK6adTqBukdF1ftMoFUqbmmKKvfDJ3Yum1+Fb16
         k+cZhjCaAQUnFdMmpEODXQO21n4juRrO42dLR6RigOiz9v8Zv3KeLAnCo0HIuRfV9L4w
         IOMH0IHUQdeKYHPTuOvCRLkFVzdTtKaJ+qYjbN1gVudAEQ95MVzWdHOuMCT5/6Gj+hNs
         dJHGvLxtpYWtOpGYV/LlIL8hvPIkWm5F1LHebgnEh/wH8IIKC/NsMKyzrywRnxsJpGNi
         ATOohXIQ0ecaM3+8ABPtlXyhOb/ytuD3rR7uEne8so24QyUvPHPRWyX6iJHNSxMH+Px5
         EIPQ==
X-Gm-Message-State: AGi0PubffIccEy4JiwF4qcUpgRc7FnWsuEQazgltF4DeB8/UAgLGRd84
        p9kGyQHM9poY++cICsK5hAfwccDy3qtX8KxNkkdeglLms1z0
X-Google-Smtp-Source: APiQypIJ3E46KuEnE+e2QTkr/FvlYted4kADS5RZaWPImSV2/Q7w4dG+0q4dvns60lBZ6mieeCONw10hVN4u0453OWg03tYi2w0b
MIME-Version: 1.0
X-Received: by 2002:a5d:9dc7:: with SMTP id 7mr3984559ioo.109.1586293684848;
 Tue, 07 Apr 2020 14:08:04 -0700 (PDT)
Date:   Tue, 07 Apr 2020 14:08:04 -0700
In-Reply-To: <20200407204754.GA66033@xz-x1>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000984d3705a2b9c7ce@google.com>
Subject: Re: WARNING: bad unlock balance in __get_user_pages_remote
From:   syzbot <syzbot+a8c70b7f3579fc0587dc@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bgeffon@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        peterx@redhat.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+a8c70b7f3579fc0587dc@syzkaller.appspotmail.com

Tested on:

commit:         763dede1 Merge tag 'for-linus-5.7-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b9ca0b4c36cd4da
dashboard link: https://syzkaller.appspot.com/bug?extid=a8c70b7f3579fc0587dc
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=122c0e1be00000

Note: testing is done by a robot and is best-effort only.
