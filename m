Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B589C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 287782088E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgFQSeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:34:06 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:47700 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgFQSeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:34:05 -0400
Received: by mail-il1-f199.google.com with SMTP id w65so2151720ilk.14
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=F3B7POYganjcYcTK3xulmlzDnkNmuFC83gI/QGxJRTY=;
        b=pZpiwj0eztRe4dqLcqkr3DfwCqOIEV7HJh2COBBDzXmQMX8X3C2s6LHb+L6EF1D2pI
         jIktQzo+d1cwqP9DaVstUW9gIZ8EleudLsWCGZqWkeEYmZZkPIsltufe7y3eWqJZKPTN
         w934EOx0KatQvTHDb0LIjasEs739AkXwEzQJPSkZr9Gda/MQvv8YeXBBsGDxgdP3EygC
         mtt1IVbz+94r/A59EmvS8wkCZUextQ/pVwsKj/tnIzUxJZ/RQfOYqM15DwNLMbCksJ5K
         InyTldjeB8eaora6KAPWlb3NKse/R/HOWYFJZQNXEBZd6rH+418mkrD/HVMP3bjnnNrE
         /Dlw==
X-Gm-Message-State: AOAM531HbC8wM7fmhTKv5oCVVssRdFsRhPdpE53Caqo5YcsIfP60nGCz
        GHbC00HQE0R5Ge+I9uCjc9v04UV/S8wAZ6OfxhET9+3TbQDV
X-Google-Smtp-Source: ABdhPJygKKcZu/ebf2TevbrWJlM+0CuGBrPVjGvdAgLKjnmnW+3Wbg2+h5A3SrR7rk6IBnaFssLxIhPC1NUTeKocc3UNX41F5Ya9
MIME-Version: 1.0
X-Received: by 2002:a02:770b:: with SMTP id g11mr621320jac.69.1592418844130;
 Wed, 17 Jun 2020 11:34:04 -0700 (PDT)
Date:   Wed, 17 Jun 2020 11:34:04 -0700
In-Reply-To: <0000000000000655c0057cd141f1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089c74405a84be7aa@google.com>
Subject: Re: WARNING: locking bug in __queue_work
From:   syzbot <syzbot+6174a6c5eba4b3cdd606@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, bp@alien8.de, cluster-devel@redhat.com,
        davem@davemloft.net, hpa@zytor.com, jon.maloy@ericsson.com,
        keescook@chromium.org, konrad.wilk@oracle.com,
        kuznet@ms2.inr.ac.ru, len.brown@intel.com,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        mingo@redhat.com, netdev@vger.kernel.org, nstange@suse.de,
        puwen@hygon.cn, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tipc-discussion@lists.sourceforge.net, wad@chromium.org,
        wang.yi59@zte.com.cn, x86@kernel.org, ying.xue@windriver.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit ea22eee4e6027d8927099de344f7fff43c507ef9
Author: Bob Peterson <rpeterso@redhat.com>
Date:   Wed Apr 29 13:45:54 2020 +0000

    gfs2: Allow lock_nolock mount to specify jid=X

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16fcf249100000
start commit:   fe5cdef2 Merge tag 'for-linus-5.1-2' of git://github.com/c..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
dashboard link: https://syzkaller.appspot.com/bug?extid=6174a6c5eba4b3cdd606
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f6c7e3200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101507fd200000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: gfs2: Allow lock_nolock mount to specify jid=X

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
