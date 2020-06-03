Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14B5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF31E2077D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgFCHoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:44:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:47913 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFCHon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:44:43 -0400
IronPort-SDR: lCKqzKguZ8/amiF4ER3VJEvMlX6hTDURzB5O25ystJ93NlfmzX3KUfBfbyLmEvd/nJdatn6DI8
 CpPM6tk0I6Fw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 00:44:43 -0700
IronPort-SDR: OaoTNCguD6VHZKwpsrKiPC2MBoAyk9VjE5N/uQievj7tI08znPL5Nu6zEZsZDcSuiOCk6XdfUV
 jFnvU27Mdcdg==
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="416470260"
Received: from unknown (HELO [10.239.13.99]) ([10.239.13.99])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 00:44:40 -0700
Subject: Re: [PATCH 4/6] KVM: X86: Split kvm_update_cpuid()
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
References: <20200529085545.29242-1-xiaoyao.li@intel.com>
 <20200529085545.29242-5-xiaoyao.li@intel.com>
 <20200603011059.GB24169@linux.intel.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <5e5574d1-245d-ce57-d7aa-998eed2ca0b6@intel.com>
Date:   Wed, 3 Jun 2020 15:44:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603011059.GB24169@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/2020 9:10 AM, Sean Christopherson wrote:
> On Fri, May 29, 2020 at 04:55:43PM +0800, Xiaoyao Li wrote:
>> Split the part of updating KVM states from kvm_update_cpuid(), and put
>> it into a new kvm_update_state_based_on_cpuid(). So it's clear that
>> kvm_update_cpuid() is to update guest CPUID settings, while
>> kvm_update_state_based_on_cpuid() is to update KVM states based on the
>> updated CPUID settings.
> 
> What about kvm_update_vcpu_model()?  "state" isn't necessarily correct
> either.
> 

yeah, it's better.
