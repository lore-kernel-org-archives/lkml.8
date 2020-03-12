Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0892EC4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 07:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECAF2206B1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 07:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388075AbgCLHME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 03:12:04 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:40072 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387767AbgCLHMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 03:12:03 -0400
Received: by mail-io1-f70.google.com with SMTP id z207so1081129iof.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 00:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NkGoJSV/Bp/D1AVTh2vJ5bc0esVeByDEUU8v4C2fFZI=;
        b=f8/KlnMJOpLp3U7lanxoQvxZZEb2e0PRhadb2yKLiTEkMSXxLwFEw2HPznUfwlPBra
         0Lu2vcu4SDiPZvgrLGz3qJ8z8aSAzZG7caHKkzrdTYkJHswflx2qiGYk7eIInGunCVOz
         2T1k7cgCyd2pgyGQ8pPf9Khg9f4PcIpU3UMcQfU2Eu1/+pZXAs7DArHfYL+RnbowWNlM
         wIA8BMvGU4WGn9rYaVEVSuIKO0mMZIOFjEuXIQOaCUOlLPA2I4OLNtMP5TQhR8i1weIx
         Sk+NvyWNBicIHFDR2mAJU15AOIxifpuw8prlPbbmtSZrW9xR7Q9bLb5lFB4N7yWZIlPI
         FgpQ==
X-Gm-Message-State: ANhLgQ1xneqIgQ2JRHe3SWcTA9YGTmsOU2FQscC9nY42gyJYxNG2d8fI
        AJCrj4jzWaDZHVJl421eR/MYYyYx+8GYWKR7s4bmo3ktBp0S
X-Google-Smtp-Source: ADFU+vu0tdPEZAEJ4MkiMJN9x0Wbxty5U2bPaFvIoXsT+C6ccTSohSa61FoSXLPgeHbcrwZMk4ztdS8AxE6Gq/FdTX412XuVHtKt
MIME-Version: 1.0
X-Received: by 2002:a02:30c8:: with SMTP id q191mr6475552jaq.34.1583997121957;
 Thu, 12 Mar 2020 00:12:01 -0700 (PDT)
Date:   Thu, 12 Mar 2020 00:12:01 -0700
In-Reply-To: <0000000000000ea4b4059fb33201@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7979105a0a311f6@google.com>
Subject: Re: WARNING in geneve_exit_batch_net (2)
From:   syzbot <syzbot+68a8ed58e3d17c700de5@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        hdanton@sina.com, jbenc@redhat.com, kadlec@blackhole.kfki.hu,
        linux-kernel@vger.kernel.org, moshe@mellanox.com,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, sd@queasysnail.net,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 4e645b47c4f000a503b9c90163ad905786b9bc1d
Author: Florian Westphal <fw@strlen.de>
Date:   Thu Nov 30 23:21:02 2017 +0000

    netfilter: core: make nf_unregister_net_hooks simple wrapper again

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1594fbfde00000
start commit:   63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1794fbfde00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1394fbfde00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
dashboard link: https://syzkaller.appspot.com/bug?extid=68a8ed58e3d17c700de5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f08165e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17902329e00000

Reported-by: syzbot+68a8ed58e3d17c700de5@syzkaller.appspotmail.com
Fixes: 4e645b47c4f0 ("netfilter: core: make nf_unregister_net_hooks simple wrapper again")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
