Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3370DC3F68F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 07:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A61820716
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 07:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgAZH0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 02:26:02 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:56611 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgAZH0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 02:26:02 -0500
Received: by mail-il1-f198.google.com with SMTP id i68so5137003ill.23
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 23:26:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=d0EAYYoFJs/j+ol20aGJxzlCRa5xPQMsZhQpp42dXF8=;
        b=YyZWZIykv4lM/zXp9umNGjznnPd3HlPJCx//CGgAu02An/zch8PGWiTlrnL0ZcbDVq
         Mo0UOJ14baZ6Q6q6KjqQiDu1C0oYDaM+lEmHaE9GYwfth/xmLPwAxlftaNlEsX4lTfVp
         oh65TwiYIjgk49Ax59IILHKto4/fTp38TXKy/75Hj9TH/zqcNcMszt1L6urbnxlWRpPn
         1FGUalRLte9B42oJ9eHjWDTVZikVbx9C2wXPGH6IfOvPAb6opSkguPcSQZT/LjgW626i
         d7M2Uzd9SdRBzStVB8xqarbqoXe3Miq2AeoS2Mz5dj5BS4dSCWIRMFqt2dN0cit4ojgB
         tm/w==
X-Gm-Message-State: APjAAAUZJAslQoa+eOkbiSovjcPSTum1edAU/hCpVIALeLx2S0a563rr
        8Dbc1oE3De6Er5GHFYegKnfi6X7C1BKpqZPCQjKBOg/RX57B
X-Google-Smtp-Source: APXvYqzP4/VEkdgFaSon67FgAjDduMDSjqndowqxJ0Wgxs/rNFlUGTPeaIFZks4U9WerRYsiCmp64bVGDtHXk327djrJdL8dA5Tn
MIME-Version: 1.0
X-Received: by 2002:a92:85d2:: with SMTP id f201mr9111770ilh.45.1580023561398;
 Sat, 25 Jan 2020 23:26:01 -0800 (PST)
Date:   Sat, 25 Jan 2020 23:26:01 -0800
In-Reply-To: <000000000000466b64059bcb3843@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d2faa059d05e738@google.com>
Subject: Re: INFO: task hung in hashlimit_mt_check_common
From:   syzbot <syzbot+adf6c6c2be1c3a718121@syzkaller.appspotmail.com>
To:     aarcange@redhat.com, akpm@linux-foundation.org,
        coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        kadlec@netfilter.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 7ddd8faf4399ab4f4edad5604eab35f8a87caf02
Author: Andrea Arcangeli <aarcange@redhat.com>
Date:   Fri Oct 13 22:57:54 2017 +0000

    userfaultfd: selftest: exercise -EEXIST only in background transfer

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=175625c9e00000
start commit:   8f8972a3 Merge tag 'mtd/fixes-for-5.5-rc7' of git://git.ke..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14d625c9e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10d625c9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9290aeb7e6cf1c4
dashboard link: https://syzkaller.appspot.com/bug?extid=adf6c6c2be1c3a718121
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ea2559e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ffc8bee00000

Reported-by: syzbot+adf6c6c2be1c3a718121@syzkaller.appspotmail.com
Fixes: 7ddd8faf4399 ("userfaultfd: selftest: exercise -EEXIST only in background transfer")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
