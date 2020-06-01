Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD42C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94116206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgFAHYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:24:04 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:55880 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFAHYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:24:04 -0400
Received: by mail-io1-f71.google.com with SMTP id b11so3998295ioh.22
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 00:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dwV5KdRye0e31ymiiDuE0zpC+cSqLV10md4bSh/xCrs=;
        b=VQwMiuQ6tE1+11ceavEKkkMAraq8r/pF9fdEuXPrJ8U7a5TnIJAZ+LEGimozR9Ym4f
         8cLX8gFqpuxxj7Ry97BGtL5PcUaoDS7r6Ub+7qI5djkbr0Ee3CQCFuRgscdDLRR+SOKd
         E5pczx2TTO3kvO1AWw88jBJVk3qkwLneg+LArdEAODGBLFawJO2NSHAZJVkjcGgfJWmb
         QnrccBfBs3xci/pTTpaW0Re1u7cm0qx4KzXMT1kbwH6FDnV09h2CNrwfN0k+LqCRU2sa
         jI2xQmE62HTkDL8oGWYou0EWVEajDM6ML8FfcqkAEo4yT2S3DcBuF42le39VFkgNMuEt
         ranw==
X-Gm-Message-State: AOAM532rkgpdL4FZY1vEpqGq/zxyxRs3U0SVU/EKyHsReVjl9TuL70QU
        yexC8KnUWz7KKy2W7NcexQmpP2NirtPivlNhgL9vMcfXJtbS
X-Google-Smtp-Source: ABdhPJxz/d/kvpzjcnGN1c1YCmqhvS4eT/h31O/xXkEEpT7Iu7wQbzsuHtKsgejoNKPcjY0takGTNoR0er3BCM4tLC0eKtzPO+xJ
MIME-Version: 1.0
X-Received: by 2002:a02:1c83:: with SMTP id c125mr19792368jac.112.1590996243587;
 Mon, 01 Jun 2020 00:24:03 -0700 (PDT)
Date:   Mon, 01 Jun 2020 00:24:03 -0700
In-Reply-To: <000000000000bbd09005a6fdc6cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0261a05a700adf5@google.com>
Subject: Re: WARNING in snd_usbmidi_submit_urb/usb_submit_urb
From:   syzbot <syzbot+5f1d24c49c1d2c427497@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=164afcf2100000
start commit:   bdc48fa1 checkpatch/coding-style: deprecate 80-column warn..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=154afcf2100000
console output: https://syzkaller.appspot.com/x/log.txt?x=114afcf2100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=129ea1e5950835e5
dashboard link: https://syzkaller.appspot.com/bug?extid=5f1d24c49c1d2c427497
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d70cf2100000

Reported-by: syzbot+5f1d24c49c1d2c427497@syzkaller.appspotmail.com
Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
