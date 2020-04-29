Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADA3C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 694442082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPjxlQW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgD2KGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgD2KGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:06:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83131C035493;
        Wed, 29 Apr 2020 03:06:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x18so1793397wrq.2;
        Wed, 29 Apr 2020 03:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c/UH3Lz8UpllzExG3i9isFfsDyna9aZhQQaKA33NG2U=;
        b=oPjxlQW77C9agVidyEJWF8dsdIZ1WaFCRAecF8V/z1nEUZTODgmjOlbYt01DNFhJZY
         Yp1JgAvJjJH7eDCEyIMLeOAPK+bUurZKaTS6IOSq8bYdsF0ngcFr+QQMSH53VfJmPa1D
         00rT6TnmzQVdmVxh+kGqRqtWOJT/oLNOpYqAyRXgsFCZ3gVHp4U4EGBukli3cPfJkhru
         TL6eAqrmxPC9eKiPhN/LgAjQSzrsMzjHYwoYzmsOHPtshJXj+YgbQfWXhSXFbt86IW0/
         Gi4LH2SxpKGm7N7FtPDRIbYyG8yRdWI1iBoJ5YTJMfonPlY5U6sVDCfx5C5B35mm7Ihm
         eT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c/UH3Lz8UpllzExG3i9isFfsDyna9aZhQQaKA33NG2U=;
        b=ozDns+OFUnmEPZZAIBcwAOVm91vL600TqrXnAbnYd4Oy2rkgYMHNXqFoXy6LXLzpYr
         +hXnPZ8t3mVOnYd3c0eE8/su0Ny1w02Jsu3Yc4bY5av6MZoQvxQ/F+54oO+Jz1BAxt9T
         EhZhNhJA7Q2noC7A9N8nOFOu3rkR51UhNEk4+5kZeTyn2pX0FlyTpQghKGqaJ2JLbOX9
         m3oj2gtbLrL8iLKvwsTETgJYlRy6+C/9tEh3Ct2E8i6Mqm6TMZ3mXcjClQV26lwWEvZa
         IsiBkDN4wf+VprsAHa/cniWFHeDA9wdPYtRJ5m5zU+5Kc7greWZrKjS8Hj04vMow9ony
         Hong==
X-Gm-Message-State: AGi0PuaPuTWZUOMQpxSws9wxmS3o0V9MVgp6xdAbNyp7iUzt63bvslq6
        ICc3gnDUmccB+ev04cNX0UPcdJN3XP2d
X-Google-Smtp-Source: APiQypLnHEW1H/Bu0qDCls5xveEV42f1LSnrbuTZrbDrpzmjXBVu7Ygy4Yq32CN0bQ2nJefR80KWzg==
X-Received: by 2002:adf:b310:: with SMTP id j16mr40764270wrd.95.1588154805951;
        Wed, 29 Apr 2020 03:06:45 -0700 (PDT)
Received: from ninjahost.lan (host-2-102-14-195.as13285.net. [2.102.14.195])
        by smtp.gmail.com with ESMTPSA id 1sm7205478wmi.0.2020.04.29.03.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 03:06:45 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev@vger.kernel.org (open list:NETWORKING [IPv4/IPv6])
Subject: [PATCH 3/6] udp: Add annotations for udp_rmem_release()
Date:   Wed, 29 Apr 2020 11:05:25 +0100
Message-Id: <20200429100529.19645-4-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200429100529.19645-1-jbi.octave@gmail.com>
References: <0/6>
 <20200429100529.19645-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning

 warning: context imbalance in udp_rmem_release() - unexpected unlock

To fix this,
__acquire(&sk_queue->lock) and __release(&sk_queue->lock) annotations
are added in case the condition is not met.

This add basically tell Sparse and not GCC to shutdown the warning

Add __acquire(&sk_queue->lock) annotation
Add the __release(&sk_queue->lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 net/ipv4/udp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 5ca12a945ac3..175bd14bfac8 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1382,6 +1382,9 @@ static void udp_rmem_release(struct sock *sk, int size, int partial,
 	sk_queue = &sk->sk_receive_queue;
 	if (!rx_queue_lock_held)
 		spin_lock(&sk_queue->lock);
+	else
+		/* annotation for sparse */
+		__acquire(&sk_queue->lock);
 
 
 	sk->sk_forward_alloc += size;
@@ -1398,6 +1401,9 @@ static void udp_rmem_release(struct sock *sk, int size, int partial,
 
 	if (!rx_queue_lock_held)
 		spin_unlock(&sk_queue->lock);
+	else
+		/* annotation for sparse */
+		__release(&sk_queue->lock);
 }
 
 /* Note: called with reader_queue.lock held.
-- 
2.25.3

