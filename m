Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A05C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D79324654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgBSLsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 06:48:04 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:38350 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgBSLsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:48:03 -0500
Received: by mail-il1-f198.google.com with SMTP id i67so19815681ilf.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 03:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=iFEJQOMtOjLaubYnrYBmTyyXPvifqApU2+AIOGRL/ps=;
        b=Fw88w7ALY0WNWHRcX8W7FOqZwKrwVhnmnE0SA876BaQ0Tb4HeMnpmG42FqjGmJkEoK
         AL2jucgPOObbNUqQknfDY5iLBhIzG9U+rHa0Wb/4cHJkw98nNh5DUYHFUSoJsK+t/x9B
         gR2EGyQeOV6tEggtg0lmu+RmcSUHmqcQrUc6M99uEtSWffHbUdL6pSsuBPgZh5KODGnk
         NsWwZefZneoNgIfyw/7L0ahT4KSIbgCsZNQFCsLV0KlLYDZIRtPDFC7aFR4U4Wy2w+nd
         Uy4XOfh8KDyWctMuJ/aVj3CQ/nqgDodHEr/WkqWvPgGEr/h3wDefRmTkXl29/Z+0pAVn
         76wQ==
X-Gm-Message-State: APjAAAXj7uPCuzauF5BMmxJykAspXF+lVfuiKZoxCSKN9IP17Jn+yuNS
        QRqFyhr7SBtSnZtmdTM5E2PfpJP83r7z7RukDQ/MSr9BiIyZ
X-Google-Smtp-Source: APXvYqxh7CarR15T4+m7VXrE/hcg2w1fTkfp5+A8SYllXe1zZAmarJXWxG7Hr5Ioc75rV2X82K/lHy+Ydq55ycG0YTdRd8Xlj6tD
MIME-Version: 1.0
X-Received: by 2002:a92:601:: with SMTP id x1mr21808045ilg.35.1582112883122;
 Wed, 19 Feb 2020 03:48:03 -0800 (PST)
Date:   Wed, 19 Feb 2020 03:48:03 -0800
In-Reply-To: <000000000000ca89a80598db0ae5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064ab40059eec5c3e@google.com>
Subject: Re: general protection fault in gcmaes_crypt_by_sg (2)
From:   syzbot <syzbot+675c45cea768b3819803@syzkaller.appspotmail.com>
To:     bp@alien8.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        hpa@zytor.com, jakub.kicinski@netronome.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, netdev@vger.kernel.org,
        simon.horman@netronome.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit db885e66d268884dc72967279b7e84f522556abc
Author: Jakub Kicinski <jakub.kicinski@netronome.com>
Date:   Fri Jan 10 12:38:32 2020 +0000

    net/tls: fix async operation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16871de9e00000
start commit:   07c4b9e9 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=675c45cea768b3819803
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cb0056e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1374f5dee00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: net/tls: fix async operation

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
