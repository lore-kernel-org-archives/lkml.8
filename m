Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663B0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3506620663
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgFDA0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 20:26:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:23805 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbgFDA0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 20:26:48 -0400
IronPort-SDR: XXwqlmkvHZpmeeARD8/2UdRie096hI+gShk7dCdhS1RVaI7SZaWkj855wbxprYL9JHfINgRmeZ
 PuN+7n1Q2JBw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 17:26:47 -0700
IronPort-SDR: 45Y+QvMO8Y60aiBlmzpjHJ9k7PROH2Fo6vqprKXRMCM/gbILxbXpHq6qsBxS2c1xX18Zoo8EXT
 1IH5/k3DJhsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,470,1583222400"; 
   d="scan'208";a="287204325"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga002.jf.intel.com with ESMTP; 03 Jun 2020 17:26:45 -0700
Subject: Re: [LKP] Re: b614345f52 ("x86/entry: Clarify
 irq_{enter,exit}_rcu()"): WARNING: CPU: 0 PID: 0 at
 kernel/locking/lockdep.c:3680 lockdep_hardirqs_on_prepare
To:     Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <lkp@intel.com>,
        "Peter, Zijlstra," <peterz@infradead.org>
Cc:     LKP <lkp@lists.01.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
References: <5ed39ad2.0a1dg5gg0oNfWJPp%lkp@intel.com>
 <87v9k8fnwj.fsf@nanos.tec.linutronix.de>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <aac6fc09-4ce0-c2f5-ae97-8f78578f8033@intel.com>
Date:   Thu, 4 Jun 2020 08:26:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87v9k8fnwj.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/3/20 6:23 PM, Thomas Gleixner wrote:
> kernel test robot <lkp@intel.com> writes:
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/lkp@lists.01.org
>> #!/bin/bash
>>
>> kernel=$1
>> initrd=yocto-x86_64-trinity.cgz
>>
>> wget --no-clobber https://download.01.org/0day-ci/lkp-qemu/osimage/yocto/$initrd
> That results in a 404. Still the same problem as months ago.

Hi Thomas,

Sorry about that, we'll fix it soon.

Best Regards,
Rong Chen

>
> initrd=yocto-trinity-x86_64.cgz
>
> works ....
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org

