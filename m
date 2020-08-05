Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA89BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98CAE2245C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9JZVAw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgHERQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:16:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20710 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728464AbgHERLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2vN/9HN97A/Ugw3D0Jvhp+JbXzLKFGpnuu9RYydUjNE=;
        b=L9JZVAw4RRwXZw2FZVvii+TXbvT2EB6CJok1Kyd5h0CqIhq9N3Lcq3P0jvIshZDcwWlzwR
        JCxUAxIrWLutFS5uGiAjF26dMp4H04W5TUYrxZWLNfKDcKwzldbPNa0Dmo9+MhohTYP/Ti
        uooOnRyR7o3BhToq9HfSNaLMWhbikms=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-hud0YCM-NB-h_jOKoYsEtA-1; Wed, 05 Aug 2020 09:44:27 -0400
X-MC-Unique: hud0YCM-NB-h_jOKoYsEtA-1
Received: by mail-wr1-f70.google.com with SMTP id f7so13583247wrs.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2vN/9HN97A/Ugw3D0Jvhp+JbXzLKFGpnuu9RYydUjNE=;
        b=ZiLHQQVBxs9DPIzphtYev3HGmdaX4Au5cjijWSoWi+QeqlBY4uHZy+jNX2qMOrqPCD
         bfuJbZ5lBXn7anpxFho9pe1BMez3xiTD5I0ZcFdAgV1OaRSCjNTCbM+uPThmDs/WYKDR
         Fsfo51GnikLT97Ab8CmI3rwsXGuYm0jeWnA/l1Gic+VcLK5jsRXO+dxs5kofFJXMq4Wa
         NeYZsMm+RfhwCksmKJREFWLF3c/MgEMFkjKll2YuRM6wJXHf6ICx7t36psyv2o49pRQC
         2qvZU/NXSaOQ5TrIw+ILaWRgxpl/HTHzbhynWbTc2xPnYzgn9Wx4waWyHZX/hK280hyX
         KyKQ==
X-Gm-Message-State: AOAM531ZIb/eNkXdfim0WmkKz+YHPvGY9kSniS98bqjHTZeOzNxbdRwN
        RR9182bpApVgBcM8QBH97nnXuXK2eht3k/XdplkvVgvtBqYHz8p0CUo2PcWaAwJf+iK7TceozYl
        vJgcBR1Fje/GnFtDAAA0WfgMt
X-Received: by 2002:a1c:18b:: with SMTP id 133mr3374864wmb.178.1596635065854;
        Wed, 05 Aug 2020 06:44:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmniM9W5lxfG5OVlWrJIftYWunBp9QME57w+VcOK3P/UiXZQDwUzDQdDREKoZWY3QgAfUYbg==
X-Received: by 2002:a1c:18b:: with SMTP id 133mr3374854wmb.178.1596635065695;
        Wed, 05 Aug 2020 06:44:25 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
        by smtp.gmail.com with ESMTPSA id c17sm2899239wrc.42.2020.08.05.06.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:25 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:44:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 25/38] virtio_config: disallow native type fields (again)
Message-ID: <20200805134226.1106164-26-mst@redhat.com>
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

_Generic version allowed __uXX types but that is no longer necessary:

Transitional devices should all use __virtioXX types (and __leXX for
fields not present in the legacy devices).
Modern ones should use __leXX.
_uXX type would be a bug.
Let's prevent that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 7fa000f02721..441fd6dd42ab 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -304,13 +304,7 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 				 __u8: (x), \
 				 __le16: virtio16_to_cpu((vdev), (__force __virtio16)(x)), \
 				 __le32: virtio32_to_cpu((vdev), (__force __virtio32)(x)), \
-				 __le64: virtio64_to_cpu((vdev), (__force __virtio64)(x)), \
-				 default: _Generic((x), \
-						  __u8: (x), \
-						  __u16: virtio16_to_cpu((vdev), (__force __virtio16)(x)), \
-						  __u32: virtio32_to_cpu((vdev), (__force __virtio32)(x)), \
-						  __u64: virtio64_to_cpu((vdev), (__force __virtio64)(x)) \
-						  ) \
+				 __le64: virtio64_to_cpu((vdev), (__force __virtio64)(x)) \
 				 ) \
 		)
 
@@ -330,13 +324,7 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 				 __u8: (x), \
 				 __le16: (__force __le16)cpu_to_virtio16((vdev), (x)), \
 				 __le32: (__force __le32)cpu_to_virtio32((vdev), (x)), \
-				 __le64: (__force __le64)cpu_to_virtio64((vdev), (x)), \
-				 default: _Generic((m), \
-						  __u8: (x), \
-						  __u16: (__force __u16)cpu_to_virtio16((vdev), (x)), \
-						  __u32: (__force __u32)cpu_to_virtio32((vdev), (x)), \
-						  __u64: (__force __u64)cpu_to_virtio64((vdev), (x)) \
-						  ) \
+				 __le64: (__force __le64)cpu_to_virtio64((vdev), (x)) \
 				 ) \
 		)
 
-- 
MST

