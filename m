Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB31CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA08E20885
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LuXp1wpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgFBNGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:06:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36275 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728273AbgFBNGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591103175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+9ArrlnZ76Z7x7tEJ0GmRFFHnk/lfGSrrAX14yhuVlU=;
        b=LuXp1wpSQyjdD4BbMfO+NICx+gSs404gET+3eNhfpzGgjqbexSTPD1bG2T40crmajQ6dLk
        sDSGiwV0Q4SrvffmERnsoXOHS/SIwd1Y0vtp1ntul/ge1bND584GKEwFJw4N/zmTPh3Kpj
        K0I+JEChJGrhzntUCTGYBw9/sY6oF64=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-pM5W72i3N8-KYtTnY52Azw-1; Tue, 02 Jun 2020 09:06:14 -0400
X-MC-Unique: pM5W72i3N8-KYtTnY52Azw-1
Received: by mail-wr1-f70.google.com with SMTP id h92so1362634wrh.23
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 06:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+9ArrlnZ76Z7x7tEJ0GmRFFHnk/lfGSrrAX14yhuVlU=;
        b=a+PQdpS0nGSlDew/k1EUvJNuBwdLJgem9N/TThpI17uItOHCpqRJ7BLb3NBFywrpZ4
         OeqXFr6BOuDpOSPh+XADVfX7xqeYwCekfxwfla8SshlleeeUuuDUuN9pazLFPgR9+vj6
         apJmSJMtGzaTvldxw7mvLaF/SXdiJl88fjiCqX8ly7/J/k9SbI2h8YsgqOEyeJ98LLDe
         actb3DH1LrD1wybhYlLceI8asm6CeidRQupzYm2mUheqAzZOAbHbfKCJB0O8sSylgw+O
         CQY379KUMyzewf9jlXinhdqDtjpYGUsLyZ8XjMHtzeNMP7dTXwyEBBY9AApT2amKIVXt
         DNgw==
X-Gm-Message-State: AOAM533SCIcwNfZXIlBOaPwSXgjYxMHJZOE1zODbGSdjQxNAd4yo5x/z
        6Cu2WmonUtrkkN0fjR7RDeAY9esnnIpr/3hQGY8PmpY494wbTVHpz1ijAyFxuwQYckaDt6lxmtJ
        28x6/gmBLSRvZtXemI0Dym3ua
X-Received: by 2002:a7b:c201:: with SMTP id x1mr4041712wmi.58.1591103172912;
        Tue, 02 Jun 2020 06:06:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAQ1hhO0DwfriHXGOJkXG1RkMZz6fc+8BSr/fDJ8YL0qd5AbUcevXhy22swxOsw0LrNtT9bQ==
X-Received: by 2002:a7b:c201:: with SMTP id x1mr4041687wmi.58.1591103172611;
        Tue, 02 Jun 2020 06:06:12 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id s7sm3687653wrr.60.2020.06.02.06.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 06:06:12 -0700 (PDT)
Date:   Tue, 2 Jun 2020 09:06:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH RFC 07/13] vhost: format-independent API for used buffers
Message-ID: <20200602130543.578420-8-mst@redhat.com>
References: <20200602130543.578420-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602130543.578420-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new API that doesn't assume used ring, heads, etc.
For now, we keep the old APIs around to make it easier
to convert drivers.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vhost.c | 52 ++++++++++++++++++++++++++++++++++---------
 drivers/vhost/vhost.h | 17 +++++++++++++-
 2 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index b4a6e44d56a8..be822f0c9428 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2292,13 +2292,12 @@ static int fetch_descs(struct vhost_virtqueue *vq)
  * number of output then some number of input descriptors, it's actually two
  * iovecs, but we pack them into one and note how many of each there were.
  *
- * This function returns the descriptor number found, or vq->num (which is
- * never a valid descriptor number) if none was found.  A negative code is
- * returned on error. */
-int vhost_get_vq_desc(struct vhost_virtqueue *vq,
-		      struct iovec iov[], unsigned int iov_size,
-		      unsigned int *out_num, unsigned int *in_num,
-		      struct vhost_log *log, unsigned int *log_num)
+ * This function returns a value > 0 if a descriptor was found, or 0 if none were found.
+ * A negative code is returned on error. */
+int vhost_get_avail_buf(struct vhost_virtqueue *vq, struct vhost_buf *buf,
+			struct iovec iov[], unsigned int iov_size,
+			unsigned int *out_num, unsigned int *in_num,
+			struct vhost_log *log, unsigned int *log_num)
 {
 	int ret = fetch_descs(vq);
 	int i;
@@ -2311,6 +2310,8 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 	*out_num = *in_num = 0;
 	if (unlikely(log))
 		*log_num = 0;
+	buf->in_len = buf->out_len = 0;
+	buf->descs = 0;
 
 	for (i = vq->first_desc; i < vq->ndescs; ++i) {
 		unsigned iov_count = *in_num + *out_num;
@@ -2340,6 +2341,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 			/* If this is an input descriptor,
 			 * increment that count. */
 			*in_num += ret;
+			buf->in_len += desc->len;
 			if (unlikely(log && ret)) {
 				log[*log_num].addr = desc->addr;
 				log[*log_num].len = desc->len;
@@ -2355,9 +2357,11 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 				goto err;
 			}
 			*out_num += ret;
+			buf->out_len += desc->len;
 		}
 
-		ret = desc->id;
+		buf->id = desc->id;
+		++buf->descs;
 
 		if (!(desc->flags & VRING_DESC_F_NEXT))
 			break;
@@ -2365,7 +2369,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 
 	vq->first_desc = i + 1;
 
-	return ret;
+	return 1;
 
 err:
 	for (i = vq->first_desc; i < vq->ndescs; ++i)
@@ -2375,7 +2379,15 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
+EXPORT_SYMBOL_GPL(vhost_get_avail_buf);
+
+/* Reverse the effect of vhost_get_avail_buf. Useful for error handling. */
+void vhost_discard_avail_bufs(struct vhost_virtqueue *vq,
+			      struct vhost_buf *buf, unsigned count)
+{
+	vhost_discard_vq_desc(vq, count);
+}
+EXPORT_SYMBOL_GPL(vhost_discard_avail_bufs);
 
 static int __vhost_add_used_n(struct vhost_virtqueue *vq,
 			    struct vring_used_elem *heads,
@@ -2459,6 +2471,26 @@ int vhost_add_used(struct vhost_virtqueue *vq, unsigned int head, int len)
 }
 EXPORT_SYMBOL_GPL(vhost_add_used);
 
+int vhost_put_used_buf(struct vhost_virtqueue *vq, struct vhost_buf *buf)
+{
+	return vhost_add_used(vq, buf->id, buf->in_len);
+}
+EXPORT_SYMBOL_GPL(vhost_put_used_buf);
+
+int vhost_put_used_n_bufs(struct vhost_virtqueue *vq,
+			  struct vhost_buf *bufs, unsigned count)
+{
+	unsigned i;
+
+	for (i = 0; i < count; ++i) {
+		vq->heads[i].id = cpu_to_vhost32(vq, bufs[i].id);
+		vq->heads[i].len = cpu_to_vhost32(vq, bufs[i].in_len);
+	}
+
+	return vhost_add_used_n(vq, vq->heads, count);
+}
+EXPORT_SYMBOL_GPL(vhost_put_used_n_bufs);
+
 static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 {
 	__u16 old, new;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index a67bda9792ec..6c10e99ff334 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -67,6 +67,13 @@ struct vhost_desc {
 	u16 id;
 };
 
+struct vhost_buf {
+	u32 out_len;
+	u32 in_len;
+	u16 descs;
+	u16 id;
+};
+
 /* The virtqueue structure describes a queue attached to a device. */
 struct vhost_virtqueue {
 	struct vhost_dev *dev;
@@ -193,7 +200,12 @@ int vhost_get_vq_desc(struct vhost_virtqueue *,
 		      unsigned int *out_num, unsigned int *in_num,
 		      struct vhost_log *log, unsigned int *log_num);
 void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
-
+int vhost_get_avail_buf(struct vhost_virtqueue *, struct vhost_buf *buf,
+			struct iovec iov[], unsigned int iov_count,
+			unsigned int *out_num, unsigned int *in_num,
+			struct vhost_log *log, unsigned int *log_num);
+void vhost_discard_avail_bufs(struct vhost_virtqueue *,
+			      struct vhost_buf *, unsigned count);
 int vhost_vq_init_access(struct vhost_virtqueue *);
 int vhost_add_used(struct vhost_virtqueue *, unsigned int head, int len);
 int vhost_add_used_n(struct vhost_virtqueue *, struct vring_used_elem *heads,
@@ -202,6 +214,9 @@ void vhost_add_used_and_signal(struct vhost_dev *, struct vhost_virtqueue *,
 			       unsigned int id, int len);
 void vhost_add_used_and_signal_n(struct vhost_dev *, struct vhost_virtqueue *,
 			       struct vring_used_elem *heads, unsigned count);
+int vhost_put_used_buf(struct vhost_virtqueue *, struct vhost_buf *buf);
+int vhost_put_used_n_bufs(struct vhost_virtqueue *,
+			  struct vhost_buf *bufs, unsigned count);
 void vhost_signal(struct vhost_dev *, struct vhost_virtqueue *);
 void vhost_disable_notify(struct vhost_dev *, struct vhost_virtqueue *);
 bool vhost_vq_avail_empty(struct vhost_dev *, struct vhost_virtqueue *);
-- 
MST

