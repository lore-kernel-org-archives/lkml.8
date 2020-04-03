Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BCAC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D657220719
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgDCUcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:32:04 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:34558 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgDCUcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:32:04 -0400
Received: by mail-io1-f72.google.com with SMTP id n26so7201529iop.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 13:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=w8mFdsMhO76bZFqWMwIe+0AsU+lplHC+HdX5ScRWf2o=;
        b=TLK1jpf7zuRcJRkVC7nV0Z2BwURQQhQaYMhwFa8ux3CYzTxzD/OXK67dnOCgBUV3lf
         s4kCIESE7Slu5LpbklOyM54HzJdnqiJcBIYpkTxNx1Ldpzs63EyMcort7Sni8unD4w7g
         7vrBZLV88MutZ/NBw+5xbsmPGhXeDcn+sCRadKUTEXXNPvX6GMn3BX/mnbotxCEA+n4Y
         23Db9U+MQ4WQtOjiQb/zRHS/dZjwIi4/M4DHBm3xF/9qC/BBpyHFPPYy/7hCu3od3/KC
         qMYAG6yLVhwmtOgHj4QdkhkUp62Eh/Pv5MH53674nRfG1JeYimqRjct60AyQXiLAHyq2
         g0+Q==
X-Gm-Message-State: AGi0PuZ8FFWLj2jNC0hJjYGTHFLZ5uB/BlUdAD4abMvJpHlBjqBf+kW/
        riSuqW+3AqFULK7M6GwkY7MWAVEM6hsYmn69KM3l/Gql1f2D
X-Google-Smtp-Source: APiQypL7/jcPzgJ8/OUT0G36YxdR1mbGZlszf4LQ7Ts2iHfYZMZCQYXEICwC6jd7nw2CDDArjKeiPzryS0MxWW+sw+5fXTvdVwjx
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:790:: with SMTP id q16mr10888997ils.295.1585945923666;
 Fri, 03 Apr 2020 13:32:03 -0700 (PDT)
Date:   Fri, 03 Apr 2020 13:32:03 -0700
In-Reply-To: <CADG63jBkWfxOSsJ=7FkB-6ScdW48VPJZLV2KrhCVLjVRCASzhQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069c9de05a268cf5f@google.com>
Subject: Re: general protection fault in ath9k_hif_usb_rx_cb
From:   syzbot <syzbot+40d5d2e8a4680952f042@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+40d5d2e8a4680952f042@syzkaller.appspotmail.com

Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=a782c087b1f425c6
dashboard link: https://syzkaller.appspot.com/bug?extid=40d5d2e8a4680952f042
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17b013b7e00000

Note: testing is done by a robot and is best-effort only.
