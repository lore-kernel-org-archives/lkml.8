Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B324C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E874C21775
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akvkN1fH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbgCDRwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:52:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51506 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730022AbgCDRv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583344316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IJXI3OyHBMNvDSp9XDQtawbxBSkKafXuFCrtPHquIJw=;
        b=akvkN1fHlnK7OgqWCEJIp1VwCHIjSu5Rdeb+ujQEUW4IL8h/UtVnARklOIF8mAqgazOeXo
        01KoownD91HYeEdBJDBT2TQF+qu+tgb9L48+BWV5niFwc+K/Xyl0YZaer0V9R49b8m/QQ4
        EjiyiAqaYfJ3Ew4HLTGjRinHzf9FJ6w=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-r1zKoanaMqmksrBt1GmGlA-1; Wed, 04 Mar 2020 12:51:55 -0500
X-MC-Unique: r1zKoanaMqmksrBt1GmGlA-1
Received: by mail-qt1-f199.google.com with SMTP id s5so1986392qtn.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:51:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IJXI3OyHBMNvDSp9XDQtawbxBSkKafXuFCrtPHquIJw=;
        b=ioA/g/AbKQlnoL8xKwUsIPwFZfCWEsolqX4c2MORoqMoSFYLYA8kjSJw88qHZgGTZ+
         cyCWdWK6jE7kAHM3QOkPM86aLT7R8OatqURmwy0aL3uEsyC7GE8joTNq6rOd4vjWlNGp
         7rhkWKEOF+4jNWNlmWvHk/NfFehcNNNPApaZEQo7KbZj0ltD13mJ9YgtX1lkDQe9DA7r
         My3fAqo/anGJ1avTMxTzOnwNB/nEqRNQaiqHhhdW5czwuNxd32Wgi7w50XM40pRg1c2w
         e+dyUdcIwHGQcAD03F3NAf4Zh4gXU0x3Rk57DtMTObCTsIWyxwZd3yK1qs3/rJeb+CAN
         wSoA==
X-Gm-Message-State: ANhLgQ3gYcP0+UgrjWkSneqM2Hq4N40P6idm45uWPFzpPIdFhs3R9pxM
        AFs3NAch3Pc2dC3Ive8g4VoXDWJdK7ilhmJKy5rpntOVuqCrd6zZL8drKp3YaPvManG+NL0taj6
        BGulyN46+NBEDpIHaeokvMZAa
X-Received: by 2002:ac8:5190:: with SMTP id c16mr3490702qtn.200.1583344314481;
        Wed, 04 Mar 2020 09:51:54 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtWEE5pJUAb30CAlOc0HdE+PUBn4KyN4CpVzLvvvPRbZcbJ8+PWR7QVW9jUIxp3W8cZRXvkfA==
X-Received: by 2002:ac8:5190:: with SMTP id c16mr3490689qtn.200.1583344314257;
        Wed, 04 Mar 2020 09:51:54 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id o4sm14008251qki.26.2020.03.04.09.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:51:53 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] KVM: Drop gfn_to_pfn_atomic()
Date:   Wed,  4 Mar 2020 12:51:52 -0500
Message-Id: <20200304175152.70471-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's never used anywhere now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/kvm_host.h | 1 -
 virt/kvm/kvm_main.c      | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index bcb9b2ac0791..3faa062ea108 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -704,7 +704,6 @@ void kvm_release_page_clean(struct page *page);
 void kvm_release_page_dirty(struct page *page);
 void kvm_set_page_accessed(struct page *page);
 
-kvm_pfn_t gfn_to_pfn_atomic(struct kvm *kvm, gfn_t gfn);
 kvm_pfn_t gfn_to_pfn(struct kvm *kvm, gfn_t gfn);
 kvm_pfn_t gfn_to_pfn_prot(struct kvm *kvm, gfn_t gfn, bool write_fault,
 		      bool *writable);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 70f03ce0e5c1..d29718c7017c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1754,12 +1754,6 @@ kvm_pfn_t gfn_to_pfn_memslot_atomic(struct kvm_memory_slot *slot, gfn_t gfn)
 }
 EXPORT_SYMBOL_GPL(gfn_to_pfn_memslot_atomic);
 
-kvm_pfn_t gfn_to_pfn_atomic(struct kvm *kvm, gfn_t gfn)
-{
-	return gfn_to_pfn_memslot_atomic(gfn_to_memslot(kvm, gfn), gfn);
-}
-EXPORT_SYMBOL_GPL(gfn_to_pfn_atomic);
-
 kvm_pfn_t kvm_vcpu_gfn_to_pfn_atomic(struct kvm_vcpu *vcpu, gfn_t gfn)
 {
 	return gfn_to_pfn_memslot_atomic(kvm_vcpu_gfn_to_memslot(vcpu, gfn), gfn);
-- 
2.24.1

