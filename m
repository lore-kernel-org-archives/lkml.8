Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D779C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293F02253D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgCKFcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:32:03 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:35622 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgCKFcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:32:02 -0400
Received: by mail-il1-f199.google.com with SMTP id h18so612523ilc.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 22:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wevRqhBz7Ha1ufXj1J5HganeoAQW6JbLBzDxT526K4A=;
        b=N81UFinEvjQ23BLb3Z8HgOGijpJT8b5tbq+nBZUpG8yCdc2TycNnmrBCmBXrn7KaT1
         XJ5uQyrYCXAMthspYzEnXbhrsQ7pmC7ObTSA5+jFGfcpcRrUjNu+JoKVmdPZ0lN59tas
         LaCqMJzN+t0lMh1FPNCrMnGqrXIC0fcT9k/Hk23+bHoEL9nqYB6eiOPWDipHEP2vJWJp
         Pc7FF4U4HcNHATE4QmWXepCxn+vt+hmWWFs1zm/K/jbnbdH7G4ffJUri2M0ZyakiL5WZ
         fQ1E5sX/i7doeiUOMonYfAEIFhP271HBpRMDAOrSBH5WOP4H3IpD2TBa6rBhSWJk5SnE
         m17g==
X-Gm-Message-State: ANhLgQ20ooCrRZhJQCliyTApUvNthiHIlgZHFvcrZps/VDWwHxaIwHk7
        4yg1yE7AF5wf9ap86v3kCYIQWPq7TkFkZ5RmIgpa0+CHnqHU
X-Google-Smtp-Source: ADFU+vs5AqIDyondsGCpHRqGUbzyITX4Ug9elC3TYXqm2eit9qrpqbl4xt+rQ3f2GwU+70pBRgba2LC0w62AfY1MRyxlthvFVwiY
MIME-Version: 1.0
X-Received: by 2002:a5d:9509:: with SMTP id d9mr1407940iom.127.1583904721925;
 Tue, 10 Mar 2020 22:32:01 -0700 (PDT)
Date:   Tue, 10 Mar 2020 22:32:01 -0700
In-Reply-To: <CAM_iQpXBb_73wLrBWW7qYfpryWB8zUpMs62d-b0cq3Rw2r2f1w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004efb2705a08d8e8e@google.com>
Subject: Re: KASAN: use-after-free Read in tcindex_dump
From:   syzbot <syzbot+653090db2562495901dc@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+653090db2562495901dc@syzkaller.appspotmail.com

Tested on:

commit:         2c19e526 net_sched: hold rtnl lock for tcindex_partial_des..
git tree:       https://github.com/congwang/linux.git tcindex
kernel config:  https://syzkaller.appspot.com/x/.config?x=bcbe864577669742
dashboard link: https://syzkaller.appspot.com/bug?extid=653090db2562495901dc
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
