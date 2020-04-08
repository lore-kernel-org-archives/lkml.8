Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF59C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 06:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33EB20771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 06:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgDHGlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 02:41:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:58629 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgDHGlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 02:41:00 -0400
IronPort-SDR: hsczhdo64+ePuI3P9IvcPEUFAHM8AdfFwQcNPeyKNXKD96mw9Fo2SRih1kHhhuGxdU/+cuM9/o
 H5NatOmDDERA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 23:41:00 -0700
IronPort-SDR: kXTd4oDxUKWyEoclSVSNSkdaL7KhEVHfzJ6FUtRw0GL2tAO7pgYelG74re22M+/MIRlGlIw1Ha
 U+zWgrp/r1OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; 
   d="scan'208";a="240207984"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga007.jf.intel.com with ESMTP; 07 Apr 2020 23:40:59 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+d889b59b2bb87d4047a2@syzkaller.appspotmail.com
Subject: [PATCH 1/2] KVM: Check validity of resolved slot when searching memslots
Date:   Tue,  7 Apr 2020 23:40:58 -0700
Message-Id: <20200408064059.8957-2-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200408064059.8957-1-sean.j.christopherson@intel.com>
References: <20200408064059.8957-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that the resolved slot (somewhat confusingly named 'start') is a
valid/allocated slot before doing the final comparison to see if the
specified gfn resides in the associated slot.  The resolved slot can be
invalid if the binary search loop terminated because the search index
was incremented beyond the number of used slots.

This bug has existed since the binary search algorithm was introduced,
but went unnoticed because KVM statically allocated memory for the max
number of slots, i.e. the access would only be truly out-of-bounds if
all possible slots were allocated and the specified gfn was less than
the base of the lowest memslot.  Commit 36947254e5f98 ("KVM: Dynamically
size memslot array based on number of used slots") eliminated the "all
possible slots allocated" condition and made the bug embarrasingly easy
to hit.

Fixes: 9c1a5d38780e6 ("kvm: optimize GFN to memslot lookup with large slots amount")
Reported-by: syzbot+d889b59b2bb87d4047a2@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 include/linux/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6d58beb65454..01276e3d01b9 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1048,7 +1048,7 @@ search_memslots(struct kvm_memslots *slots, gfn_t gfn)
 			start = slot + 1;
 	}
 
-	if (gfn >= memslots[start].base_gfn &&
+	if (start < slots->used_slots && gfn >= memslots[start].base_gfn &&
 	    gfn < memslots[start].base_gfn + memslots[start].npages) {
 		atomic_set(&slots->lru_slot, start);
 		return &memslots[start];
-- 
2.24.1

