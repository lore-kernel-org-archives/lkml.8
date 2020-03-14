Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B938AC0044D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 03:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9642074B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 03:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgCNDwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 23:52:03 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:45299 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgCNDwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 23:52:03 -0400
Received: by mail-il1-f200.google.com with SMTP id h12so8535101ils.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 20:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=KCmAJDk94gn8lmzBp3+MaZXdfTJa9zfOjP1Al0kR+Bg=;
        b=k7BxK5lfFTGKqHwLip07m/i3qqIJDREDgqLXiqaK7B9fSGcb35UmPHxvKinvgHJGKl
         zFlrJws4f9x6U/vfUAOuNJ2kcJs4FAJ3cd6a0TChxFVEB/jEalVquRf8zUrpyXkbfTkc
         yUpZmsUQ3sFB6Ikm8RlJkNugl6yGSH++Vq7H3dGw+5GYoeAxT/ehW+OWvMOsyFu/A27d
         jDblZdwoo7sHlag5mLQw5rf8ZUXQSI0bMNig5P0W/g871WnuFz7MKS0HKuKAUgjNmfA4
         6WvmVhnw/oQNyjqxmy9mmpDucNCxAFv7/jpoiOxsVvhiMLO978Ooxh2mAYhnWJtY3RlI
         4xOQ==
X-Gm-Message-State: ANhLgQ24UhZxu624M5pD9Qm1J0f136oSBXeVaELS/SgEml+q+MzW1ggs
        SNmF4evFPpqlPdQlw07B3oFtdzpi7qGnb/88m8sY4qg5RkQX
X-Google-Smtp-Source: ADFU+vt7Mx2gi6kRYfnT0aEo7wr0TNid+UV7hnHce2sBBCczu7qzhEVpG7lpLM714nNqKTdMRjkbmYp6hIKUGEo84swpCtCVg24a
MIME-Version: 1.0
X-Received: by 2002:a6b:5a0c:: with SMTP id o12mr15083450iob.137.1584157922264;
 Fri, 13 Mar 2020 20:52:02 -0700 (PDT)
Date:   Fri, 13 Mar 2020 20:52:02 -0700
In-Reply-To: <CAM_iQpXM7daXmcEGjk+CuOFf3KDixDidWSDpUAk=RcpRehF+Ag@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000398bd005a0c882ab@google.com>
Subject: Re: WARNING in call_rcu
From:   syzbot <syzbot+2f8c233f131943d6056d@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+2f8c233f131943d6056d@syzkaller.appspotmail.com

Tested on:

commit:         29311b74 cls_route: remove the old filter from hashtable
git tree:       https://github.com/congwang/linux.git tcindex
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5295e161cd85b82
dashboard link: https://syzkaller.appspot.com/bug?extid=2f8c233f131943d6056d
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Note: testing is done by a robot and is best-effort only.
