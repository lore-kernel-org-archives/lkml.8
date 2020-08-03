Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1703C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 00:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C4620738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 00:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgHCAXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 20:23:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:29350 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbgHCAXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 20:23:37 -0400
IronPort-SDR: kaB14GmGtraADcsSpGYCJkNLmoVUtWIlyIQlHdhKcI58zO65fKtSXNUr7yBiN09GLvWs5Rbyo1
 mvrF8OQJTQzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="139605146"
X-IronPort-AV: E=Sophos;i="5.75,428,1589266800"; 
   d="scan'208";a="139605146"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 17:23:37 -0700
IronPort-SDR: 8cGyRBA9/dzKpCtb1vIl0pZXK9Dit/1PGjobykj+GZY+qkTzSIEa1R3uT0//CnMQ1SU5i2OaV/
 RGpdzM/BGZyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,428,1589266800"; 
   d="scan'208";a="314480910"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by fmsmga004.fm.intel.com with ESMTP; 02 Aug 2020 17:23:34 -0700
Subject: Re: [kbuild-all] Re: [RFC PATCH linux-next] platform/x86:
 thinkpad_acpi: dev_attr_charge_start_threshold can be static
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <202008011649.b8CEYWIz%lkp@intel.com>
 <20200801083654.GA31368@144836a6079b>
 <CAHp75VcCa4whJ7ry9uU+14suLbGPvKgRFJku3dC+dPVNzc0d5Q@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <095dca8b-e54c-1b5b-4b40-ff3ce43d377e@intel.com>
Date:   Mon, 3 Aug 2020 08:23:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VcCa4whJ7ry9uU+14suLbGPvKgRFJku3dC+dPVNzc0d5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/20 7:45 PM, Andy Shevchenko wrote:
> On Sat, Aug 1, 2020 at 11:38 AM kernel test robot <lkp@intel.com> wrote:
>
> Thanks and sorry folks, Hulk robot was faster, and TBH their patch
> looks much better (proper commit message applied). Perhaps something
> LKP should work on?

Hi Andy,

Thanks for the advice, we'll improve the commit message.

Best Regards,
Rong Chen

>
>> Fixes: e33929537b76 ("platform/x86: thinkpad_acpi: use standard charge control attribute names")
>> Signed-off-by: kernel test robot <lkp@intel.com>
>

