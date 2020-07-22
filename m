Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047EBC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7CC20771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgGVGRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 02:17:05 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:51057 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGVGRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:17:05 -0400
Received: by mail-io1-f71.google.com with SMTP id a6so263002ioh.17
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 23:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=YTJNkn3K0lAu0WfnfaHPX3yGOM5dq4p5kCQOwP1l3BA=;
        b=NneFn5qj5T7kVcDW9UrLjkPW/Oj/LsVL1EJv/lTEARoZJ4yWFWrUmYs0xGpC2ogQZ/
         Jqu+8JMGs/JmyqjS1YEc5IpEnLWN2pU756W6hCT0VMVePbRsoWnwmwgoHcNUaiNga+xY
         EBsSaOsN5dfybF2T+5BcbmI+IdzeikMaNVHIKagz/DbMlzJmMmS3Otxohdo/VbX2E8mC
         PGq2XVC6+YqS5CJn6hUQ1mIF36xvfBjlkFK9pta5mlkMRSZ3KG6MLRKYoXWwSE7dxH5w
         0Ry6nWePO0IdUjHD2cVxYeOzniEPDSpxsigvc7/7lbZPylxsjcp7ufNeuRXOJ7L0N7BE
         0pyg==
X-Gm-Message-State: AOAM531QGs6tSlCTKPaplsqPuyfhyy7Up2uNyYGbvKft8Dcr5DXiXTc0
        x0Jffo4t7Znu3lqjbfN5Wq57PJeXp0eCUJt6iiC+zIHVz4tk
X-Google-Smtp-Source: ABdhPJxk0Y02K0zpjpX1xDkj+BoB+WbLeh05UfRV4WWg+C/g//EG61rZD9A7SbhdSh2JwvW0cZwyEkXlBwPgpj+TPPEySnEIJzHJ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:961:: with SMTP id q1mr29247314ilt.94.1595398624111;
 Tue, 21 Jul 2020 23:17:04 -0700 (PDT)
Date:   Tue, 21 Jul 2020 23:17:04 -0700
In-Reply-To: <000000000000588c2c05aa156b2b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043f09405ab01b0b8@google.com>
Subject: Re: kernel BUG at mm/vmalloc.c:LINE! (2)
From:   syzbot <syzbot+5f326d255ca648131f87@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        mingo@kernel.org, mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit bdbfb1d52d5e576c1d275fd8ab59b677011229e8
Author: Ingo Molnar <mingo@kernel.org>
Date:   Sun Jun 7 19:12:51 2020 +0000

    Revert "mm/vmalloc: modify struct vmap_area to reduce its size"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=166e6b7f100000
start commit:   ab8be66e Add linux-next specific files for 20200720
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=156e6b7f100000
console output: https://syzkaller.appspot.com/x/log.txt?x=116e6b7f100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4bf77d63d0cf88c
dashboard link: https://syzkaller.appspot.com/bug?extid=5f326d255ca648131f87
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151192bb100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d7a873100000

Reported-by: syzbot+5f326d255ca648131f87@syzkaller.appspotmail.com
Fixes: bdbfb1d52d5e ("Revert "mm/vmalloc: modify struct vmap_area to reduce its size"")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
