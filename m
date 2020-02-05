Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96BDC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20D62082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFrTHfEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgBEC7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 21:59:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24584 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727998AbgBEC67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 21:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580871539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dlAqEpPTUndIZh7wPLDVCooz5AgvSxeI8vfIAUOxmtc=;
        b=hFrTHfEKgkDl1MixL/e6qj8PD2kAMOte3cqwofpnxKiJTkjgdpx7iSqasaSmPLu0Yxu1bA
        pWv3QTfoePTFz/9t1z+PDp50S7YWyQYtkh7DbfdK3fTnuwveH1i9Ow6JIKGlMwWjXHtEGo
        QoankEDM+kWPH0BLUPwrWJ9XJ2NPTFg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-nzQAxUx7NTq-xBodU0W7Cg-1; Tue, 04 Feb 2020 21:58:50 -0500
X-MC-Unique: nzQAxUx7NTq-xBodU0W7Cg-1
Received: by mail-qv1-f70.google.com with SMTP id p3so629790qvt.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 18:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dlAqEpPTUndIZh7wPLDVCooz5AgvSxeI8vfIAUOxmtc=;
        b=i6lIhazfXtWJMk/F3AjwDqPfzoBsb8YlTMp3qqtLRFWCpsUsjtlCiDBAEXhv9CttZ0
         jseqNwCVykmEuaAzJro03GPVPkXLaKsvMo3SLO6pcK+2YNTCUhbVxVEcU2PAYIT48IWh
         pwbnum5KI0XlQKwFnJsf44BD1CQww6qUhYj24Ul94KnZLF3g9/809UrcNzeM5fxetVD/
         8mi82gOJqNkJj1jyptWqlfPCyJKCbi/TYCarRhp2f7lfepqB7Cugd4RQJjPeDD9pLqBX
         5C+3ULStqZg8fuc3CEhgGeRGqoiWCewseAr/p3Mir/PgkHfv9//TyHrG05j97yrKQSze
         mWqQ==
X-Gm-Message-State: APjAAAXC0YigVYP970zRRZE4zCyi5w881A0iUXglmZ6wu8XP6uDG93kq
        Km+xfYdHhWTrWTT3Vchb9wjh+p4lYFyOeOyzbuVQ+zG/z/CuiQz4YJ9fF69wjKwNWG0FY9ODWYr
        +5vTgTl0jIPBhsg4EQuIS1S0Q
X-Received: by 2002:a37:a14f:: with SMTP id k76mr31068433qke.170.1580871530253;
        Tue, 04 Feb 2020 18:58:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqxlLWnSK6a/QgArTLNRRly1uyWTIwUItXLoG9GWm3CQ5h4eRRPsHCvnbEv3po8kqmv45eTqfg==
X-Received: by 2002:a37:a14f:: with SMTP id k76mr31068418qke.170.1580871529992;
        Tue, 04 Feb 2020 18:58:49 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id e64sm12961649qtd.45.2020.02.04.18.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 18:58:48 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinechin@redhat.com, sean.j.christopherson@intel.com,
        pbonzini@redhat.com, jasowang@redhat.com, yan.y.zhao@intel.com,
        mst@redhat.com, peterx@redhat.com, kevin.tian@intel.com,
        alex.williamson@redhat.com, dgilbert@redhat.com,
        vkuznets@redhat.com
Subject: [PATCH 06/14] KVM: Make dirty ring exclusive to dirty bitmap log
Date:   Tue,  4 Feb 2020 21:58:34 -0500
Message-Id: <20200205025842.367575-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205025842.367575-1-peterx@redhat.com>
References: <20200205025105.367213-1-peterx@redhat.com>
 <20200205025842.367575-1-peterx@redhat.com>
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
 Documentation/virt/kvm/api.txt |  7 +++++++
 virt/kvm/kvm_main.c            | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/virt/kvm/api.txt b/Documentation/virt/kvm/api.txt
index 558e719efdec..bbdd68583cde 100644
--- a/Documentation/virt/kvm/api.txt
+++ b/Documentation/virt/kvm/api.txt
@@ -5514,3 +5514,10 @@ make sure all the existing dirty gfns are flushed to the dirty rings.
 
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
index b710cee7e897..5a6f83b7270f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1243,6 +1243,10 @@ int kvm_get_dirty_log(struct kvm *kvm,
 	unsigned long n;
 	unsigned long any = 0;
 
+	/* Dirty ring tracking is exclusive to dirty log tracking */
+	if (kvm->dirty_ring_size)
+		return -EINVAL;
+
 	as_id = log->slot >> 16;
 	id = (u16)log->slot;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
@@ -1300,6 +1304,10 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 	unsigned long *dirty_bitmap;
 	unsigned long *dirty_bitmap_buffer;
 
+	/* Dirty ring tracking is exclusive to dirty log tracking */
+	if (kvm->dirty_ring_size)
+		return -EINVAL;
+
 	as_id = log->slot >> 16;
 	id = (u16)log->slot;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
@@ -1371,6 +1379,10 @@ int kvm_clear_dirty_log_protect(struct kvm *kvm,
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

