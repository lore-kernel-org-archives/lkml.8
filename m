Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2EBC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B622051A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341649;
	bh=vE4sw5pXGrs+jUPMxqzbdGisJdgJaBReRiGMoZcKJXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DsiNU/oqQb6pBbNmBLC9I6cGIihdfFldm/1zo++rJHSMJJgl5bdBH27AJ3QbUg2pf
	 tOueZO8iFDOKKPTNQ4fRu2m8SwxNdC8r9bXgYqervtfiWzeuNs9eJJR3JZ4pDsa3Uv
	 3yq+OtYmdOvN9XYx+Xpo4/u7oigAI7DFw2kOJD/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbgEAOAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:00:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbgEAN06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:26:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCE50208D6;
        Fri,  1 May 2020 13:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339618;
        bh=vE4sw5pXGrs+jUPMxqzbdGisJdgJaBReRiGMoZcKJXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nUoZaNG9/BX5DKHfbWdFjxbAvR7Czu3epjTfwmLLPrcs+CJBy6ZdSWCRCmcyRLJf1
         NDs3tk7h2dWmLuyZ1seY+DxEPx2K/kMKLX4NvGPx25B4/qPkYhqL6akjtks1wl5Xc7
         7GfKLlFC3yjPVx4Zt44r27ybpcFWKaO5Ovgv5p5w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+d889b59b2bb87d4047a2@syzkaller.appspotmail.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.4 39/70] KVM: Check validity of resolved slot when searching memslots
Date:   Fri,  1 May 2020 15:21:27 +0200
Message-Id: <20200501131525.781677076@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131513.302599262@linuxfoundation.org>
References: <20200501131513.302599262@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit b6467ab142b708dd076f6186ca274f14af379c72 upstream.

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
Message-Id: <20200408064059.8957-2-sean.j.christopherson@intel.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/kvm_host.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -934,7 +934,7 @@ search_memslots(struct kvm_memslots *slo
 			start = slot + 1;
 	}
 
-	if (gfn >= memslots[start].base_gfn &&
+	if (start < slots->used_slots && gfn >= memslots[start].base_gfn &&
 	    gfn < memslots[start].base_gfn + memslots[start].npages) {
 		atomic_set(&slots->lru_slot, start);
 		return &memslots[start];


