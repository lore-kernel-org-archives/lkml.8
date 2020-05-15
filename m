Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741A8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B3320758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1eDNabf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgEOPd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:33:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23496 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726246AbgEOPd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589556835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=0q1Y8ePvKhM4R3+rVYPWm7Pu+FP0VGkrqM/os2Y0oAI=;
        b=a1eDNabfdJ/mv/Wkdl9a8WVvXIvQ2iR9P+ZHXEFFxw/gD7Utw4ma+5HHtBD8kyF7JYxg4y
        urdKdsMBpLavQHdav0U/M3GmwBIr5XibOEGmDsW0WhTG2ZXy5r8bA9uGw7bMDPHzSh02ro
        6CkkwG4R++jABGnc/opUj0oxRdvFVjU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-dt4NoZgUMeWlEEnxb-eUig-1; Fri, 15 May 2020 11:33:54 -0400
X-MC-Unique: dt4NoZgUMeWlEEnxb-eUig-1
Received: by mail-wm1-f69.google.com with SMTP id f62so1352762wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=0q1Y8ePvKhM4R3+rVYPWm7Pu+FP0VGkrqM/os2Y0oAI=;
        b=mYpQGonuff8gc4sWstgslUXaiQq1DEfSUOq3vJH2D8iwbq6grB/InDUZsD4ktFqg3a
         0y81zfUPfHFCbQlH8ByfsfCW8WAt6WsaHht8gMUtpvT5vGrwwsY/w5KVp6am8hmymnit
         nTJggQpEtKb9nlF28QTw5wft538MshGQhn8sd6RrTFzCadbNVgCi/t5FUQhiW6zlgo5/
         61jxWxUhcEe4aak3/HzQCtQ+BeRnzxhe+Wr3/J9gcz2vw55clhBdJHY9KLjCxSszWaAL
         1kJifwMdpwfBfjrYZguEPQpDmGFTzotcAgoRgkJWi79xoJ9umFpWZ+VLRltQ+pYLNbj7
         dn9Q==
X-Gm-Message-State: AOAM531T//FeGJ3SU98QbSHYrThPR95hR7WVnKggi1HzFKmgF+Yo9rpl
        UQOHqktRX+IB9eZ/KvyE0L6LVR6YHissX25jA4lJZ+/dsF6JBeQGhyX/bFsA0P0XY0XyZsz6blj
        jf0LmaP5a6x1TngzqHf0vIVEX
X-Received: by 2002:a1c:2087:: with SMTP id g129mr4503998wmg.126.1589556832766;
        Fri, 15 May 2020 08:33:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwz/KlciQFx1rHU1J+UL9igbunQtTe0UZESWhBj7gKnvBR65GITM/RzOMxXTQwccrKqsnawtA==
X-Received: by 2002:a1c:2087:: with SMTP id g129mr4503978wmg.126.1589556832581;
        Fri, 15 May 2020 08:33:52 -0700 (PDT)
Received: from redhat.com (bzq-79-179-68-225.red.bezeqint.net. [79.179.68.225])
        by smtp.gmail.com with ESMTPSA id c16sm4048373wrv.62.2020.05.15.08.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 08:33:51 -0700 (PDT)
Date:   Fri, 15 May 2020 11:33:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kbuild test robot <lkp@intel.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH] vhost: missing __user tags
Message-ID: <20200515153347.1092235-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse warns about converting void * to void __user *. This is not new
but only got noticed now that vhost is built on more systems.
This is just a question of __user tags missing in a couple of places,
so fix it up.

Fixes: f88949138058 ("vhost: introduce O(1) vq metadata cache")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index d450e16c5c25..21a59b598ed8 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -730,7 +730,7 @@ static inline void __user *vhost_vq_meta_fetch(struct vhost_virtqueue *vq,
 	if (!map)
 		return NULL;
 
-	return (void *)(uintptr_t)(map->addr + addr - map->start);
+	return (void __user *)(uintptr_t)(map->addr + addr - map->start);
 }
 
 /* Can we switch to this memory table? */
@@ -869,7 +869,7 @@ static void __user *__vhost_get_user_slow(struct vhost_virtqueue *vq,
  * not happen in this case.
  */
 static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
-					    void *addr, unsigned int size,
+					    void __user *addr, unsigned int size,
 					    int type)
 {
 	void __user *uaddr = vhost_vq_meta_fetch(vq,
-- 
MST

