Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520F6C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 20:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C654206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 20:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbgAKU46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 15:56:58 -0500
Received: from foss.arm.com ([217.140.110.172]:57004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731097AbgAKU46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 15:56:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0968830E;
        Sat, 11 Jan 2020 12:56:57 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 014473F534;
        Sat, 11 Jan 2020 12:56:55 -0800 (PST)
Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations conflicts with
 lower layer
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
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
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <1a8f7963-97e9-62cc-12d2-39f816dfaf67@arm.com>
Date:   Sat, 11 Jan 2020 20:56:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED340BEDD6@dggemm526-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2020 12:58, Zengtao (B) wrote:
>> IIUC, the problem is that virt can set up a broken topology in some
>> cases where MPIDR doesn't line up correctly with the defined NUMA
>> nodes.
>>
>> We could argue that it is a qemu/virt problem, but it would be nice if
>> we could at least detect it. The proposed patch isn't really the right
>> solution as it warns on some valid topologies as Sudeep already pointed
>> out.
>>
>> It sounds more like we need a mask subset check in the sched_domain
>> building code, if there isn't already one?
> 
> Currently no, it's a bit complex to do the check in the sched_domain building code,
> I need to take a think of that.
> Suggestion welcomed.
> 

Doing a search on the sched_domain spans themselves should look something like
the completely untested:

---8<---
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6ec1e595b1d4..96128d12ec23 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1879,6 +1879,43 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 	return sd;
 }
 
+/* Ensure topology masks are sane; non-NUMA spans shouldn't overlap */
+static int validate_topology_spans(const struct cpumask *cpu_map)
+{
+	struct sched_domain_topology_level *tl;
+	int i, j;
+
+	for_each_sd_topology(tl) {
+		/* NUMA levels are allowed to overlap */
+		if (tl->flags & SDTL_OVERLAP)
+			break;
+
+		/*
+		 * Non-NUMA levels cannot partially overlap - they must be
+		 * either equal or wholly disjoint. Otherwise we can end up
+		 * breaking the sched_group lists - i.e. a later get_group()
+		 * pass breaks the linking done for an earlier span.
+		 */
+		for_each_cpu(i, cpu_map) {
+			for_each_cpu(j, cpu_map) {
+				if (i == j)
+					continue;
+				/*
+				 * We should 'and' all those masks with 'cpu_map'
+				 * to exactly match the topology we're about to
+				 * build, but that can only remove CPUs, which
+				 * only lessens our ability to detect overlaps
+				 */
+				if (!cpumask_equal(tl->mask(i), tl->mask(j)) &&
+				    cpumask_intersects(tl->mask(i), tl->mask(j)))
+					return -1;
+			}
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Find the sched_domain_topology_level where all CPU capacities are visible
  * for all CPUs.
@@ -1953,7 +1990,8 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	struct sched_domain_topology_level *tl_asym;
 	bool has_asym = false;
 
-	if (WARN_ON(cpumask_empty(cpu_map)))
+	if (WARN_ON(cpumask_empty(cpu_map)) ||
+	    WARN_ON(validate_topology_spans(cpu_map)))
 		goto error;
 
 	alloc_state = __visit_domain_allocation_hell(&d, cpu_map);
--->8---

Alternatively the assertion on the sched_group linking I suggested earlier
in the thread should suffice, since this should trigger whenever we have
overlapping non-NUMA sched domains.

Since you have a setup where you can reproduce the issue, could please give
either (ideally both!) a try? Thanks.

> Thanks 
> Zengtao 
> 
>>
>> Morten
