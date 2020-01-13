Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AD5C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 20:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFE32084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 20:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgAMUJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 15:09:43 -0500
Received: from mga07.intel.com ([134.134.136.100]:8591 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgAMUJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 15:09:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 12:09:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,430,1571727600"; 
   d="scan'208";a="397261117"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga005.jf.intel.com with ESMTP; 13 Jan 2020 12:09:42 -0800
Date:   Mon, 13 Jan 2020 12:09:42 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        liran.alon@oracle.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2] KVM: nVMX: vmread should not set rflags to specify
 success in case of #PF
Message-ID: <20200113200942.GC2322@linux.intel.com>
References: <1577514324-18362-1-git-send-email-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577514324-18362-1-git-send-email-linmiaohe@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 02:25:24PM +0800, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> In case writing to vmread destination operand result in a #PF, vmread
> should not call nested_vmx_succeed() to set rflags to specify success.
> Similar to as done in VMPTRST (See handle_vmptrst()).
> 
> Reviewed-by: Liran Alon <liran.alon@oracle.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
