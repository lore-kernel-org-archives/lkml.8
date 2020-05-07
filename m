Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753CFC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D58E20753
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPXDjXIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgEGH0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 03:26:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27255 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725809AbgEGH0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588836361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=MNb3P1C6nMcjTzE7KOYMh3f2/+8YEUojREhYLpZKIq8=;
        b=CPXDjXICXP86phWuYEpceGMX9lxSgxY6Zrs+X0y1S2x/BXrkLaCD2WDXvSnIa4Mt/Gj6/f
        6ptd9VClaLdzWpX5cZhhEwSb8De3dOr99bHH6ifG84Eo+INuMZ//TJ/YLvuit51asaCw0B
        kZSIS/fi4Ur1LsBdkkqzQlUbQ6epuuc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-QAUb4EzfPu6b19rItuAW3w-1; Thu, 07 May 2020 03:26:00 -0400
X-MC-Unique: QAUb4EzfPu6b19rItuAW3w-1
Received: by mail-wr1-f69.google.com with SMTP id f15so2885968wrj.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 00:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=MNb3P1C6nMcjTzE7KOYMh3f2/+8YEUojREhYLpZKIq8=;
        b=Hd2KLZ1/iijjoWLpkfyaO7plR0cmquc8+XNrkGNde5A/ab98dK84/NzRCvB9SWQLMy
         ezDKlrB/+y48HzJhUmWcMCx4FS/aEfx1d/FWFzAQBHae3HOfq9t/fcCh3ZUO/nFvTcgi
         GdWH7KHXuV487Yy+0QjWenEp4SYPC2IgECdHNYpPlWWFT9fux6C0fmxOX6mf6e/C3Y7e
         fxP1W0eIBBLcUDDofFtFXTfZg4999TcT2FmZgUHLpeZ0RKNK0UOkBwBuNiI/Ptd0CDht
         ER6KuPsZixWJ7IZ1z3fLEWYSUE2l3Z5R9OXwLOrcgEN7ggLJC0lSWLzUS/8EU+BQbp4s
         r3vw==
X-Gm-Message-State: AGi0PuYaokLZ9lD4U3oNpqEzLVyLIENOxaxKvrJVg/GBUDHQHPmB8si4
        eFr7e7VGkAdl3oLoFmJ1+3gyOGscmo/M/ejD/HzOdJlxctJ0NF7Mg/QTVdZhSp91owwRo0fuIpE
        71iNqdIqZ7ssvk3UhzwU5IDlH
X-Received: by 2002:adf:e9d0:: with SMTP id l16mr3446592wrn.69.1588836359018;
        Thu, 07 May 2020 00:25:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypK3v4r+fkltKyHrOlH+oryMeYYEXo3bj8rv8XDyVYT7v3qL9oDVeAXDdb2dOeLpaZveqKy4Yg==
X-Received: by 2002:adf:e9d0:: with SMTP id l16mr3446572wrn.69.1588836358811;
        Thu, 07 May 2020 00:25:58 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id s18sm7318969wra.94.2020.05.07.00.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 00:25:58 -0700 (PDT)
Date:   Thu, 7 May 2020 03:25:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH v2] virtio_net: fix lockdep warning on 32 bit
Message-ID: <20200507072525.355222-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we fill up a receive VQ, try_fill_recv currently tries to count
kicks using a 64 bit stats counter. Turns out, on a 32 bit kernel that
uses a seqcount. sequence counts are "lock" constructs where you need to
make sure that writers are serialized.

In turn, this means that we mustn't run two try_fill_recv concurrently.
Which of course we don't. We do run try_fill_recv sometimes from a
softirq napi context, and sometimes from a fully preemptible context,
but the later always runs with napi disabled.

However, when it comes to the seqcount, lockdep is trying to enforce the
rule that the same lock isn't accessed from preemptible and softirq
context - it doesn't know about napi being enabled/disabled. This causes
a false-positive warning:

WARNING: inconsistent lock state
...
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.

As a work around, shut down the warning by switching
to u64_stats_update_begin_irqsave - that works by disabling
interrupts on 32 bit only, is a NOP on 64 bit.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

changes from v1:
	builds now. lightly tested

 drivers/net/virtio_net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 11f722460513..ce07f52d89e7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1243,9 +1243,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 			break;
 	} while (rq->vq->num_free);
 	if (virtqueue_kick_prepare(rq->vq) && virtqueue_notify(rq->vq)) {
-		u64_stats_update_begin(&rq->stats.syncp);
+		unsigned long flags;
+
+		flags = u64_stats_update_begin_irqsave(&rq->stats.syncp);
 		rq->stats.kicks++;
-		u64_stats_update_end(&rq->stats.syncp);
+		u64_stats_update_end_irqrestore(&rq->stats.syncp, flags);
 	}
 
 	return !oom;
-- 
MST

