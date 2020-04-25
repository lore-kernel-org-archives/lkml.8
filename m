Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09992C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 00:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCBF02084D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 00:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgDYAXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 20:23:06 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:34523 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgDYAXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 20:23:05 -0400
Received: by mail-il1-f199.google.com with SMTP id z5so7994704ilz.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 17:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=esBSsBbw+kcCXBkpJEM2iyfuK9TKxh9r1ZoVcdUm/nY=;
        b=mowy9wXzS67eKG4TrLAG8Id1BqJDuWK7GoGy1vdFIzLzJNlOeN0+GX3pXbFs5Gc7SM
         kMnxa1Gv/CjzVSjDxN/f6/CyBHtI+BolGt2JKU4ONhPb9s2hOB53a0e8aMVHL85rzp87
         NpWWm6HuSY5TaMkPY1Dk2hXTlJE4CkuoN04bKqQchnKmNSTeAO3hoZ+vXw5qTiAPI++x
         7T9Uc4WuEDM+gaiGuh36cuin9OhJ39TsjiKG/5XwsAppv97C4HxIRJyOvdaJ5RllyKFt
         lPxTJ666quOezVVSkVUcCBS0Tv3emzDYY+GgUbUt8IiZS1ladERO/UUlZoTVbj7AtILJ
         JULA==
X-Gm-Message-State: AGi0Pua+HNJ/Q5OMte+nNKIJzYpMRowOHkJX1YwoKr3sbYl4uMlmumDq
        qVayzx0I5Thfgl2NMlWoMew3aGiJJHpwvWiKKUC55ifnWy60
X-Google-Smtp-Source: APiQypL5JVe43wR3OA9+wBM/bsSnyUQzSomysGMB1rykNrbbIzpZF4k6STnA0yLWvTFxmNUaKhUQRanw35nPbZ32kTlU916icgi/
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d91:: with SMTP id k17mr10959064iow.78.1587774183258;
 Fri, 24 Apr 2020 17:23:03 -0700 (PDT)
Date:   Fri, 24 Apr 2020 17:23:03 -0700
In-Reply-To: <000000000000dd04830598d50133@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d42ee05a4127cfc@google.com>
Subject: Re: KASAN: use-after-free Read in tty_open
From:   syzbot <syzbot+9af6d43c1beabec8fd05@syzkaller.appspotmail.com>
To:     dvyukov@google.com, ebiggers@google.com, gleb@kernel.org,
        gregkh@linuxfoundation.org, gwshan@linux.vnet.ibm.com,
        hpa@zytor.com, jslaby@suse.com, jslaby@suse.cz,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, mpe@ellerman.id.au, pbonzini@redhat.com,
        ruscur@russell.cc, stewart@linux.vnet.ibm.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit ca4463bf8438b403596edd0ec961ca0d4fbe0220
Author: Eric Biggers <ebiggers@google.com>
Date:   Sun Mar 22 03:43:04 2020 +0000

    vt: vt_ioctl: fix VT_DISALLOCATE freeing in-use virtual console

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11594fc8100000
start commit:   07c4b9e9 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=9af6d43c1beabec8fd05
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113886fae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1263520ae00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: vt: vt_ioctl: fix VT_DISALLOCATE freeing in-use virtual console

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
