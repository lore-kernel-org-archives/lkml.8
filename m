Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5204CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3022B20643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgERM2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:28:08 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:54918 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgERM2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:28:06 -0400
Received: by mail-il1-f197.google.com with SMTP id j69so9639446ila.21
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 05:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/UaoSKuEg7BgmQIEUODx1VNqxB3FUarTMqVlwdmdwdQ=;
        b=nF951jTjwnzKypaEOQiGomujsWU4RM71AtpSft0gGwisERiObHsN/w/n7wXjGgAvn7
         pGn9iq6wX5Kzpsr2pRMxez+cs/gW+ZoTUAqzhjDBiCEPP4zGjhKLURAN0W0/E5ozVc3T
         piO0D9bR9eRyjgtycf7Y6eQqq1/iaGVRKc1F+JF5yJRewwGvRZlXATnWRJbLlVeZ7fsb
         yLP4hiLKkkBC0MZ+IgN/LLFZqrg5KUljE+4LAUY76lNm4OlUADRTUF+Jpv5Yzo2tcIky
         Oq+2P/5vGZIcwHvbW1TUIOSTOVYA9Llcmv2Va7q6CEy84FUKw7q+dg8AEaasNQTpjrWn
         Qcuw==
X-Gm-Message-State: AOAM532rk8e/2IcRYJCSuXTivRZwQx01YC0aPfrj9G/ISC8orhiFGRsY
        592eu21pOVSM742lSx5Iul/KgmA24XgbxJ4EC+FNpyTfdGiG
X-Google-Smtp-Source: ABdhPJxkBXNmIdsvsy/8YA3Op0IoHRuKNDhs6dRsom9/LIy6f2/gjKuMzC0g8/WxId+iZPkY72GepOClyDlw7dzo+ODBcds/NPKb
MIME-Version: 1.0
X-Received: by 2002:a05:6638:bc4:: with SMTP id g4mr13605771jad.55.1589804885154;
 Mon, 18 May 2020 05:28:05 -0700 (PDT)
Date:   Mon, 18 May 2020 05:28:05 -0700
In-Reply-To: <000000000000ada39605a5e71711@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071203205a5eb4b43@google.com>
Subject: Re: BUG: Bad rss-counter state (4)
From:   syzbot <syzbot+347e2331d03d06ab0224@syzkaller.appspotmail.com>
To:     a@unstable.cc, akpm@linux-foundation.org, ast@kernel.org,
        b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net,
        dvyukov@google.com, jbacik@fb.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mareklindner@neomailbox.ch, mingo@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org,
        songliubraving@fb.com, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 0d8dd67be013727ae57645ecd3ea2c36365d7da8
Author: Song Liu <songliubraving@fb.com>
Date:   Wed Dec 6 22:45:14 2017 +0000

    perf/headers: Sync new perf_event.h with the tools/include/uapi version

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13240a02100000
start commit:   ac935d22 Add linux-next specific files for 20200415
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10a40a02100000
console output: https://syzkaller.appspot.com/x/log.txt?x=17240a02100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc498783097e9019
dashboard link: https://syzkaller.appspot.com/bug?extid=347e2331d03d06ab0224
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d18e6e100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104170d6100000

Reported-by: syzbot+347e2331d03d06ab0224@syzkaller.appspotmail.com
Fixes: 0d8dd67be013 ("perf/headers: Sync new perf_event.h with the tools/include/uapi version")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
