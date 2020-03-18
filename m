Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212ABC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E8F20757
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hR7HVNrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgCRQiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:38:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:42946 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727230AbgCRQh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584549479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=21sofClSkTFdAbqYOhAifzJwk3zPehrCVdo8Kk9QLLk=;
        b=hR7HVNrt9/ho26wznye2DMxaszA+rzlmB332aM56kMLWpWXFnhRbZ0ab14h7iCN3ZCVq3s
        usZX+ipNR920n5FomQEhetrmgzRkYBj+h32ua9s+ImZ1b7b0pWUvia+byChLbCB4mn+ChP
        W5wIGzo1C81JW0e4gfzdkTKhrBKE8jE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-J4nru55DNCWws-YP72rdLg-1; Wed, 18 Mar 2020 12:37:41 -0400
X-MC-Unique: J4nru55DNCWws-YP72rdLg-1
Received: by mail-wm1-f71.google.com with SMTP id p18so1324787wmk.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 09:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21sofClSkTFdAbqYOhAifzJwk3zPehrCVdo8Kk9QLLk=;
        b=oGs8bRX7f/eTe74XWMVnLcwn+hxUxH3KbNzJQ3h8etIMalJbnh4aVQHmSbP3OHEB+c
         zMp4PetmjlwV+SMivXZOBrV04bBqwHvoBAAm37K24LmgXIDXBDF8+Dw12rcpMcFYCp6Z
         vRisQgheN5pzRTyEnhrt2ljQmzUzmWQbLhn9SJ+k+sJdpBtVieC8yr+RWQS+i9lcvew/
         /vz2kgIpB5YCkvUXB3yZx4EVssONEus30Npuunz6chQlstmjgkxV4VJ2Mr3bC/nxmbXf
         GpIWelbE/d/w0vsTjzmPHD4UGNyTLOYC4owxcBXwAaPv2y1IQkmT1Oji7Gn94g/e1IEN
         +UDg==
X-Gm-Message-State: ANhLgQ3OsRTjExifgZFiIklkKvCZoh9L5jrvvU54OKrZJlOcN/3pyYZG
        uMBpbcR7tfLBg6XRcmqhPDIgfA0Y2JRJh48GkFjQCzr5q3wOHP4d7yrb6RSCckFpOsfJiZQhV6b
        zV9ZBMKmxSkztiYTiw1u7xQLQ
X-Received: by 2002:a7b:c458:: with SMTP id l24mr5971066wmi.120.1584549460667;
        Wed, 18 Mar 2020 09:37:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu6QMYREid4T3v+QT6mb4juZTk8sOTjJFcMXVrQf34I+KjMVmT6LOjD/v9zyyVBGzqkktKnHA==
X-Received: by 2002:a7b:c458:: with SMTP id l24mr5971041wmi.120.1584549460429;
        Wed, 18 Mar 2020 09:37:40 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id t1sm10316109wrq.36.2020.03.18.09.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 09:37:39 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>, peterx@redhat.com,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v7 02/14] KVM: Cache as_id in kvm_memory_slot
Date:   Wed, 18 Mar 2020 12:37:08 -0400
Message-Id: <20200318163720.93929-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318163720.93929-1-peterx@redhat.com>
References: <20200318163720.93929-1-peterx@redhat.com>
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
index 35bc52e187a2..2def86edcd65 100644
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
index 28eae681859f..e24e7111a308 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1240,6 +1240,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	if (!mem->memory_size)
 		return kvm_delete_memslot(kvm, mem, &old, as_id);
 
+	new.as_id = as_id;
 	new.id = id;
 	new.base_gfn = mem->guest_phys_addr >> PAGE_SHIFT;
 	new.npages = mem->memory_size >> PAGE_SHIFT;
-- 
2.24.1

