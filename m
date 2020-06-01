Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DE3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB84C20772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoRzWH3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgFAMBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:01:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27545 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727084AbgFAMAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591012817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0iDL7BowDYNcq44fr2mt7MXUp9DN6SRpw9sZLiGRV8=;
        b=BoRzWH3btylfNAokSPbatGW8GnRZgYXKs07m0FJhV7MBLd2yQ4A73gJKvBC8IgI4teb+z4
        GSqw6FxgJBAScv+dLXzl7XpCFQmhRfdc3dcp9medUBPx6vOovjnEikBqAS8VT153jKRw/H
        a1ynAKV48UP6832d94/oua9gmgxjxXk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-4NgtNk4HPpeQiMMWc1v51A-1; Mon, 01 Jun 2020 08:00:14 -0400
X-MC-Unique: 4NgtNk4HPpeQiMMWc1v51A-1
Received: by mail-qk1-f199.google.com with SMTP id l184so640635qkb.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 05:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t0iDL7BowDYNcq44fr2mt7MXUp9DN6SRpw9sZLiGRV8=;
        b=ATfTZ8ww3ouIAapBMiImxfWBponrqDeBlENrkiM1N+8+DhaHxJQ7gmYB/s9FyNi/HU
         LgEk6/wVamzaSADxzafOyFeKeaemXqsI7/ykjLxaeiUx7IxuMzZ6f0XWB2vV+1QGlG2i
         r2lgkUOi52UTeHDET266TQOMOa07DEXEzm7EgLQVAwoUeEVYxTCw3RZiUkNxzeTrSr/f
         wtPqc2Y7KrFJhWSyqRmHnCiNxcllWbL6ZJKspIdik1QfcMuul6/2BgOWM+r2ES5uBUXt
         NbNZb0UAeLzAdEfEYYs6Fr2CmiCbwGcXvG4DZfXOTyCcPnRDkYROZ/bqjzaYueEQ/rJ5
         ICWA==
X-Gm-Message-State: AOAM5318mhTisgAn9d6EKs0xNuKYVSfZ+JcpZY9BCwmwISSp7Dmcn8O8
        19LYUfo5FxwBRJMD0+qmkcZwVlkkiiRTBOy9mug9KrBFOTn2Z4/KJOGvi9PEI8oO+YlNmhdExdL
        0ffJ0XMXuqQy9YEiI1jrcxI14
X-Received: by 2002:ac8:2df5:: with SMTP id q50mr21780452qta.228.1591012813730;
        Mon, 01 Jun 2020 05:00:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKevJ+Gc95uadw9jcOQ6sK5QQZ9VPOeYVRFYWptIIu8gWsdG2pV8QB8JJ5rxea75QspQfhPg==
X-Received: by 2002:ac8:2df5:: with SMTP id q50mr21780431qta.228.1591012813473;
        Mon, 01 Jun 2020 05:00:13 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id l9sm14474185qki.90.2020.06.01.05.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 05:00:12 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH v10 06/14] KVM: Make dirty ring exclusive to dirty bitmap log
Date:   Mon,  1 Jun 2020 07:59:49 -0400
Message-Id: <20200601115957.1581250-7-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601115957.1581250-1-peterx@redhat.com>
References: <20200601115957.1581250-1-peterx@redhat.com>
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
index c40b0c57427f..6b759f48a302 100644
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
2.26.2

