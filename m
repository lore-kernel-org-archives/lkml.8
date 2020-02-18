Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35F0C34022
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 00:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19B92072C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 00:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgBRAYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 19:24:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:21791 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgBRAYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 19:24:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 16:24:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,454,1574150400"; 
   d="scan'208";a="433927310"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga005.fm.intel.com with ESMTP; 17 Feb 2020 16:24:37 -0800
Date:   Tue, 18 Feb 2020 08:24:56 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rientjes@google.com
Subject: Re: [PATCH v2] mm/vmscan.c: only adjust related kswapd cpu affinity
 when online cpu
Message-ID: <20200218002456.GA16623@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200214073320.28735-1-richardw.yang@linux.intel.com>
 <20200214085113.GP31689@dhcp22.suse.cz>
 <20200215003753.GA32682@richard>
 <20200217093124.GH31531@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217093124.GH31531@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:31:24AM +0100, Michal Hocko wrote:
>On Sat 15-02-20 08:37:53, Wei Yang wrote:
>> On Fri, Feb 14, 2020 at 09:51:13AM +0100, Michal Hocko wrote:
>> >On Fri 14-02-20 15:33:20, Wei Yang wrote:
>> >> When onlining a cpu, kswapd_cpu_online() is called to adjust kswapd cpu
>> >> affinity.
>> >> 
>> >> Current routine does like this:
>> >> 
>> >>   a) Iterate all the numa node
>> >>   b) Adjust cpu affinity when node has an online cpu
>> >> 
>> >> For a) this is not necessary, since the particular online cpu belongs to
>> >> a particular numa node. So it is not necessary to iterate on every nodes
>> >> on the system. This new onlined cpu just affect kswapd cpu affinity of
>> >> this particular node.
>> >> 
>> >> For b) several cpumask operation is used to check whether the node has
>> >> an online CPU. Since at this point we are sure one of our CPU onlined,
>> >> we can set the cpu affinity directly to current cpumask_of_node().
>> >> 
>> >> This patch simplifies the logic by set cpu affinity of the affected
>> >> kswapd.
>> >
>> >How have you tested this patch?
>> >
>> 
>> I online one cpu and confirm the "cpu" is the one we just onlined.
>> 
>> If my understanding is correct, this is the expected behavior.
>> 
>> >Also this is an old code and quite convoluted but does it still work as
>> >inteded? I mean, I do not see any cpu offline callback to reduce the
>> >cpu mask as all the CPUs for the given node go offline? Wouldn't the
>> 
>> You are right, I didn't see the counterpart for cpu offline. This is the
>> question I want to ask. Seems we didn't handle it at the very beginning.
>> 
>> >scheduler simply go and fallback to no affinity if that happens?
>> >In other words what is the value of kswapd_cpu_online in the first
>> >place?
>> 
>> Some cases may this function be useful.
>> 
>> If we have a memory node which doesn't have any online cpu, the default
>> cpumask is not set. After one of the cpu online, we want to change cpu
>> affinity.
>> 
>> Or we want to add more cpu to the system, we could allow kswapd use more cpu
>> resources. Otherwise, kswapd would be limited to those original cpus.
>
>OK, so the usecase is when a NUMA node gains a new CPU which wasn't
>there at the time when the node got onlined. Is this a scenario we
>really do care about? While not completely impossible I haven't seen
>a system which would allow such a runtime configurability. Maybe it
>would be simply easier to drop the callback for now until we have a real
>world usecase to support it and have it documented.

I am fine with this suggestion. Let me prepare v3.

>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
