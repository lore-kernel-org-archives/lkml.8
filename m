Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7102CC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C5E82075B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgH2SXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 14:23:14 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:38597 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgH2SXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 14:23:08 -0400
Received: by mail-il1-f198.google.com with SMTP id m10so1811934ild.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 11:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=bPIxx1nU1y1vRAICXwgpqNsvENjqeAPVEB+JHRttykM=;
        b=W3QtA8TBvIoU6VdSCIuCCNL3VQBinLybWmMEVA3HXOzQf4dxplh3fzvskPV67vbEVY
         MUpIEIX09kdLN/AZSks3fwtswIpRacCqj6twX1z9TAeoB1d0dO3pgcYOaFLvx/4Czukn
         VtTtmqgzQ0++5AmaV+M8xZKtgIMbsWvIUv2k3V3X3sYGZ7KNx5COVcD8ji+IV+ASKBFm
         TfDHRQdAy0DWDLFYX+1YV9WjhWkowDZ1FTCgi2P8iTJLDa4yaE0W5wCqaVOi7smLzuLG
         h6zcXYkeOt4vtfRtYCgiPJLlZSq7GmAjami0P2X7DDR0Ps9x9uzNdi3EkBOH8pdqncAB
         FWPQ==
X-Gm-Message-State: AOAM530Jxfu7fQxXzjnxY2lYdZrryl/gO05yFq0tROhSJ3AFXgJ8aCKa
        6BXICageIGF/uGCof3stbIsDPacibmK3xgKrFE++qkkdzPpO
X-Google-Smtp-Source: ABdhPJxEVVgA7Ub0bc+MvFmjZc1/RLEdJoez91edkd/s46zbbgIIdHjRz0Wm+HGP+LJ67kuMQWaAkopVRrwprhGvW720EhjW9N/v
MIME-Version: 1.0
X-Received: by 2002:a92:d1c4:: with SMTP id u4mr3401246ilg.295.1598725387974;
 Sat, 29 Aug 2020 11:23:07 -0700 (PDT)
Date:   Sat, 29 Aug 2020 11:23:07 -0700
In-Reply-To: <000000000000d3d67f05a20d2027@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8002705ae084273@google.com>
Subject: Re: INFO: task hung in tls_sk_proto_close
From:   syzbot <syzbot+ca1345cca66556f3d79b@syzkaller.appspotmail.com>
To:     a@unstable.cc, aviadye@mellanox.com, aviadye@nvidia.com,
        b.a.t.m.a.n@lists.open-mesh.org, borisp@mellanox.com,
        borisp@nvidia.com, daniel@iogearbox.net, davem@davemloft.net,
        idosch@mellanox.com, john.fastabend@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, petrm@mellanox.com, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 02d21b59d5cc4b4b395bbc2a29319b8a529ebeff
Author: Ido Schimmel <idosch@mellanox.com>
Date:   Wed Jan 23 14:32:59 2019 +0000

    mlxsw: spectrum_nve: Enable VXLAN on Spectrum-2

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e89b05900000
start commit:   5438dd45 net_sched: fix error path in red_init()
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16e89b05900000
console output: https://syzkaller.appspot.com/x/log.txt?x=12e89b05900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0437fdd630bee11
dashboard link: https://syzkaller.appspot.com/bug?extid=ca1345cca66556f3d79b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14acdfe5900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1792598e900000

Reported-by: syzbot+ca1345cca66556f3d79b@syzkaller.appspotmail.com
Fixes: 02d21b59d5cc ("mlxsw: spectrum_nve: Enable VXLAN on Spectrum-2")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
