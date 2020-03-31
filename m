Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFBFC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990962137B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaUqHcdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgCaTAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:00:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60902 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728920AbgCaTAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585681229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SaPQXaz9TKeQDPqLSUMIea2gfLqrEOy+hFjS5pVMWw8=;
        b=VaUqHcdhAXzJQyZgpOw374YMYhwzhBmWyifz7DkAKR5LRyUSy+wsWaI0ak8m3S/hZ6AcuG
        pqvfgiHvpWjqPUbNMeLv8ulggJ165i2YT79EnotO1XPzZtBeL/nUqPzrhCiEEtN1nu3NTR
        ovX4SUimFmrS36te/VhDNDgvZrzT1fU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-RMli6X2aOXOgIuTktfBBPg-1; Tue, 31 Mar 2020 15:00:17 -0400
X-MC-Unique: RMli6X2aOXOgIuTktfBBPg-1
Received: by mail-wr1-f71.google.com with SMTP id r15so5546499wrm.22
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 12:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SaPQXaz9TKeQDPqLSUMIea2gfLqrEOy+hFjS5pVMWw8=;
        b=Cbyhz6BDdX7C6KmJhZOHUYKtbRP31T5tPufAMUoTTRo6KjbgPLvZIXqWNjlSWwve9u
         01po0LMilCC0XIS3W8LvR+1VspLUtYUYcysFse3ikO3QJzP32RHv9Gf+A7diTztqs8v7
         kg2qfthhhtl4KFfGMuCvAm2025DTOLSomH3WAeh1J6uLa/6D/vtCki7buqxTapm3n+HP
         tX+lrWyrwaF34vs1AWJMb5dAdbWbODyZ56W3LOWXC4y9P91AaTnz3f6qiM2IzEnUun1o
         IQ+YE3g0QV6iy7SEgdZI8JK4EZxfrNrCacc5ZlQjudaDcE5cyx+j4kS3c5b1/gSlkdX4
         9BWg==
X-Gm-Message-State: ANhLgQ0zKmWRR8PN36bPB2JWrBCrqNsQFQruDt/AkrMhq651/32HbbfL
        qrqJ4sKh5MoumAlJEYVYw2a6crC2ufed3SM/Uk+VW/yiK4Q//10e4gP8tyYw45aE8dS7A4bujW9
        wLZ/vFsP1cVKyyQCTpCkAMY9W
X-Received: by 2002:a05:6000:1142:: with SMTP id d2mr14417448wrx.320.1585681215825;
        Tue, 31 Mar 2020 12:00:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs0Lmm2yi8/lUh7kTfD26unrSU3jTgx7/Q3MKzSFGqyTBAic1CzUicbDhtyuT9z9CxyagfGGg==
X-Received: by 2002:a05:6000:1142:: with SMTP id d2mr14417424wrx.320.1585681215622;
        Tue, 31 Mar 2020 12:00:15 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id a8sm4817655wmb.39.2020.03.31.12.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:00:15 -0700 (PDT)
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
Subject: [PATCH v8 02/14] KVM: Cache as_id in kvm_memory_slot
Date:   Tue, 31 Mar 2020 14:59:48 -0400
Message-Id: <20200331190000.659614-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200331190000.659614-1-peterx@redhat.com>
References: <20200331190000.659614-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache the address space ID just like the slot ID.  It will be used in
order to fill in the dirty ring entries.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/kvm_host.h | 1 +
 virt/kvm/kvm_main.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f6a1905da9bf..515570116b60 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -346,6 +346,7 @@ struct kvm_memory_slot {
 	unsigned long userspace_addr;
 	u32 flags;
 	short id;
+	u16 as_id;
 };
 
 static inline unsigned long kvm_dirty_bitmap_bytes(struct kvm_memory_slot *memslot)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f744bc603c53..c04612726e85 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1243,6 +1243,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	if (!mem->memory_size)
 		return kvm_delete_memslot(kvm, mem, &old, as_id);
 
+	new.as_id = as_id;
 	new.id = id;
 	new.base_gfn = mem->guest_phys_addr >> PAGE_SHIFT;
 	new.npages = mem->memory_size >> PAGE_SHIFT;
-- 
2.24.1

