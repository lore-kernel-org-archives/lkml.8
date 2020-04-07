Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242F5C2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A4A20719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgDGJbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:31:04 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:55251 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgDGJbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 05:31:03 -0400
Received: by mail-il1-f198.google.com with SMTP id m2so1115080ilb.21
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 02:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9ecQ8raBwV+ql8FB6mKArZB1484qcIdZc1keMaK2jMc=;
        b=Y2tJqHbf/zSITczatjJXsMWemsvJd6fWCL7vujvGXBo3mGc9c4ofpNeo9b+Rp4nBcJ
         NbpEjFyY16ZhR+lJdqFukOzPqQIApAI0IPJWFmndY8CJVYJzBmfw+BObNw3UYYpIfpGq
         KRmqOkTSijdl37Oct0V88I1PLjwZHV2PPaqtxsOxx5s1QPixRhHD0sxXAuiuQc4NkuXK
         BLTRtSNrWo0whwqF7eABHJh3tRNwBBxM+b5HHBIbPxv/8qV9yFOyEvkwdtEbPxw6Kcir
         JaCOIK3C+J8g0Cs4S9n0aBSxuRwDq+um+Aeghr1qW3af4JUIiGyZ4x8IOAx2aezwjy/U
         U93w==
X-Gm-Message-State: AGi0Pub6zBYc9Bpt0wVRvk+XIypTsOkJ4nBBRbwX6tg2UquphPDP4kA9
        qZyHOEcHXp9FfpZDaNSkn2CiIq8viuJ4V+4J+gb6c/GN6PiV
X-Google-Smtp-Source: APiQypIVR59kn7drjOvrJ37LHlH0A1TQqNo5AIe8adfVvVA7j+43yXTNPKQq6cEndGOflU7+5OFZ9Q/tarO/p/azAPJ9AMzyiuAb
MIME-Version: 1.0
X-Received: by 2002:a92:498e:: with SMTP id k14mr1290576ilg.160.1586251862658;
 Tue, 07 Apr 2020 02:31:02 -0700 (PDT)
Date:   Tue, 07 Apr 2020 02:31:02 -0700
In-Reply-To: <000000000000f59ac305a25cfa14@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc522f05a2b00ad5@google.com>
Subject: Re: possible deadlock in io_submit_one (3)
From:   syzbot <syzbot+343f75cdeea091340956@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        allison@lohutok.net, areber@redhat.com, aubrey.li@linux.intel.com,
        avagin@gmail.com, bcrl@kvack.org, christian@brauner.io,
        cyphar@cyphar.com, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, guro@fb.com, joel@joelfernandes.org,
        keescook@chromium.org, linmiaohe@huawei.com, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, mingo@kernel.org, oleg@redhat.com,
        peterz@infradead.org, sargun@sargun.me,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 7bc3e6e55acf065500a24621f3b313e7e5998acf
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Thu Feb 20 00:22:26 2020 +0000

    proc: Use a list of inodes to flush from proc

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b3c9c7e00000
start commit:   7e634208 Merge tag 'acpi-5.7-rc1-2' of git://git.kernel.or..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11b3c9c7e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16b3c9c7e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12205d036cec317f
dashboard link: https://syzkaller.appspot.com/bug?extid=343f75cdeea091340956
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105d592be00000

Reported-by: syzbot+343f75cdeea091340956@syzkaller.appspotmail.com
Fixes: 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
