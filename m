Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFD5C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645272187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393050AbgBNSMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:12:50 -0500
Received: from foss.arm.com ([217.140.110.172]:42760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389702AbgBNSMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:12:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92AB4328;
        Fri, 14 Feb 2020 10:12:45 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 917163F68E;
        Fri, 14 Feb 2020 10:12:44 -0800 (PST)
Subject: Re: [PATCH] x86/resctrl: Preserve CDP enable over cpuhp
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
References: <20200212185359.163111-1-james.morse@arm.com>
 <8aab67d7-c13e-19f1-9bec-85b7cca55146@intel.com>
 <720c9253-d590-82d5-2338-7f577a71b791@arm.com>
 <1e1ee570-8deb-688e-1875-94b84eef7641@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <75bcb664-d840-96ed-c49f-34eefa010143@arm.com>
Date:   Fri, 14 Feb 2020 18:12:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1e1ee570-8deb-688e-1875-94b84eef7641@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 13/02/2020 19:45, Reinette Chatre wrote:
> On 2/13/2020 9:42 AM, James Morse wrote:
>> On 12/02/2020 22:53, Reinette Chatre wrote:
>>> On 2/12/2020 10:53 AM, James Morse wrote:
>>>> mounted, and that cpus remember their CDP-enabled state over cpu
>>>> hotplug.
>>>>
>>>> This goes wrong when resctrl's CDP-enabled state changes while all
>>>> the cpus in a domain are offline.
>>>>
>>>> When a domain comes online, enable (or disable!) CDP to match resctrl's
>>>> current setting.

>> ... I think you're describing adding:

[...]

>> to rdtgroup.c and using that from core.c?
> 
> If I understand this correctly the CDP configuration will be done twice
> for each CDP resource, and four times for each CDP resource on a system
> supporting both L2 and L3 CDP. I think it is possible to do
> configuration once for each. Also take care on systems that support MBA
> that would not be caught by the first if statement. A system supporting
> MBA and CDP may thus attempt the configuration even more. It should be
> possible to use the resource parameter for a positive test and then just
> let the other resources fall through? Considering this, what do you
> think of something like below?
> 
> void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
> {
> 	if (!r->alloc_capable)
> 		return;
> 
> 	if (r == &rdt_resources_all[RDT_RESOURCE_L2DATA])
> 		l2_qos_cfg_update(&r->alloc_enabled);
> 
> 	if (r == &rdt_resources_all[RDT_RESOURCE_L3DATA])
> 		l3_qos_cfg_update(&r->alloc_enabled);
> }

Sold!

(the !r->alloc_capable are already filtered out by the caller, but checking is the
least-surprise option)

I'll send a v2 shortly with your suggested-by. I'd like to keep the lockdep annotations as
the MPAM tree tries to stop the arch code taking the rdtgroup_mutex. Those patches
changing these annotations makes it nice and clear what is going on.



Thanks,

James
