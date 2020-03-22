Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE93C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 13:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FB3206C3
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 13:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgCVN3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 09:29:04 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:50590 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgCVN3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 09:29:03 -0400
Received: by mail-il1-f197.google.com with SMTP id z12so9873965ilh.17
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 06:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jmLK9Nx0sV4n9spz6FizKEO/UiXLat+guCFQpWcvF0A=;
        b=nIHLanqxfFtC1PS3iPFVX/B1DK4Ran97mBco2Ai+HQ7846UYyQmEx4eR3I0JNRoj/3
         YTB5W7qC4vCDAkbADNJ7LoT5ICgjsjyTfof+HK6G7V5HDUmtuhgezy9iSnmaM6TSHkU6
         bV5+YfO4OXUk31bAVHjuf4Qvh463M14ldMLNtIdJGuKt5o6wuU3GGvHWbf103aIvFRpH
         QxbgBYwtYcii5HvxknVWU4y85S0bA6a2YXWB9J719P6tekrA7YdSUbuyRZyBnKIogIhI
         fhvWJD0NlTad3pBNXfqM4EiMJbwpkKhUvHmyjcpwmz1fKYWkhDTzZumswieP98ERUmkp
         1vqQ==
X-Gm-Message-State: ANhLgQ3i3SyyW7e/gxc1m0HOEzCMcZpL5QpAgUH0KBOpXHy4hkIW2BKy
        4shyasJsxE9wupZ48p6X489ERPNEDFIuAAhGbyKqN4f6QzEk
X-Google-Smtp-Source: ADFU+vuxGqce5HdcWsT4uwnV72WS992615JlGUhT5JCgdY61XjgcaVQW8M8Cui/rAj31oWjxi4kC07HBUM/mm6t6pOUvYSxhRcSr
MIME-Version: 1.0
X-Received: by 2002:a05:6638:398:: with SMTP id y24mr5155770jap.125.1584883742893;
 Sun, 22 Mar 2020 06:29:02 -0700 (PDT)
Date:   Sun, 22 Mar 2020 06:29:02 -0700
In-Reply-To: <000000000000277a0405a16bd5c9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008172fe05a17180aa@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in handle_external_interrupt_irqoff
From:   syzbot <syzbot+3f29ca2efb056a761e38@syzkaller.appspotmail.com>
To:     bp@alien8.de, clang-built-linux@googlegroups.com,
        davem@davemloft.net, dhowells@redhat.com, dvyukov@google.com,
        hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kuba@kernel.org, kvm@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, netdev@vger.kernel.org, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit f71dbf2fb28489a79bde0dca1c8adfb9cdb20a6b
Author: David Howells <dhowells@redhat.com>
Date:   Thu Jan 30 21:50:36 2020 +0000

    rxrpc: Fix insufficient receive notification generation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1483bb19e00000
start commit:   b74b991f Merge tag 'block-5.6-20200320' of git://git.kerne..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1683bb19e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1283bb19e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6dfa02302d6db985
dashboard link: https://syzkaller.appspot.com/bug?extid=3f29ca2efb056a761e38
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1199c0c5e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15097373e00000

Reported-by: syzbot+3f29ca2efb056a761e38@syzkaller.appspotmail.com
Fixes: f71dbf2fb284 ("rxrpc: Fix insufficient receive notification generation")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
