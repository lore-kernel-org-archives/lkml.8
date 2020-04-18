Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A54DC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 04:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555E021D91
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 04:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgDREfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 00:35:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:1277 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgDREff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 00:35:35 -0400
IronPort-SDR: +4ArurAJ1BdXMpuOHTXLowKWJqSI0JqautlwESJAe2vPlwUx1SAPB1LJpuxBY/Bo0G94Ii5oqg
 2udAAaKPoxLA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 21:35:34 -0700
IronPort-SDR: VbHChn9YK7EmIZR5E0iZSzb6xSr24piTOHUo3BjKKMp0XmbgvhQLJp1fYnAUelkvrJ4yKJeWzo
 n8DEermTm58A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,397,1580803200"; 
   d="scan'208";a="454939582"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga005.fm.intel.com with ESMTP; 17 Apr 2020 21:35:35 -0700
Date:   Fri, 17 Apr 2020 21:35:35 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 2/3] x86/split_lock: Bits in IA32_CORE_CAPABILITIES are
 not architectural
Message-ID: <20200418043534.GG15609@linux.intel.com>
References: <873691zuqu.fsf@nanos.tec.linutronix.de>
 <651504d9-f458-1d25-870d-b8c55061be45@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <651504d9-f458-1d25-870d-b8c55061be45@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 12:15:57PM +0800, Xiaoyao Li wrote:
> So now, it's tightly associated with CPU model, which makes it harder to
> expose this feature to guest. For guest, the CPU model can be configured to
> anything.
> 
> As suggested by Sean internally, we'd better use a KVM CPUID to expose it to
> guest, which makes it independent of CPU model.

Making this a paravirt feature from a KVM perspective would also let us do
the whole STICKY bit thing straight away.  I don't like paravirtualizing
something that could be emulated as-is, I but dislike it less than exposing
features based on CPU model.
