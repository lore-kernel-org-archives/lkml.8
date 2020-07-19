Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80621C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 11:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E364208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 11:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgGSLSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 07:18:09 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:34517 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSLSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 07:18:08 -0400
Received: by mail-il1-f197.google.com with SMTP id y3so8950972ily.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 04:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=VyO5STFmnVvO9DvN7eCLqjZBvvoFWMGC3SxiQbso7po=;
        b=ifpB3RbrNLoLD6X3125WEtLxNIRtF2vPqzAHiVrtLw0GOJjiHgNecnjCHBk2e2C/zY
         SSxa7Zhvi+6/V7EtcYJohPs54y01SOvO9IWhuFJsxDpXCAA6z8jw+PIDrtquJiHd79pl
         9qBim26rSxPpbt4Rv6vx1Jb5Z8purl4g6hBkbVtGlQGq3LfKDYHwX7Qid42BQGuZwla1
         sR+e6QP7D21f/F91C7pMkqfpr9CEtw4dQTztRk2o9AHrjxUg7q2Re/sqP0BF8874KEef
         5igDhswoTqTbre5FFv9YHg1v20BOa9K2vClpgk7rCZbHyL3CxoAKgRXxy/Pzt8FD8VWy
         x05g==
X-Gm-Message-State: AOAM5332zOpWCm8aMiZ0KYPcS893/FhScHNVtjN8Bx39KJLEmUma75Gs
        SKPQILx8KhSiTPxXXMp8lC+O6hnHbYNifGpxT7u3K8tLlWAC
X-Google-Smtp-Source: ABdhPJzN017k94AQ4JkwHlIiCPM6i7N8XKcvfwgy3aNk8yE7/wZ8vtYocUkUUv41lSt8g45qQwCeZF6Sahc4C+Lvrm1HNhfd3B+A
MIME-Version: 1.0
X-Received: by 2002:a92:d48a:: with SMTP id p10mr18445285ilg.230.1595157487462;
 Sun, 19 Jul 2020 04:18:07 -0700 (PDT)
Date:   Sun, 19 Jul 2020 04:18:07 -0700
In-Reply-To: <0000000000009f4ecd05a9d4dd9f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066afb205aac98b9d@google.com>
Subject: Re: INFO: rcu detected stall in iterate_cleanup_work (2)
From:   syzbot <syzbot+cc8495ea4052b9b79b72@syzkaller.appspotmail.com>
To:     Markus.Elfring@web.de, davem@davemloft.net, hdanton@sina.com,
        jhs@mojatatu.com, jiri@resnulli.us, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vinicius.gomes@intel.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Sat Sep 29 00:59:43 2018 +0000

    tc: Add support for configuring the taprio scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=141ed087100000
start commit:   cd77006e Merge tag 'hyperv-fixes-signed' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121ed087100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7be693511b29b338
dashboard link: https://syzkaller.appspot.com/bug?extid=cc8495ea4052b9b79b72
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e567e5100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126ffccd100000

Reported-by: syzbot+cc8495ea4052b9b79b72@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
