Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96366C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680D320714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgCZVZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:25:05 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:44107 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCZVZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:25:04 -0400
Received: by mail-io1-f70.google.com with SMTP id h4so6568619ior.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 14:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=R0UtT0wl+/DHJxOHjaoWbQcF3VR+MnxFmO8PugCJFXM=;
        b=JmMvWwq4HYsu7S7v00ZDI9Nvu8QFHUVvTwAWfPNB3ziwo4M8Zs2ZpO5dmqKJ4x3aEO
         4YewGzEK4WN7vKSu33l0xIkqtre+xwyZiAwlAavbqbBxNKTqj1NipE+SW7GZB3OACE8C
         mddPAJiS3yN/gC+cRq0Omf3/Pmyt1HzrMXXdgqNBNie0W6foBnsry3wwM6owyNr3jesH
         jBXPGp3JLFMu01jPJMUtzZfmqHz2OhkEZ8AcggAzGf67Rh4NHGAanP2K0sckZGt83HvA
         HKPsGnoSjNA8Oq9DrW1HRe4hczictdum+4FPuBgS3wmgPqIc1wTJolUwuoCsBOGkpPLJ
         RMyw==
X-Gm-Message-State: ANhLgQ15zOCw1H/ahp6xSLJ4Nr5xYpQ20BN6uOk25fG9vnIVlS7IbJzE
        VNyxTb4H6aGnjOExGrB2WQtzCzBoiG4eRr74vJOrfnf8wyxP
X-Google-Smtp-Source: ADFU+vuq1ZdA15x+aWbKAF5XR3OUgPZocunA3rxU2f2eixsCPsTJVpYHE8hrML1m+H2C0/QHibYoQEO8qicie9S7k8eG7C6Y0h32
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3a4:: with SMTP id z4mr9602598jap.141.1585257901712;
 Thu, 26 Mar 2020 14:25:01 -0700 (PDT)
Date:   Thu, 26 Mar 2020 14:25:01 -0700
In-Reply-To: <CADG63jDGY1dEQ9uS5Cd9q3DeEKWTff-4FC=UiEBpuh2caSLwOQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bedcf05a1c89e96@google.com>
Subject: Re: WARNING: refcount bug in sctp_wfree
From:   syzbot <syzbot+cea71eec5d6de256d54d@syzkaller.appspotmail.com>
To:     anenbupt@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
        marcelo.leitner@gmail.com, netdev@vger.kernel.org,
        nhorman@tuxdriver.com, syzkaller-bugs@googlegroups.com,
        vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+cea71eec5d6de256d54d@syzkaller.appspotmail.com

Tested on:

commit:         9420e8ad Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ac76c43beddbd9
dashboard link: https://syzkaller.appspot.com/bug?extid=cea71eec5d6de256d54d
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1670bfbbe00000

Note: testing is done by a robot and is best-effort only.
