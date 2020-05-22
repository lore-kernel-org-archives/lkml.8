Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21D7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89F162073B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbgEVXSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 19:18:04 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:34504 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731041AbgEVXSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 19:18:04 -0400
Received: by mail-io1-f71.google.com with SMTP id r17so8412938ioa.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 16:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hY+OQTAuY6M9q+ZlmlR3e05EdcbrRXkCCbneZ37ciSs=;
        b=pjSBLG1TSMlh5YaAskxTOhuc9x/4ZEHvxtDR+0ppKpl4Mqdbw5ncyREnBHpQbtRr+T
         zjFWWdBCCcXiZc6lFrmhQS0Oa5Z//Vn7mv6uLUFvRYxuEgljLrlVNPdbq1xrXkU3Gx2a
         CiqnKugr4XhDV0Odsz8OEn9Vd3/uBzJOZz/ZdT2v5fj9pJ0t0SemfBqh+0LM3uRIjfAY
         klXkRBWoxQ3/kao2nkAKMp/EzWd9GYxZ4gGPpVyIMqKg2oJ/j7lRy0iIGuVk7itOEEee
         RQEhNvDnF/W+iOG8v9c6YWo8ib9Jpx+Dt4v0HxaEJYteilutFM9Y/o7YJtPRpT9ZEkdO
         c+pg==
X-Gm-Message-State: AOAM530rHrM/CTiqEFEscYR4kvAmHDSWkzNiKNPOuENBZMrVrTzt0o7t
        O43eNs63KRyDPaXHoD8oGCv4V1VXFLmtbk4PpUStIHWZ9e/J
X-Google-Smtp-Source: ABdhPJwgYqS05aE4+oBbSGGIRzX2fn9OewAC8LgxkJqcCKZPII9tPeLQBXsUSEDvz5Roj7zFdf6zjg2Dj5BNDCyhUjhu5gkgsAJs
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:68d:: with SMTP id o13mr15946835ils.230.1590189483733;
 Fri, 22 May 2020 16:18:03 -0700 (PDT)
Date:   Fri, 22 May 2020 16:18:03 -0700
In-Reply-To: <000000000000fc0c1c05a0ffc2b8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004db88405a644d75e@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in dlfb_usb_probe
From:   syzbot <syzbot+ed94135f896a14d75284@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rafael@kernel.org,
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10510cba100000
start commit:   051143e1 Merge tag 'apparmor-pr-2020-05-21' of git://git.k..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12510cba100000
console output: https://syzkaller.appspot.com/x/log.txt?x=14510cba100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3368ce0cc5f5ace
dashboard link: https://syzkaller.appspot.com/bug?extid=ed94135f896a14d75284
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103d795e100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143d795e100000

Reported-by: syzbot+ed94135f896a14d75284@syzkaller.appspotmail.com
Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
