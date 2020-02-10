Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424A2C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2086F20714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgBJPzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:55:01 -0500
Received: from mga07.intel.com ([134.134.136.100]:1546 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727584AbgBJPzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:55:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 07:55:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="380142760"
Received: from avandeve-mobl.amr.corp.intel.com (HELO [10.254.13.35]) ([10.254.13.35])
  by orsmga004.jf.intel.com with ESMTP; 10 Feb 2020 07:54:59 -0800
Subject: Re: [RFC PATCH 06/11] x86: make sure _etext includes function
 sections
To:     Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <75f0bd0365857ba4442ee69016b63764a8d2ad68.camel@linux.intel.com>
 <B413445A-F1F0-4FB7-AA9F-C5FF4CEFF5F5@amacapital.net>
 <20200207092423.GC14914@hirez.programming.kicks-ass.net>
 <202002091742.7B1E6BF19@keescook>
 <20200210105117.GE14879@hirez.programming.kicks-ass.net>
From:   Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <43b7ba31-6dca-488b-8a0e-72d9fdfd1a6b@linux.intel.com>
Date:   Mon, 10 Feb 2020 07:54:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200210105117.GE14879@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I'll leave it to others to figure out the exact details. But afaict it
> should be possible to have fine-grained-randomization and preserve the
> workaround in the end.
> 

the most obvious "solution" is to compile with an alignment of 4 bytes (so tight packing)
and then in the randomizer preserve the offset within 32 bytes, no matter what it is

that would get you an average padding of 16 bytes which is a bit more than now but not too insane
(queue Kees' argument that tiny bits of padding are actually good)




