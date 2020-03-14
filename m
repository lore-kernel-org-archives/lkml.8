Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DATE_IN_PAST_12_24,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950FFC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 04:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C19D20722
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 04:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgCOEVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 00:21:14 -0400
Received: from mail-qk1-f198.google.com ([209.85.222.198]:39432 "EHLO
        mail-qk1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgCOEVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 00:21:14 -0400
Received: by mail-qk1-f198.google.com with SMTP id a21so13518352qkg.6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 21:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=H5UL55Jt0P8+lhekSBof6CJMLz8v0e26Cnd2rcAgXuU=;
        b=EoIXp6VqlhKhTHUjA0WJwtcTeSfQ+tL3RBvIyqlXFGMEpt6yHXHvGVEpHoizUXn9Ti
         N1gtkyvGnt6qOv8hc9uUt7CMoi7/E4hLMQQyuYfmN2ufT1r8CSBTpNa0CQGN/8AACU5s
         7uczGc1UwnOli2FGqcBame6DWgdtwzbWORKf8suSTJix1xTUgRHeJQrgNKRoPBQMzl5t
         B8U8gpadCH49unzzlIVaQr9vLbku/eZ98VSU/znWpb9XCUKi+vSd2dAqCO5vr7zpQlj6
         HwF97Y2Wzk0gdA9zMOlPUsSjAKbHhcsiLHGrdIh1UcWMKZXAYB37XLI9kGUljY4l9CJK
         AlNg==
X-Gm-Message-State: ANhLgQ22qmGUC2/mrYHdjnCMHXCjDjBmk4V2XmwPVxKEQFaBN3y3pdjm
        nQeuFPQSpGgDNhAhPNYuB95TKjkF1QHGIdHlIuQV6K4FAuY0
X-Google-Smtp-Source: ADFU+vuMuZRQB4plQWTVVNLqwBcbrFI1SQwYA3uqfRjAyzEhpvXcwloMBXgVy/yGvQ7oZDstiPZt9V3wkVKoQhD/DqzkLaxTcBBW
MIME-Version: 1.0
X-Received: by 2002:a05:6638:266:: with SMTP id x6mr15874404jaq.46.1584159902975;
 Fri, 13 Mar 2020 21:25:02 -0700 (PDT)
Date:   Fri, 13 Mar 2020 21:25:02 -0700
In-Reply-To: <CAM_iQpUo0L0+J7aGTvUsBWZ=A8cGxyN7oJVjqyent+9OCbJ_Jg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048ca0c05a0c8f8a8@google.com>
Subject: Re: WARNING: ODEBUG bug in tcf_queue_work
From:   syzbot <syzbot+9c2df9fd5e9445b74e01@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+9c2df9fd5e9445b74e01@syzkaller.appspotmail.com

Tested on:

commit:         29311b74 cls_route: remove the old filter from hashtable
git tree:       https://github.com/congwang/linux.git tcindex
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e8e51c36c1e1ca7
dashboard link: https://syzkaller.appspot.com/bug?extid=9c2df9fd5e9445b74e01
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
