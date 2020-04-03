Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866B3C2BA18
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 02:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DD420787
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 02:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390360AbgDCCHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 22:07:07 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:54888 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390227AbgDCCHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 22:07:06 -0400
Received: by mail-il1-f200.google.com with SMTP id m2so5348108ilb.21
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 19:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7J/k6eEvJIq17JOSR8idMeCvoHGU5sGu3VSOhnubzmQ=;
        b=bJudWkHu0lMAp/kDlKjtoUw3TsLB7k+NX6+Y/Rw+2iRLl6n+OS2SWbPAGhmXHiqqe4
         FJMdYnaqzxt5dX4v0Xd3kb8+07VraT93Kmbhp5WyQ8eF2JMoxK/W4QtVNYlZA59F5CYH
         qkP0MtmdIq0BZCFJy1JNb2jofgNGqd5+/Ql5ulXPj0dfIb7jB/V8lxutuffMMktTccLA
         MF2cNf1nS0dLDno/flOlrPPdqZY0CPQ8VThaVEzDTPonTU80lqrJZBLdVOh3v0lhQ+wP
         0XMBGJ8q/0E1ZIh6LZmJDkEiIaxlAak52SZdWSg1pitL82qRFSVoc+10/JsFijabNdTI
         IL6w==
X-Gm-Message-State: AGi0PuZjzUI1zOkrv+6Io0pY9nIM1kKb0TAQd4Ouvg5msWK44K/yLut9
        jgdDyJsCQij5CI6b/LquxeSXLIy743aHnjqiMxKXooI0LL1P
X-Google-Smtp-Source: APiQypIAlBCMDIO8Mp11ihUP2Aa0Ng3EkKSMlaylNoj+IQZ2XoML5J9qeSvuWJ7dpt7NnOEllOT2e+Bk8VEnYuPTEsrmo2SdkbZx
MIME-Version: 1.0
X-Received: by 2002:a6b:dd14:: with SMTP id f20mr5790683ioc.123.1585879624594;
 Thu, 02 Apr 2020 19:07:04 -0700 (PDT)
Date:   Thu, 02 Apr 2020 19:07:04 -0700
In-Reply-To: <CADG63jC06pj4pSrKMKQeK1pedyRnjNTWWmTzg-6rNbQh5c6=Ug@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae3c0205a2595fc4@google.com>
Subject: Re: KASAN: use-after-free Write in ath9k_htc_rx_msg
From:   syzbot <syzbot+b1c61e5f11be5782f192@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, anenbupt@gmail.com,
        ath9k-devel@qca.qualcomm.com, davem@davemloft.net,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+b1c61e5f11be5782f192@syzkaller.appspotmail.com

Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=a782c087b1f425c6
dashboard link: https://syzkaller.appspot.com/bug?extid=b1c61e5f11be5782f192
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=172383dbe00000

Note: testing is done by a robot and is best-effort only.
