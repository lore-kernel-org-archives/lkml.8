Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11695C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E25D72065F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgGWVHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 17:07:10 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:52195 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgGWVHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 17:07:09 -0400
Received: by mail-io1-f69.google.com with SMTP id l1so4885942ioh.18
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 14:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xSJ7/AO/6lFKOpWNdlJkZ7IuUzYOAbFTfGyilIxrJTA=;
        b=uVnV//Kl5t0WZHIET0H4OGB0pCMYq24XMhsFmrI5/PTpZf6+fGNKCiGg4NMpkT3Voi
         Y0fmY9Hua+qINrHI2jq45S8tuRJaaoAR6VGULxIJYrgW8xpFcToUHd81Qg2NLO9N1byt
         MATYYBNKE9oxVjMTCC8Jurx8P0f/OE8n11cO/3GYTy3m6vhi2Ki1ByNRn+xpPPADhBLC
         WBbGDeVBl03+RDHZOsaWl9qfccLW1/GbikfUA5QS5k+XT3jVVZIZMTEPiFwLM5CfE0bW
         xMXZMqFSrkJskffg3CBc9HZehE+G0Xezy5jBX2HYkuxO6I/QFeetMpbzIVFVkA8u1P7y
         tgHw==
X-Gm-Message-State: AOAM531NIhSP9iCMk1sjud0gBWKVOlnj/3Ex/xKQqKzUbH1/LOj/JQvT
        vUPucgqnlqXEBNnZkV5W/IGIBqhP3rtf/iKX2WXc1DMCOL6+
X-Google-Smtp-Source: ABdhPJxYUTSFYLbJirO5SmxzloqaeYADQ3DxhbFAabRldIzWkPHkVFQjpT7AWxxHG1jFZHTks11qkmQ3pLU2rwcKL+yfzctTrFuc
MIME-Version: 1.0
X-Received: by 2002:a6b:4f19:: with SMTP id d25mr219660iob.190.1595538428817;
 Thu, 23 Jul 2020 14:07:08 -0700 (PDT)
Date:   Thu, 23 Jul 2020 14:07:08 -0700
In-Reply-To: <000000000000ba65ba05a2fd48d9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000467ece05ab223d81@google.com>
Subject: Re: kernel BUG at net/core/dev.c:LINE! (3)
From:   syzbot <syzbot+af23e7f3e0a7e10c8b67@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, andy@greyhouse.net,
        andy@infradead.org, arnd@arndb.de, davem@davemloft.net,
        dvhart@infradead.org, gregkh@linuxfoundation.org,
        j.vosburgh@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        peterz@infradead.org, platform-driver-x86@vger.kernel.org,
        skunberg.kelsey@gmail.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vfalico@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 5a707af10da95a53a55011a612e69063491020d4
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Fri Apr 21 13:36:06 2017 +0000

    platform/x86: wmi: Describe function parameters

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a9ad40900000
start commit:   994e99a9 Merge tag 'platform-drivers-x86-v5.8-2' of git://..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16a9ad40900000
console output: https://syzkaller.appspot.com/x/log.txt?x=12a9ad40900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e944500a36bc4d55
dashboard link: https://syzkaller.appspot.com/bug?extid=af23e7f3e0a7e10c8b67
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ea63cf100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14afdb9f100000

Reported-by: syzbot+af23e7f3e0a7e10c8b67@syzkaller.appspotmail.com
Fixes: 5a707af10da9 ("platform/x86: wmi: Describe function parameters")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
