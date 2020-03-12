Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DAFC4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2119C2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgCLSfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:35:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:39938 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgCLSfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:35:02 -0400
Received: by mail-io1-f69.google.com with SMTP id z207so2372100iof.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 11:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ir7UeiOgRla46VgJyqdvELP5IALvlHJBWBv4Kon2YiQ=;
        b=UVJq4bKgNRagxL/7qzXTjlp6g5EbFHHpc9Vkg3yf2mGMLdHUD6VC5AeCmrEj9GCPed
         YvG4evgNTjOgXwKdJR4/mP/o/0UMMj+dtv3mOiqhpM7J0zm6STmuLUTtZpv/Jvhki4PU
         nozsG6F484OdF4Hbq59+dHg2Xw3t/N+kwibphBZhMNigws9WDR3PLwBpFcjvPnxNjQKc
         rt6KLHcqpYIlNeSZZr3gfWupRKKrpQI55J3STTFVLCQWL2uLiP01ELWm/RHyx/v+7G2c
         terXCmG6QDzapwMeGxWdSAt9gTQW6gkcVzqwWLl7VfrrIVK4Uq+J1g3RWfAFZiUqt6zs
         Pwgg==
X-Gm-Message-State: ANhLgQ3hdOoNBee9+1F3VPp3HoGjQQ/gr5VjtYDDcwi3jGriB02m/LsD
        uPK9bCtChc/ZxCvB/mJXIX84KcZhreZugnSgmmH1PTi9sTvg
X-Google-Smtp-Source: ADFU+vuGqMVU/sCZ2uqRsye5iy6iExo0L2KoabBfOjwzUDCql4SHBehAYnSYwmvKUogZv6oHxiMhvYUhcEbBhS3sxDoZr2KgrRRU
MIME-Version: 1.0
X-Received: by 2002:a02:5489:: with SMTP id t131mr9106656jaa.134.1584038101466;
 Thu, 12 Mar 2020 11:35:01 -0700 (PDT)
Date:   Thu, 12 Mar 2020 11:35:01 -0700
In-Reply-To: <CAJfpegswE6pLBbBmbkPMjmLPjgvn5z=gDEB6cTpe7o84hOuroA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059489f05a0ac9cae@google.com>
Subject: Re: WARNING: lock held when returning to user space in ovl_write_iter
From:   syzbot <syzbot+9331a354f4f624a52a55@syzkaller.appspotmail.com>
To:     jiufei.xue@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        mszeredi@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+9331a354f4f624a52a55@syzkaller.appspotmail.com

Tested on:

commit:         63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
dashboard link: https://syzkaller.appspot.com/bug?extid=9331a354f4f624a52a55
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=134ceef9e00000

Note: testing is done by a robot and is best-effort only.
