Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DADFC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A6A2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgDTNhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:37:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:42846 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgDTNhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:37:17 -0400
IronPort-SDR: 33bRO4NTGozpJYbMy+zieYJRsfB6IiZZffd8ZakZRR+xALttUCcF7361iJmKLxefsdxJNxpWY/
 CqsYHXdmYKKQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 06:37:17 -0700
IronPort-SDR: vt2Cpxgf/VyAygW430U5YyGa47SK2s/6vIwyWW+Y1T1iX68HonZOtbt8Uu23Tuc4lXlPEJ83q8
 lTYVzBCgebyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="279241230"
Received: from avandeve-mobl.amr.corp.intel.com (HELO [10.135.0.43]) ([10.135.0.43])
  by fmsmga004.fm.intel.com with ESMTP; 20 Apr 2020 06:37:16 -0700
Subject: Re: [PATCH 9/9] module: Reorder functions
To:     Ard Biesheuvel <ardb@kernel.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, Jessica Yu <jeyu@kernel.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com, rick.p.edgecomb@intel.com
References: <20200415210452.27436-1-kristen@linux.intel.com>
 <20200415210452.27436-10-kristen@linux.intel.com>
 <CAMj1kXGbh=0nC_6SGTWjKeDPdwBrEW0_vRbjDzWyqqjY_88S7Q@mail.gmail.com>
From:   Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <cff1fa99-c692-d9f2-f077-60d630bb40bc@linux.intel.com>
Date:   Mon, 20 Apr 2020 06:37:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXGbh=0nC_6SGTWjKeDPdwBrEW0_vRbjDzWyqqjY_88S7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/2020 5:01 AM, Ard Biesheuvel wrote:
> Is that the only prerequisite? I.e., is it sufficient for another
> architecture to add -ffunction-sections to the module CFLAGS to get
> this functionality? (assuming it defines CONFIG_FG_KASLR=y)

I suspect you also need/want at least normal KASLR enabled as
a "does it even make sense" common sense threshold
