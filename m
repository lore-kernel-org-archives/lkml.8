Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1532C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B89B1208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgGSXCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 19:02:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:35482 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgGSXCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:02:05 -0400
Received: by mail-io1-f71.google.com with SMTP id i204so10091723ioa.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=yAyoquWQur/JE0vcMjr85UEh8dUhSL28OuUIPGAj7Z4=;
        b=gw2KFkJuRelXJ0sdpLrul9hXBC6bU4Suqbk4rnai6cgz+iJ0k//fe+9Z/iNlP6n8iC
         GnS+Zcu79dF+wPxIlGouc06IEFzGWMrLbOiQwEUTzdgFh4Q6Wmt3vek8Srks8wmRGWW9
         qBvVQSSFJItaOSd5SfQLdHbGu9/FknNV84OaxT4dPfO/3CHjcIyLCMbj92n9xBKiYJSd
         KSDSLZ1SqME9OI2uirqhDEbneOhXb9JM6aip06gyR6Pm6/EePuF4E17HKUTUhI88KVIc
         vqW8/HGlWDA8yu+1wgwvdeEH9b1jZQHTzb5FqAGlyHm8Drat40OGEvv2Y6Rf3TrIujKF
         aTVA==
X-Gm-Message-State: AOAM532pDYJ+IK+E74Q5j/DULIZDpcfo930Mc7VFRp8Tm/XjGMVtFNZj
        peFVrJzEO38sGmgfmALV8dX0CoCE8hex0BdhI2gawFI4SraT
X-Google-Smtp-Source: ABdhPJwWt4B8WbtLMsmBYQmM2VfWyfOntvoTC+LmzCsi1coiOMj3P2eZTNHm+1EGBF8VkbJpY83MG5RtAxjdYt/IIRKpIihJWwHt
MIME-Version: 1.0
X-Received: by 2002:a92:d181:: with SMTP id z1mr20509309ilz.41.1595199724489;
 Sun, 19 Jul 2020 16:02:04 -0700 (PDT)
Date:   Sun, 19 Jul 2020 16:02:04 -0700
In-Reply-To: <0000000000001e16e605a9d01ab3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec958305aad360e3@google.com>
Subject: Re: BUG: soft lockup in __do_sys_clock_adjtime
From:   syzbot <syzbot+b63f85efcdedbba8b3be@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bp@alien8.de, davem@davemloft.net,
        hpa@zytor.com, jhs@mojatatu.com, jiri@resnulli.us,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@elte.hu,
        mingo@redhat.com, netdev@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vinicius.gomes@intel.com, x86@kernel.org, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Sat Sep 29 00:59:43 2018 +0000

    tc: Add support for configuring the taprio scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13cb847f100000
start commit:   7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=102b847f100000
console output: https://syzkaller.appspot.com/x/log.txt?x=17cb847f100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7be693511b29b338
dashboard link: https://syzkaller.appspot.com/bug?extid=b63f85efcdedbba8b3be
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f6948f100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=138eb7a7100000

Reported-by: syzbot+b63f85efcdedbba8b3be@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
