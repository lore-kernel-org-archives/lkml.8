Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A943DC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F2D22067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgGOFnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 01:43:06 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:35119 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbgGOFnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 01:43:05 -0400
Received: by mail-io1-f72.google.com with SMTP id i204so735586ioa.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/z2x/BsnXueVROTB2+EfJc+boAw0TokYStszpq182V8=;
        b=PEHlC/4GVPCzAiw7O2X3fJ7DWjMOwNKaa6C/UF/F35S37N6eMaiFtGXzjrEz2BZnTR
         j4WhghfavqHxabzFpp1o8CD0L+IEKDK5kErRzPoAACt3h1bxoZ9MagW3AMQXeKhKkVMe
         qKnAhoTH5A6YX0WaDWyZ89wMsxzy5q5A0IR2bgK4Yy3e5ABw1jy8mFHrPOIWtMP5fopA
         oEQPghlsw29aR0kUyO6W7r6ofxL1xUME+M5BRzsLRilRUzrO6srptj2ebDdauCsGTwfh
         jCVaHvxUMPCNJTm+Sq0e8sbUzrc1XWKbSzReDdczEo/XSvoGlHDFp+P3miTgiV7gVFjM
         XbHw==
X-Gm-Message-State: AOAM532+MPoRrrp/rFaqYLlaEYCNGpKOzov6PFiMnKz9586vTRNzHV2Z
        NfbTfagGG0YYO2Kw5ryuzwRYCdqzsdJcNbMjKntGj0HNB7T6
X-Google-Smtp-Source: ABdhPJwjK+YsDz9DCMtkcUKewccMP7gwa0bvnKpr7nngnJQGwjL5uJUGDmQoZeU6zE2L47JMOzdR8e3Cmdi/wnee0F6CBDeoyLKa
MIME-Version: 1.0
X-Received: by 2002:a6b:691d:: with SMTP id e29mr8454664ioc.159.1594791784843;
 Tue, 14 Jul 2020 22:43:04 -0700 (PDT)
Date:   Tue, 14 Jul 2020 22:43:04 -0700
In-Reply-To: <000000000000080a5f05aa4691a8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d38e6805aa746577@google.com>
Subject: Re: BUG: soft lockup in smp_call_function
From:   syzbot <syzbot+cce3691658bef1b12ac9@syzkaller.appspotmail.com>
To:     bp@alien8.de, davem@davemloft.net, dvyukov@google.com,
        hpa@zytor.com, jhs@mojatatu.com, jiri@resnulli.us,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        luto@amacapital.net, luto@kernel.org, mingo@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vinicius.gomes@intel.com, wad@chromium.org,
        x86@kernel.org, xiyou.wangcong@gmail.com
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1196d06f100000
start commit:   4437dd6e Merge tag 'io_uring-5.8-2020-07-12' of git://git...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1396d06f100000
console output: https://syzkaller.appspot.com/x/log.txt?x=1596d06f100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66ad203c2bb6d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=cce3691658bef1b12ac9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a160bf100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d2bd77100000

Reported-by: syzbot+cce3691658bef1b12ac9@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
