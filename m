Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A08C35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 04:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F24F222D9
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 04:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgBHEGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 23:06:03 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:47474 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgBHEGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 23:06:02 -0500
Received: by mail-io1-f72.google.com with SMTP id 13so1036097iof.14
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 20:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=YdmzA7D11PRTJN9WOgeGykpVtC5L5hrmQEgxtcYNPyo=;
        b=V73AymHPsIMaEVdvT2xpscl4eYK0G9mmQ60D/glIIp0RRoEgw6JS+82UrqKCntjA3e
         tX6gJNp9w7XhSc3fcFaNOycQJ8f4TUPRPgWRHJvpgwfuzTvCCGVL9HKHanLGje8/9/fK
         Eh5Vd2FTwAVStq1HxkAuR4uQ7koV0VLF4Tmo1Ybz8e7p0U7vk4EJw6VRXNiG+U+IZFJD
         PURpae4RiKrFPu6I+EwyE/b+5ev2flCpnrn0e35ys+5WUWNrDZhEuMXsfen7OYsYSn9B
         65pZhuGUDLs2GdPpC1n4me1uw5vf1COszmWxEsosuX+7T59f54V15TsS4iv3vs3OVQUP
         t9aQ==
X-Gm-Message-State: APjAAAWcVSUfFA8zU57v8EF9qPTKjx1vnCx4Jfpcm3nqahmFM/Eoe19F
        caDxq/nTVkrp+QgAhVO8SWETNqZsbjoGvNyW4j8uKA4zMXJJ
X-Google-Smtp-Source: APXvYqx6+g7SHOZaaddW/1HIQIDO4JPcYx9LGs3vtbUQW2sQVYO85DabjDjhW9x29TzuvSOjB3EzxFCGFghJ6FpaAZ4nvi+3pD+q
MIME-Version: 1.0
X-Received: by 2002:a6b:92d4:: with SMTP id u203mr1503471iod.288.1581134761739;
 Fri, 07 Feb 2020 20:06:01 -0800 (PST)
Date:   Fri, 07 Feb 2020 20:06:01 -0800
In-Reply-To: <000000000000861441059e047626@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0cac6059e089f5a@google.com>
Subject: Re: INFO: task hung in tls_sw_cancel_work_tx
From:   syzbot <syzbot+ba431dd9afc3a918981a@syzkaller.appspotmail.com>
To:     airlied@linux.ie, andriin@fb.com, ast@kernel.org,
        aviadye@mellanox.com, borisp@mellanox.com, bpf@vger.kernel.org,
        chris@chris-wilson.co.uk, daniel@iogearbox.net, davejwatson@fb.com,
        davem@davemloft.net, dri-devel@lists.freedesktop.org,
        ilyal@mellanox.com, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, john.fastabend@gmail.com,
        joonas.lahtinen@linux.intel.com, kafai@fb.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        rodrigo.vivi@intel.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tvrtko.ursulin@intel.com,
        yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit f75f91574617a3c6fbc821c6b156f5777a59d0ed
Author: Chris Wilson <chris@chris-wilson.co.uk>
Date:   Tue May 15 14:31:49 2018 +0000

    drm/i915: Shrink search list for active timelines

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=121dc6b5e00000
start commit:   90568ecf Merge tag 'kvm-5.6-2' of git://git.kernel.org/pub..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=111dc6b5e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=161dc6b5e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69fa012479f9a62
dashboard link: https://syzkaller.appspot.com/bug?extid=ba431dd9afc3a918981a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1036b6b5e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1651f6e9e00000

Reported-by: syzbot+ba431dd9afc3a918981a@syzkaller.appspotmail.com
Fixes: f75f91574617 ("drm/i915: Shrink search list for active timelines")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
