Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426E7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01DBB206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCsy6hgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgHET2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:28:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32013 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728612AbgHERLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aTite/iD0lQBRsDAUmY/i15AjG2mB78/HSvWX+2Oy3A=;
        b=ZCsy6hghHHxpvm+UAuRlGfP5ReAko5dndR8p/b6hkMIso+M8GNb58Mj8uVFDTeemFqLFww
        jDBEc9W7L2Jf5oxvDe7dPFm1VnJcf8Wapbn9TD98k0s/HNH9nw8n1F+cNs2HO4BvrSNloO
        lARG2G3a+NXtUP7+JRPMkZcwWX/KCNU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314--WmjpFDvOfm_oikNDSEmCw-1; Wed, 05 Aug 2020 09:44:35 -0400
X-MC-Unique: -WmjpFDvOfm_oikNDSEmCw-1
Received: by mail-wm1-f72.google.com with SMTP id q15so2738833wmj.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aTite/iD0lQBRsDAUmY/i15AjG2mB78/HSvWX+2Oy3A=;
        b=COsNbVF70AY2aUdVM7ao1ygBtAGyia5VhCVgSYrBgck1DWe/W3Cfq3RIUYGR9u6MZh
         5Y2IwOhjFmH3ShB2H1cTdd7yZ2rzLDC6wOvdkX3F5ptQtVlnAWprGK5h8yAAC5oLRcyJ
         SREaZxWEhd9YAb3oAvW+QD/GOurTK005jwB0bLONaxJCMeR7yWvonymUViv5EHBeNBjp
         Udpbgy8YaMpICTaw7c+Ioc/3WCaMWw3mkq4esE46pqqARKTU+rbQrlGZqHX5/bWVejFp
         MzIseVjqJ5rfj+/xjtqdXdP+aEbp9yQ1bYIzqs8ANFL4riPT85ABKuSRbk1l5f0j+m9L
         nwXw==
X-Gm-Message-State: AOAM5308zdGrOVkE8wR6+/fTJVtoyFO/5jxutvvIStfin7Plp6ZvF1QK
        DTSv63GFuZ+0YgJy0n/28+nB3goR94Z9u0gELYDyh4JLtOgJ3DFW6n+oqjVBmVbTdEOE3av0Ayn
        1m7dFZd8mcegnO0V8igNQ34pf
X-Received: by 2002:a1c:7915:: with SMTP id l21mr3585718wme.50.1596635073670;
        Wed, 05 Aug 2020 06:44:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBmRcbWg6Zcj3SVEKY1RPNAFRs6pH6ZTvrDA1nI/1TIiw8ZC6tgWC862aXu3/qn+3fvibSog==
X-Received: by 2002:a1c:7915:: with SMTP id l21mr3585709wme.50.1596635073461;
        Wed, 05 Aug 2020 06:44:33 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id b77sm2354968wmb.3.2020.08.05.06.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:32 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:44:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 28/38] virtio_config: add virtio_cread_le_feature
Message-ID: <20200805134226.1106164-29-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mirrors virtio_cread_feature but for LE fields.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 5b5196fec899..cc7a2b1fd7b2 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -555,4 +555,14 @@ static inline void virtio_cwrite64(struct virtio_device *vdev,
 		_r;							\
 	})
 
+/* Conditional config space accessors. */
+#define virtio_cread_le_feature(vdev, fbit, structname, member, ptr)	\
+	({								\
+		int _r = 0;						\
+		if (!virtio_has_feature(vdev, fbit))			\
+			_r = -ENOENT;					\
+		else							\
+			virtio_cread_le((vdev), structname, member, ptr); \
+		_r;							\
+	})
 #endif /* _LINUX_VIRTIO_CONFIG_H */
-- 
MST

