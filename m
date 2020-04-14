Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BA6C2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 054E12072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438863AbgDNK7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:59:19 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:41712 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438845AbgDNK7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:59:04 -0400
Received: by mail-il1-f200.google.com with SMTP id y2so4653609ilm.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 03:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=B/wMlDlQPegcALh4XzxDXP3zbriJPXSUWAjVGj5HNW0=;
        b=oct8CoZHzN2WHNADYkIEU/z2vUgI4KQx+KV7FO4+QHpuCuj773qegwyIKj2YWJHZqn
         /KggybvuZpdY1RCusIS0CEVXN+zRS+OLPi8W+jpi/TCgCuR0iv7iDaJjg6mfQdUPKoJU
         RT8CFGeXVc49QZIMU6EgbY2EKZY+dRhIXc2PQIWBszdIvQBQ9th4tS0/v+Brqx5x+t+q
         c941F98Tj7kL2vIBEaZxGWRmieWPMMp55J3v/k0qNxMADZiX2SQObGJUJZSrmei8k70O
         +wkX06lsDY1A3BecdOdwxp5uyZmNOGX9L0+fyNinYKmq9ydCKfIHTQEIIYFLs18Fo/xP
         nGfA==
X-Gm-Message-State: AGi0PuZfMhw7bxUBB4fsz0X+mMB3N3kJGnQ++o0unF1np4OGwBaI3ipV
        hG5Sj71sS73cbM9YnXBBSjQ9AkoLpEzFH+D9c+fEZHKZxWuV
X-Google-Smtp-Source: APiQypKAhI/rash2i+SF7YvWdutz9ltcTt0CfD36FY1rEVx5Y6wMm1OewFDHN3vNTTAmI5vEiUVtkIEsNuYKCiBd0yNc3Rmw/p18
MIME-Version: 1.0
X-Received: by 2002:a6b:770e:: with SMTP id n14mr20446473iom.110.1586861943126;
 Tue, 14 Apr 2020 03:59:03 -0700 (PDT)
Date:   Tue, 14 Apr 2020 03:59:03 -0700
In-Reply-To: <66c3db9b1978a384246c729034a934cc558b75a6.camel@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d7e0f05a33e163e@google.com>
Subject: Re: WARNING in hwsim_new_radio_nl
From:   syzbot <syzbot+a4aee3f42d7584d76761@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+a4aee3f42d7584d76761@syzkaller.appspotmail.com

Tested on:

commit:         e154659b mptcp: fix double-unlock in mptcp_poll
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=5af684c50f30bcb2
dashboard link: https://syzkaller.appspot.com/bug?extid=a4aee3f42d7584d76761
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=144e124fe00000

Note: testing is done by a robot and is best-effort only.
