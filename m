Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CFFC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 23:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DBB206A1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 23:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgAIX4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 18:56:23 -0500
Received: from mga05.intel.com ([192.55.52.43]:55945 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbgAIX4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 18:56:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 15:56:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="246828479"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jan 2020 15:56:21 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Andrew Honig <ahonig@google.com>,
        Barret Rhoden <brho@google.com>
Subject: [PATCH 0/3] KVM: Clean up guest/host cache read/write code
Date:   Thu,  9 Jan 2020 15:56:17 -0800
Message-Id: <20200109235620.6536-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanup to fix the underlying crustiness that led to an uninitialized
variable warning reported by Barret.

The first two patches are tagged with Fixes:, but I don't know that they're
actually worth backporting to stable.  Functionally, everthing works, it's
just a bit weird and AFAICT not what is intended.  It might be preferable
to take Barret's patch[*] first and only mark that for stable, as it fixes
the immediate issue without revamping __kvm_gfn_to_hva_cache_init().

[*] https://lkml.kernel.org/r/20200109195855.17353-1-brho@google.com

Sean Christopherson (3):
  KVM: Check for a bad hva before dropping into the ghc slow path
  KVM: Clean up __kvm_gfn_to_hva_cache_init() and its callers
  KVM: Return immediately if __kvm_gfn_to_hva_cache_init() fails

 virt/kvm/kvm_main.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

-- 
2.24.1

