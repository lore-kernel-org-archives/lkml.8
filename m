Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A969C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D7F21D56
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/lB6Dwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388333AbgCDRuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:50:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40507 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388237AbgCDRuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583344213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=88e070kHMgQjDdreg4NYtPFAqs0Pb9K+uERwa96oW/g=;
        b=L/lB6DwzFezHbeD20LndzCdn8/rY9DSd851X3B1Qs4FSehIMby8vn23xWKN7SDxAv+Q1wi
        trocBJ9YADX4pYuz4oSQFC2trydtCtF8r9w6nC8YQK80enDXBJPTnD/EHAwthQXHEAo+0W
        Kxxy75aC+ivB92S4BdQ8fhfhYGR0NH8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-9rSzC0HdOv20FZzffYD6Aw-1; Wed, 04 Mar 2020 12:50:11 -0500
X-MC-Unique: 9rSzC0HdOv20FZzffYD6Aw-1
Received: by mail-qk1-f199.google.com with SMTP id w2so1857147qka.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:50:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88e070kHMgQjDdreg4NYtPFAqs0Pb9K+uERwa96oW/g=;
        b=YlRgfRpsCgM7WwQtlBuwY6EprPbjpnc1HUWdwc3XKjhneZXi9Rxwyk7C4XbNmjcPAD
         kfMeZy6abh1Tm4HGoF3/eTg9A4e8CALToIU1lspb/xKX/jyjc6W8y5QIzoWjCJ6VNdv5
         ljOwMw73zrSadAj3XQr9kADCZRUd19AvabsSeYmaUxLnM5UEEKWaTn2JjwP8MN4hVM3F
         Yq/1oGhI/G0s7TV4tTOVPTqrjR0hDKoEAIIOOPiWtGuXn1DjCPA4r3pWd9qNRicaklh7
         YmoCpWW3wuLlpHa6nM2Rt2OqyeZHxQ0S/yXcb9QQd0o1XugBlXCfFKUMyiB48OxMHrwD
         GXpg==
X-Gm-Message-State: ANhLgQ2jZk/7TX+JReL0WuwuPGkVD7cj1sQ4ttal48mmMYTgHzRn8M42
        OCPc3Ze35frnZlPbZ918xLxr82fQlJ6VduHTufR9ybRk6OecspMdR0nbpkC5Zogd5I9f/obLqkc
        d0KZZaeeK2GG/9ag8LV2fXMD5
X-Received: by 2002:a37:6796:: with SMTP id b144mr3936272qkc.485.1583344210915;
        Wed, 04 Mar 2020 09:50:10 -0800 (PST)
X-Google-Smtp-Source: ADFU+vu9WZ6XP24dbx7zQpLCjm1Uw/r9f4TnWu/pZupo36cltZ2EcASFT4MB9aTSiTz8+K10AprVoA==
X-Received: by 2002:a37:6796:: with SMTP id b144mr3936242qkc.485.1583344210665;
        Wed, 04 Mar 2020 09:50:10 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id q3sm3448488qtf.67.2020.03.04.09.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:50:10 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Yan Zhao <yan.y.zhao@intel.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>
Subject: [PATCH v5 06/14] KVM: Make dirty ring exclusive to dirty bitmap log
Date:   Wed,  4 Mar 2020 12:49:39 -0500
Message-Id: <20200304174947.69595-7-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200304174947.69595-1-peterx@redhat.com>
References: <20200304174947.69595-1-peterx@redhat.com>
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
index e26affa3ac4d..72dfb84a08a4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1244,6 +1244,10 @@ int kvm_get_dirty_log(struct kvm *kvm,
 	unsigned long n;
 	unsigned long any = 0;
 
+	/* Dirty ring tracking is exclusive to dirty log tracking */
+	if (kvm->dirty_ring_size)
+		return -EINVAL;
+
 	as_id = log->slot >> 16;
 	id = (u16)log->slot;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
@@ -1301,6 +1305,10 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 	unsigned long *dirty_bitmap;
 	unsigned long *dirty_bitmap_buffer;
 
+	/* Dirty ring tracking is exclusive to dirty log tracking */
+	if (kvm->dirty_ring_size)
+		return -EINVAL;
+
 	as_id = log->slot >> 16;
 	id = (u16)log->slot;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
@@ -1372,6 +1380,10 @@ int kvm_clear_dirty_log_protect(struct kvm *kvm,
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

