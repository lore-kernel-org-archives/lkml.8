Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCB1C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 06:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD4520836
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 06:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgBRGDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 01:03:04 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:45632 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgBRGDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 01:03:03 -0500
Received: by mail-il1-f200.google.com with SMTP id w6so16101801ill.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 22:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=s90mtOgUot9BLQ8vD0J1ERBgI+WUMFy7aI1WWZiJRPc=;
        b=Rds0Bwu473teY1oUfhm+VQPjAUIwXRN0R1iOLw0nqEAz1ahbR642AbdxoBao7Cuc+x
         m8dzaRX/eLAtmxn3+rxn+21HH7wIy81Picvhl9PDGHJjS0XKjkWVQu3I/6JUZg0vCJsi
         EsYrIGf/WrMnO57KwQ9o6BMERl4Xgka95Ll0KfJnZDrCOa7/ts3amcGklyb7e092icvr
         7YFi4F51ii7JqLFEPDB0MEbZQUa3JvFDZ3dmrQH35ZC5YmnNeACS4z7xIt+2tXOaX3Ys
         088RsM6i3RHPfRI6SGNYiqmr2cNDcVWTpZfH5qlEwgcopd6NV83bs+TEhvr05MZWXSak
         aGBg==
X-Gm-Message-State: APjAAAVfsXEq+OjxjuxdGaPH+1ljGV27aM11YWEEDz3x+ax6G6h7vH+Y
        nIIrxSpXu0aGz3KivtJYZeqLnITGJTO/2Mq8zaJl3vcYfUxD
X-Google-Smtp-Source: APXvYqyKbrb4s0QHhXUHJyLBgCo8QfHdPqjJt+Gn6V7xrj04pmL0UCt5qN2sCqpWHU5C1lVX4urkbh8cyDLI0yG0Ty2a9C4plVi6
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3f9:: with SMTP id s25mr15172224jaq.83.1582005781889;
 Mon, 17 Feb 2020 22:03:01 -0800 (PST)
Date:   Mon, 17 Feb 2020 22:03:01 -0800
In-Reply-To: <0000000000007838f1059ed1cea5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a98782059ed36cb4@google.com>
Subject: Re: general protection fault in l2cap_sock_getsockopt
From:   syzbot <syzbot+6446a589a5ca34dd6e8b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, eric.dumazet@gmail.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.von.dentz@intel.com, marcel@holtmann.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit eab2404ba798a8efda2a970f44071c3406d94e57
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Fri Feb 14 18:08:57 2020 +0000

    Bluetooth: Add BT_PHY socket option

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17b08045e00000
start commit:   c25a951c Add linux-next specific files for 20200217
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14708045e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10708045e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c727d8fc485ff049
dashboard link: https://syzkaller.appspot.com/bug?extid=6446a589a5ca34dd6e8b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10465579e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16dabb11e00000

Reported-by: syzbot+6446a589a5ca34dd6e8b@syzkaller.appspotmail.com
Fixes: eab2404ba798 ("Bluetooth: Add BT_PHY socket option")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
