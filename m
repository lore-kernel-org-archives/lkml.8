Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A58C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0D4206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgCFWzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:55:03 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:38650 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCFWzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:55:03 -0500
Received: by mail-io1-f72.google.com with SMTP id x2so2513774iog.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 14:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=m8ypvxz+cK1JIvyLt/BMDjKohGZTA1dUlqmR0UXYtMg=;
        b=A+Ng3XWxnjcz2e+ASPnI+1zDq7UqMLpXBrAoOiPj5duBONNgHvXb6JI15yXqWVsALn
         4FuK1SsmZnEi2muABRz4YuJRhY8xYNrUOxXHBlv66KH2E/3A+hMry3HD6fFRDoz5C403
         1m1/APLGHw2Jzs4kl7xVDQ3GwI4Dd9IUaI9udK0UAV1rhbAH2DQcovYVPmNtEucC/NuM
         TMElHEEXOpY9Ffa/KPek0Hzgf4vWmI2MdETwsTUdY9jFzrEBR0GN7oAR4IUf1qGuXC/K
         xJde8/zz+pqp9GaSEPvxLICPXBl2MYF1jVMsTaagYM+8zoWTCup2E41Y1M5Zrt3K6rU8
         AoSQ==
X-Gm-Message-State: ANhLgQ3CesJQ1WPPS31Uu/AMj573NkX1S6YOggJSgGjyeQWB/w3+N1Mv
        /iii5ntlqEV53gNH/RvBv13Dm9myt+igQ7xTV4yEYfqEawe+
X-Google-Smtp-Source: ADFU+vvl/Pw/zrYZi3hTs86i/nHL37mFWPQxthR6YKLbvs4Bfi5y+N2n+47G78N/xSSVGDM+PUK1aVBGtLcC1MK5QKPC+D5KtvQh
MIME-Version: 1.0
X-Received: by 2002:a6b:17c4:: with SMTP id 187mr4941793iox.143.1583535302639;
 Fri, 06 Mar 2020 14:55:02 -0800 (PST)
Date:   Fri, 06 Mar 2020 14:55:02 -0800
In-Reply-To: <20200304135649.GE31668@ziepe.ca>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003406b805a0378b77@google.com>
Subject: Re: BUG: corrupted list in cma_listen_on_dev
From:   syzbot <syzbot+2b10b240fbbed30f10fb@syzkaller.appspotmail.com>
To:     chuck.lever@oracle.com, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+2b10b240fbbed30f10fb@syzkaller.appspotmail.com

Tested on:

commit:         5e29d144 RDMA/mlx5: Prevent UMR usage with RO only when we..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d613b606deeaad7
dashboard link: https://syzkaller.appspot.com/bug?extid=2b10b240fbbed30f10fb
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Note: testing is done by a robot and is best-effort only.
