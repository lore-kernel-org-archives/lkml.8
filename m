Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C610C3404E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2E621D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgBSHyE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:54:04 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:51312 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgBSHyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:54:04 -0500
Received: by mail-il1-f198.google.com with SMTP id c12so19225862ilr.18
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 23:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=bhiLhZ0hGFmHCjOA0xxswOfkox27Yu7xmMOMfRdjKnY=;
        b=gQXB5y3oCBNilMM8O+EiFL7AtKASuXWsMWFUkUNS4unf1B/fBqJJ/Lmtj90Y9OQgPI
         w2BnS7tYZnJnOm2Zxm9LPPhfFYs14rb/1XL8Sz0jJJYn0lJ6WLeoyUfugR45Ott9JT48
         fc8S/srOKQ8BN9GlW6t2gaI8J3xo3BVVEtEi6+G1IyiQcWuAu22QCHTvpXCZnSIvGyUJ
         tUtOI7riNdT4CR4etgxB3MNj2s4JhIHeWisnJPznGeC/Fv2IN8LgxWYZtjK285FwzqZH
         I3FtXN7yTW5Gk8T4G6NI0d5C7k2054OcjeIOXQEOxg1ug8sQFsw1yA8rkCIBchpYuROG
         wc8Q==
X-Gm-Message-State: APjAAAVsFJCo1jbWEf8MpyzHV8RqOq+j0VoV0v6Tivx5KRCg00UiJJWB
        BKzNMF+MPMxY5tx6VgB5eu4bEa1/eFEsa2uOU1QOaQ+Kp4qt
X-Google-Smtp-Source: APXvYqxGYY13aZOMM0BSOmDQMzSYZrf2qmPLxLF8eTHCcZFD8r1N2DfCNIuzDx8cL8jZ8cKMDsJUm0ShbBazBm0Pcb2Lzvn6MzqR
MIME-Version: 1.0
X-Received: by 2002:a02:2101:: with SMTP id e1mr19970446jaa.29.1582098843467;
 Tue, 18 Feb 2020 23:54:03 -0800 (PST)
Date:   Tue, 18 Feb 2020 23:54:03 -0800
In-Reply-To: <0000000000006d7b1e059c7db653@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000908c50059ee9173a@google.com>
Subject: Re: KASAN: use-after-free Read in bitmap_ip_ext_cleanup
From:   syzbot <syzbot+b554d01b6c7870b17da2@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        bridge@lists.linux-foundation.org, coreteam@netfilter.org,
        davem@davemloft.net, florent.fourcot@wifirst.fr, fw@strlen.de,
        jeremy@azazel.net, johannes.berg@intel.com,
        kadlec@blackhole.kfki.hu, kadlec@netfilter.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        nikolay@cumulusnetworks.com, pablo@netfilter.org,
        roopa@cumulusnetworks.com, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 32c72165dbd0e246e69d16a3ad348a4851afd415
Author: Kadlecsik József <kadlec@blackhole.kfki.hu>
Date:   Sun Jan 19 21:06:49 2020 +0000

    netfilter: ipset: use bitmap infrastructure completely

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17079245e00000
start commit:   8f8972a3 Merge tag 'mtd/fixes-for-5.5-rc7' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9290aeb7e6cf1c4
dashboard link: https://syzkaller.appspot.com/bug?extid=b554d01b6c7870b17da2
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145948d6e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16202cc9e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: netfilter: ipset: use bitmap infrastructure completely

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
