Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF7EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8A42074D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgCXSKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:10:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:35222 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbgCXSKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 14:10:32 -0400
IronPort-SDR: MBUfyfrPolWdpckycSeZ99xoPXlxRTowbdVVQKFGoXg82r+OHGf3Axw6SZCjdSGE9rPQQoX7w0
 gEaryGlfzZaw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 11:10:32 -0700
IronPort-SDR: 8UCukCbZ6REd+9cLNVuWAjMAa45dVXVUIcGdlW3sQiFstMuiTksNOTT106b0rQWvPrG+Z2QunH
 1e+xi0nTWK7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,301,1580803200"; 
   d="scan'208";a="270479707"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga004.fm.intel.com with ESMTP; 24 Mar 2020 11:10:31 -0700
Date:   Tue, 24 Mar 2020 11:10:31 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 34/37] KVM: nVMX: Don't flush TLB on nested VMX
 transition
Message-ID: <20200324181031.GE5998@linux.intel.com>
References: <20200320212833.3507-1-sean.j.christopherson@intel.com>
 <20200320212833.3507-35-sean.j.christopherson@intel.com>
 <4e2b2b82-278e-72d9-4db3-5047b678049c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e2b2b82-278e-72d9-4db3-5047b678049c@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 12:20:31PM +0100, Paolo Bonzini wrote:
> On 20/03/20 22:28, Sean Christopherson wrote:
> > Unconditionally skip the TLB flush triggered when reusing a root for a
> > nested transition as nested_vmx_transition_tlb_flush() ensures the TLB
> > is flushed when needed, regardless of whether the MMU can reuse a cached
> > root (or the last root).
> > 
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> So much for my WARN_ON. :)

Ha, yeah.  The double boolean also makes me nervous, but since there are
only two options, it seemed cleaner overall than a single mask-based param,
a ala EMULTYPE.
