Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0719EC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D0E20661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608472;
	bh=AzMvOGFeP02uYb2htvlWBAJwij+2RSgKQh/WezhmmP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FNIg3JT3jOxLCNwP0wO8jYP1o2dNKighe+hL2Y3/ok4UtEo6u0N0kMBqdcwq0GS8z
	 MGus9lkZXQEVhnDD+SM1l/vUKNuyG8dZnhKM/rMRUd0hMDkHtLq02bg2Btotzj4ujO
	 iEN1k30yDzG2Az4PS+Wg6f4L0TMHOTxDQwM3YG9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387588AbgBMPlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:41:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:55996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387736AbgBMP2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:36 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A48A2168B;
        Thu, 13 Feb 2020 15:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607715;
        bh=AzMvOGFeP02uYb2htvlWBAJwij+2RSgKQh/WezhmmP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aGWaCeEdmqZEqNI3wxhEBzcnLCxokNLOjN4QSdGFDDYdO3BOhHQfWBnN7HOybWPs6
         GpeQQdPh23GGAkm85y3U9Ns9vufFPVcFTr7UHS+Tw7YSEypLyhkEy+rRbqwsimxq2q
         kInCSG8OwRpTGBbbqMlMMH/dzRltWD0zqQXfauK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH 5.5 038/120] bpf, sockhash: Synchronize_rcu before freeing map
Date:   Thu, 13 Feb 2020 07:20:34 -0800
Message-Id: <20200213151914.760603850@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Sitnicki <jakub@cloudflare.com>

commit 0b2dc83906cf1e694e48003eae5df8fa63f76fd9 upstream.

We need to have a synchronize_rcu before free'ing the sockhash because any
outstanding psock references will have a pointer to the map and when they
use it, this could trigger a use after free.

This is a sister fix for sockhash, following commit 2bb90e5cc90e ("bpf:
sockmap, synchronize_rcu before free'ing map") which addressed sockmap,
which comes from a manual audit.

Fixes: 604326b41a6fb ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20200206111652.694507-3-jakub@cloudflare.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/sock_map.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -250,6 +250,7 @@ static void sock_map_free(struct bpf_map
 	}
 	raw_spin_unlock_bh(&stab->lock);
 
+	/* wait for psock readers accessing its map link */
 	synchronize_rcu();
 
 	bpf_map_area_free(stab->sks);
@@ -873,6 +874,9 @@ static void sock_hash_free(struct bpf_ma
 		raw_spin_unlock_bh(&bucket->lock);
 	}
 
+	/* wait for psock readers accessing its map link */
+	synchronize_rcu();
+
 	bpf_map_area_free(htab->buckets);
 	kfree(htab);
 }


