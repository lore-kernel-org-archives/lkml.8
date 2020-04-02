Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28A7C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8081D2063A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389634AbgDBPxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:53:04 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:34650 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388677AbgDBPxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:53:03 -0400
Received: by mail-io1-f70.google.com with SMTP id n26so3257574iop.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 08:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=y7vyX4dwNfImoAb2kTpG/mlept3XB7l7BPC3h9R/j0U=;
        b=RojQVED8A7Tlz8SdHWN35JaltGxzLpEcmEXmbM5X7j5cgnEsXAICiMJ+6Kx/Na7jSA
         GVWJ87Qk6CuOmIib6G/A54E0cM02tujQQOBILsDXfMhvKPE04xcuJi7Ra6b2u8pUJCaL
         UNdUMU+PRfVGHJ/aYSmzkmBr6dlzulj325HW85x+eUUrLMwvYlTfE7VnMu8lT9gxJ3P1
         BrJdOnL98VgGsQxTRTbKuCYhHsqKwQSVSuuLIJF+CnPNT0Fe/KfBAjxKPIC5KVIRlIJ6
         nquwcD4Jm7xCkxJpKi0yQ/lbg7uftRCEXikqYaMr+C0LABiJC8qrHYaYYk8fqi247cpF
         NnVQ==
X-Gm-Message-State: AGi0PubtWx6Mq+uLd5lSAVWt16BbuG8v+KRDBj+XZXK//E0eDuFbXr12
        PPMKFTUpc/pD8Mhj0PdMeDOwmafpyfFr3+Ws7Ubvcxgi00m+
X-Google-Smtp-Source: APiQypIbeARlH3te42UHKEJijHcRjo6btS3ejyDzsS2fN0V2D0ZR4C80RFaYtWLaMBu213izZhliy4NrEep2SZ4XhPMyB9f31M4D
MIME-Version: 1.0
X-Received: by 2002:a92:8604:: with SMTP id g4mr3792122ild.245.1585842783220;
 Thu, 02 Apr 2020 08:53:03 -0700 (PDT)
Date:   Thu, 02 Apr 2020 08:53:03 -0700
In-Reply-To: <Pine.LNX.4.44L0.2004021133440.13377-100000@netrider.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3793205a250cb6a@google.com>
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=143c2c63e00000

Note: testing is done by a robot and is best-effort only.
