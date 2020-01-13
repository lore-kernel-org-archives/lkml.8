Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B32C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BB62084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgAMQmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:42:03 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:55130 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbgAMQmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:42:02 -0500
Received: by mail-il1-f197.google.com with SMTP id t4so8208283ili.21
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 08:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UggXgyDMOpX5GHDFThGPB3yVNMKWrTSHTCaDTJ6McXo=;
        b=WWNcSHcm3IqNckhB3KfP3VHQh+K0OMdM12xS+eFinxefvCITb200qsS/5c4/gbZ5pM
         y/9gh5dY2tXNl3JXRJhXlvVGiwX99zx1PTWJNJu2iUHCxI+X42kaY2+PPinx6AZEopv9
         HefQqVLxeic20ahyhhc8/7nQPKZ5do3dWd9gfdjNc/7PtQCJIxSl5/jPXO9Ui9tW3ym0
         TziT/7pcTVA9boiW9GUy63bKs78x3gan35IfeTk8Z0NolLM01aaYjWgTIE1arolxidNk
         ukJy+X6QABDXN+w50TKebxsnAB+G7tddf214A33ZHsZAtJtjUdYoUgUdGuAx20vAiscH
         H5cQ==
X-Gm-Message-State: APjAAAVHfAS2EqB71wtyrJ4963abc+7qbZIV7c297Z3hHlAJrGBUn/Wh
        OE11zZatx/to6wQppvA/wRcuUEEPkokctsp+XHrYDtR0bDJJ
X-Google-Smtp-Source: APXvYqy9CaTqUtRxm4JcRDeD0S3bogD6d4mwoiAZp6aBCI1DHZPoiOj+/Q+WaCE26zNZRvjut3aai5qER8Zl/wD9tSgZi30iB5tl
MIME-Version: 1.0
X-Received: by 2002:a5e:8516:: with SMTP id i22mr13810044ioj.130.1578933722080;
 Mon, 13 Jan 2020 08:42:02 -0800 (PST)
Date:   Mon, 13 Jan 2020 08:42:02 -0800
In-Reply-To: <0000000000005ed7710596937e86@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0ef18059c082789@google.com>
Subject: Re: KASAN: use-after-free Read in j1939_xtp_rx_abort_one
From:   syzbot <syzbot+db4869ba599c0de9b13e@syzkaller.appspotmail.com>
To:     bst@pengutronix.de, davem@davemloft.net,
        dev.kurt@vandijck-laurijssen.be, ecathinds@gmail.com,
        kernel@pengutronix.de, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        lkp@intel.com, maxime.jayat@mobile-devices.fr, mkl@pengutronix.de,
        netdev@vger.kernel.org, o.rempel@pengutronix.de, robin@protonic.nl,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit ddeeb7d4822ed06d79fc15e822b70dce3fa77e39
Author: Oleksij Rempel <o.rempel@pengutronix.de>
Date:   Sat Nov 9 15:11:18 2019 +0000

     can: j1939: j1939_can_recv(): add priv refcounting

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a7ec76e00000
start commit:   de620fb9 Merge branch 'for-5.4-fixes' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9ff8f11e66c1fb1
dashboard link: https://syzkaller.appspot.com/bug?extid=db4869ba599c0de9b13e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113e0d72e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136aa6e8e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: can: j1939: j1939_can_recv(): add priv refcounting

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
