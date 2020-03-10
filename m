Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9676DC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCF421655
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgCJUJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:09:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:59487 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbgCJUJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:09:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 13:09:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,538,1574150400"; 
   d="scan'208";a="245808300"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 10 Mar 2020 13:09:30 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jBlBx-0002cb-VR; Wed, 11 Mar 2020 04:09:29 +0800
Date:   Wed, 11 Mar 2020 04:08:31 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kbuild-all@lists.01.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liran Alon <liran.alon@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [RFC PATCH] KVM: nVMX: nested_vmx_handle_enlightened_vmptrld() can
 be static
Message-ID: <20200310200830.GA84412@69fab159caf3>
References: <20200309155216.204752-4-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309155216.204752-4-vkuznets@redhat.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: e3fd8bda412e ("KVM: nVMX: properly handle errors in nested_vmx_handle_enlightened_vmptrld()")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 nested.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 65df8bcbb9c86..1d9ab1e9933fb 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1910,7 +1910,7 @@ static int copy_vmcs12_to_enlightened(struct vcpu_vmx *vmx)
  * This is an equivalent of the nested hypervisor executing the vmptrld
  * instruction.
  */
-enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
+static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
 	struct kvm_vcpu *vcpu, bool from_launch)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
