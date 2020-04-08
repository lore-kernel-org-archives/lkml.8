Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E72C2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 02:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934B320748
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 02:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgDHCKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 22:10:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:41466 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgDHCKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 22:10:30 -0400
IronPort-SDR: 8g1hUajbiryR96XA+YHwh3L3lldV05HEsC38oMrkMSn5uT7HQiButgGWbknFKQ3m9UPU2eHayn
 JtMX9S9SbswQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 19:10:29 -0700
IronPort-SDR: jZU2sZzQ9z+kqloBgT+/E2E9jINi1XjhVfPdr0bp5BbGNA2Kh/z1FA7K3zDx2sIraUwQ7apbUU
 iVKMcPS6DUag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; 
   d="scan'208";a="398056890"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.249.170.68]) ([10.249.170.68])
  by orsmga004.jf.intel.com with ESMTP; 07 Apr 2020 19:10:23 -0700
Subject: Re: [PATCH 3/4] x86,module: Detect VMX vs SLD conflicts
To:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        pbonzini@redhat.com, fenghua.yu@intel.com, nadav.amit@gmail.com,
        thellstrom@vmware.com, tony.luck@intel.com, rostedt@goodmis.org,
        gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
References: <20200407110236.930134290@infradead.org>
 <20200407111007.352324393@infradead.org>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <fa0d7421-9a6a-2e28-40cf-50f1364de502@intel.com>
Date:   Wed, 8 Apr 2020 10:10:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407111007.352324393@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/2020 7:02 PM, Peter Zijlstra wrote:
> It turns out that with Split-Lock-Detect enabled (default) any VMX
> hypervisor needs at least a little modification in order to not blindly
> inject the #AC into the guest without the guest being ready for it.
> 
> Since there is no telling which module implements a hypervisor, scan
> all out-of-tree modules' text and look for VMX instructions and refuse
> to load it when SLD is enabled (default) and the module isn't marked
> 'sld_safe'.
> 
> Hypervisors, which have been modified and are known to work correctly,
> can add:
> 
>    MODULE_INFO(sld_safe, "Y");
> 
> to explicitly tell the module loader they're good.
> 

I'm thinking that it helps nothing other than telling the possible 
hypervisors "we have a new feature SLD enabled in kernel, but you seem 
not aware of it. To avoid something wrong with you and your VMs, you are 
not allowed to be loaded. Please tell me sld_safe as your assurance to 
get approval"

It's actually the bug/issue of hypervisor and it does no harm to (host) 
kernel. We can just leave it to hypervisor developer that they need to 
fix the bug in their hypervisor.

If we go the way like this patch, then whenever someone reports a 
similar bug due to new feature introduced and enabled in the future, we 
add a new xxx_safe module info?

