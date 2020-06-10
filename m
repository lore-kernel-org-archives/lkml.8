Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30887C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C47204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4exZrjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgFJLg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:36:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37396 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728594AbgFJLgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591788979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g1mhrQ6NM5wYShJMoCPQWA/YwUtZgT5jddxZW0yxgs8=;
        b=e4exZrjI9HtnU7rNPcCffQSp6dcxNVzPTIOk9WOlEhevQmVFckVdD6wwrPz4beGBi294ot
        GjFTWLDX72WBmnpB0hJPN9LiHTo0iVrvnEclvOeUEX+xGkA7PpqXqYrhzlVXgqwx2LDFxi
        aDoHlxPegSPHT/43Gw5cVqlu6RSSu3w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-B0oq4rSJP9GGyyx7Uzg_MA-1; Wed, 10 Jun 2020 07:36:17 -0400
X-MC-Unique: B0oq4rSJP9GGyyx7Uzg_MA-1
Received: by mail-wr1-f72.google.com with SMTP id z10so978151wrs.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g1mhrQ6NM5wYShJMoCPQWA/YwUtZgT5jddxZW0yxgs8=;
        b=p18qdk3wgv0B7hb3H3vYqli8O1ylejtFNsQWMCRtgfeN834ie1p3Kif5d1+AGCbxgB
         1xMjzVT5dDS0a7IJ06/z9+ms3w8uVUBZ9b72UTiXlzZeL9TD3zN6awcGagGSgzku5Lcc
         v6YI9phNrEkWCKYOTHK+8Jbbka8dk1QQpiof65PURa+ax4A0lSGITWy1tCpvmL+Q3oQj
         lInSdt6ok698ilmhB+ac+0TAd3vWDiSniwI7nIs7TVD6Cs+PwM3ulSPebkJwxFamrTjH
         I8Sk+bcS+4EXbaJt6XhigktXRbyxijhhLIUxjMvYSxKrR//T1IzmmlMOS7/LDGOw9LpJ
         /R5w==
X-Gm-Message-State: AOAM533jDO9F4Iw7IrVeUFrJnVkTE/xran1n8ecE2iA3VpEdueUzYJP9
        TEnuFpdK4L/7oiyMgk2LspJlvPDjJWT+9FhWG0j3lL7zi6Uug890J/HY8akhO/HQsjal6MgtW1g
        wEC1a1kSurxQ+EFpg51A+DHea
X-Received: by 2002:a1c:254:: with SMTP id 81mr2746855wmc.93.1591788976419;
        Wed, 10 Jun 2020 04:36:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFkt3Ubc8PKFjtb6gY/lDXcBZnr6E3I6m79bNAQFz95Fybj8NNv1w+aulFwppsq1zCYoyKZw==
X-Received: by 2002:a1c:254:: with SMTP id 81mr2746830wmc.93.1591788976169;
        Wed, 10 Jun 2020 04:36:16 -0700 (PDT)
Received: from redhat.com ([212.92.121.57])
        by smtp.gmail.com with ESMTPSA id z22sm6583776wmf.9.2020.06.10.04.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 04:36:15 -0700 (PDT)
Date:   Wed, 10 Jun 2020 07:36:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        eperezma@redhat.com
Subject: [PATCH RFC v7 07/14] fixup! vhost: format-independent API for used
 buffers
Message-ID: <20200610113515.1497099-8-mst@redhat.com>
References: <20200610113515.1497099-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610113515.1497099-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/vhost/vhost.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index e5763d81bf0f..7a587b13095c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2421,7 +2421,7 @@ int vhost_get_avail_buf(struct vhost_virtqueue *vq, struct vhost_buf *buf,
 err:
 	unfetch_descs(vq);
 
-	return ret ? ret : vq->num;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(vhost_get_avail_buf);
 
@@ -2433,6 +2433,27 @@ void vhost_discard_avail_bufs(struct vhost_virtqueue *vq,
 }
 EXPORT_SYMBOL_GPL(vhost_discard_avail_bufs);
 
+/* This function returns the descriptor number found, or vq->num (which is
+ * never a valid descriptor number) if none was found.  A negative code is
+ * returned on error. */
+int vhost_get_vq_desc(struct vhost_virtqueue *vq,
+		      struct iovec iov[], unsigned int iov_size,
+		      unsigned int *out_num, unsigned int *in_num,
+		      struct vhost_log *log, unsigned int *log_num)
+{
+	struct vhost_buf buf;
+	int ret = vhost_get_avail_buf(vq, &buf,
+				      iov, iov_size, out_num, in_num,
+				      log, log_num);
+
+	if (likely(ret > 0))
+		return buf->id;
+	if (likely(!ret))
+		return vq->num;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
+
 /* Reverse the effect of vhost_get_vq_desc. Useful for error handling. */
 void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
 {
-- 
MST

