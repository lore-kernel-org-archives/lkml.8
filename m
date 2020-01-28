Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E45C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CEF207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222943;
	bh=kvKXTCNphan1+FsgLSajrygmMUgSdUAfETnu5I/AWwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ff7aEFBX0CzlCC+AYB7czm92n5hc3/cNnUhB/4Qjn1wXoAK45HVP18i3AelPfuCsW
	 w4rjDCSljUhPnuXNZmOGSizkzcoQJ36rWfj2DmcMSy4c5HWgqmwbhyWb8je237Cg4H
	 H9lSn5tm/WHrWeEmd0MkJZePHRhgnzhVckWOjE8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgA1OBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:01:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbgA1OBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:01:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A082B24688;
        Tue, 28 Jan 2020 14:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220102;
        bh=kvKXTCNphan1+FsgLSajrygmMUgSdUAfETnu5I/AWwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bh9l4gqfc/DkV+SCuPvbXv3QCYEqF3ngvLeSFMZaPevYWWK0PzGFgKQmbWENjUd1w
         ZV4HTMbsIMydkFZJhlq1gKZ26JseEbpYTVWpH8ibLN9eiJMOKg2CZWYMXMegncjkwk
         wc3ocZvHWYcA0uIvcOYXBB1KVEfWehm7aPjjdc6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 018/104] tun: add mutex_unlock() call and napi.skb clearing in tun_get_user()
Date:   Tue, 28 Jan 2020 14:59:39 +0100
Message-Id: <20200128135819.762305010@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135817.238524998@linuxfoundation.org>
References: <20200128135817.238524998@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 1efba987c48629c0c64703bb4ea76ca1a3771d17 ]

If both IFF_NAPI_FRAGS mode and XDP are enabled, and the XDP program
consumes the skb, we need to clear the napi.skb (or risk
a use-after-free) and release the mutex (or risk a deadlock)

WARNING: lock held when returning to user space!
5.5.0-rc6-syzkaller #0 Not tainted
------------------------------------------------
syz-executor.0/455 is leaving the kernel with locks still held!
1 lock held by syz-executor.0/455:
 #0: ffff888098f6e748 (&tfile->napi_mutex){+.+.}, at: tun_get_user+0x1604/0x3fc0 drivers/net/tun.c:1835

Fixes: 90e33d459407 ("tun: enable napi_gro_frags() for TUN/TAP driver")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Petar Penkov <ppenkov@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1936,6 +1936,10 @@ drop:
 			if (ret != XDP_PASS) {
 				rcu_read_unlock();
 				local_bh_enable();
+				if (frags) {
+					tfile->napi.skb = NULL;
+					mutex_unlock(&tfile->napi_mutex);
+				}
 				return total_len;
 			}
 		}


