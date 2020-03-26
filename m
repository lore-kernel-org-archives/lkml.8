Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AFAC2D0E7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 02:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797152073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 02:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgCZCnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 22:43:03 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:56670 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgCZCnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 22:43:03 -0400
Received: by mail-io1-f71.google.com with SMTP id d13so3900696ioo.23
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 19:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aNKbH0C5nhaSvaxnuPHvbScDrpBtg5wAIeotQ1aTojQ=;
        b=RdD686xVSslBO7Ot4OQWYJw4xZ1qIHRtsIWF8wNcwUKh6fY8JI1aX4cCiaavZ2mXnz
         Ho8T7R/Dd/xvf8UeuycpcTeNp0Hgzeh4tDGPJwhifnEgNxwY8UF5x50GUDxyIMkmi9Tg
         G6hKTOiQZHRRoBH4yhxuHE0yTJPlLWLyoAchgeQI5i6iTpilUyOixgyDaQ8csZcIA3ou
         BOXMiw2rplz3tpeSZwD6Vgi0FGtYNOFGBCT10KbKdboqZZnXuJOwTlzxeDgf3xvcyyTQ
         UNTsxHDlNlsEFc9P2lVuiM2OcIyrMOhPNWG3Q53hk28mDKnT4Jj058BmKQsYTDpZkv4s
         h3pA==
X-Gm-Message-State: ANhLgQ0c+2msyOfWv1NQ2Jm11mzOb1TIos5iJEflx6xDaE1nga6V60k0
        O98CnCE91kQIF5PPSW3ylOAobG+s6++vVT+vgdfIwKLpmvWS
X-Google-Smtp-Source: ADFU+vsyJo5aW8olRQsuP2lZBL8G2f0aIdWmmHouPiIHprsbNVwb6QosdWSqAkw/ANNEu5ryjz7fKFC1xIL+0vYyBOsRmfaXCFbu
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:be7:: with SMTP id d7mr6759283ilu.238.1585190582522;
 Wed, 25 Mar 2020 19:43:02 -0700 (PDT)
Date:   Wed, 25 Mar 2020 19:43:02 -0700
In-Reply-To: <CADG63jDu3Q=OmjaJRKV_drF9vcJt_OhwJoYiKfQ=e0rJif-pOg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000929bf405a1b8f162@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hfa384x_usbin_callback
From:   syzbot <syzbot+7d42d68643a35f71ac8a@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, anenbupt@gmail.com,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        hdanton@sina.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, nishkadg.linux@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+7d42d68643a35f71ac8a@syzkaller.appspotmail.com

Tested on:

commit:         e17994d1 usb: core: kcov: collect coverage from usb comple..
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d64370c438bc60
dashboard link: https://syzkaller.appspot.com/bug?extid=7d42d68643a35f71ac8a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1406d1d3e00000

Note: testing is done by a robot and is best-effort only.
