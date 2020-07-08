Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23537C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0009C205CB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNDvfezA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgGHTfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:35:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40726 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726780AbgGHTeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594236862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Gh6qA+fB/LA3kl5rPoiuYHmLXSgMPKPUDULRc9B3B0=;
        b=dNDvfezA/PLvZ2t7PxcSjAYjcA0XSyKyBOKNio9T8J8yxnVGwhFYH9Wp4ln3vevMzqVTIy
        b/IwxwykgYz4M0CeSQ5qdyjHG2x1sJOasZIrnUNROKG0K6MS5w7EmzDYL2BdOSe701vBWl
        ljRSkKoGyhr+5NAQcDhf+1Xcec7POjU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-RDYiMjlFOkeKa6Sq-9H4Gw-1; Wed, 08 Jul 2020 15:34:21 -0400
X-MC-Unique: RDYiMjlFOkeKa6Sq-9H4Gw-1
Received: by mail-qt1-f200.google.com with SMTP id c26so33838523qtq.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 12:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Gh6qA+fB/LA3kl5rPoiuYHmLXSgMPKPUDULRc9B3B0=;
        b=DLVlZPOyzVQkmdgdotPSq9FUYtR04o9LG+p17+s0wd/8B1o4CssrIBiGQmtIJHGba9
         bCudWhpwIA5H1Kdbr6qEzU+QMvHGZQPmVHcGZULH4v3D0qUDom92lsbo/sZ8Vi+sC24H
         jOD9iFmnFIDYduNQeY33ZZFYMS2SASej75Igv4Cpt/XppHxmAXUFeuTZL2eL0AslbEVR
         XfJykzMK6tTvYZ/vMysxhj09RRL5KNUbgGlzf402bkIgAVJe8uuDuuC4k35LtavZwk7z
         rPVrOrjSxEnfsSZwg4ziPSOlhaDa39Ezc+ChckUuGFwFq2lrIorg1zX9mYvReHNyIqCA
         DqQQ==
X-Gm-Message-State: AOAM530q85eCukeH30THsDuIsbGQJaEIZU+hAgca8BQyMKibCfvJhyR6
        ho3jdw93Y5XWklwUl08pCNYXjTu5fKNg+VaDwxqIzwm/Eu6W/F+Quhtq/Dhda24NPO/fx1d1oC9
        c9LROJokqNCyTqGTG0uuvoJ5C
X-Received: by 2002:aed:208c:: with SMTP id 12mr61867800qtb.286.1594236860737;
        Wed, 08 Jul 2020 12:34:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcc19hsTYobFOkkcQre46Z+fJ84n4EzXno6SCHdoqWxkBbl4iGltA5UbSOUP+brzOwG25//Q==
X-Received: by 2002:aed:208c:: with SMTP id 12mr61867771qtb.286.1594236860480;
        Wed, 08 Jul 2020 12:34:20 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c8:6f::1f4f])
        by smtp.gmail.com with ESMTPSA id f18sm664884qtc.28.2020.07.08.12.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 12:34:19 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v11 05/13] KVM: Make dirty ring exclusive to dirty bitmap log
Date:   Wed,  8 Jul 2020 15:34:00 -0400
Message-Id: <20200708193408.242909-6-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708193408.242909-1-peterx@redhat.com>
References: <20200708193408.242909-1-peterx@redhat.com>
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
index c6b9f083d216..ffade37a15ae 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6267,3 +6267,10 @@ make sure all the existing dirty gfns are flushed to the dirty rings.
 
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
index 43e5536cfa93..c8c249edc885 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1374,6 +1374,10 @@ int kvm_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log,
 	unsigned long n;
 	unsigned long any = 0;
 
+	/* Dirty ring tracking is exclusive to dirty log tracking */
+	if (kvm->dirty_ring_size)
+		return -EINVAL;
+
 	*memslot = NULL;
 	*is_dirty = 0;
 
@@ -1435,6 +1439,10 @@ static int kvm_get_dirty_log_protect(struct kvm *kvm, struct kvm_dirty_log *log)
 	unsigned long *dirty_bitmap_buffer;
 	bool flush;
 
+	/* Dirty ring tracking is exclusive to dirty log tracking */
+	if (kvm->dirty_ring_size)
+		return -EINVAL;
+
 	as_id = log->slot >> 16;
 	id = (u16)log->slot;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
@@ -1543,6 +1551,10 @@ static int kvm_clear_dirty_log_protect(struct kvm *kvm,
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

