Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BB3C2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095F1208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALj1E49F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbgCaTAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:00:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49815 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727852AbgCaTAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585681243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V6kMOTSpFcDOP0/szFuhOxO6Epp29hRF0tLj3kk1Vz8=;
        b=ALj1E49FBlCVILJe+1SQBZGGKdi34KaePAAwlbJOHLkqomOl3GEAcKqOqWNiXn6J/Ii6PE
        Szj/BL6RArlrgM/4SdqD0TKM4GKw6ax0xfa3I3eI/kjj3+tyVkoKnAScfjncTiCXKdYFAo
        +BsLhAoSFxnUJvUDvcu4JT69aC3CKmI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-D69q8SYKNvS55GPbxhHqQQ-1; Tue, 31 Mar 2020 15:00:42 -0400
X-MC-Unique: D69q8SYKNvS55GPbxhHqQQ-1
Received: by mail-wm1-f69.google.com with SMTP id o5so1437701wmo.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 12:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V6kMOTSpFcDOP0/szFuhOxO6Epp29hRF0tLj3kk1Vz8=;
        b=TSkfV+o+1W+kayvj55iGy/zyR/b2rf5Cn1cWXUJm1mgb6GVCNsHwfBRa4uTw1mwm7D
         kku9jReCvbdVELwYd/QN3ITmBfTy6T/bEpe+dEVjdgT/eGGhKuGZDe6LOcSBue1VU512
         X5TjK81Vvqn17q/BD532Tgfksfk70K/DTGJpDupKqs8ZLJyR/OTG2HnmTGt5vwUB1MJW
         lFQ7qYrobpMyWy9IeWy4zqsrKwdItKY3dvOUtAPTCM/40ZevG0ItkaNq3nqM/2FT7OQx
         LA6LdDYlC1rs8UKx3SHMvrUrKq8GiOmLk2ZuNkD8AWZUB0Pf5ABKhCMreamuTPsPPcmb
         e1yQ==
X-Gm-Message-State: ANhLgQ100sAXQ47wh0ttL57JNsq+9Xg2qUiQOVgMUUFEdsABQJJpsVZl
        XmNWbvUpde1TCJZ28ss2bo4ZOwvwIIEWQVVxwtr8uCb+wy1DfCKBZEEJ+lxuKpUDnTuvdhzp1za
        HcldKSwKz+PdRgCXh0GRbPmec
X-Received: by 2002:a5d:4f08:: with SMTP id c8mr22446220wru.27.1585681240674;
        Tue, 31 Mar 2020 12:00:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuThXSQEdN/aEbHa49dPZlaZI4ScfCEKwPD+n8JlJD2q3rs9KEG7qvjptIjNzDS5gjRDFr73Q==
X-Received: by 2002:a5d:4f08:: with SMTP id c8mr22446200wru.27.1585681240485;
        Tue, 31 Mar 2020 12:00:40 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id p10sm23444848wre.15.2020.03.31.12.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:00:39 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Kevin Tian <kevin.tian@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com
Subject: [PATCH v8 06/14] KVM: Make dirty ring exclusive to dirty bitmap log
Date:   Tue, 31 Mar 2020 14:59:52 -0400
Message-Id: <20200331190000.659614-7-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200331190000.659614-1-peterx@redhat.com>
References: <20200331190000.659614-1-peterx@redhat.com>
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
index aa54a34077b7..d56f86ba05a0 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6225,3 +6225,10 @@ make sure all the existing dirty gfns are flushed to the dirty rings.
 
 The dirty ring can gets full.  When it happens, the KVM_RUN of the
 vcpu will return with exit reason KVM_EXIT_DIRTY_LOG_FULL.
+
+NOTE: the capability KVM_CAP_DIRTY_LOG_RING and the corresponding
+ioctl KVM_RESET_DIRTY_RINGS are mutual exclusive to the existing ioctl
+KVM_GET_DIRTY_LOG.  After enabling KVM_CAP_DIRTY_LOG_RING with an
+acceptable dirty ring size, the virtual machine will switch to the
+dirty ring tracking mode.  Further ioctls to either KVM_GET_DIRTY_LOG
+or KVM_CLEAR_DIRTY_LOG will fail.
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index eacdedf8d122..1a4cc20c5a3c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1355,6 +1355,10 @@ int kvm_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log,
 	unsigned long n;
 	unsigned long any = 0;
 
+	/* Dirty ring tracking is exclusive to dirty log tracking */
+	if (kvm->dirty_ring_size)
+		return -EINVAL;
+
 	*memslot = NULL;
 	*is_dirty = 0;
 
@@ -1416,6 +1420,10 @@ static int kvm_get_dirty_log_protect(struct kvm *kvm, struct kvm_dirty_log *log)
 	unsigned long *dirty_bitmap_buffer;
 	bool flush;
 
+	/* Dirty ring tracking is exclusive to dirty log tracking */
+	if (kvm->dirty_ring_size)
+		return -EINVAL;
+
 	as_id = log->slot >> 16;
 	id = (u16)log->slot;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
@@ -1524,6 +1532,10 @@ static int kvm_clear_dirty_log_protect(struct kvm *kvm,
 	unsigned long *dirty_bitmap_buffer;
 	bool flush;
 
+	/* Dirty ring tracking is exclusive to dirty log tracking */
+	if (kvm->dirty_ring_size)
+		return -EINVAL;
+
 	as_id = log->slot >> 16;
 	id = (u16)log->slot;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
-- 
2.24.1

