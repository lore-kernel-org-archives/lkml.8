Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9030FC433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA2320658
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgHOWau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbgHOWan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:30:43 -0400
Received: from mail-io1-xd48.google.com (mail-io1-xd48.google.com [IPv6:2607:f8b0:4864:20::d48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BDBC0045B7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 13:03:06 -0700 (PDT)
Received: by mail-io1-xd48.google.com with SMTP id k10so7851410ioh.22
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 13:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GL4DVB34UG1iqD0+jY4irCmmCEbZL1uTh6mw9vlItmk=;
        b=K+0zPQau+AVLJdRVdghWc6Ox5tbjbIc7ve8BHAlkllkGrbCT2WLUKZfzxMMHANucgv
         cHJ68z/3GqpUstAauB38JY7cqAR0UFP/DZ+zPMJUZnjgIxVkDYzbtkjZqe94jXQVVokP
         v1X6vRpJPHJbny0HBHS9ATRsz8ZrJzWRxSWlk49WdL0ejNsw+R25BQtxOWeirgBljovA
         ++XVEe1CtsPuzx51AahBxOqhLEQ3I/qRREtYnUeafjnBtl0lkGjngCDlFhAgdF60DaL4
         n9bP2f/67bqPQBJRDbbLdumIF+3MhWUqEgLh+KE/kiaBOWAI5fo5kylHNGvai6/L+8hY
         wXvA==
X-Gm-Message-State: AOAM532kD/SCuPxTZIqN9pSA3jfWFkHqfnHJ3qrl6+y5JRY5VMtJCCMR
        lUx9WjN4F+M/snyI+S+hpj/s/O5e5XsozG1XuvQmSiOhRtSO
X-Google-Smtp-Source: ABdhPJwdTmBisU2wAY2tIbzM3sMi0k8roJATOzeZ3Cok9bb17JPYOxx0ftj7w2o6tEV0k/n7ffBFf8rJeLR+Tlx+Ol4cIbF5UNVl
MIME-Version: 1.0
X-Received: by 2002:a92:354d:: with SMTP id c74mr7061356ila.27.1597521785710;
 Sat, 15 Aug 2020 13:03:05 -0700 (PDT)
Date:   Sat, 15 Aug 2020 13:03:05 -0700
In-Reply-To: <00000000000077346605a5a70a32@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008eef2f05acf006f8@google.com>
Subject: Re: KASAN: out-of-bounds Read in pebs_update_state
From:   syzbot <syzbot+45862e7027be5d590577@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com, bp@alien8.de,
        daniel.vetter@ffwll.ch, gregkh@linuxfoundation.org, hpa@zytor.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp,
        penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 033724d6864245a11f8e04c066002e6ad22b3fd0
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Wed Jul 15 01:51:02 2020 +0000

    fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12ed4181900000
start commit:   e99332e7 gcc-10: mark more functions __init to avoid secti..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a96cf498e199d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=45862e7027be5d590577
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17bb1714100000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
