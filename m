Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2055C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 00:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE72C20753
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 00:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgCTAsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 20:48:03 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:34658 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCTAsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 20:48:03 -0400
Received: by mail-io1-f71.google.com with SMTP id n26so3329641iop.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 17:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=KQIeV41BqSA2HWOsTXHaruLvJbTFku9df88EiZxeP2U=;
        b=m/hPGwrXJG5I5XxPztSI5dDif3z7R8TU6/5IobAqKlRpXdfpX8j4A5tRRSsh/jlP87
         Mlu7PXGiJOauXfo2o9pqwYGbX54fXsFJ6xq2E1Yig2M4iwNG/oH5Zj8F1Dg/oQ/56oJa
         9ChxS3uIsMPTuEJ2hfTx07upy4z64kQ1U7JZtbAoJQVuL0knXOfc/v6CRVJk5Dzm8hXx
         9scYvLk8Jfbw8IttNynh+qJYUPE2nYw4brHFt4LVp6lPNKAVeLtgjPrPHLOq0TxW+blu
         2sEwFqluFCHFDA3chuEIPRXrnXUIqHShbDgSeEEIAq1Xd47iaxSh1BSZN+IUHPw+nOUU
         1ekA==
X-Gm-Message-State: ANhLgQ2/zcb43kPKIgerlq9w8WL+jxEQl9lvvdQVGK6u7EHhCDVkkLE5
        UzG30Pyj9J9+TwV0N5o4MG8e1XqBP2O0njryTlY1vH6PPJLL
X-Google-Smtp-Source: ADFU+vtOqc6u9s+pMnAy4wggYF/r7nVtJrIj9IeIrcmEVypYawzs8Dh9C2t0kEbG2HqkEDMYGd/BujA1AdzgBk4Sx4zpBokunsE7
MIME-Version: 1.0
X-Received: by 2002:a6b:5406:: with SMTP id i6mr5275616iob.188.1584665282593;
 Thu, 19 Mar 2020 17:48:02 -0700 (PDT)
Date:   Thu, 19 Mar 2020 17:48:02 -0700
In-Reply-To: <00000000000074219d05a139e082@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041ca9305a13ea3e0@google.com>
Subject: Re: general protection fault in sctp_ulpevent_nofity_peer_addr_change
From:   syzbot <syzbot+3950016bd95c2ca0377b@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        b.zolnierkie@samsung.com, davem@davemloft.net,
        dri-devel@lists.freedesktop.org, kuba@kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, lkundrak@v3.sk,
        marcelo.leitner@gmail.com, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, nhorman@tuxdriver.com,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com,
        vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit da2648390ce3d409218b6bbbf2386d8ddeec2265
Author: Lubomir Rintel <lkundrak@v3.sk>
Date:   Thu Dec 20 18:13:09 2018 +0000

    pxa168fb: trivial typo fix

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1361e139e00000
start commit:   5076190d mm: slub: be more careful about the double cmpxch..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10e1e139e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1761e139e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f894bd92023de02
dashboard link: https://syzkaller.appspot.com/bug?extid=3950016bd95c2ca0377b
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1162bbe3e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c93b45e00000

Reported-by: syzbot+3950016bd95c2ca0377b@syzkaller.appspotmail.com
Fixes: da2648390ce3 ("pxa168fb: trivial typo fix")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
