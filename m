Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB84C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D47120661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgD3PSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:18:04 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:46964 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgD3PSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:18:04 -0400
Received: by mail-io1-f70.google.com with SMTP id e76so1599950iof.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 08:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=JGTxr3NuYyzFEHaxhGOpPcWadTbEs1hwXtwC8XsL+zs=;
        b=P49IiRYpxke5Ptq+P+FRE7A8O63/StfFo7kPlC4AVnCuqdpYP3FQSxE485vtVGJMyf
         7flyLjTdgcwVUQNPSqA55hxJr0Kg58linTvrWZfAordhYXjHqNBMK+pDonPHEk5+EPkl
         DWHGdhbUhJrcv7Y6KTNmbTEolGmVEn3KEBPYUKvB8rTKJei1XMiQeas5zeW6xvonYokM
         EU7fAlChgZLg9iSey7OYen+/guxZ7Tj5VEe52CmKflGmptTOkjl2CX3y4d+jcBDUoNZ5
         1MpHAt4G5l9tDy1G9Hh9wx964BQtX6Hw/+cnDkYZP6kwWktuZaQnidgCgcjLgNYZjmHQ
         DgWg==
X-Gm-Message-State: AGi0PuYHyhGvCOy8sRHJC2mN+IVsMZdNiCDPcsLA4IFzjPSDzw0HQgEs
        Cjze4w/2vfiqBmxEeYKLSSqBR0Jpu2s8mtQUgsOPX6H+obXr
X-Google-Smtp-Source: APiQypJ+2GdMiIan64zRsaTvA84Vhh2H4TpONP2u/LUFqggYTEpvImz55Foa0keMm8tyXX+LkAktBx/3cQ7tSVMFxKaPILiPBKsg
MIME-Version: 1.0
X-Received: by 2002:a6b:8b05:: with SMTP id n5mr2391220iod.68.1588259883479;
 Thu, 30 Apr 2020 08:18:03 -0700 (PDT)
Date:   Thu, 30 Apr 2020 08:18:03 -0700
In-Reply-To: <Pine.LNX.4.44L0.2004301050190.27217-100000@netrider.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a7b2905a4839206@google.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (3)
From:   syzbot <syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        ingrassia@epigenesys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com

Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
dashboard link: https://syzkaller.appspot.com/bug?extid=db339689b2101f6f6071
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12a35540100000

Note: testing is done by a robot and is best-effort only.
