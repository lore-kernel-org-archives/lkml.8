Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4D2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C81C20657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgERPtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:49:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:11281 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgERPtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:49:24 -0400
IronPort-SDR: kp+h8Sb8My/UII/YXc4z9vv7QAXWISEr1LsOZcxVkrrrLaukiE/0XQQVhHQlkO8dEV96gEy0Us
 973A2z5NmDOQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 08:49:23 -0700
IronPort-SDR: L6G04AIge5D55UrRgxPLrv4p4b0eq6pVar1+izTtqtjQ3SmrW/XACqXzn35bZ6qFbHNNydws0g
 dKKn4R/QpTlA==
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="465801574"
Received: from xiaoxuwa-mobl.ccr.corp.intel.com (HELO [10.255.28.12]) ([10.255.28.12])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 08:49:22 -0700
Subject: Re: [PATCH] kvm: x86: Use KVM CPU capabilities to determine CR4
 reserved bits
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     jmattson@google.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20200506094436.3202-1-pbonzini@redhat.com>
 <6a4daca4-6034-901a-261f-215df7d606a6@intel.com>
 <09cb27f8-fa02-4b37-94de-1a4d86b9bdbd@redhat.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <3bf2e68f-9843-cfed-6520-54dbf4955fc8@intel.com>
Date:   Mon, 18 May 2020 23:49:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <09cb27f8-fa02-4b37-94de-1a4d86b9bdbd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/2020 8:31 PM, Paolo Bonzini wrote:
> On 18/05/20 06:52, Xiaoyao Li wrote:
>> On 5/6/2020 5:44 PM, Paolo Bonzini wrote:
>>> Using CPUID data can be useful for the processor compatibility
>>> check, but that's it.  Using it to compute guest-reserved bits
>>> can have both false positives (such as LA57 and UMIP which we
>>> are already handling) and false negatives:
>>
>>> in particular, with
>>> this patch we don't allow anymore a KVM guest to set CR4.PKE
>>> when CR4.PKE is clear on the host.
>>
>> A common question about whether a feature can be exposed to guest:
>>
>> Given a feature, there is a CPUID bit to enumerate it, and a CR4 bit to
>> turn it on/off. Whether the feature can be exposed to guest only depends
>> on host CR4 setting? I.e., if CPUID bit is not cleared in cpu_data in
>> host but host kernel doesn't set the corresponding CR4 bit to turn it
>> on, we cannot expose the feature to guest. right?
> 
> It depends.  The most obvious case is that the host kernel doesn't use
> CR4.PSE but we even use 4MB pages to emulate paging disabled mode when
> the processor doesn't support unrestricted guests.
> 
> Basically, the question is whether we are able to save/restore any
> processor state attached to the CR4 bit on vmexit/vmentry.  In this case
> there is no PKRU field in the VMCS and the RDPKRU/WRPKRU instructions
> require CR4.PKE=1; therefore, we cannot let the guest enable CR4.PKE
> unless it's also enabled on the host.
> 

aha! That's reason!
Thanks for the clarification.

