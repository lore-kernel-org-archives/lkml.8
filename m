Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52605C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 319B922B43
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732988AbgGVV33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:29:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:12792 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgGVV32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 17:29:28 -0400
IronPort-SDR: pdVJPBDq9EWGK0JMk9sfko4RNtLeewETDQePVK1vVJUjOw1gOHaSZStl/6/IVfQMqvwIbekIeg
 CxJgB/Pbi9lA==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="149605225"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="149605225"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 14:29:28 -0700
IronPort-SDR: nrC32TCEhbb21Blqr43x2Wm9/wQPhHkWLlRX09IHjUvr1PKG623X03w8isSRHW5wtViaEtX4jW
 kCrcsQVYGXKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="284360271"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga003.jf.intel.com with ESMTP; 22 Jul 2020 14:29:27 -0700
Date:   Wed, 22 Jul 2020 14:29:27 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, jmattson@google.com,
        yu.c.zhang@linux.intel.com
Subject: Re: [RESEND v13 10/11] KVM: x86: Add #CP support in guest exception
 dispatch
Message-ID: <20200722212927.GK9114@linux.intel.com>
References: <20200716031627.11492-1-weijiang.yang@intel.com>
 <20200716031627.11492-11-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716031627.11492-11-weijiang.yang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 11:16:26AM +0800, Yang Weijiang wrote:
> CPU defined #CP(21) to handle CET induced exception, it's accompanied
> with several error codes corresponding to different CET violation cases,
> see SDM for detailed description. The exception is classified as a
> contibutory exception w.r.t #DF.
> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---

This patch can be moved much earlier in the series.
