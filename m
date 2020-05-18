Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCE9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E72A207BB
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgERB1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 21:27:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:62464 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbgERB1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 21:27:52 -0400
IronPort-SDR: hwgmVVkDU0tRVcvt/W/J/KtXIpO1WQzWgJX/Gutv4C3D5pdEO1HtZB1CoX/q0LQBEtFR0zEI8h
 081IinlLnH/w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 18:27:51 -0700
IronPort-SDR: Aqzlh6aBiYoLzYWHgtR5GMwBAXEoKyK6vuDwqa+I0cEiOgiNDo1kJ7SZkYG4F6L3iYfDrNi8wd
 sGGrl12QpPxw==
X-IronPort-AV: E=Sophos;i="5.73,405,1583222400"; 
   d="scan'208";a="411090277"
Received: from unknown (HELO [10.239.13.122]) ([10.239.13.122])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 18:27:48 -0700
Subject: Re: [PATCH v9 0/8] KVM: Add virtualization support of split lock
 detection
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, peterz@infradead.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
References: <20200509110542.8159-1-xiaoyao.li@intel.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <98c5ccc7-30bb-bed2-2065-59f7b7b09fbc@intel.com>
Date:   Mon, 18 May 2020 09:27:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200509110542.8159-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/2020 7:05 PM, Xiaoyao Li wrote:
> This series aims to add the virtualization of split lock detection in
> KVM.
> 
> Due to the fact that split lock detection is tightly coupled with CPU
> model and CPU model is configurable by host VMM, we elect to use
> paravirt method to expose and enumerate it for guest.

Thomas and Paolo,

Do you have time to have a look at this version?
