Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1AAC10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C1C24649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMccKAxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgCIWYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:24:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32737 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726656AbgCIWYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583792649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gz4cVZBWbRKHAvLf/UbUUA3uFSN9eBglr4ne2SLrQGM=;
        b=RMccKAxXFZdXdxyruzVSxM1IKQd2azZkn0mSckC3MzOTPeHITtExx1gJOTNrLMvif6gD44
        DS1XY1Bf+Wu3CBM6tpcneXd+gg4dg8yq4OwzxDUJFmOu629hOoZiTBJUWPAY8LXn4+DqeS
        TECfqX7znXy9Cm8skSRdQRrgUpo3Gz4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-sF9T88UHPaOirAKqax0l4A-1; Mon, 09 Mar 2020 18:24:08 -0400
X-MC-Unique: sF9T88UHPaOirAKqax0l4A-1
Received: by mail-qv1-f70.google.com with SMTP id e16so955432qvr.16
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 15:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gz4cVZBWbRKHAvLf/UbUUA3uFSN9eBglr4ne2SLrQGM=;
        b=M9T1OaDwXJYqqoD7t50cKWwPSyXlmInaMWF7B6+Np3uCT1u9vKrGXcAMcs5YGlzvL+
         BQtXc0b+LLkDPbjTKdPIamZZ5HcoH4fVdJUlhafVR7LkG8qq4zgZ0RbJls8kyf1k8k5s
         NYgXV26+uGDlTX3xfnJtsawa8mqfPbYd3IfThuiPmGIQLEyKSSB9Si9Tt2+i0hfKk7pc
         DXjcuhcmxQmp0qsmKOF+93zlzvFkDOavzYYyAH9T9s8ro3w44QHAvTuoNR5ZztwbYBIv
         EdnC49jbctI/4DtTYgH5iIQGz3RtBNOQyY1CBOq0Axk35wI/NEGZi4d1F43ZWhbW22IS
         ak+g==
X-Gm-Message-State: ANhLgQ0Ib9IuLAjI7xumxXMuOnKb0zQFBGC1qXfjOm0ZVYXTiIu3PIx9
        hMfcX25UIf4Uausb557ayQqWOPcJH/VDYcpvQGTS+qqdKxf424bSvYyzR19uytMK+0EIV1arQmy
        6SoyoSfvaq4uAywyKPgophulw
X-Received: by 2002:ae9:edd2:: with SMTP id c201mr9511251qkg.366.1583792647883;
        Mon, 09 Mar 2020 15:24:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtCW+fLB8QzaXn2Sr2P0CEQsHfa2lXJzsCZDIwtY2mePQah4+YwmAlTdXJ3yzBmsdQSZPlvfw==
X-Received: by 2002:ae9:edd2:: with SMTP id c201mr9511231qkg.366.1583792647635;
        Mon, 09 Mar 2020 15:24:07 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id k50sm23584589qtc.90.2020.03.09.15.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 15:24:06 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v6 06/14] KVM: Make dirty ring exclusive to dirty bitmap log
Date:   Mon,  9 Mar 2020 18:24:05 -0400
Message-Id: <20200309222405.345331-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309214424.330363-1-peterx@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no good reason to use both the dirty bitmap logging and the
new dirty ring buffer to track dirty bits.  We should be able to even
support both of them at the same time, but it could complicate things
which could actually help little.  Let's simply make it the rule
before we enable dirty ring on any arch, that we don't allow these two
interfaces to be used together.

The big world switch would be KVM_CAP_DIRTY_LOG_RING capability
enablement.  That's where we'll switch from the default dirty logging
way to the dirty ring way.  As long as kvm->dirty_ring_size is setup
correctly, we'll once and for all switch to the dirty ring buffer mode
for the current virtual machine.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 Documentation/virt/kvm/api.rst |  7 +++++++
 virt/kvm/kvm_main.c            | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index bc17ca955495..55979d5095aa 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6143,3 +6143,10 @@ make sure all the existing dirty gfns are flushed to the dirty rings.
 
 The dirty ring can gets full.  When it happens, the KVM_RUN of the
 vcpu will return with exit reason KVM_EXIT_DIRTY_LOG_FULL.
+
+NOTE: the KVM_CAP_DIRTY_LOG_RING capability and the new ioctl
+KVM_RESET_DIRTY_RINGS are exclusive to the existing KVM_GET_DIRTY_LOG
+interface.  After enabling KVM_CAP_DIRTY_LOG_RING with an acceptable
+dirty ring size, the virtual machine will switch to the dirty ring
+tracking mode, and KVM_GET_DIRTY_LOG, KVM_CLEAR_DIRTY_LOG ioctls will
+stop working.
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2112958c7500..e51a14d24619 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1191,6 +1191,10 @@ int kvm_get_dirty_log(struct kvm *kvm,
 	unsigned long n;
 	unsigned long any = 0;
 
+	/* Dirty ring tracking is exclusive to dirty log tracking */
+	if (kvm->dirty_ring_size)
+		return -EINVAL;
+
 	as_id = log->slot >> 16;
 	id = (u16)log->slot;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
@@ -1248,6 +1252,10 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 	unsigned long *dirty_bitmap;
 	unsigned long *dirty_bitmap_buffer;
 
+	/* Dirty ring tracking is exclusive to dirty log tracking */
+	if (kvm->dirty_ring_size)
+		return -EINVAL;
+
 	as_id = log->slot >> 16;
 	id = (u16)log->slot;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
@@ -1319,6 +1327,10 @@ int kvm_clear_dirty_log_protect(struct kvm *kvm,
 	unsigned long *dirty_bitmap;
 	unsigned long *dirty_bitmap_buffer;
 
+	/* Dirty ring tracking is exclusive to dirty log tracking */
+	if (kvm->dirty_ring_size)
+		return -EINVAL;
+
 	as_id = log->slot >> 16;
 	id = (u16)log->slot;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
-- 
2.24.1

