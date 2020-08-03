Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22221C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E9020678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgHCGB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:01:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726057AbgHCGB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 02:01:26 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0735WxrU026871;
        Mon, 3 Aug 2020 02:01:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32p9bncj67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 02:01:11 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0735YWYI029971;
        Mon, 3 Aug 2020 02:01:10 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32p9bncj55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 02:01:10 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0735pAQ4026967;
        Mon, 3 Aug 2020 06:01:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 32n01893vu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 06:01:08 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0735xdPn59900208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Aug 2020 05:59:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8236A405B;
        Mon,  3 Aug 2020 06:01:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C947A4062;
        Mon,  3 Aug 2020 06:01:03 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon,  3 Aug 2020 06:01:03 +0000 (GMT)
Date:   Mon, 3 Aug 2020 11:31:02 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jordan Niethe <jniethe5@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH v4 09/10] Powerpc/smp: Create coregroup domain
Message-ID: <20200803060102.GD24375@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20200727053230.19753-1-srikar@linux.vnet.ibm.com>
 <20200727053230.19753-10-srikar@linux.vnet.ibm.com>
 <jhjr1sviswg.mognet@arm.com>
 <20200729061355.GA14603@linux.vnet.ibm.com>
 <jhjlfj0ijeg.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <jhjlfj0ijeg.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_04:2020-07-31,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Also in the current P9 itself, two neighbouring core-pairs form a quad.
> > Cache latency within a quad is better than a latency to a distant core-pair.
> > Cache latency within a core pair is way better than latency within a quad.
> > So if we have only 4 threads running on a DIE all of them accessing the same
> > cache-lines, then we could probably benefit if all the tasks were to run
> > within the quad aka MC/Coregroup.
> >
> 
> Did you test this? WRT load balance we do try to balance "load" over the
> different domain spans, so if you represent quads as their own MC domain,
> you would AFAICT end up spreading tasks over the quads (rather than packing
> them) when balancing at e.g. DIE level. The desired behaviour might be
> hackable with some more ASYM_PACKING, but I'm not sure I should be
> suggesting that :-)
> 

Agree, load balance will try to spread the load across the quads. In my hack,
I was explicitly marking QUAD domains as !SD_PREFER_SIBLING + relaxing few
load spreading rules when SD_PREFER_SIBLING was not set. And this was on a
slightly older kernel (without recent Vincent's load balance overhaul).

> > I have found some benchmarks which are latency sensitive to benefit by
> > having a grouping a quad level (using kernel hacks and not backed by
> > firmware changes). Gautham also found similar results in his experiments
> > but he only used binding within the stock kernel.
> >
> 
> IIUC you reflect this "fabric quirk" (i.e. coregroups) using this DT
> binding thing.
> 
> That's also where things get interesting (for me) because I experienced
> something similar on another arm64 platform (ThunderX1). This was more
> about cache bandwidth than cache latency, but IMO it's in the same bag of
> fabric quirks. I blabbered a bit about this at last LPC [1], but kind of
> gave up on it given the TX1 was the only (arm64) platform where I could get
> both significant and reproducible results.
> 
> Now, if you folks are seeing this on completely different hardware and have
> "real" workloads that truly benefit from this kind of domain partitioning,
> this might be another incentive to try and sort of generalize this. That's
> outside the scope of your series, but your findings give me some hope!
> 
> I think what I had in mind back then was that if enough folks cared about
> it, we might get some bits added to the ACPI spec; something along the
> lines of proximity domains for the caches described in PPTT, IOW a cache
> distance matrix. I don't really know what it'll take to get there, but I
> figured I'd dump this in case someone's listening :-)
> 

Very interesting.

> > I am not setting SD_SHARE_PKG_RESOURCES in MC/Coregroup sd_flags as in MC
> > domain need not be LLC domain for Power.
> 
> From what I understood your MC domain does seem to map to LLC; but in any
> case, shouldn't you set that flag at least for BIGCORE (i.e. L2)? AIUI with
> your changes your sd_llc is gonna be SMT, and that's not going to be a very
> big mask. IMO you do want to correctly reflect your LLC situation via this
> flag to make cpus_share_cache() work properly.

I detect if the LLC is shared at BIGCORE, and if they are shared at BIGCORE,
then I dynamically rename the DOMAIN as CACHE and enable
SD_SHARE_PKG_RESOURCES in that domain.

> 
> [1]: https://linuxplumbersconf.org/event/4/contributions/484/

Thanks for the pointer.

-- 
Thanks and Regards
Srikar Dronamraju
