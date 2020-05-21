Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78B2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACCDE20814
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbgEUTiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 15:38:05 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:54079 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbgEUTiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 15:38:04 -0400
Received: by mail-il1-f197.google.com with SMTP id m17so6536386ilq.20
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 12:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NkM41cRyykyrTcXhuRq+Uqt1euBLz5q82M1iSb3aSkc=;
        b=Vyq4FjcfL0G4ry/noXxTse6IGLn7PbvdlsKNgB76LjmqsY+8C33TaCHl+euugT/B7L
         tb7mvd+7GgSuKw6ZyPIL/f9SvWX36GNRKbrVn/gL9ssod/Mu6OomNm1GfCc0A/s4ZUTG
         t7eIlP96rbPpN5qTL8rA1/UdjBc3pt6JyR2LeS0IZaZt7y9Rc8ZnrxJ9V76CLqVp8x8B
         9CLMphxAA/c0QzJoQrv4bfjUWhm7UVT1Ob+7CwAs6Zz6ViaaHQvs5uTr1racdWymcwar
         eEqJTjN3mbvH31/D1f9cUKJWIzq+Ukk8EQpErmyMCRte+xEKjnVokQ4Sz9DaN4fkA2vu
         tOQA==
X-Gm-Message-State: AOAM532pveHq35ZUXs2qoE9TycTy4O/2/mhjhQbrOpBzPT/NITTNEypn
        uOyEJBh12rfOFc10GE/i+5yHTMOz2wQGktmJqUIv6x3TRO0Z
X-Google-Smtp-Source: ABdhPJz1FMid2HBzS6OeC8X8s51lXhWDo/4NiVC0UQXz/KcfgeapJlPG+XCp1SR4JS6Dx+SAezbEtWn4NTX3HiGc7Kjpjzv7X1zA
MIME-Version: 1.0
X-Received: by 2002:a92:40ca:: with SMTP id d71mr10291945ill.200.1590089883386;
 Thu, 21 May 2020 12:38:03 -0700 (PDT)
Date:   Thu, 21 May 2020 12:38:03 -0700
In-Reply-To: <0000000000004a72f505a5a16525@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9080105a62da6e4@google.com>
Subject: Re: WARNING in media_create_pad_link
From:   syzbot <syzbot+dd320d114deb3f5bb79b@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit f2c2e717642c66f7fe7e5dd69b2e8ff5849f4d10
Author: Andrey Konovalov <andreyknvl@google.com>
Date:   Mon Feb 24 16:13:03 2020 +0000

    usb: gadget: add raw-gadget interface

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126d2b81100000
start commit:   b85051e7 Merge tag 'fixes-for-5.7-rc6' of git://git.kernel..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=116d2b81100000
console output: https://syzkaller.appspot.com/x/log.txt?x=166d2b81100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c33c7f7c5471fd39
dashboard link: https://syzkaller.appspot.com/bug?extid=dd320d114deb3f5bb79b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16accd06100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1680ce5e100000

Reported-by: syzbot+dd320d114deb3f5bb79b@syzkaller.appspotmail.com
Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
