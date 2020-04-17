Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD16C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC5F208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgDQPdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:33:13 -0400
Received: from foss.arm.com ([217.140.110.172]:52920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728542AbgDQPdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:33:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 024B71FB;
        Fri, 17 Apr 2020 08:33:13 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98A903F73D;
        Fri, 17 Apr 2020 08:33:11 -0700 (PDT)
Subject: Re: [PATCH v3] x86/resctrl: Preserve CDP enable over cpuhp
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>
References: <20200221162105.154163-1-james.morse@arm.com>
 <8d84868f-4045-8d69-ed45-d0f0629ba25c@intel.com>
 <a411323a-2439-5d30-2106-2e3598e9a8c7@intel.com>
 <20200417141841.GD7322@zn.tnic>
 <e762a1c9-b13a-cc8c-e945-292218af418b@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <2030b4e2-bf52-592c-ac67-ddc2aa5f918c@arm.com>
Date:   Fri, 17 Apr 2020 16:33:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e762a1c9-b13a-cc8c-e945-292218af418b@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 17/04/2020 15:57, Reinette Chatre wrote:
> On 4/17/2020 7:18 AM, Borislav Petkov wrote:
>> On Wed, Apr 15, 2020 at 08:57:34AM -0700, Reinette Chatre wrote:
>>> Hi Thomas and Borislav,
>>>
>>> Could you please consider this patch for inclusion as a fix for v5.7?
>>
>> Do you mean by that that I should add
>>
>> Cc: <stable@vger.kernel.org>
>>
>> so that it goes to stable?

Is the CC-stable still required? I've seen a 'Fixes' tag on its own cause patches to get
picked up...


>> The commit in Fixes: is from 4.10-ish times...
>>
> 
> Borislav: Sorry about that and thank you very much for catching this
> omission. Yes, this patch needs to go to stable.

> James: would you be able to do the backports to stable? Please note that
> support for L2 and L3 CDP was added across Linux versions and the
> resctrl files moved around since then so the backport would need some
> changes to address this issue in all versions.

Yes, certainly!


Thanks,

James
