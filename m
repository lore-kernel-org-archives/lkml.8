Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD73C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89B9920857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbgEAOtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:49:11 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:40757 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbgEAOtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:49:06 -0400
Received: by mail-il1-f198.google.com with SMTP id k5so5036190ilg.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 07:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Jh5jVpDHfQplZhcaNyu6KjtSKvR1Mtv8UVWG8cYmvgs=;
        b=MTUqMFpJ6PgdZgxVhGvJcEJeXVfnjdFKXI1LbIUKQ+kwCb2c8uyngl4ORJaZGrz+4d
         o8fq1zxVNhtTwBmQiqfCXLoY/N5HiXWST0+Yzymewr+gPoX4u2alXiRVHJDF8k11Y4FC
         SYbBaBnCIcz4RiCt/t4gA9w/uIxisBjnQIDGIJD4090CQ6750+khEqqGdWdIC5pSbT4G
         txW9CT8U40kpQ1LWZdpQDM1XtgB0gKjnnfzckd3U0DubjRVeA4buNPLvntzEhwA0KCee
         FUwf0WxYQaCUk+KDfeoPNFvXqMnfQoFiA4C4WQrt2puyl2HlC07oUXzq4gIo3fV082sg
         ULZQ==
X-Gm-Message-State: AGi0PuZPSZtoUphuTxqEvie5CYgGye/SNGuCuimSe0BQaky3JGK3yGEP
        HGqikXzSYzqV0uVDbfOkmIcts6dtzduRj1pQ6XyQfuhamKtB
X-Google-Smtp-Source: APiQypLK1R32YygzKw6o+zrjKt0GIokFgX8oowRX0+5I/s/40LhWT/hwtwkehxiJ47ijw4bdIgcKya/AdAIK2f7+ZiLlGEbjeIlX
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:dc3:: with SMTP id l3mr3777413ilj.149.1588344543764;
 Fri, 01 May 2020 07:49:03 -0700 (PDT)
Date:   Fri, 01 May 2020 07:49:03 -0700
In-Reply-To: <00000000000052913105a4943655@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004fe61505a49748ee@google.com>
Subject: Re: KASAN: use-after-free Read in inet_diag_bc_sk
From:   syzbot <syzbot+13bef047dbfffa5cd1af@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net,
        john.fastabend@gmail.com, kafai@fb.com, khlebnikov@yandex-team.ru,
        kpsingh@chromium.org, kuba@kernel.org, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org, zeil@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit b1f3e43dbfacfcd95296b0f80f84b186add9ef54
Author: Dmitry Yakunin <zeil@yandex-team.ru>
Date:   Thu Apr 30 15:51:15 2020 +0000

    inet_diag: add support for cgroup filter

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106b15f8100000
start commit:   37ecb5b8 hinic: Use kmemdup instead of kzalloc and memcpy
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=126b15f8100000
console output: https://syzkaller.appspot.com/x/log.txt?x=146b15f8100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1494ce3fbc02154
dashboard link: https://syzkaller.appspot.com/bug?extid=13bef047dbfffa5cd1af
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12296e60100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150c6f02100000

Reported-by: syzbot+13bef047dbfffa5cd1af@syzkaller.appspotmail.com
Fixes: b1f3e43dbfac ("inet_diag: add support for cgroup filter")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
