Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A491C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB87C207FD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgCDHiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:38:52 -0500
Received: from mga03.intel.com ([134.134.136.65]:10852 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgCDHiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:38:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 23:38:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,513,1574150400"; 
   d="scan'208";a="440913031"
Received: from liujing-mobl1.ccr.corp.intel.com (HELO [10.249.174.187]) ([10.249.174.187])
  by fmsmga006.fm.intel.com with ESMTP; 03 Mar 2020 23:38:45 -0800
Subject: Re: [PATCH 0/4] KVM: x86: TIF_NEED_FPU_LOAD bug fixes
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Derek Yerger <derek@djy.llc>,
        kernel@najdan.com, Thomas Lambertz <mail@thomaslambertz.de>,
        Rik van Riel <riel@surriel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200117062628.6233-1-sean.j.christopherson@intel.com>
From:   "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <32d432f7-bbdf-a240-7ee9-303d019d8d1a@linux.intel.com>
Date:   Wed, 4 Mar 2020 15:38:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200117062628.6233-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/17/2020 2:26 PM, Sean Christopherson wrote:
> TIF_FPU_NEED_LOAD can be set any time
> control is transferred out of KVM, e.g. via IRQ->softirq, not just when
> KVM is preempted.

Hi Sean,

Is this just because kernel_fpu_begin() is called during softirq? I saw 
the dump trace in 3/4 message, but didn't find out clue.

Could I ask where kernel_fpu_begin() is called? Or is this just a 
"possible" thing?

Because I just want to make sure that, kvm can use this flag to cover 
all preempt/softirq/(other?) cases?

Thanks,

Jing

