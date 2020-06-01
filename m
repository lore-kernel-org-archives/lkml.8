Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7A4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E5E2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ul+z7Gaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgFAMAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:00:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42764 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726017AbgFAMAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591012810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V2vaOYux+g8r9FQrQ+JLM9qTkiUW1rAWuUxZinM0SyI=;
        b=Ul+z7GaaewQr++DonHVVHzqa0x4aUb91sWAOOCD/rOpdldG8IF4ggDJnWSoOMGiwBCN9y9
        MbTw+P7Mgzl3odf1d8bC1aSA4zx78PhG3HEu7xT5Gq/hv8a3AYKDtV/3ZsORQ2rXPPewNP
        6MqAAtWRwX+tAiYrsbX5bSQ7kseYl/o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-PQMey4feO7GvEv0Dw8j8cA-1; Mon, 01 Jun 2020 08:00:06 -0400
X-MC-Unique: PQMey4feO7GvEv0Dw8j8cA-1
Received: by mail-qv1-f71.google.com with SMTP id s15so7118608qvo.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 05:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V2vaOYux+g8r9FQrQ+JLM9qTkiUW1rAWuUxZinM0SyI=;
        b=huYbO/3As6S70qtDngHTFAj9cqM4hWVVIzihuI1VVMZr4yOAjSDinnm1wiY0DMbw47
         NjJ8XQCADUvc+ihnRuur1nEiJdIvLu1Q4lkbQ/qmUiQQRCP3AFFnUGeQJxtiMsksEXBa
         ZEEgeGR64QOQuxYVutYJPYNR0bRl1JULvRiWV1CUk/FWYxglqHWbhZHiYlsyMNjh1F0U
         1es8/1dfVR+nQBJ6ZvvvPJ3xt97Ks+xLBKgkW0jZH8Rybvl+GErJ6tnqdo3qOu/+EARY
         EOcNC+ymCdAamSSAU3BRYgAnJqBC2Zs0nL9iQgtXkJezOerq0Z5BjYps7yl4mEsrnbqN
         ThYQ==
X-Gm-Message-State: AOAM530Fic6/l2+EvZi1ncqsbbpaxY1XtBBhph8/I/wl6EqhHivRG5Mg
        Cw89rTuXMSl/lDf0fgo8EnIRRbyqxru3QXrZCnKHGJ7hTTHvE68K6eyi4IXC6+8ADt6Et/pBB8J
        fv7pxMwQ2msL+m5iM9TZmamAw
X-Received: by 2002:ac8:38d8:: with SMTP id g24mr21955553qtc.360.1591012805499;
        Mon, 01 Jun 2020 05:00:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSyAI13lKJj29QiphxO0kMgJRdgJ352fnuCkEvomwDAkqADNTYqonnUCGWQwYiQSsRYeIUDA==
X-Received: by 2002:ac8:38d8:: with SMTP id g24mr21955513qtc.360.1591012805113;
        Mon, 01 Jun 2020 05:00:05 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id l9sm14474185qki.90.2020.06.01.05.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 05:00:04 -0700 (PDT)
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
Subject: [PATCH v10 02/14] KVM: Cache as_id in kvm_memory_slot
Date:   Mon,  1 Jun 2020 07:59:45 -0400
Message-Id: <20200601115957.1581250-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601115957.1581250-1-peterx@redhat.com>
References: <20200601115957.1581250-1-peterx@redhat.com>
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

