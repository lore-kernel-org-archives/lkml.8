Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76C0C47254
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 996072073B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlfY3VSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgEFABi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 20:01:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26814 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728642AbgEFABi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 20:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588723296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=uPy7LWjiZV38WzP4ia9r6qbCDanZ9+7jGEAYy844X1w=;
        b=VlfY3VSB+yU7MrhrErllB4x2dQZedCoCI4yxeH1J0855cOcq8tLrLUwI9+qIuNxKpqPfrK
        iz3snfPdr+uBH5MRVPaJh1hGbIPhhjq3m6+c0cQz9EyRpUSbajm2aQYTNyZ2GvzwVN3a+h
        BXDioIVv281GCzxPzqbRE1oBAdLpJVU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-vlQ9c-X4MjOGSRe2N2pZ7A-1; Tue, 05 May 2020 20:01:35 -0400
X-MC-Unique: vlQ9c-X4MjOGSRe2N2pZ7A-1
Received: by mail-wm1-f70.google.com with SMTP id l21so181961wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 17:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uPy7LWjiZV38WzP4ia9r6qbCDanZ9+7jGEAYy844X1w=;
        b=HXFo0wscy5WEN3qfOG+Nf+pLvFZ7zs5vzHbhsqP+RqRa1uhwWUI2zt7r8ic4dBtpKw
         SrgjRz1T6Du1M3Vh4xrwJqidOZv4uKGxnEDhjs0COdkQerbBcj7rP44hgDo6G4ufnx+G
         YPIAeC09SsJFa2NLCgV954jIAwAN3t85JSIxZUJn0Z//K7k5gWJSdIXL3wkZoLAFcD5v
         sCiVI0ajYp/a5AL3b+hVbmtVrZDF7JAdwjxZ5kjp1eDITg6dMeAepo8bypDnoJlAX4tZ
         H6niPsCy1surSLN4ZNx5m8l5jlscJ8TrslVU+MGAL8I+hRAA12VgBJyZ3901597VuSl0
         Emmg==
X-Gm-Message-State: AGi0PuauURNBMACgMufXtrzN5Bzjye9bV6UOAbX/M9La1ogNogIrUD1E
        rELDxd1oLZB27TSlsbBfo64n5++BK+WVQ4/0fyBdlx8y615b4JSBckMKPI85yyms0mFQMRiIsSb
        Whz7jn6GqIprlZAVFlnEKUJVD
X-Received: by 2002:a1c:668a:: with SMTP id a132mr1374907wmc.46.1588723293808;
        Tue, 05 May 2020 17:01:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ8RYGHvYZzJ/QpEX2WdgeFSAVsMNA2jw0S7Y/1PxVtp3/Bj3PJc6VuKrGHjyReVPI+0wkbBw==
X-Received: by 2002:a1c:668a:: with SMTP id a132mr1374894wmc.46.1588723293612;
        Tue, 05 May 2020 17:01:33 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id n7sm447wrm.86.2020.05.05.17.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 17:01:32 -0700 (PDT)
Date:   Tue, 5 May 2020 20:01:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH] virtio_net: fix lockdep warning on 32 bit
Message-ID: <20200506000006.196646-1-mst@redhat.com>
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
Which of course we don't. We do run try_fill_recv sometimes from a fully
preemptible context and sometimes from a softirq (napi) context.

However, when it comes to the seqcount, lockdep is trying to enforce
the rule that the same lock isn't accessed from preemptible
and softirq context. This causes a false-positive warning:

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

I'm not thrilled about this but this seems the best we can do for now.

Completely untested.


Thomas, can you pls let me know the config I need to trigger the warning
in question?


 drivers/net/virtio_net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6594aab4910e..95393b61187f 100644
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
+		u64_stats_update_end_irqrestore(&rq->stats.syncp);
 	}
 
 	return !oom;
-- 
MST

