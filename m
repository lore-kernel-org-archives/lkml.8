Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF46C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2435A20838
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbgGaIoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:44:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:49427 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgGaIoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:44:06 -0400
Received: by mail-io1-f70.google.com with SMTP id f7so14851611ioj.16
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2MiWhebPAZEwNHbE02ggeQmHTDlIjaaAtS5l21f1BPw=;
        b=iln+QqEO/xVhBvSxnDmTMSXWvUoN08jz5nM4s8I7lf2hSJAjK0ygxzELKnKrip1B8k
         XjdGc0O7vlEIwySCuCO/bqFfJBTzPzdHBpKVxLx+drUhnQrMK2v0CYoj2gwouHPu3JD7
         oSjnWFws0Am3pCI9tlNvdg7WPo3n0Tnb1oUaORp2g9wtU0wVWfTRKtwgWLAt8ZTO7NvZ
         sj5SYw/7NxW+fYNJt9oBtxaYMbBaupXblgtYKy6vnNdY7fZmzsgLPRm9omNmi103G5ro
         S4gaqBr0cQ9Rvf93rnbTu/aK+znAPrGXSLdNNzM1SOj+T/WeNCOiyXyPxzrpl0AvpMyR
         VFrg==
X-Gm-Message-State: AOAM530LCbo1hf1mOhtpV+0Ag4CVZwkQDYqvJPzqRKbqRD052+fvXGvd
        V9hhRjBrq1IARtVaCdasz9N4TCdpuWYj+z1245Q5sCicUY5O
X-Google-Smtp-Source: ABdhPJy4Rj2LLEiAspTEtCegum11hHhIEmst76GFNZjb8ziE/nZyOIvy4zdOy45COS+BYVrIBbRSJc0ymQWmZ3YMzOpl0u7SggRq
MIME-Version: 1.0
X-Received: by 2002:a6b:7416:: with SMTP id s22mr2545374iog.160.1596185045466;
 Fri, 31 Jul 2020 01:44:05 -0700 (PDT)
Date:   Fri, 31 Jul 2020 01:44:05 -0700
In-Reply-To: <000000000000f6d80505abb42b60@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1816805abb8caa1@google.com>
Subject: Re: WARNING in cancel_delayed_work
From:   syzbot <syzbot+35e70efb794757d7e175@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com,
        johannes.berg@intel.com, johannes@sipsolutions.net,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        luciano.coelho@intel.com, marcel@holtmann.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit fbd05e4a6e82fd573d3aa79e284e424b8d78c149
Author: Luca Coelho <luciano.coelho@intel.com>
Date:   Thu Sep 15 15:15:09 2016 +0000

    cfg80211: add helper to find an IE that matches a byte-array

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1790af82900000
start commit:   83bdc727 random32: remove net_rand_state from the latent e..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1050af82900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e59ee776d5aa8d55
dashboard link: https://syzkaller.appspot.com/bug?extid=35e70efb794757d7e175
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1160faa2900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11816098900000

Reported-by: syzbot+35e70efb794757d7e175@syzkaller.appspotmail.com
Fixes: fbd05e4a6e82 ("cfg80211: add helper to find an IE that matches a byte-array")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
