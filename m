Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E291C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D1BD20678
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cf3h+MJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgHKILd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:11:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728225AbgHKILa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 04:11:30 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07B82WpA143054;
        Tue, 11 Aug 2020 04:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=2QKqibQLkfC4+NATjrERYrmrCWhFdQCQXQuGVrIRjAc=;
 b=Cf3h+MJUwx1wL/YD6z1GILlhIvkXo8yG8xnTwQBVj7fsYpP6tO9K+ldCX6Q0HlYtQk9K
 PikA824ZMiPhaJlz1YV4R9y+DzcM57KL3m3jsZ8V+fXiDfZfmjqq8NBFnTvbjmEmKP/W
 GTdvPFKL8azgriAt1oIHB1d8dBwMJvdbqqOg4RnkPSTCpcwibG1+1t0J2odLYfAacJD/
 0LX7F+b0/LlE/PKATShFboILxZKx1BnjUl8s7IlY5iztkbLuWkSVxX+Q7EXrdEHU6wTD
 J/9kZ2wRWnLi/myUJ/ug+1lKI9m16JDwhRsSfDIOifFhWwoBN/uCKg0cO8MrDwfjHhJ/ Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32sr7veh8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Aug 2020 04:11:19 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07B83NX9148010;
        Tue, 11 Aug 2020 04:11:18 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32sr7veh82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Aug 2020 04:11:18 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07B8BGSF001946;
        Tue, 11 Aug 2020 08:11:16 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 32skp7swvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Aug 2020 08:11:16 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07B8BEaA33817052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Aug 2020 08:11:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CF0152052;
        Tue, 11 Aug 2020 08:11:14 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.21.82])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 67E8D5204E;
        Tue, 11 Aug 2020 08:11:13 +0000 (GMT)
Date:   Tue, 11 Aug 2020 10:11:11 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Balamuruhan S <bala24@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 1/3] perf bench numa: use numa_node_to_cpus() to bind
 tasks to nodes
Message-ID: <20200811081111.GA31614@oc3871087118.ibm.com>
References: <cover.1597004831.git.agordeev@linux.ibm.com>
 <a002ebf17a3970e5d2dc7b9869dc180e68b88db4.1597004831.git.agordeev@linux.ibm.com>
 <CAM9d7cjLA29eOm6UU5FVE-Zeg7wm4bJaSdwMOH=ghDn=hfBo=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjLA29eOm6UU5FVE-Zeg7wm4bJaSdwMOH=ghDn=hfBo=A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-11_07:2020-08-06,2020-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2
 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008110047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 04:26:50PM +0900, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Aug 10, 2020 at 3:22 PM Alexander Gordeev
> <agordeev@linux.ibm.com> wrote:
> >
> > It is currently assumed that each node contains at most
> > nr_cpus/nr_nodes CPUs and node CPU ranges do not overlap.
> > That assumption is generally incorrect as there are archs
> > where a CPU number does not depend on to its node number.
> >
> > This update removes the described assumption by simply calling
> > numa_node_to_cpus() interface and using the returned mask for
> > binding CPUs to nodes. It also tightens a cpumask allocation
> > failure check a bit.
> >
> > Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> > Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > Cc: Balamuruhan S <bala24@linux.vnet.ibm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> > ---
> >  tools/perf/bench/numa.c | 27 +++++++++++++--------------
> >  1 file changed, 13 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> > index 5797253..23e224e 100644
> > --- a/tools/perf/bench/numa.c
> > +++ b/tools/perf/bench/numa.c
> > @@ -247,12 +247,13 @@ static int is_node_present(int node)
> >   */
> >  static bool node_has_cpus(int node)
> >  {
> > -       struct bitmask *cpu = numa_allocate_cpumask();
> > +       struct bitmask *cpumask = numa_allocate_cpumask();
> >         unsigned int i;
> >
> > -       if (cpu && !numa_node_to_cpus(node, cpu)) {
> > -               for (i = 0; i < cpu->size; i++) {
> > -                       if (numa_bitmask_isbitset(cpu, i))
> > +       BUG_ON(!cpumask);
> > +       if (!numa_node_to_cpus(node, cpumask)) {
> > +               for (i = 0; i < cpumask->size; i++) {
> > +                       if (numa_bitmask_isbitset(cpumask, i))
> >                                 return true;
> >                 }
> >         }
> > @@ -288,14 +289,10 @@ static cpu_set_t bind_to_cpu(int target_cpu)
> >
> >  static cpu_set_t bind_to_node(int target_node)
> >  {
> > -       int cpus_per_node = g->p.nr_cpus / nr_numa_nodes();
> >         cpu_set_t orig_mask, mask;
> >         int cpu;
> >         int ret;
> >
> > -       BUG_ON(cpus_per_node * nr_numa_nodes() != g->p.nr_cpus);
> > -       BUG_ON(!cpus_per_node);
> > -
> >         ret = sched_getaffinity(0, sizeof(orig_mask), &orig_mask);
> >         BUG_ON(ret);
> >
> > @@ -305,13 +302,15 @@ static cpu_set_t bind_to_node(int target_node)
> >                 for (cpu = 0; cpu < g->p.nr_cpus; cpu++)
> >                         CPU_SET(cpu, &mask);
> >         } else {
> > -               int cpu_start = (target_node + 0) * cpus_per_node;
> > -               int cpu_stop  = (target_node + 1) * cpus_per_node;
> > -
> > -               BUG_ON(cpu_stop > g->p.nr_cpus);
> > +               struct bitmask *cpumask = numa_allocate_cpumask();
> >
> > -               for (cpu = cpu_start; cpu < cpu_stop; cpu++)
> > -                       CPU_SET(cpu, &mask);
> > +               BUG_ON(!cpumask);
> > +               if (!numa_node_to_cpus(target_node, cpumask)) {
> > +                       for (cpu = 0; cpu < (int)cpumask->size; cpu++) {
> > +                               if (numa_bitmask_isbitset(cpumask, cpu))
> > +                                       CPU_SET(cpu, &mask);
> > +                       }
> > +               }
> 
> It seems you need to call numa_free_cpumask() for both functions.

Well, the whole approach to memory allocation is rather relaxed
troughout the code. I.e cpumasks do not get deallocated (*),
strdup() return values are not checked etc.

If it worth fixing all that then it would be a separate effort,
as far as I am concerned.

> Thanks
> Namhyung
> 
> >         }
> >
> >         ret = sched_setaffinity(0, sizeof(mask), &mask);
> > --
> > 1.8.3.1
> >
