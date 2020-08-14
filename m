Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE4AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 294DA20885
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgHNW7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:59:08 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:53505 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgHNW7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 18:59:07 -0400
Received: by mail-io1-f71.google.com with SMTP id f22so7019162iof.20
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=26hWQC191k0LtuaZdSkVmfh/7oglcND6lOLk0CrAyjg=;
        b=UatOcHi7n79hFt1G7RmTMMiiUEi813NimJS0PEimvCv5pWmv+NvDMGzYoZs8cTdRlV
         mTuio5g7pdqnff3vSf7IqNJR4GDfQ3ZuDr0Dih0xZxTL90b88IdUgHDm92bu5War3o+s
         ckv6CV3sWD2u1KG2wX3tPFaN9FWVQZv7/9VgH4Lj5VkBjX91aXUwiLZHvZz/NFnUuTxT
         8pAufABpJwhUAzOYrgkdT98WCXr6Yke9HfXNzTQLrAepT5WlgY8ga23HEuAmjfKIf9n+
         XU2b7Y0Cv/n3dnilNZfe4U8wZPcofloq+gCJ9GUGNI9m8pDswhBP4MWuvINDayaqGpf0
         Xj4Q==
X-Gm-Message-State: AOAM530HSDS86ebxTxnOQHn+PYSN/aPTVqe4db8WYQVAbWH1iN4w8gHq
        Dcyf/tQYd76VsPDGDZQ4GDAPBjVSs20a0q6K7RR7VdOTxS+g
X-Google-Smtp-Source: ABdhPJypLHX9dDgEVGPD3bwTWaZvyk4HCc9VC0CCoMFtyaW6XMVYLFWi6Q4yAOt+dOK2FInhgOit9VdtS0K9OXDQNFwAB7SvoEdS
MIME-Version: 1.0
X-Received: by 2002:a02:6903:: with SMTP id e3mr4870665jac.142.1597445946590;
 Fri, 14 Aug 2020 15:59:06 -0700 (PDT)
Date:   Fri, 14 Aug 2020 15:59:06 -0700
In-Reply-To: <000000000000c770710586c6fc92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031c95f05acde5eda@google.com>
Subject: Re: BUG: unable to handle kernel paging request in free_block (5)
From:   syzbot <syzbot+438a5abd4f53adb1c073@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, jmaloy@redhat.com,
        jon.maloy@ericsson.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 1378817486d6860f6a927f573491afe65287abf1
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu May 21 18:29:58 2020 +0000

    tipc: block BH before using dst_cache

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1537694a900000
start commit:   e6986423 socket: fix compat SO_RCVTIMEO_NEW/SO_SNDTIMEO_NEW
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fb64439e07a1ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=438a5abd4f53adb1c073
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12adddbf200000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: tipc: block BH before using dst_cache

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
