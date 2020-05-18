Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F75C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF7EC20671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgERPFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:05:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:22351 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbgERPFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:05:04 -0400
IronPort-SDR: 305zeS+kcWD0TMHLCckGhJi8fJLXR6N/ZiFMDyfjHG4qqmzqDRKrPDqQeu61s4SqbYcoX1vc6l
 vTe25RMSqHbA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 08:05:03 -0700
IronPort-SDR: Vd9P702OhnTD65JgCyk6ybw/3fCd/mJxdm4xaT7hjG79UP3iByIu24MuLNT/WNYwW971Wpmo0Y
 KgJoXokK7tmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="252919967"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga007.jf.intel.com with ESMTP; 18 May 2020 08:05:01 -0700
Date:   Mon, 18 May 2020 08:05:01 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        peterx@redhat.com
Subject: Re: [PATCH 1/4] KVM: nSVM: fix condition for filtering async PF
Message-ID: <20200518150501.GA3632@linux.intel.com>
References: <20200516135311.704878-1-pbonzini@redhat.com>
 <20200516135311.704878-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516135311.704878-2-pbonzini@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 09:53:08AM -0400, Paolo Bonzini wrote:
> Async page faults have to be trapped in the host (L1 in this
> case), since the APC reason was passed from L0 to L1 and stored
> in the L1 APF data page.  This was completely reversed, as the
> page faults were passed to the guest (a L2 hypervisor).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
