Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A92C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0B620675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgENJIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:08:06 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:51003 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgENJIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:08:06 -0400
Received: by mail-io1-f70.google.com with SMTP id b21so1851693iob.17
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 02:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=t+L8A9JFXmMTj8UgdC85xQfnigFPoelWUd0rvBKXTDk=;
        b=WzbSH04c6byc2n066kyTMzCrqGmh6K/qtThMsrgACwsYAcFTrjrtxpEckFR4Mwwel+
         +96TOU3vjgb74jJA97lA0I03/WhVhncQgf/IfEit01TmiXeMjgxCWEuwUuz4CL8KM8Q/
         V3c6xbqm74OyRpOLl6Q9j0xzRDmb5GqIumo1GDV1qMmWAOjm3P395BjSLR6uBMvJy6EZ
         TnNYA8G9XPwHzLvfTgBUdkQcuycuuPY1+3uC+kHeVpq7jiH7wRhZ4bfyIJ2E7wekCVnz
         WSW0S6IlgmRHIhRk7G5B0cmbOOE1t2XjhJ1KX5PsSIpDeIvU6heINIAFb79GBRsHTqRf
         dpHw==
X-Gm-Message-State: AOAM530HLA7UNr4NuDRLbnZd3b3GWimDM2cB9e2yRIc3hhGm6m3Qb6ze
        ++CdlZJ9YOaIyAgEPs0qUv2lohOpi0YwQjPFEjObLq29aCw5
X-Google-Smtp-Source: ABdhPJztFM85l7FEKdyZ95KpoEvXKV9e+4xvtKyOyNebdeGNlGG938KQev9qq9G6+CxhGhQzpbdQpbAnPZE7r3RtbN7V23bvCrD4
MIME-Version: 1.0
X-Received: by 2002:a92:3607:: with SMTP id d7mr3281292ila.222.1589447285459;
 Thu, 14 May 2020 02:08:05 -0700 (PDT)
Date:   Thu, 14 May 2020 02:08:05 -0700
In-Reply-To: <20200514035458.14760-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6cf5705a5980874@google.com>
Subject: Re: WARNING in memtype_reserve
From:   syzbot <syzbot+353be47c9ce21b68b7ed@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, hch@lst.de, hdanton@sina.com,
        jeremy.linton@arm.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+353be47c9ce21b68b7ed@syzkaller.appspotmail.com

Tested on:

commit:         d5eeab8d Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0212dbee046bc1f
dashboard link: https://syzkaller.appspot.com/bug?extid=353be47c9ce21b68b7ed
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1046a052100000

Note: testing is done by a robot and is best-effort only.
