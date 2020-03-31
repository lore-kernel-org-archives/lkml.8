Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F0CC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF0020BED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgCaRgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:36:04 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:49120 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgCaRgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:36:04 -0400
Received: by mail-io1-f69.google.com with SMTP id b136so19906365iof.15
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 10:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=EkBmF5uXCWrM6aOPYLh3R3gAH7wKc57Bigw1PTLooMY=;
        b=lAHkF54SWzzb3uMwYZ37CXRnOiYp0+2NObsgE8/4eb1AhwnmtY6QgBCLTzAXfWPEjh
         azU8PSDzyU4iXM6pPDvunosaWjZBxIyTs9VBB9X8l9ZyO52opS+6gnvm+aceA4GnORS8
         rKDpEJv0APnCVeXi7sNSfLaOCgkopjw2FYLWrAcxl6+JyLVXhMJrpb/hiF9xrF2Z6g5v
         xF3q4KJZ+5TRZKjPkUzq2wCsODEUuBw2q3KiAKS63R3gjUHLHXH6QJkI6Td8Z/xsipou
         EbVairw0OtM6ByMEiv4tM1FAhu5IaQGtWAszPFhXC458JYqrSMqF/3xreqaYS67yiD2w
         ox+w==
X-Gm-Message-State: ANhLgQ3/tHHqACAHoXMCj0jFpaiC+ZevOjxzDT+QVjC9gMDw8XVs+IB/
        jMs2pQIPt1BIbCJyshuXBlQfJZFsw55S6MjLlCvYs98DXxt7
X-Google-Smtp-Source: ADFU+vvHwabh6/XT3HQsMvsns9bvDqN3/9G4mkXHM92526jZauR7yd6nL/ccsz/Mvu+hTOSZfNJXAFtWrHfa8tJOTfHuhC7B/BNp
MIME-Version: 1.0
X-Received: by 2002:a5e:880e:: with SMTP id l14mr15608634ioj.8.1585676161841;
 Tue, 31 Mar 2020 10:36:01 -0700 (PDT)
Date:   Tue, 31 Mar 2020 10:36:01 -0700
In-Reply-To: <000000000000da6059059fcfdcf9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b022005a22a0050@google.com>
Subject: Re: KASAN: use-after-free Read in skb_release_data (2)
From:   syzbot <syzbot+a66a7c2e996797bb4acb@syzkaller.appspotmail.com>
To:     davem@davemloft.net, festevam@gmail.com,
        gregkh@linuxfoundation.org, grundler@chromium.org,
        hayeswang@realtek.com, johan.hedberg@gmail.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        marcel@holtmann.org, nishadkamdar@gmail.com, peter.chen@nxp.com,
        pmalani@chromium.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit d9958306d4be14f4c7466242b38ed3893a7b1386
Author: Nishad Kamdar <nishadkamdar@gmail.com>
Date:   Sun Mar 15 10:55:07 2020 +0000

    USB: chipidea: Use the correct style for SPDX License Identifier

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d4940be00000
start commit:   63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
dashboard link: https://syzkaller.appspot.com/bug?extid=a66a7c2e996797bb4acb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c25a81e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: USB: chipidea: Use the correct style for SPDX License Identifier

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
