Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA34BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952B42078C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgDCVtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:49:04 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:38222 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbgDCVtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 17:49:04 -0400
Received: by mail-il1-f199.google.com with SMTP id b6so8468411iln.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 14:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zSI07CjR5IyEH+/NIlKzkOBeWdFhLCDjSvm8dcjjF9E=;
        b=X56OYrRFggbxN3I/1nAeMnQvWgUSP2kV3NeWoVfMBCnPfON0nCFy3JOso/za1p+8JY
         QsfCmW0fXNs7tnHjxuS8sdWx6UhrsJPi+THaAx6GWYw34A1rPSUsZ6C6caddTxj4+Ivg
         Xrv/FxFBK9PJpcOWdR8G2JTewE5GWqjEinzxFhsP0527Ukt/iBO4M1u7iOZhAdcGHzik
         MMiDCu0Y36rFcH3msq4w6701OxEMnWytS39Vr6H64Nc7aey0KYe4/M4YUz1dQN4Zq6xf
         XVj8dog1Pv/jIBrCSHYaM5Dtqvij1j24F+sIqMJ+/zlQJBDFlwZeyXUgY+DPUQEX3SXE
         mHLQ==
X-Gm-Message-State: AGi0Pubnsr6yipZ7azMg/t4JgpHiGnY6bRxzj0iD2wLQUt9Ahb4ne7Of
        QsJxw8oyyLqlijGlN5KkzliKunZtlLRTb1ZerudMU3A0OUj2
X-Google-Smtp-Source: APiQypIjGi0Wfgk0b25qP452rAzQr3GjIWACeIBF++/I8dzYGRRklPvqHEKztUVWk9BfQ+s9cnDjHNsygkQrmfW6PoH9mK/E1CNX
MIME-Version: 1.0
X-Received: by 2002:a02:2b11:: with SMTP id h17mr10019717jaa.140.1585950543555;
 Fri, 03 Apr 2020 14:49:03 -0700 (PDT)
Date:   Fri, 03 Apr 2020 14:49:03 -0700
In-Reply-To: <CADG63jDvVnX=_5oJSEqrsTUsCuYPj6Grz9dEFLvWpa1F=oa1Lw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7b02e05a269e206@google.com>
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11981b1fe00000

Note: testing is done by a robot and is best-effort only.
