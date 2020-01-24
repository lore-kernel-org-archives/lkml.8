Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E14EC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 04:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357622070A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 04:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbgAXEzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 23:55:02 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:41979 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730055AbgAXEzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 23:55:01 -0500
Received: by mail-il1-f198.google.com with SMTP id k9so652638ili.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 20:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wqIW1GSh96dKBLUXIwcBCdzQGnE7BxtkVO3LYYJlVQE=;
        b=F+2p5VVOYRS8pulNJ45Nc0uXBdgHT9kQr39V7H2PNLZnPtENqMBI3mD6slcPY8lCDp
         kiOhNyJzX695j39hY9c9FwQI+DADgv3xuUdAUTgIFoLsAPeltSZ80ORTTt2r9QsigR+r
         IRjMIoY4aK6o9QltOMsLGyPDU573zCdKdrPvGlpjRqzZZZGoTtwEy7gTFyLzzqSGzqAy
         6l4MjiX+wcG6ucYVypYTqSQD7b7hqAjz3NvXCB0pXzXDljN6cYfLi1q5R+r35oKPXXk1
         Unkfv0zQWhl50JpHkKdrjmQ79GHTqN5xt2XUXZvkV+67yy35ZZTIBlqkhEsHLWt3CcYq
         Lucw==
X-Gm-Message-State: APjAAAVuZ700ueHGT6rWWJHeGVbgyRQAah7GkTY0Qe9TjGP1vWLjG51T
        98QcL+BNDf/BPxCGVPu5sPT8PJBorvP08TeEHtH0nVKdp9m1
X-Google-Smtp-Source: APXvYqxrBcPP1lod4jQ5x9Z+3r0zQv4PBuVpX/irM3rH1cFEkIinSrYxZh5p5QiT0thS8XZ7XZ8TETunB7YSrXzC5GGeknq9swin
MIME-Version: 1.0
X-Received: by 2002:a92:7903:: with SMTP id u3mr1546730ilc.254.1579841700988;
 Thu, 23 Jan 2020 20:55:00 -0800 (PST)
Date:   Thu, 23 Jan 2020 20:55:00 -0800
In-Reply-To: <000000000000204b4d059cd6d766@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000638fae059cdb8fe8@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bitmap_port_destroy
From:   syzbot <syzbot+b96275fd6ad891076ced@syzkaller.appspotmail.com>
To:     arvid.brodin@alten.se, coreteam@netfilter.org, davem@davemloft.net,
        florent.fourcot@wifirst.fr, fw@strlen.de, jeremy@azazel.net,
        johannes.berg@intel.com, kadlec@netfilter.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit b9a1e627405d68d475a3c1f35e685ccfb5bbe668
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu Jul 4 00:21:13 2019 +0000

    hsr: implement dellink to clean up resources

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17d0c611e00000
start commit:   131701c6 Merge tag 'leds-5.5-rc8' of git://git.kernel.org/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1430c611e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1030c611e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83c00afca9cf5153
dashboard link: https://syzkaller.appspot.com/bug?extid=b96275fd6ad891076ced
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fba721e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1339726ee00000

Reported-by: syzbot+b96275fd6ad891076ced@syzkaller.appspotmail.com
Fixes: b9a1e627405d ("hsr: implement dellink to clean up resources")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
