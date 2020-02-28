Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F93DC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF392467B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgB1Hy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 02:54:29 -0500
Received: from mga09.intel.com ([134.134.136.24]:59601 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgB1Hy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 02:54:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 23:54:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,495,1574150400"; 
   d="scan'208";a="232158707"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga008.jf.intel.com with ESMTP; 27 Feb 2020 23:54:27 -0800
Subject: Re: [KVM] a06230b62b: kvm-unit-tests.vmx.fail
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Oliver Upton <oupton@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
References: <20200228074408.GM6548@shao2-debian>
 <96533a86-feca-ace8-952b-7e5c88732ee5@redhat.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <8b9491a2-85a2-1dd0-bc06-26831ba2d6d6@intel.com>
Date:   Fri, 28 Feb 2020 15:54:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <96533a86-feca-ace8-952b-7e5c88732ee5@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/20 3:51 PM, Paolo Bonzini wrote:
> On 28/02/20 08:44, kernel test robot wrote:
>> [31mFAIL[0m vmx (408415 tests, 3 unexpected failures, 2 expected failures, 5 skipped)
> Please include the commit of kvm-unit-tests that you are using. You are
> likely missing "vmx: tweak XFAILS for #DB test".
>
> Paolo
>

Hi Paolo,

Many thanks for your help, we'll update it and test again.

Best Regards,
Rong Chen
