Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B62C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8855D20882
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgHYA6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 20:58:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:21060 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgHYA6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:58:16 -0400
IronPort-SDR: Wnm/HaDrGjET4+3aUAC4MeTygxWI2pqEh5DyOYmdh/ISSOvU/LnS0Y3lrj2nk+ypOqNB0Ho1Eb
 Mx/wqVYtVkdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="135565434"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="135565434"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:58:15 -0700
IronPort-SDR: 2eKQQQwP2WrZWLeQXIWU6xAWF65uFSrWjZ16L1zEz0Bkgab5pTRE4pUh9uc2cl2TXCL6mEKJ/8
 FIX6oXWkVx1g==
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="281352562"
Received: from sjchrist-ice.jf.intel.com (HELO sjchrist-ice) ([10.54.31.34])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:58:15 -0700
Date:   Mon, 24 Aug 2020 17:58:13 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 2/2] KVM: LAPIC: Guarantee the timer is in
 tsc-deadline mode when setting
Message-ID: <20200825005813.GE15046@sjchrist-ice>
References: <1597213838-8847-1-git-send-email-wanpengli@tencent.com>
 <1597213838-8847-2-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597213838-8847-2-git-send-email-wanpengli@tencent.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 02:30:38PM +0800, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Check apic_lvtt_tscdeadline() mode directly instead of apic_lvtt_oneshot()
> and apic_lvtt_period() to guarantee the timer is in tsc-deadline mode when
> wrmsr MSR_IA32_TSCDEADLINE.
> 
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
