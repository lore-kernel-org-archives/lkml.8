Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3EEC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 03:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F06E24655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 03:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgAVDUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 22:20:02 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:56700 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbgAVDUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 22:20:02 -0500
Received: by mail-io1-f70.google.com with SMTP id d13so3129468ioo.23
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 19:20:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Q+V6MdfziKIz0rbDvk/UXGQIlbKYZGAYXmvHdG0XHko=;
        b=PEVOtkKF7wPs5qYAPRYRfDqKeqknz+AgbyiHIMQ8H/ZdkrpK0eTe9VwXhVyve0lzSU
         Qcaoss3yYTz9Dr6IZGdhX+xr6g+hKvyARXIVOZA5rwhsZ9bwY+j5K51fadBSnvqdIOqU
         dPLa3GCh5JnGzohFAUCLz1zSiyDY2jk6CaEsyJJ8g8dxUO1eSVpmX4yuy7SHrpe7+4TL
         BbPqXlzV3lFXANjmgJE/lUs+CD/TL+PGbu2aeQXNRh8Bw44QB8zseyKHluaUFGJO8kU4
         605m273TRHSud9yfqzQQvs17TVhvgUfsvwQl7MMeIwbpyCI4LnKVt20Kc22Bi1BBwLzm
         paOA==
X-Gm-Message-State: APjAAAX3L7eVSLMCmXFPA+6vzMeVqoIHqMV1xKk2Bfc+ms8TP6Nvnk/z
        1Rp2QPvgZJL8Qox3+xVUxXSyTBarvpb3ucrUtj3XpOhmLdjE
X-Google-Smtp-Source: APXvYqy+uydHS2wj8B3br4rKAZaNttmqlZ2vOJL3KADXaffFC3CoRkqx64UrmHbPL/Z+BdkU6gah06YpVkq7VIafjd3pXuRhagi3
MIME-Version: 1.0
X-Received: by 2002:a92:860f:: with SMTP id g15mr6227655ild.297.1579663201195;
 Tue, 21 Jan 2020 19:20:01 -0800 (PST)
Date:   Tue, 21 Jan 2020 19:20:01 -0800
In-Reply-To: <000000000000310afa059cabd024@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8dfac059cb1ff9b@google.com>
Subject: Re: WARNING in cbq_destroy_class
From:   syzbot <syzbot+0a0596220218fcb603a8@syzkaller.appspotmail.com>
To:     davem@davemloft.net, echaudro@redhat.com, ivecera@redhat.com,
        jhs@mojatatu.com, jiri@mellanox.com, jiri@resnulli.us,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit d51aae68b142f48232257e96ce317db25445418d
Author: Jiri Pirko <jiri@mellanox.com>
Date:   Mon Nov 27 17:37:21 2017 +0000

    net: sched: cbq: create block for q->link.block

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12efb80de00000
start commit:   80892772 hsr: Fix a compilation error
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11efb80de00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16efb80de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9290aeb7e6cf1c4
dashboard link: https://syzkaller.appspot.com/bug?extid=0a0596220218fcb603a8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f107d1e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12114335e00000

Reported-by: syzbot+0a0596220218fcb603a8@syzkaller.appspotmail.com
Fixes: d51aae68b142 ("net: sched: cbq: create block for q->link.block")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
