Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607B4C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 04:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274A6206D4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 04:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgDDEJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 00:09:06 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:54215 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgDDEJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 00:09:05 -0400
Received: by mail-il1-f200.google.com with SMTP id a15so9130237ilh.20
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 21:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=diBIYrBkL43yhmYF0/S2uMZTr+kD81tZauofr3nRl24=;
        b=pE5PsyutVncTjUAKVaKKVZ/jSBLmVAxXn2YkpfFv6cS1kR74JJfOw1YMKsGGmYsJag
         MIMqvEd++NANMNwVoM1P9C143PEkkoWdhwAtZYpx7Euw6vm3ReQWuRN2fL/1MhUbvIpO
         j1b+g49FSi/S32PWa89W/xZ9k9YytTJxB8fWeG8v0wNVG8tJ59EWT52N9lkLREk1rpab
         ulsITjMGTNwnmIza4/5QjfBFkpFf4hShC4QySnnd98chA4dJGdpVxm8ljSBIIyEuzl+1
         DT51+mUpWC3/cQ+38PZcYAvx3cs53nBN5HEjDRxp5exniSdzi1KjpmCuBSacQ1+Qm6BA
         YvsA==
X-Gm-Message-State: AGi0PubAtcixjUpk8+g/K5SZnljRzL7on6YCLmargN0APMpdgV6w9z76
        BCPHUz+arSzJUwzl2liy5SYTruR4c2Qxv9prsE+PRMronw2N
X-Google-Smtp-Source: APiQypJ5efjfRCN5u7ZAYjDOHXe+DOFRnUU7zbwH7K1RJaIG4HFLng7f7L5dljhYeD3j82EhyOQlk1THoej8y+TkewC+4f/Gn6uz
MIME-Version: 1.0
X-Received: by 2002:a92:d108:: with SMTP id a8mr12182305ilb.107.1585973345184;
 Fri, 03 Apr 2020 21:09:05 -0700 (PDT)
Date:   Fri, 03 Apr 2020 21:09:05 -0700
In-Reply-To: <CADG63jDQEbMbmRsmQ=xVQyG_Gy=vqTYhFZ1J+3k1dTX_K75s6w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dcf19a05a26f3110@google.com>
Subject: Re: KASAN: use-after-free Read in ath9k_wmi_ctrl_rx
From:   syzbot <syzbot+5d338854440137ea0fef@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+5d338854440137ea0fef@syzkaller.appspotmail.com

Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=a782c087b1f425c6
dashboard link: https://syzkaller.appspot.com/bug?extid=5d338854440137ea0fef
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11646f93e00000

Note: testing is done by a robot and is best-effort only.
