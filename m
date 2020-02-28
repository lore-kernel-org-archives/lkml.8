Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76772C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BEA24695
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgB1ICN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:02:13 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:52162 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgB1ICM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:02:12 -0500
Received: by mail-il1-f200.google.com with SMTP id c12so2508842ilr.18
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 00:02:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=1F6QPB2AKxQKkbwngYuex+ythgWDXEu9f8wBzkprX/k=;
        b=ohlbLW5FcRvCT8G5h0zIW2yJJiY/fHWDQr9CLxV2AY+iHobjzW+fI1O0+guWCtdmSX
         7s2O1a4xA+tjrdA45szNpwXJd8nUe/kZ3ym7Hqr4mIg4NSMeCTUz8R1yKAuWBnV+1DnQ
         sB3gLB0gZuLz8jJnIkdpTHO3UUg9A/SxnIIsT/wPTY9f4WO5Rxcpogds9JOoqXeWQceT
         AHPmi5kuyjAFq77U/MrtnN6VIRo0NwWvA7/tSVXNvcVXMbZbONbpTpsB3KM/PN1Nfw4k
         ahBtc6vgDmvTNoTOD3JX6kifb2XOA9OYuAAHMfeqTUVteciMS92JDebvzR9XNglaDiVY
         gzEw==
X-Gm-Message-State: APjAAAVfxuaQ0n+8sPGObKq+PBfG6IzdNHNrOys/nqtTWO+0O0xBw7F9
        X1fXATUkM5DCyvO6RxKEGTJybnwoXPDnoHb+bKDAgS8nLOvj
X-Google-Smtp-Source: APXvYqxZ9gEkMkdQklGzMnNVCnk+p9vHrNJcx3ZgSr4fyoEdO9KrfufCKBEV6C7rY7YOdZ1PYafI/aStyzaxESHVe4uOP8/zThGl
MIME-Version: 1.0
X-Received: by 2002:a02:9988:: with SMTP id a8mr2420608jal.33.1582876931843;
 Fri, 28 Feb 2020 00:02:11 -0800 (PST)
Date:   Fri, 28 Feb 2020 00:02:11 -0800
In-Reply-To: <00000000000080f1d305988bb8ba@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003eeb63059f9e41d2@google.com>
Subject: Re: BUG: unable to handle kernel paging request in ion_heap_clear_pages
From:   syzbot <syzbot+be6ccf3081ce8afd1b56@syzkaller.appspotmail.com>
To:     arve@android.com, christian@brauner.io, devel@driverdev.osuosl.org,
        dja@axtens.net, dri-devel@lists.freedesktop.org,
        dvyukov@google.com, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, kasan-dev@googlegroups.com,
        labbott@redhat.com, linaro-mm-sig-owner@lists.linaro.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        maco@android.com, sumit.semwal@linaro.org,
        syzkaller-bugs@googlegroups.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
kasan: support vmalloc backing of vm_map_ram()
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
