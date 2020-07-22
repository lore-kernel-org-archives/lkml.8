Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E17C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4C22071A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgGVWYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 18:24:08 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:40041 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgGVWYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 18:24:08 -0400
Received: by mail-il1-f198.google.com with SMTP id z16so2132073ill.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 15:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wyels00yuO2hXMVYbZQVnCTESUbWVpmiNO+l3fFwAEg=;
        b=a7Dn8QAppHRg3swKgSoYEhfPSCwZljN/XhunOBx+FKFGMycY0GYEtHXL4hF+1la9Rg
         Mc7UkZeRh0RBCrIRAutjhfiXlyhB7Y3s3qfWf9oreihah6EpDj0wWngYWCjBkKpKbcWv
         fFEgZPv6F+GxhEz6F1A4tRMi2EIg4wDKuWA/Tmt1jbq1GYPgYl/wRQcO63uN/49DcnNz
         nbWs5uAtbhmqOpHzNhZy8C2rr8A+NdD0+TEBKpKJAqCBPoeucv0CIP01kHED5glZhzGL
         a0p6pikd6LjQfXEtVuaW9JP7qD5YZlUfYH95y/Lrp62jxjg3pynQ6ukCsvYPPN7eOtDf
         eu4Q==
X-Gm-Message-State: AOAM5335BX/Urw5VuoCkTt0P7djzCuWKiWr/gD75FLvyqOlE9a+noFvn
        e0VBrwF6N0B/SCINnhvGYr1vogQ/DRG41KOx0CKc4TbvWnOF
X-Google-Smtp-Source: ABdhPJxjCcHozifK7eLXi30QKZ6a69Z/FmqquTzaVoaFK0E57gWv+ZSUlpHJnnPfhdRwhMZOJa28BI3Nn7D0lDWwXXKE1mAUB+OI
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13ce:: with SMTP id i14mr1515751jaj.62.1595456647624;
 Wed, 22 Jul 2020 15:24:07 -0700 (PDT)
Date:   Wed, 22 Jul 2020 15:24:07 -0700
In-Reply-To: <CAM_iQpXKJ2SA=pRFEjwAwLkR_bw-y7ZqnSoe3zPqJc-CKv09Xw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc7a5905ab0f32b9@google.com>
Subject: Re: KASAN: use-after-free Write in __linkwatch_run_queue
From:   syzbot <syzbot+bbc3a11c4da63c1b74d6@syzkaller.appspotmail.com>
To:     andrew@lunn.ch, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+bbc3a11c4da63c1b74d6@syzkaller.appspotmail.com

Tested on:

commit:         0c473089 bonding: fix register_netdevice() in bond_newlink()
git tree:       https://github.com/congwang/linux.git net
kernel config:  https://syzkaller.appspot.com/x/.config?x=dddbcb5a9f4192db
dashboard link: https://syzkaller.appspot.com/bug?extid=bbc3a11c4da63c1b74d6
compiler:       gcc (GCC) 10.1.0-syz 20200507

Note: testing is done by a robot and is best-effort only.
