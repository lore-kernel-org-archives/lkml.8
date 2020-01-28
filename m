Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D984C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175162467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGm6L0Vh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgA1SyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:54:23 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:43312 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgA1SyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:54:20 -0500
Received: by mail-pj1-f73.google.com with SMTP id i3so415889pjx.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 10:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=D8ZUQ1iH7UYJdekJiQ43tyzlStAo9VsUap383J1XoBc=;
        b=cGm6L0Vh2NeLo0SSDbWSjRCz3JHlt6hazZyyxnMfW5/XOJEAfHAM9e4P5T/4bjJ1vj
         5W1/HlJUNLtPJggumIuwfXpCblGvLig+vI8bFGz8vQU2ad8pbpm29ekfW+Yp4wBxT7Ud
         47qfHYp/WeHOyS2zvCJZwIbfzYgEL0pQv5fPzo0qc1lKCAAngkzPYctuaXa5H/CWk2xd
         eKM2Jq2WkW91SFPraueCygjQO01pxxnAVhv6y7USTzZsHFVgpoa8k8jy2GjKKYWbyzJP
         cF1ar47rmU6+Oc/nqz4ioMMq2Nh1SOUq2qmLP50SfsnHsgoNbC/uAcg7D+RzkqqMhaWk
         TP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=D8ZUQ1iH7UYJdekJiQ43tyzlStAo9VsUap383J1XoBc=;
        b=l8CenOSoHjCSiZMEVrN1KDP2LfJ9W4g0Y63EzfUqsw0oPnuBzwiOeVf3PqYBniTvSs
         7YGD7jU5plQ8SJ+bXEHm0x18MQ+w+RjqfgkoL6WeUZC+To1AN0fGx1ZR4TXbFre/bMwa
         zqsbnSO8YQ7Y2d0C6JTbemUsWTp/kWnSS5Zt2t06SAwBoWdlJNsXukW2z8CzA+RuvQnc
         qjENkEj10MnNbPCxS2q1GbA1BaR/ORFA8SrPaEDeww1sB0y5OTMcHnisHcpwwu3sFQFO
         4dSQ+o+mVuy+XGZQ0tsGP3cxCWtFZ/LQkivFebFfH2aIKhHe6o/IQEtblggsroBMewCQ
         UVug==
X-Gm-Message-State: APjAAAVaOuP4UqiMh2h+CV7Jq1kZbBQsEpRxLWCfJAPkstVvQPZpvQsS
        bD/xtBunpzIkIg5+kYn8fDOnouR4lYO6YA==
X-Google-Smtp-Source: APXvYqwMGIhNdBb1uhMfzbfgKURyoP+pBKSWsr0NxPReGsr8lCZ3ikSiKfSVKqp45vgaYbph8TlNQT/X06WtYw==
X-Received: by 2002:a63:8f55:: with SMTP id r21mr4675275pgn.422.1580237659563;
 Tue, 28 Jan 2020 10:54:19 -0800 (PST)
Date:   Tue, 28 Jan 2020 10:54:13 -0800
Message-Id: <20200128185414.158541-1-mmandlik@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH 0/1] Bluetooth: Fix refcount use-after-free issue
From:   Manish Mandlik <mmandlik@google.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Yoni Shavit <yshavit@chromium.org>,
        linux-bluetooth@vger.kernel.org,
        Alain Michaud <alainmichaud@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Linux-Bluetooth,

   Sometimes after boot following kernel warning is observed:

   [   62.793493] refcount_t: underflow; use-after-free.
   [   62.799419] WARNING: CPU: 2 PID: 69 at /mnt/host/source/src/third_party/
   kernel/v4.19/lib/refcount.c:187 refcount_sub_and_test_checked+0x80/0x8c
   [   62.812298] Modules linked in: hidp rfcomm uinput hci_uart btqca
   bluetooth ecdh_generic mtk_scp mtk_rpmsg mtk_scp_ipi rpmsg_core bridge
   snd_seq_dummy stp llc snd_seq snd_seq_device lzo_rle lzo_compress
   nf_nat_tftp nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp esp6 ah6
   xfrm6_mode_tunnel xfrm6_mode_transport xfrm4_mode_tunnel
   xfrm4_mode_transport ip6t_REJECT ip6t_ipv6header zram ipt_MASQUERADE fuse
   ath10k_sdio ath10k_core ath mac80211 cfg80211 joydev
   [   62.852227] CPU: 2 PID: 69 Comm: kworker/2:1 Tainted: G S    4.19.36 #344
   [   62.860057] Hardware name: MediaTek kukui rev1 board (DT)
   [   62.865510] Workqueue: events l2cap_chan_timeout [bluetooth]
   [   62.871177] pstate: 60000005 (nZCv daif -PAN -UAO)
   [   62.875973] pc : refcount_sub_and_test_checked+0x80/0x8c
   [   62.881285] lr : refcount_sub_and_test_checked+0x7c/0x8c
   [   62.886594] sp : ffffff8008533cc0
   [   62.889907] x29: ffffff8008533cc0 x28: 0000000000000402
   [   62.895227] x27: ffffffaf37f16000 x26: ffffffe33b342d80
   [   62.900547] x25: ffffffe33aa2c210 x24: 0000000000000000
   [   62.905867] x23: ffffffe3294ef910 x22: ffffffe3294efc68
   [   62.911188] x21: ffffffe3294ef910 x20: ffffffe320fe3238
   [   62.916516] x19: ffffffe3294ed000 x18: 0000464806a32cd4
   [   62.921842] x17: 0000000000000400 x16: 0000000000000001
   [   62.927162] x15: 0000000000000000 x14: 0000000000000001
   [   62.932482] x13: 00000000000c001f x12: 0000000000000000
   [   62.937802] x11: 0000000000000001 x10: 0000000000000007
   [   62.943122] x9 : 97fe39c0a1baee00 x8 : 97fe39c0a1baee00
   [   62.948442] x7 : ffffffaf36af114c x6 : 0000000000000000
   [   62.953762] x5 : 0000000000000080 x4 : 0000000000000001
   [   62.959081] x3 : ffffff8008533868 x2 : 0000000000000006
   [   62.964401] x1 : ffffffe33b3436a0 x0 : 0000000000000000
   [   62.969721] Call trace:
   [   62.972176]  refcount_sub_and_test_checked+0x80/0x8c
   [   62.977142]  refcount_dec_and_test_checked+0x14/0x20
   [   62.982153]  l2cap_sock_kill+0x40/0x58 [bluetooth]
   [   62.986974]  l2cap_sock_close_cb+0x1c/0x28 [bluetooth]
   [   62.992140]  l2cap_chan_timeout+0x94/0xb4 [bluetooth]
   [   62.997196]  process_one_work+0x330/0x65c
   [   63.001206]  worker_thread+0x2c8/0x3ec
   [   63.004957]  kthread+0x124/0x134
   [   63.008197]  ret_from_fork+0x10/0x18
   [   63.011784] irq event stamp: 50638
   [   63.015203] hardirqs last  enabled at (50637): [<ffffffaf37404fa4>]
   _raw_spin_unlock_irq+0x34/0x68
   [   63.024165] hardirqs last disabled at (50638): [<ffffffaf36a80e4c>]
   do_debug_exception+0x44/0x16c
   [   63.033036] softirqs last  enabled at (50632): [<ffffffaf36a81634>]
   __do_softirq+0x45c/0x4a4
   [   63.041473] softirqs last disabled at (50613): [<ffffffaf36abcf80>]
   irq_exit+0xd8/0xf8
   [   63.049386] ---[ end trace 91fdf7b9eddd3bb0 ]---

   After analyzing the code, we noticed that there is a race condition between
   l2cap_chan_timeout() and l2cap_sock_release() while killing the socket.

   There are few more places in l2cap code where this race condition will occur.
   Issue is reproducible by writing a test which runs connect/disconnect of a
   bluetooth device in loop. With the help of this test, issue is consistently
   reproducible just within a couple of hours.

   To fix this, protect teardown/sock_kill and orphan/sock_kill by adding
   hold_lock on l2cap channel to ensure that the socket is killed only after
   it is marked as zapped and orphan.

   This change was tested by running the above test overnight and verifying that
   issue is not observed.

   There are places in sco and rfcomm code as well where similar race condition
   may occur. We are planning to send separate patches for them as well. Please
   let us know if this looks like a good generalized solution.

Regards,
Manish.


Manish Mandlik (1):
  Bluetooth: Fix refcount use-after-free issue

 net/bluetooth/l2cap_core.c | 26 +++++++++++++++-----------
 net/bluetooth/l2cap_sock.c | 16 +++++++++++++---
 2 files changed, 28 insertions(+), 14 deletions(-)

-- 
2.25.0.341.g760bfbb309-goog

