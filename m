Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F06DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B1620734
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgFRR4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:56:10 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:40143 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbgFRR4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:56:06 -0400
Received: by mail-il1-f197.google.com with SMTP id s4so4554790ilc.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 10:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=EFtXSNMLUGInsLNSBypEMpMMFyFYOsaqbMXTYo9acWE=;
        b=EhM6rWQDdUxo3PMscvnlkqQ+liKrQBn9ErwADtUDLsooBSI7y/mNjfigd5MKEo1UxY
         XtUGo3zkSBobhUZcsusQRoqunSVllk+aMm5XMcck6+6YM4k+ahTFx1jUfeuvFLjE+Ri4
         tAjlwjEPn8u9VIXhSGPLVNGFZmMZlqLVF5xP1utXwKNHVKYpEqRQZ736aUdcphJwZi4k
         +yAzRDbW1t+vgBzB4rf3F5RO7B1m76Bw0zJ9cPPGY9G0Mqru+otzTDvwPMy5HOYszfXj
         fMby12/WhqbivRr67oU1O60PhMnIF63Xd/UUvs4jtGTNo1E880tiQUtJ8q4SZ6upPuVS
         QY/A==
X-Gm-Message-State: AOAM530u/m3w8V3Oaguyzf/2c3mkKErpTa54cuKxRtvSKyMNiNfbDKwS
        b3TtJbxHa/llbKfpQXRpk56IlnegPBfS+7ALTZSstGIL32GF
X-Google-Smtp-Source: ABdhPJxyaSvc8IYhW8iRskEa+5nwLcHwdzT7YI+Bk1XFGFOcjid5bO4Xf5g7G5xn+B2xZguzw1cT2eOse36ijX8XtbSjosI9JjkB
MIME-Version: 1.0
X-Received: by 2002:a6b:1785:: with SMTP id 127mr6231079iox.136.1592502964342;
 Thu, 18 Jun 2020 10:56:04 -0700 (PDT)
Date:   Thu, 18 Jun 2020 10:56:04 -0700
In-Reply-To: <000000000000aa674005a845bbc5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e5a7305a85f7dbd@google.com>
Subject: Re: KASAN: null-ptr-deref Write in media_request_close
From:   syzbot <syzbot+6bed2d543cf7e48b822b@syzkaller.appspotmail.com>
To:     ezequiel@collabora.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab+huawei@kernel.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 016baa59bf9f6c2550480b73f18100285e3a4fd2
Author: Ezequiel Garcia <ezequiel@collabora.com>
Date:   Tue Apr 14 22:06:24 2020 +0000

    media: Kconfig: Don't expose the Request API option

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=108d7149100000
start commit:   7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=128d7149100000
console output: https://syzkaller.appspot.com/x/log.txt?x=148d7149100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be4578b3f1083656
dashboard link: https://syzkaller.appspot.com/bug?extid=6bed2d543cf7e48b822b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b3fc35100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fbb6f1100000

Reported-by: syzbot+6bed2d543cf7e48b822b@syzkaller.appspotmail.com
Fixes: 016baa59bf9f ("media: Kconfig: Don't expose the Request API option")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
