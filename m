Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87602C2BA16
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 06:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674BC2072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 06:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgDHGlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 02:41:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:58629 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbgDHGlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 02:41:01 -0400
IronPort-SDR: O0vphgqvcSfvdwK8eA1NKUhh2SPd3BTkw2PHjiuFhA70O3PEFQ4GGtuV0DKFux5c9qjJAxcTDP
 96ol0kHH5MNw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 23:41:00 -0700
IronPort-SDR: 1usDcTI6wc8x5ZLUrsON3Wq0Th2N0cJsPE7Kky6Uud5b/JMvzdo9mo6V0nW2s1XVIEzRDCpwrt
 rgIPR+666OdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; 
   d="scan'208";a="240207985"
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
Subject: [PATCH 0/2] KVM: Fix out-of-bounds memslot access
Date:   Tue,  7 Apr 2020 23:40:57 -0700
Message-Id: <20200408064059.8957-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two fixes for what are effectively the same bug.  The binary search used
for memslot lookup doesn't check the resolved index and can access memory
beyond the end of the memslot array.

I split the s390 specific change to a separate patch because it's subtly
different, and to simplify backporting.  The KVM wide fix can be applied
to stable trees as is, but AFAICT the s390 change would need to be paired
with the !used_slots check from commit 774a964ef56 ("KVM: Fix out of range
accesses to memslots").  This is why I tagged only the KVM wide patch for
stable.

Sean Christopherson (2):
  KVM: Check validity of resolved slot when searching memslots
  KVM: s390: Return last valid slot if approx index is out-of-bounds

 arch/s390/kvm/kvm-s390.c | 3 +++
 include/linux/kvm_host.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.24.1

