Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AD2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1632083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgA3QaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 11:30:02 -0500
Received: from mga12.intel.com ([192.55.52.136]:18032 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbgA3QaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 11:30:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 08:30:01 -0800
X-IronPort-AV: E=Sophos;i="5.70,382,1574150400"; 
   d="scan'208";a="222842003"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.249.168.169]) ([10.249.168.169])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jan 2020 08:29:58 -0800
Subject: Re: [PATCH 2/2] KVM: VMX: Extend VMX's #AC handding
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200130121939.22383-3-xiaoyao.li@intel.com>
 <4A8E14B3-1914-4D0C-A43A-234717179408@amacapital.net>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <cf79eeeb-e107-bdff-13a8-c52288d0d123@intel.com>
Date:   Fri, 31 Jan 2020 00:29:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4A8E14B3-1914-4D0C-A43A-234717179408@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/2020 11:18 PM, Andy Lutomirski wrote:
> 
> 
>> On Jan 30, 2020, at 4:24 AM, Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>
>> ﻿There are two types of #AC can be generated in Intel CPUs:
>> 1. legacy alignment check #AC;
>> 2. split lock #AC;
>>
>> Legacy alignment check #AC can be injected to guest if guest has enabled
>> alignemnet check.
>>
>> When host enables split lock detection, i.e., split_lock_detect!=off,
>> guest will receive an unexpected #AC when there is a split_lock happens in
>> guest since KVM doesn't virtualize this feature to guest.
>>
>> Since the old guests lack split_lock #AC handler and may have split lock
>> buges. To make guest survive from split lock, applying the similar policy
>> as host's split lock detect configuration:
>> - host split lock detect is sld_warn:
>>    warning the split lock happened in guest, and disabling split lock
>>    detect around VM-enter;
>> - host split lock detect is sld_fatal:
>>    forwarding #AC to userspace. (Usually userspace dump the #AC
>>    exception and kill the guest).
> 
> A correct userspace implementation should, with a modern guest kernel, forward the exception. Otherwise you’re introducing a DoS into the guest if the guest kernel is fine but guest userspace is buggy.

To prevent DoS in guest, the better solution is virtualizing and 
advertising this feature to guest, so guest can explicitly enable it by 
setting split_lock_detect=fatal, if it's a latest linux guest.

However, it's another topic, I'll send out the patches later.

> What’s the intended behavior here?
> 
It's for old guests. Below I quote what Paolo said in
https://lore.kernel.org/kvm/57f40083-9063-5d41-f06d-fa1ae4c78ec6@redhat.com/

"So for an old guest, as soon as the guest kernel happens to do a split 
lock, it gets an unexpected #AC and crashes and burns.  And then, after 
much googling and gnashing of teeth, people proceed to disable split 
lock detection.

(Old guests are the common case: you're a cloud provider and your
customers run old stuff; it's a workstation and you want to play that
game that requires an old version of Windows; etc.).

To save them the googling and gnashing of teeth, I guess we can do a
pr_warn_ratelimited on the first split lock encountered by a guest.  (It
has to be ratelimited because userspace could create an arbitrary amount
of guests to spam the kernel logs).  But the end result is the same,
split lock detection is disabled by the user."



