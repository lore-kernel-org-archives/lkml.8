Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CFBC33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEEE3207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAMOtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:49:13 -0500
Received: from foss.arm.com ([217.140.110.172]:40386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbgAMOtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:49:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C342611B3;
        Mon, 13 Jan 2020 06:49:11 -0800 (PST)
Received: from [192.168.0.103] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 854213F68E;
        Mon, 13 Jan 2020 06:49:10 -0800 (PST)
Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations conflicts with
 lower layer
To:     Valentin Schneider <valentin.schneider@arm.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1577088979-8545-1-git-send-email-prime.zeng@hisilicon.com>
 <20191231164051.GA4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AE1D3@dggemm526-mbx.china.huawei.com>
 <20200102112955.GC4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AEB67@dggemm526-mbx.china.huawei.com>
 <c43342d0-7e4d-3be0-0fe1-8d802b0d7065@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340AFCA0@dggemm526-mbx.china.huawei.com>
 <20200103114011.GB19390@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340B31E9@dggemm526-mbx.china.huawei.com>
 <20200109104306.GA10914@e105550-lin.cambridge.arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340BEDD6@dggemm526-mbx.china.huawei.com>
 <1a8f7963-97e9-62cc-12d2-39f816dfaf67@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <1fbe4475-363d-e800-8295-a1591d5e52d9@arm.com>
Date:   Mon, 13 Jan 2020 15:49:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1a8f7963-97e9-62cc-12d2-39f816dfaf67@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11.01.20 21:56, Valentin Schneider wrote:
> On 09/01/2020 12:58, Zengtao (B) wrote:
>>> IIUC, the problem is that virt can set up a broken topology in some
>>> cases where MPIDR doesn't line up correctly with the defined NUMA
>>> nodes.
>>>
>>> We could argue that it is a qemu/virt problem, but it would be nice if
>>> we could at least detect it. The proposed patch isn't really the right
>>> solution as it warns on some valid topologies as Sudeep already pointed
>>> out.
>>>
>>> It sounds more like we need a mask subset check in the sched_domain
>>> building code, if there isn't already one?
>>
>> Currently no, it's a bit complex to do the check in the sched_domain building code,
>> I need to take a think of that.
>> Suggestion welcomed.
>>
> 
> Doing a search on the sched_domain spans themselves should look something like
> the completely untested:

[...]

LGTM. This code detects the issue in cpu_coregroup_mask(), which is the
the cpumask function of the sched domain MC level struct
sched_domain_topology_level of ARM64's (and other archs)
default_topology[].
I wonder how x86 copes with such a config error?
Maybe they do it inside their cpu_coregroup_mask()?


We could move validate_topology_spans() into the existing

for_each_cpu(i, cpu_map)
    for_each_sd_topology(tl)

loop in build_sched_domains() saving some code?

---8<---

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index e6ff114e53f2..5f2764433a3d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1880,37 +1880,34 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 }
 
 /* Ensure topology masks are sane; non-NUMA spans shouldn't overlap */
-static int validate_topology_spans(const struct cpumask *cpu_map)
+static int validate_topology_spans(struct sched_domain_topology_level *tl,
+                                  const struct cpumask *cpu_map, int cpu)
 {
-       struct sched_domain_topology_level *tl;
-       int i, j;
+       const struct cpumask* mask = tl->mask(cpu);
+       int i;
 
-       for_each_sd_topology(tl) {
-               /* NUMA levels are allowed to overlap */
-               if (tl->flags & SDTL_OVERLAP)
-                       break;
+       /* NUMA levels are allowed to overlap */
+       if (tl->flags & SDTL_OVERLAP)
+               return 0;
 
+       /*
+        * Non-NUMA levels cannot partially overlap - they must be
+        * either equal or wholly disjoint. Otherwise we can end up
+        * breaking the sched_group lists - i.e. a later get_group()
+        * pass breaks the linking done for an earlier span.
+        */
+       for_each_cpu(i, cpu_map) {
+               if (i == cpu)
+                       continue;
                /*
-                * Non-NUMA levels cannot partially overlap - they must be
-                * either equal or wholly disjoint. Otherwise we can end up
-                * breaking the sched_group lists - i.e. a later get_group()
-                * pass breaks the linking done for an earlier span.
+                * We should 'and' all those masks with 'cpu_map'
+                * to exactly match the topology we're about to
+                * build, but that can only remove CPUs, which
+                * only lessens our ability to detect overlaps
                 */
-               for_each_cpu(i, cpu_map) {
-                       for_each_cpu(j, cpu_map) {
-                               if (i == j)
-                                       continue;
-                               /*
-                                * We should 'and' all those masks with 'cpu_map'
-                                * to exactly match the topology we're about to
-                                * build, but that can only remove CPUs, which
-                                * only lessens our ability to detect overlaps
-                                */
-                               if (!cpumask_equal(tl->mask(i), tl->mask(j)) &&
-                                   cpumask_intersects(tl->mask(i), tl->mask(j)))
-                                       return -1;
-                       }
-               }
+               if (!cpumask_equal(mask, tl->mask(i)) &&
+                   cpumask_intersects(mask, tl->mask(i)))
+                       return -1;
        }
 
        return 0;
@@ -1990,8 +1987,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
        struct sched_domain_topology_level *tl_asym;
        bool has_asym = false;
 
-       if (WARN_ON(cpumask_empty(cpu_map)) ||
-           WARN_ON(validate_topology_spans(cpu_map)))
+       if (WARN_ON(cpumask_empty(cpu_map)))
                goto error;
 
        alloc_state = __visit_domain_allocation_hell(&d, cpu_map);
@@ -2013,6 +2009,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
                                has_asym = true;
                        }
 
+                       if (WARN_ON(validate_topology_spans(tl, cpu_map, i)))
+                               goto error;
+
                        sd = build_sched_domain(tl, cpu_map, attr, sd, dflags, i);
 
                        if (tl == sched_domain_topology)






































