Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7206C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDB3720578
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgESHzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 03:55:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:51506 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbgESHzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 03:55:24 -0400
IronPort-SDR: Sl56r/PpV4pSU/3oXgnlalwgRc6EHu133qtrR8oEeQZPqZvgeICMQ++f2zIe7TVb9Fr8s5Bacx
 J+oayICN2BdA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 00:55:23 -0700
IronPort-SDR: ZPnZTrVnX+qFuUg46YGTHf+UKbx3tiQbAgYuZOGjsrzojnHeBRtkS3NE/FlvszOg2Xzszuf2nK
 ioxOwnHJY+EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; 
   d="scan'208";a="254663872"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga008.fm.intel.com with ESMTP; 19 May 2020 00:55:23 -0700
Date:   Tue, 19 May 2020 00:55:23 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: emulate reserved nops from 0f/18 to 0f/1f
Message-ID: <20200519075523.GE5189@linux.intel.com>
References: <20200515161919.29249-1-pbonzini@redhat.com>
 <20200518160720.GB3632@linux.intel.com>
 <57d9da9b-00ec-3fe0-c69a-f7f00c68a90d@redhat.com>
 <20200519060156.GB4387@linux.intel.com>
 <60c2c33c-a316-86d2-118a-96b9f4770559@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60c2c33c-a316-86d2-118a-96b9f4770559@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 09:43:23AM +0200, Paolo Bonzini wrote:
> On 19/05/20 08:02, Sean Christopherson wrote:
> > On Mon, May 18, 2020 at 07:37:08PM +0200, Paolo Bonzini wrote:
> >> On 18/05/20 18:07, Sean Christopherson wrote:
> >>> On Fri, May 15, 2020 at 12:19:19PM -0400, Paolo Bonzini wrote:
> >>>> Instructions starting with 0f18 up to 0f1f are reserved nops, except those
> >>>> that were assigned to MPX.
> >>> Well, they're probably reserved NOPs again :-D.
> >>
> >> So are you suggesting adding them back to the list as well?
> > 
> > Doesn't KVM still support MPX?
> > 
> >>>> These include the endbr markers used by CET.
> >>> And RDSPP.  Wouldn't it make sense to treat RDSPP as a #UD even though it's
> >>> a NOP if CET is disabled?  The logic being that a sane guest will execute
> >>> RDSSP iff CET is enabled, and in that case it'd be better to inject a #UD
> >>> than to silently break the guest.
> >>
> >> We cannot assume that guests will bother checking CPUID before invoking
> >> RDSPP.  This is especially true userspace, which needs to check if CET
> >> is enable for itself and can only use RDSPP to do so.
> > 
> > Ugh, yeah, just read through the CET enabling thread that showed code snippets
> > that do exactly this.
> > 
> > I assume it would be best to make SHSTK dependent on unrestricted guest?
> > Emulating RDSPP by reading vmcs.GUEST_SSP seems pointless as it will become
> > statle apart on the first emulated CALL/RET.
> 
> Running arbitrary code under the emulator is problematic anyway with
> CET, since you won't be checking ENDBR markers or updating the state
> machine.  So perhaps in addition to what you say we should have a mode
> where, unless unrestricted guest is disabled, the emulator only accepts
> I/O, MOV and ALU instructions.

Doh, I forgot all about those pesky ENDBR markers.  I think a slimmed down
emulator makes sense?

Tangentially related, isn't the whole fastop thing doomed once CET kernel
support lands?
