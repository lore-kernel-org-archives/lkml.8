Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2643C4332E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 04:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4D820732
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 04:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgCVEqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 00:46:12 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:41109 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgCVEqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 00:46:12 -0400
Received: by mail-il1-f199.google.com with SMTP id f19so9185228ill.8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 21:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GI4GkIJkW1bKRzFiBtT/34jbKoBVKx5WZcrXpE1yJ60=;
        b=imYJVRER7wAdyj3SR+DLiyzNW9JIcsjeY58ekfFSAUGDGQpsvKQu6TPh8IQ9Q3bGQc
         NAw63O+wV/SIVmlnQL5E0dqnXBK5Dbm1jWJdLF81qp4gbqauNzfSel4qmFNyLl1P4vSs
         IuiXDlJvR+QmUUrnrLurY0zC4qUiCDW4T6yb5WbqRvIkpTYyERE0OPz5Kkz/P0zkGLVu
         jlykswHkdFvspc5MUn6AZwJZwtayMAgzIb0AcKBu08otPfNOEtUlSNl3W6KVcp/RuCzT
         tUDypm7cdVkx6hX5qkQZ4IZB1Wa0dDIMaBD/Ne54Y6rCeKqMU4c/yWVwnQ4QeciuaXXB
         0b6w==
X-Gm-Message-State: ANhLgQ0zLI3Jxvaj9y13AB34jUVWzEuSrIhz1wKEilPG3nt3Tqzj+Rgb
        wVn6edlfmEx+tUsMiOshFJHIwnw4vEAfhWCj5ymhLQ/FBAAf
X-Google-Smtp-Source: ADFU+vsJt5RAxUckaqjG5zRClhUofRtFleFv8EV/BOf4ia/aNTZI5251vcnXqewrTdJPZ9LxYOHay+p6Ei7aFnsYFXYRUdY460/d
MIME-Version: 1.0
X-Received: by 2002:a92:9e99:: with SMTP id s25mr14982996ilk.306.1584851942582;
 Sat, 21 Mar 2020 21:39:02 -0700 (PDT)
Date:   Sat, 21 Mar 2020 21:39:02 -0700
In-Reply-To: <CADG63jB59ZXWSUFKieXKGGEbPT9=z5OPARBjGqMgfh+K-k4-yQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f2eea05a16a1979@google.com>
Subject: Re: WARNING: refcount bug in sctp_wfree
From:   syzbot <syzbot+cea71eec5d6de256d54d@syzkaller.appspotmail.com>
To:     anenbupt@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
        marcelo.leitner@gmail.com, netdev@vger.kernel.org,
        nhorman@tuxdriver.com, syzkaller-bugs@googlegroups.com,
        vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+cea71eec5d6de256d54d@syzkaller.appspotmail.com

Tested on:

commit:         e76397e4 iterate datamsg list
git tree:       https://github.com/hqj/hqjagain_test.git sctp_for_each_tx_datachunk
kernel config:  https://syzkaller.appspot.com/x/.config?x=6dfa02302d6db985
dashboard link: https://syzkaller.appspot.com/bug?extid=cea71eec5d6de256d54d
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Note: testing is done by a robot and is best-effort only.
