Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF70C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F16D2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbgIHTCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:02:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:48497 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731304AbgIHQIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:08:02 -0400
IronPort-SDR: JxtOrhEL2IN2nLZOWwzpucfgbW84Q++ZSiPAB3+UEZGu3N+qTLnTnv7KiaeIdXtHSt1qdsrriC
 W4ZycAUl4mFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="159100510"
X-IronPort-AV: E=Sophos;i="5.76,405,1592895600"; 
   d="scan'208";a="159100510"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 06:49:21 -0700
IronPort-SDR: Y633VkXYeLItp/BiYFQLWnOuVpA1lx6LudGy6mO47pEFOy6pTpuzXaoEMrsUUnhOE4kG4Og2or
 Ab2bATFPLVkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,405,1592895600"; 
   d="scan'208";a="317191899"
Received: from mylly.fi.intel.com (HELO [10.237.72.195]) ([10.237.72.195])
  by orsmga002.jf.intel.com with ESMTP; 08 Sep 2020 06:49:19 -0700
Subject: Re: [PATCH v1] x86/defconfigs: Unbreak 32-bit defconfig builds
To:     Ingo Molnar <mingo@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
References: <20200908100018.50188-1-andriy.shevchenko@linux.intel.com>
 <20200908121354.GA3848343@gmail.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <7424b868-7463-2ea4-1cb0-386b143dc8f0@linux.intel.com>
Date:   Tue, 8 Sep 2020 16:49:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200908121354.GA3848343@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 9/8/20 3:13 PM, Ingo Molnar wrote:
> 
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> After the commit 1d0e12fd3a84 ("x86/defconfigs: Refresh defconfig files")
>> 32-bit builds using defconfig become broken because on x86_64 build host
>> with no ARCH provided the default behaviour is to assume 64-bit independently
>> on the configuration file name. The crucial part is CONFIG_64BIT option
>> that used to be explicit. Let restore the latter option in order to unbreak
>> 32-bit builds.
> 
> So exactly which build method broke due to this? The typical way to do a defconfig build is:
> 
>    make ARCH=i386 defconfig
> 
> which still works fine AFAICS.
> 
Maybe wrong way to do it, just plain "make i386_defconfig". I'm aware of 
ARCH=, but never needed to specify it for x86 targets.

Jarkko
