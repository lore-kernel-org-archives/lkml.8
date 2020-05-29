Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA7EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A6720897
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgE2Qv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 12:51:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:58601 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgE2QvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:51:25 -0400
IronPort-SDR: kc2tV3i8J4VNGJqGPMJP57LuYraXRDkQaxgYnAmL5SaVGgKG75fmt6dz1TNVKDjbiHL5whYEB8
 dT5dF3McMPEg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 09:51:25 -0700
IronPort-SDR: NZI9hH+nitIWPQIlbZvARn1Y9JNWrM6DlBBASubVpGXnyhpDF/GqXeTyldLKZnoV6PL0kPXqL2
 1U7OwAgTOgQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,449,1583222400"; 
   d="scan'208";a="443458186"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.153.119]) ([10.249.153.119])
  by orsmga005.jf.intel.com with ESMTP; 29 May 2020 09:51:23 -0700
Subject: Re: Regression with PM / wakeup: Show wakeup sources stats in sysfs"
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        trong@android.com, Greg KH <gregkh@linuxfoundation.org>,
        swboyd@chromium.org, kaleshsingh@google.com
References: <11459cde-7f57-c95b-8cac-4301f0a2390e@gmail.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <9d75a67b-87f0-161c-02d7-c9fc4efe97e7@intel.com>
Date:   Fri, 29 May 2020 18:51:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <11459cde-7f57-c95b-8cac-4301f0a2390e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/2020 10:46 PM, Florian Fainelli wrote:
> Hi,
>
> Commit c8377adfa78103be5380200eb9dab764d7ca890e ("PM / wakeup: Show
> wakeup sources stats in sysfs") is causing some of our tests to fail
> because /sys/class/net/*/device/power/wakeup_count is now 0, despite
> /sys/kernel/debug/wakeup_sources clearly indicating that the Ethernet
> device was responsible for system wake-up.
>
> What's more in looking at /sys/class/wakekup/wakeup2/event_count, we
> have the number of Wake-on-LAN wakeups recorded properly, but
> wakeup_count is desperately 0, why is that?

I need to look at that commit in detail to find out what is going on.


> This is seen on 5.4.43, but it is reproducible on Linus' master as well.
>
> The Ethernet driver being used is under
> drivers/net/ethernet/broadcom/genet/ and the relevant part is in the
> function bcmgenet_set_wol().
>
> BTW, I think you want to backport
> e976eb4b91e906f20ec25b20c152d53c472fc3fd ("PM: wakeup: Show statistics
> for deleted wakeup sources again") into 5.4 and 4.19 at least.

Well, please feel free to send a request to do that to 
stable@vger.kernel.org.

Thanks!


