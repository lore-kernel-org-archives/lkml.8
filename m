Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AEFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A02020756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgHKMHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 08:07:08 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:43629 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgHKMHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 08:07:06 -0400
Received: by mail-io1-f72.google.com with SMTP id f19so9547075iol.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 05:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=HzQLLDC1IVxhcp7/2UGjOxAx/is2c+2Svqmxvr49UPw=;
        b=Ewz7UjvAb/d0FZO08AqjEyYxu3MYO6U6BDh4V3ff6Fvor102/jEF6ZYVOL+4fJoJkh
         GadJJdfRX8DaifZ/liNzNADspNZiLo4nR96B7EIUTeW8vWeH4PpJs8GtYCmcGTqfbB1x
         uHzKCZMOBDCHR9glDBoWdcf3UMjQOdPEeTPs0LZj3xdCfmbkvp5L/FmDJQoWPnci9+Pz
         C8tN725UZ6Gp5whubs4pzXWzAw7JuTqzBR7aWDlD3N0ymRlt1ZFwW1vEz8nrcsg61NCD
         HZSnrYzbL8OtKy5VzZi+vl4w1MKaOWc1rv5k28mLrsvJG5xZSe2MO77I/vSk4mH9WNh/
         C2FA==
X-Gm-Message-State: AOAM532EXycgWJD9ZxjdZQ1o3dEmU7lOqhamG5ECHYKpiQ04Gp3dYG5n
        Us31htFDWwKjucvDWGVfS350CdOkJhI9I24SytUmVEQovjjZ
X-Google-Smtp-Source: ABdhPJxzQS39hv4MK29/Jx/x0y/5Yh1oJ5MVyHs9Ac+UcQli1on3FM41GDUlr03BCZqL5G33nbAGhCmN34y5wng1V3Lzp7VBKGAJ
MIME-Version: 1.0
X-Received: by 2002:a92:b6cb:: with SMTP id m72mr14759930ill.276.1597147624930;
 Tue, 11 Aug 2020 05:07:04 -0700 (PDT)
Date:   Tue, 11 Aug 2020 05:07:04 -0700
In-Reply-To: <000000000000cf1be105a8ffc44c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d683c505ac98e87e@google.com>
Subject: Re: possible deadlock in dev_mc_unsync
From:   syzbot <syzbot+08e3d39f3eb8643216be@syzkaller.appspotmail.com>
To:     ap420073@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit be74294ffa24f5fbc0d6643842e3e095447e17a2
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri Jun 26 18:24:22 2020 +0000

    net: get rid of lockdep_set_class_and_subclass()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=110b0fc2900000
start commit:   4a21185c Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf3aec367b9ab569
dashboard link: https://syzkaller.appspot.com/bug?extid=08e3d39f3eb8643216be
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d2b1c5100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17aed775100000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: get rid of lockdep_set_class_and_subclass()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
