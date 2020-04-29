Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11651C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC8C206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgD2UaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:30:05 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:56676 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgD2UaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 16:30:04 -0400
Received: by mail-io1-f69.google.com with SMTP id 2so3730983ioy.23
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 13:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=P36ux4kpJA4yJ0M9w1keQlA8L7/Ku3ikNPWzORzqPpQ=;
        b=oGeVbofRWEbGz7F+Y1GxFMo8nx/mwoX6cS9YIcLTQOjC/SNtR/w7D+7cMNgaGhI8QG
         sxrSUMC9MjkpwOmf8RYWNKJ+AlPqTdEq8qjTCzPRRiEf3s6PyWucROoXgpjY2/Eg6QDM
         7gD5NsPQlkhmjSN7SbKBE9sp5hwmlWhrHR2bVp5BxvOEKZEShgwpCgLmvFE5oTGAGy8Y
         +QBGUdpiUN/EVZfbQRkp+pilhyiN7HCeMg9siK+EekGkUNIM1PvPLRdfbbxv9clU6PMc
         BQsvmATD5V30RCHX7T3zxQXILrhCZKf/++sNR/oA95Sj4CTyK6gqFRadTHa+1Rg606Fi
         t5Bg==
X-Gm-Message-State: AGi0PuZxAgFSPLoc2qMpyBYsreY7XPXgNPOPCfD4GeJ6ukk3kpeQRTQF
        JwOMWPo3AtT3RnEai8nMjGDwa1LpsRFn3HDkCTCtciqQpH9l
X-Google-Smtp-Source: APiQypJtO21lrjpHALiSJyG1R7XX5MYRsAvJuVRMEvqi38U8bebrgP09swd00jLT9r90N3751dAGaeiGZhTX2GTT/KujJwiW1QaN
MIME-Version: 1.0
X-Received: by 2002:a02:6a4e:: with SMTP id m14mr32417870jaf.17.1588192203152;
 Wed, 29 Apr 2020 13:30:03 -0700 (PDT)
Date:   Wed, 29 Apr 2020 13:30:03 -0700
In-Reply-To: <Pine.LNX.4.44L0.2004291608270.24784-100000@netrider.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001aa0e705a473d05c@google.com>
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14a84ac4100000

Note: testing is done by a robot and is best-effort only.
