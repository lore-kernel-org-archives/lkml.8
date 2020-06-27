Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AAFC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 05:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D88E206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 05:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgF0FiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 01:38:06 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:48131 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgF0FiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 01:38:04 -0400
Received: by mail-il1-f198.google.com with SMTP id o4so7935755ilc.15
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 22:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=u9P2EE/S87kAn+TJjavtmwObTBtoebe5eiDhz57fLfc=;
        b=efmdqrwKHQGygj+hKJYtW2lJ0t0ga/as+ZpZJwujHc+l/3L9NhP0gfv3qm4l0lzuDo
         n11V7bLvetnYS3hF0yx2lkbCqn89n8eohJ8lGFBiFoQdSgHhCJh9ljuJe+Rdpp8bZkze
         j7tGzfzdQuqB2UC294aELHTqacWG3JvHIogKFigbV8BR0Ih6UhZavVIC5+Kt+419oHUD
         K6avwzBJWaniyDJ4fkp4zvcQKvllDPdNuA6Nx+RpDL5olXbJEd5THcXBMWmw2NygWQ9b
         XX9XziXGLtQWiRSQ0UFIq5JqUjN0X4ZBx2oEgxBbw3qwobc/btrBPY/+QskXMKpRF4Kl
         NFmw==
X-Gm-Message-State: AOAM533SWojYrizbcwBbyAL7FQX5CvU0pK5Rrn68RXnHMYviy1CpXDmi
        F7LYLb0Ukl5mJfUyo+BVaFPEMYB3YrNRLVy1MjMYuEFEvNpa
X-Google-Smtp-Source: ABdhPJzpnDkAp15KnEECPp6xwF/eVMiqJE7Rm/uBR99//bOgu9a1bSEAuZM/ifHXEU678lXhmIQB1koTWBBxMkem4QkFc/IVdVFD
MIME-Version: 1.0
X-Received: by 2002:a92:5898:: with SMTP id z24mr6561879ilf.242.1593236283469;
 Fri, 26 Jun 2020 22:38:03 -0700 (PDT)
Date:   Fri, 26 Jun 2020 22:38:03 -0700
In-Reply-To: <CAM_iQpVtv0Ut8nwwLYtKgMpQV2WknQJF9t35Ew4RewBYBvQ2wQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b835a205a90a3a11@google.com>
Subject: Re: KASAN: use-after-free Read in tipc_nl_node_dump_monitor_peer (2)
From:   syzbot <syzbot+c96e4dfb32f8987fdeed@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jmaloy@redhat.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, xiyou.wangcong@gmail.com,
        ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+c96e4dfb32f8987fdeed@syzkaller.appspotmail.com

Tested on:

commit:         152c6a4d genetlink: get rid of family->attrbuf
git tree:       https://github.com/congwang/linux.git net
kernel config:  https://syzkaller.appspot.com/x/.config?x=20c907630cbdbe5
dashboard link: https://syzkaller.appspot.com/bug?extid=c96e4dfb32f8987fdeed
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Note: testing is done by a robot and is best-effort only.
