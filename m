Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DAFC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D5720737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgDCVbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:31:06 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:46160 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgDCVbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 17:31:06 -0400
Received: by mail-il1-f197.google.com with SMTP id n18so8360794ilp.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 14:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=SPAwpvKMvYbr6XxAGejDItd1iT8+uNKheRzWPuMzaNE=;
        b=ImEGFYD53Uxt36AdCFa4wyB0lzEGeean4C+Bh30RaAKZY/TpE3Vmh71oiJ2neYpWS6
         RIxkpub+mP1/qUq0OU6OBh5vcX92SknToAC44ZRkn0xBaB50Ep8Qom10d1agDrj4n8+y
         GBQrZsDMVyml3hjxjazRVOXPidayFjGIMcaN/1MdO1GEwiPWjwekj68EbhTIpRb51Rhf
         b1HM26nh0sbMqUk81VHGDMUgEKGyP1oL+ymAjp0LLXOSrkksMgHDw4xk4eVVuuH4a3ug
         FdScpWh3v+W4QmBbJIQXbHnLso+Sx5hnBvk4Xaimen3SvBEOJ3Qe/1oSG1LCfN3Mt4me
         JAAA==
X-Gm-Message-State: AGi0Pua7q1XSthJS3zcpGihM7aMxFzqhghZCGD1EhmVtwmfEZAhkbQdW
        fe3RLV4bZXDgx6kFbNv/7PJxetstgwqLwL+34JdwhJNaQuQh
X-Google-Smtp-Source: APiQypKtbpUx/vzWx0thrapB3XZjS4Im1jHjhnIpoPxECPWeYSgLiP8MWdcuJaBa01aC7/l5u2pJ7JQUYFzktar8s2Ldy/IUQ2JZ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1550:: with SMTP id h16mr9161068iow.171.1585949464055;
 Fri, 03 Apr 2020 14:31:04 -0700 (PDT)
Date:   Fri, 03 Apr 2020 14:31:04 -0700
In-Reply-To: <CADG63jDxb5zkvQwNn=M1ONCsEVZxZBUo8SzN86U01w4tQ5F4Rg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006fd4d605a269a296@google.com>
Subject: Re: KASAN: use-after-free Read in htc_connect_service
From:   syzbot <syzbot+9505af1ae303dabdc646@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+9505af1ae303dabdc646@syzkaller.appspotmail.com

Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
dashboard link: https://syzkaller.appspot.com/bug?extid=9505af1ae303dabdc646
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15bab2cde00000

Note: testing is done by a robot and is best-effort only.
