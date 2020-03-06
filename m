Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7A0C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BEA2073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgCFJlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:41:19 -0500
Received: from foss.arm.com ([217.140.110.172]:58604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgCFJlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:41:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18BC231B;
        Fri,  6 Mar 2020 01:41:19 -0800 (PST)
Received: from [10.1.195.32] (e112269-lin.cambridge.arm.com [10.1.195.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 664A33F6C4;
        Fri,  6 Mar 2020 01:41:18 -0800 (PST)
Subject: Re: [PATCH] mm: Correct guards for non_swap_entry()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>
References: <20200305130550.22693-1-steven.price@arm.com>
 <20200305194431.7fe10d760d9921d0eff106c1@linux-foundation.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <efa519d1-5f0a-11a6-e143-c83698b7e5b2@arm.com>
Date:   Fri, 6 Mar 2020 09:41:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305194431.7fe10d760d9921d0eff106c1@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2020 03:44, Andrew Morton wrote:
> On Thu,  5 Mar 2020 13:05:50 +0000 Steven Price <steven.price@arm.com> wrote:
> 
>> If CONFIG_DEVICE_PRIVATE is defined, but neither CONFIG_MEMORY_FAILURE nor
>> CONFIG_MIGRATION, then non_swap_entry() will return 0, meaning that the
>> condition (non_swap_entry(entry) && is_device_private_entry(entry)) in
>> zap_pte_range() will never be true even if the entry is a device private
>> one.
>>
>> Equally any other code depending on non_swap_entry() will not function
>> as expected.
> 
> What are the user-visible runtime effects of this change?
> 
> Is a cc:stable needed?
> 

I originally spotted this just by looking at the code, I haven't
actually observed any problems.

Looking a bit more closely it appears that actually this situation
(currently at least) cannot occur:

DEVICE_PRIVATE depends on ZONE_DEVICE
ZONE_DEVICE depends on MEMORY_HOTREMOVE
MEMORY_HOTREMOVE depends on MIGRATION

So there's probably no need to back port.

Steve
