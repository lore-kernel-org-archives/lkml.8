Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D459C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E28F620684
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbgGVU3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:29:05 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:54301 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgGVU3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 16:29:05 -0400
Received: by mail-il1-f199.google.com with SMTP id d18so1903695ill.21
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 13:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=J+35V1GhRYpImLMMK2GI/sO17Jyt3p/2anYHKeEsSGE=;
        b=iDgbHqsVQmvFUt7no3gfCkMcXXvOfpqFVYf6eTHIc2BazWBmJGKQ2hCMplZk9zuWnk
         4sWTofZ63T17PEfOOqNWOg8Sc1P1W59RUvbfycwCTSpzKxxEcOVNaCwLdUdrSBgMyz2+
         +2GjxIwygkUIh92PY1rdfi9iiGyPqgdkqdxrmJhT3YUA1ykS62i+gajRSNUG5LO1ejYe
         m3en+4Y2KqDdm3IcC2RK6wI5Qs1fuKxAupa0ZLoyVhKApu4QRvGNfMm10RkgTy2n6Cbh
         9zVWTKigHKcaBnvmIq3B0FY6jLVnKie8gFAYFXlK8sczI1FuzxmlMP5idJFhEaJ/M72U
         uIAA==
X-Gm-Message-State: AOAM531pbxCyczRezBVQIT4T6Fp/rYU7kt6DAmML2zg8dVTEqOyPFTXb
        F5elsMu/gW+Dh4Qa4nbWz0pS3g4MU2Xsf9M60AHv8suGHfWd
X-Google-Smtp-Source: ABdhPJxHK6WbX/I4a7/yMyShEPLIR0Q9QECWtZRgxeRHjQAiPmIUBL9QFevmt3eA7WbXHH2iZgv3Tq89tpWot0N8y5MnqAgDQh6w
MIME-Version: 1.0
X-Received: by 2002:a92:8b45:: with SMTP id i66mr1708429ild.19.1595449744109;
 Wed, 22 Jul 2020 13:29:04 -0700 (PDT)
Date:   Wed, 22 Jul 2020 13:29:04 -0700
In-Reply-To: <0000000000005b9fca05aa0af1b9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041388e05ab0d97aa@google.com>
Subject: Re: KASAN: use-after-free Read in netdevice_event_work_handler
From:   syzbot <syzbot+20b90969babe05609947@syzkaller.appspotmail.com>
To:     andrew@lunn.ch, davem@davemloft.net, dledford@redhat.com,
        f.fainelli@gmail.com, hkallweit1@gmail.com, jgg@ziepe.ca,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux@armlinux.org.uk,
        netdev@vger.kernel.org, rkovhaev@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit d70c47c8dc6902db19555b7ff7e6eeb264d4ac06
Author: Heiner Kallweit <hkallweit1@gmail.com>
Date:   Thu Apr 23 19:34:33 2020 +0000

    net: phy: make phy_suspend a no-op if PHY is suspended already

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16b2aad8900000
start commit:   0bddd227 Documentation: update for gcc 4.9 requirement
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15b2aad8900000
console output: https://syzkaller.appspot.com/x/log.txt?x=11b2aad8900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66ad203c2bb6d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=20b90969babe05609947
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a8edff100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167d3bb7100000

Reported-by: syzbot+20b90969babe05609947@syzkaller.appspotmail.com
Fixes: d70c47c8dc69 ("net: phy: make phy_suspend a no-op if PHY is suspended already")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
