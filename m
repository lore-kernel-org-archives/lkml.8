Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8264EC2BA17
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 22:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D802078C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 22:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgDCWpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 18:45:07 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:41055 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbgDCWpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 18:45:06 -0400
Received: by mail-il1-f197.google.com with SMTP id f19so8513526ill.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 15:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zSmQHMpVTPuNbvjhNgH4TOFQnalp5wC6Xun5Vz1zvC8=;
        b=cRjUqWW9S/DvG9wueVuvyefx7eseLctHjkIJB5Hftj7lJfaz9HaUE8ox676QkrC0Gy
         IKWQWuc1zSHJvR4pZiRvwte3EMsscLZxNPJRDJe8oQwiZCHs1xH6dMwgw9IeOrtM+wqY
         BLoKODaFk1OhDqOHlKU1ywXen7evhZVfRXIsU6D71s0851i+5VhqYqugPY/v1sRfG0gv
         98w/bU+TqQEmgr9knRTxTVlCBPWH0ddBCeeR1WTxNf+rxBC7ao/hhK0AWTIRBZcjESwk
         wuFF+HGVUVHW8222mMFYNLAQ/l2XGaoZiI/Q/LTUKUB2/nAZAwoJfOB/xpB/kDXA0xg9
         Eb4g==
X-Gm-Message-State: AGi0PuayuWLfXjAbFMwKiI3BL8SolIiKFjY9GfaiW/Pi7pCh9Mvvrbel
        rq8ud+xZWBqh0SQUq1FRiNtGG3DtVyr5C6uLHq+X55uFWQ/Y
X-Google-Smtp-Source: APiQypIKDmUyBf9guvJkvEFIs6BXHK+tEO0WOLsZVEYo5TOyYoc094K76H4pzciRloGviGw2V0QWvIABWL18PjwKEBogYoICkj7b
MIME-Version: 1.0
X-Received: by 2002:a5d:9e4d:: with SMTP id i13mr9625291ioi.43.1585953904624;
 Fri, 03 Apr 2020 15:45:04 -0700 (PDT)
Date:   Fri, 03 Apr 2020 15:45:04 -0700
In-Reply-To: <CADG63jAuwRJ4uRH2qUGgqPP+Cjq0w7PrKziU4G3jWS3K4wpJog@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d8c7d05a26aab0c@google.com>
Subject: Re: KASAN: stack-out-of-bounds Write in ath9k_hif_usb_rx_cb
From:   syzbot <syzbot+d403396d4df67ad0bd5f@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+d403396d4df67ad0bd5f@syzkaller.appspotmail.com

Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=a782c087b1f425c6
dashboard link: https://syzkaller.appspot.com/bug?extid=d403396d4df67ad0bd5f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15bd0cfbe00000

Note: testing is done by a robot and is best-effort only.
