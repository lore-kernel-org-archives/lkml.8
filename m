Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F339C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4E520842
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgCBTTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:19:42 -0500
Received: from mga17.intel.com ([192.55.52.151]:18572 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbgCBTTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:19:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 11:19:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,508,1574150400"; 
   d="scan'208";a="412415599"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga005.jf.intel.com with ESMTP; 02 Mar 2020 11:19:41 -0800
Date:   Mon, 2 Mar 2020 11:19:41 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/13] KVM: x86: Shrink the usercopy region of the
 emulation context
Message-ID: <20200302191940.GD6244@linux.intel.com>
References: <20200218232953.5724-1-sean.j.christopherson@intel.com>
 <20200218232953.5724-11-sean.j.christopherson@intel.com>
 <87r1yhi6ex.fsf@vitty.brq.redhat.com>
 <727b8d16-2bab-6621-1f20-dc024ee65f10@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <727b8d16-2bab-6621-1f20-dc024ee65f10@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 07:40:27PM +0100, Paolo Bonzini wrote:
> On 26/02/20 18:51, Vitaly Kuznetsov wrote:
> >> +
> >> +	/* Here begins the usercopy section. */
> >> +	struct operand src;
> >> +	struct operand src2;
> >> +	struct operand dst;
> > Out of pure curiosity, how certain are we that this is going to be
> > enough for userspaces?
> > 
> 
> And also, where exactly are the user copies done?

Anything that funnels into ctxt->ops->read_std() or ctxt->ops->write_std(),
e.g.

	if (ctxt->src2.type == OP_MEM) {
		rc = segmented_read(ctxt, ctxt->src2.addr.mem,
				    &ctxt->src2.val, ctxt->src2.bytes);
		if (rc != X86EMUL_CONTINUE)
			goto done;
	}


segmented_read() : @data = &ctxt->src2.val
|
|-> read_emulated()
    |
    |-> ctxt->ops->read_emulated() / emulator_read_emulated()
        |
        |-> emulator_read_write()
            |
            |-> emulator_read_write_onepage()
                |
                |-> ops->read_write_emulate() / read_emulate()
                    |
                    |-> kvm_vcpu_read_guest()
                        |
                        ...
                          |-> __kvm_read_guest_page()
                              |
                              |-> __copy_from_user(data, ...)
