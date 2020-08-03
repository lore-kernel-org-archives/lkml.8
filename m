Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325F6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C88622C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xfk6ByDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgHCU7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:59:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47866 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729079AbgHCU7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ab6nlp2Jw2w+JsB2kWgOwMJeURtEG/pcTlw1+Idrc0w=;
        b=Xfk6ByDARDnH4VHd4O9qqSeykAwQjQFULdvf6ALai383GfkYPK6A9bfhdVurOhczH74vos
        2+Cg/j2+iCXiASRwMVjY2dxnBaxVpYAkRpPGxHz9AaU9mtx7wL4pddjJDbIHLE+CVfZU33
        LMrlfgawdtrSJEkF4+7E9I9ZNjvKXrU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-H_vfbk0ENtOJRs8o9nUGLg-1; Mon, 03 Aug 2020 16:59:28 -0400
X-MC-Unique: H_vfbk0ENtOJRs8o9nUGLg-1
Received: by mail-qv1-f69.google.com with SMTP id k17so13049991qvj.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ab6nlp2Jw2w+JsB2kWgOwMJeURtEG/pcTlw1+Idrc0w=;
        b=mKstZgOQbTik8yXZ/qg1NSdz/i6fE6uRIZqz3EZ/DTKDKUQmnABSaOd4FUl5eqZo/E
         pMrjOIew+T3C7WH+3IsoIrBQ/C/+Z5p5L2fps/AcoMf20TN4E0Bcocv02xPt9WIlKxK4
         aT8t66c+pQTmM1HzFL3iRGmrlrebolEgeOCRIbEv340q3ZWXmnRxLT36G6uSzM1KVpp5
         s+9hqzZFiLl3H1wYlwvPr4TNqCVGK7p4WtFt9PxDP/bv9r11KaqTJGjiDTj+qEg4OQsE
         iW5UbmnPACFCRSrRUNscJAtxmzzgkKGoxKUNBPKfDJN8tRflMEz6zfcXesM998O6hRBy
         PZTQ==
X-Gm-Message-State: AOAM533Jzce07l8f/LdeeKXXgtXWKTuXZ7Lt+APUKgrJFbo28g04jPmL
        VJxN8+vlAB31ADBug+9t5cSk/xTKVlimePICTeuS+EwztauF6lp2gSyGJgZh10XR8hZH07fc1Mq
        6r/8H5yCrtA5o5vlYpqnNS5NZ
X-Received: by 2002:a05:620a:208f:: with SMTP id e15mr17956954qka.473.1596488367587;
        Mon, 03 Aug 2020 13:59:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrB9UGtNCPuZQkt5PUco1BHyFWN4HxBbqHKD5Mi9qKM26/vro6+0vNw0/CJquO0wN55PmNug==
X-Received: by 2002:a05:620a:208f:: with SMTP id e15mr17956941qka.473.1596488367357;
        Mon, 03 Aug 2020 13:59:27 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id i20sm19809053qka.17.2020.08.03.13.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:59:26 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:59:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 11/24] virtio_input: correct tags for config space fields
Message-ID: <20200803205814.540410-12-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this is a modern-only device,
tag config space fields as having little endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_input.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/virtio_input.h b/include/uapi/linux/virtio_input.h
index a7fe5c8fb135..52084b1fb965 100644
--- a/include/uapi/linux/virtio_input.h
+++ b/include/uapi/linux/virtio_input.h
@@ -40,18 +40,18 @@ enum virtio_input_config_select {
 };
 
 struct virtio_input_absinfo {
-	__u32 min;
-	__u32 max;
-	__u32 fuzz;
-	__u32 flat;
-	__u32 res;
+	__le32 min;
+	__le32 max;
+	__le32 fuzz;
+	__le32 flat;
+	__le32 res;
 };
 
 struct virtio_input_devids {
-	__u16 bustype;
-	__u16 vendor;
-	__u16 product;
-	__u16 version;
+	__le16 bustype;
+	__le16 vendor;
+	__le16 product;
+	__le16 version;
 };
 
 struct virtio_input_config {
-- 
MST

