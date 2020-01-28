Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A9FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4227A21739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221670;
	bh=pHfKayhJkEP0+Z8XbmIK/wAEZYdTwzNIrJUxBK/RCGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sQrGdZsn/JrP5BWOjKNvQhrNGD+KcKy0HNkBrQL/K5FuwX157zNa3lKm73lzkVxiP
	 8Q2YgCTPhdQZ3TnpY377CTrIWpBptNYtenp4zUCSMw3xtwZXJDL6nsDcCvlOJPfSU8
	 1viAixL6lk6fB2KUSs7CfEHo98oAaBOZMb9o64sQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbgA1O1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:27:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:55408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733304AbgA1O1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:27:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D990121739;
        Tue, 28 Jan 2020 14:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221655;
        bh=pHfKayhJkEP0+Z8XbmIK/wAEZYdTwzNIrJUxBK/RCGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QvuQ7yvZtLheRmuoSnpvFeVtDUSBVPffGMqdxyuu2HCLH3p4es6MRl5XeEpA1B1sP
         sXzifK6s+uIr0syyAUxTkrbhGqoTH6TH11uXE38t0s/2mgbzQsOq5xXu8EInYnhCih
         dHIj8aHLhCxnxJ+JKuue6d9z/VyEQvEG8CfVkJZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 21/92] tun: add mutex_unlock() call and napi.skb clearing in tun_get_user()
Date:   Tue, 28 Jan 2020 15:07:49 +0100
Message-Id: <20200128135811.856076624@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135809.344954797@linuxfoundation.org>
References: <20200128135809.344954797@linuxfoundation.org>
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
@@ -1900,6 +1900,10 @@ drop:
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


