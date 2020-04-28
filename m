Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DA9C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF89320575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099140;
	bh=2yWQ2COUuuTnHoBxyQRtu+KP95CUyMOunznIYckENiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uHJ7TmxZpPpSCKMeb9eyPjqw0KHYNYdSZQ3YE85vLfakYFQY5D7kvpMmaluBvd2+s
	 JjboRx6xIn7acXeFegc+mmv/9f3fYOcSlJETr4rCQEh2scMrm9q2Yl5TOGFEAMqg8J
	 r0krthEUx6E9fBKQ5+22xNZgwKmW3LTdUfJwLyKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbgD1Si7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:38:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729821AbgD1Si4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:38:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E690320575;
        Tue, 28 Apr 2020 18:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099136;
        bh=2yWQ2COUuuTnHoBxyQRtu+KP95CUyMOunznIYckENiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zdG4mYu8CyB401s0vYezQLp1XgNfWxsRT0lSsl4tScnayPZ5GFP96L/Fw8C/dP4E4
         H4yY5YbT3ezJ5wHGQpV61AozvZRnW/FDKqrHpvfl0Eu5MYrp63xe4tXvLCCEqbqA1I
         Rmd9+bJ/ZOhzCwKXmTYeajNbf3rcAXwbLp+yYh8o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 101/131] KVM: s390: Return last valid slot if approx index is out-of-bounds
Date:   Tue, 28 Apr 2020 20:25:13 +0200
Message-Id: <20200428182237.821244600@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 97daa028f3f621adff2c4f7b15fe0874e5b5bd6c upstream.

Return the index of the last valid slot from gfn_to_memslot_approx() if
its binary search loop yielded an out-of-bounds index.  The index can
be out-of-bounds if the specified gfn is less than the base of the
lowest memslot (which is also the last valid memslot).

Note, the sole caller, kvm_s390_get_cmma(), ensures used_slots is
non-zero.

Fixes: afdad61615cc3 ("KVM: s390: Fix storage attributes migration with memory slots")
Cc: stable@vger.kernel.org # 4.19.x: 0774a964ef56: KVM: Fix out of range accesses to memslots
Cc: stable@vger.kernel.org # 4.19.x
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Message-Id: <20200408064059.8957-3-sean.j.christopherson@intel.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kvm/kvm-s390.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1666,6 +1666,9 @@ static int gfn_to_memslot_approx(struct
 			start = slot + 1;
 	}
 
+	if (start >= slots->used_slots)
+		return slots->used_slots - 1;
+
 	if (gfn >= memslots[start].base_gfn &&
 	    gfn < memslots[start].base_gfn + memslots[start].npages) {
 		atomic_set(&slots->lru_slot, start);


