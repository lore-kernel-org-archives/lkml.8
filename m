Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BBBC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 22:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67B0E207CB
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 22:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gd7L9Sot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388188AbgEWW5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 18:57:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49621 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388137AbgEWW5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 18:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590274633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V2vaOYux+g8r9FQrQ+JLM9qTkiUW1rAWuUxZinM0SyI=;
        b=Gd7L9SotTNpqXhL5wr9Gu1rMbCoiHuAH+mHDB6LgCnY2urW82wA8/FLTNcs5ULrlLHg9ki
        KNnNykraOJt71APvgQ40Vha1/T5lfN/5a/HUqOQJ870PaygzfVDmmG+aMpuY5pXzYKyWss
        LMcUTYmiSLHLaorXtE/p4Xo3wZapcgE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-7cUvwZKhMNmMJ0AbcSwn5A-1; Sat, 23 May 2020 18:57:08 -0400
X-MC-Unique: 7cUvwZKhMNmMJ0AbcSwn5A-1
Received: by mail-qv1-f69.google.com with SMTP id i6so14152792qvq.17
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 15:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V2vaOYux+g8r9FQrQ+JLM9qTkiUW1rAWuUxZinM0SyI=;
        b=ZItEec7nvPgpluCspWO2k8mc5wdnx1EyDjBo8tFD5VOiX5mQAlqRmrBEzXiXkTqRo/
         UH5fVVqCdvM4Ircg+tFOtvvVWNLfOdrYaxjj06097vHBderdo9MfOKKekxxSgMjHFeH5
         axFPMeaKohRVQeizAKCAoEAj+tr5qEAZo47Mkw13gi15RZ6Obs9yFtwv8DXHnRQnaWoS
         tSU3c1YRp5zOJ71gDB8X+ZV2pFilMrrG7xRUVqymYLW1OD8OcSQzfxu7ty+t0SNCwDSt
         MKa12M1lXm/mhmaiYKLeSzZ0CZ7LOEc4RlYmVSyivcHvvPjVjjRcz/4tVmsDiUknZPTx
         YtkA==
X-Gm-Message-State: AOAM530s6cN6HZPiM0Hrh1aR5BRzkXkZfPNiIziv/TRLwNaQAQyLsgdD
        I6ZYYbPu7Mu1myWBrtwPdPxzjFqsn67JvXrry0U9G7T03Kb3lb+umPwso2E01wX45Te58d9KYrs
        0CcNM+43hMKYfZkbQRYooxqxf
X-Received: by 2002:aed:2fc6:: with SMTP id m64mr21701807qtd.201.1590274627522;
        Sat, 23 May 2020 15:57:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyHfUpdzkaAG+qrmzGo3ardtWcNSWeeBDEJMAsakoieGi64jilBwNJLDSnB26H9LpKoSLinA==
X-Received: by 2002:aed:2fc6:: with SMTP id m64mr21701790qtd.201.1590274627283;
        Sat, 23 May 2020 15:57:07 -0700 (PDT)
Received: from xz-x1.hitronhub.home (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id w14sm11630979qtt.82.2020.05.23.15.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 15:57:06 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>, peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [PATCH v9 02/14] KVM: Cache as_id in kvm_memory_slot
Date:   Sat, 23 May 2020 18:56:47 -0400
Message-Id: <20200523225659.1027044-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523225659.1027044-1-peterx@redhat.com>
References: <20200523225659.1027044-1-peterx@redhat.com>
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
index 01276e3d01b9..5e7bbaf7a36b 100644
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
index 74bdb7bf3295..ebdd98a30e82 100644
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
2.26.2

