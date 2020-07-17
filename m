Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C86DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8213B20775
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgGQWkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 18:40:05 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:51194 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgGQWkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 18:40:05 -0400
Received: by mail-il1-f198.google.com with SMTP id l17so6330358ilj.17
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 15:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=bZyN/zZkAna3AuJV7mJCywjPBma23V/L6XGmPytQX3g=;
        b=ufSF/DEoadiFJmRuAGKQgEbTwBNj0V1AT7bUamaiCLFdGMBLW+M1rIR8/CZ9JAekp2
         jlmxnzvSXktYRlNPyxMsae4R0+kI/U1XRj1Z2ci/HR8pmON3HdgEJz8eo+7z96EnfWU7
         MTsnJ2WJ3euzyDwoeMqVVZO5TjU3dT6IC/MLLlM67em/+w5lzHV73fku6Y4PXXlhFPwn
         IkUovySBRLVMRjP+fhDLvCdJiJ99VZhY2JZ2o7Vys3Kknq9lLba2IdIgsyShqe3Bm2hz
         WwtGorqxyWGZom6F7lycunGnG3kBfOERBHpGfAQnzIi7YroGHFLxqVGlqspnuSUMZAS0
         1oIA==
X-Gm-Message-State: AOAM53213ndztrCcqsnP5KrtaffESKU6q+5UuBCOkXeRSY4XXgfXufko
        gtWDLlltAxXmM6IC/wgZm0MbuNWUR9cAeRaTt4NXoLDjvAQY
X-Google-Smtp-Source: ABdhPJxLi7/gPDf4MlcBV9h1ItF5n6fCkgiWG0/+rbnSHUtonUG5WWXjJHmQs62JK8/EaZk4B+A2cmhJTAcbiYpEg6/zYnrU6Ale
MIME-Version: 1.0
X-Received: by 2002:a05:6638:dcf:: with SMTP id m15mr13454918jaj.86.1595025604135;
 Fri, 17 Jul 2020 15:40:04 -0700 (PDT)
Date:   Fri, 17 Jul 2020 15:40:04 -0700
In-Reply-To: <000000000000358aec05a9fc8aa8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ad07505aaaad631@google.com>
Subject: Re: general protection fault in khugepaged
From:   syzbot <syzbot+ed318e8b790ca72c5ad0@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, william.kucharski@oracle.com,
        yang.shi@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit ffe945e633b527d5a4577b42cbadec3c7cbcf096
Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Wed Jun 3 23:00:09 2020 +0000

    khugepaged: do not stop collapse if less than half PTEs are referenced

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17356c2f100000
start commit:   e44f65fd xen-netfront: remove redundant assignment to vari..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14b56c2f100000
console output: https://syzkaller.appspot.com/x/log.txt?x=10b56c2f100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=829871134ca5e230
dashboard link: https://syzkaller.appspot.com/bug?extid=ed318e8b790ca72c5ad0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113406a7100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=175597d3100000

Reported-by: syzbot+ed318e8b790ca72c5ad0@syzkaller.appspotmail.com
Fixes: ffe945e633b5 ("khugepaged: do not stop collapse if less than half PTEs are referenced")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
