Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9F3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03FEB2070E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yZYlXHV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgGIXI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:08:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51092 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGIXI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:08:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 069N7tkk074180;
        Thu, 9 Jul 2020 23:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=sScchhS4atJn0O2/LzMdmzUNFdSvjrcpC4fpbNwpoy8=;
 b=yZYlXHV6So3hU9W2DzFgb7WNOrtM97PX15VIcZjjUYYRbyVy548GCnx4YaGJKIGhW8RA
 frLmra2FZBrFUx2yPwS2GG4v+/DzkHy5jarQwRJaRt48exNScxuwOavhv9JPkhitdJ5G
 GSXQuEI1blTAgoaPQ/oaeFfCMtqs70+w7Um2cvl9RxBZD07tuucA7pxDfNZOi21xLJza
 WafTmfE3/MR1EU+IQIDb20xNxmim8rEZYy85oObsWmNgkV9GLiblJoAXqgI+240CYEy/
 ImF/i0zHq5mx3kH4NXXlPFRZJEbTAC+gS+wRu3+n+rjtOB5/FxUwecRqlFavj8nUkVuA Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 325y0amh2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 09 Jul 2020 23:08:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 069N8Nq4004546;
        Thu, 9 Jul 2020 23:08:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 325k4169vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jul 2020 23:08:25 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 069N8CJB018661;
        Thu, 9 Jul 2020 23:08:13 GMT
Received: from [192.168.0.193] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Jul 2020 16:08:12 -0700
Subject: [SchedulerWakeupLatency] Skipping Idle Cores and CPU Search
To:     Parth Shah <parth@linux.ibm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Josef Bacik <jbacik@fb.com>
References: <87v9kv2545.derkling@matbug.com> <87h7wd15v2.derkling@matbug.net>
 <87imgrlrqi.derkling@matbug.net> <87mu5sqwkt.derkling@matbug.net>
 <87eer42clt.derkling@matbug.net> <87imfi2qbk.derkling@matbug.net>
 <39cc4666-6355-fb9f-654d-e85e1852bc6f@linux.ibm.com>
From:   chris hyser <chris.hyser@oracle.com>
Message-ID: <ffcff197-122f-c5bd-91f4-0ff8600be04d@oracle.com>
Date:   Thu, 9 Jul 2020 19:08:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <39cc4666-6355-fb9f-654d-e85e1852bc6f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007090153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > A) Name:

Skipping Idle Cores and CPU Search


 > B) Target behavior:

Finding idle CPUs in the CFS scheduler for scheduling awakened tasks increases system throughput at the expense of 
additional wake-up latency. For the majority of processes this is a reasonable trade-off. Some communication tasks are 
sufficiently sensitive to latency as well as sufficiently short lived (the search time on large systems exceeding the 
typical run before sleep time of the comm task itself) to warrant skipping the search. While a real-time priority in a 
correctly set up environment might remove the latency, real-time has its own issues, in particular with cgroup 
interoperability/configuration.


 > C) Existing control paths: reference to code paths to justify B)

--------------------------------------------------------------

select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
         nr = INT_MAX
         avg_idle = this_rq()->avg_idle / 512;
         avg_cost = this_sd->avg_scan_cost + 1;

         if (sched_feat(SIS_AVG_CPU) && avg_idle < avg_cost)
                 return -1;

         if (sched_feat(SIS_PROP))
                 u64 span_avg = sd->span_weight * avg_idle;
                 if (span_avg > 4*avg_cost)
                         nr = div_u64(span_avg, avg_cost);
                 else
                         nr = 4;

         // conditionally use a per-task tunable to adjust 'nr' or return 'target'.

         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
         for_each_cpu_wrap(cpu, cpus, target)
                 if (!--nr)
                         return -1;
                 if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
                         break;

          return cpu;

-------------------------------------------------------------

select_idle_sibling(struct task_struct *p, int prev, int target)
         // if NOT per-task tunable set. ie the default for tasks.
                 i = select_idle_core(p, sd, target);
                 if ((unsigned)i < nr_cpumask_bits)
                         return i;

          i = select_idle_cpu(p, sd, target);
          if ((unsigned)i < nr_cpumask_bits)
                  return i;

          i = select_idle_smt(p, target);
          if ((unsigned)i < nr_cpumask_bits)
                  return i;

          return target;

-------------------------------------------------------------


 > D) Desired behavior:

Reduce the maximum wake-up latency of designated CFS tasks by skipping some or all of the idle CPU and core searches by 
setting a maximum idle CPU search value (maximum loop iterations).

Searching 'ALL' as the maximum would be the default and implies the current code path which may or may not search up to 
ALL. Searching 0 would result in the least latency (shown with experimental results to be included if/when patchset goes 
up). One of the considerations is that the maximum length of the search is a function of the size of the LLC scheduling 
domain and this is platform dependent. Whether 'some', i.e. a numerical value limiting the search can be used to 
"normalize" this latency across differing scheduling domain sizes is under investigation. Clearly differing hardware 
will have many other significant differences, but in different sized and dynamically sized VMs running on fleets of 
common HW this may be interesting.


 > E/F) Existing knobs (and limitations):

There are existing sched_feat: SIS_AVG_CPU, SIS_PROP that attempt to short circuit the idle cpu search path in 
select_idle_cpu() based on estimations of the current costs of searching. Neither provides a means of task-based 
selectivity potentially shortening the search for an unimportant tasks and lengthening the one for a critical task. This 
also highlights the difference between lowering average or tail-end latencies for all tasks versus as desired here, 
specific targeted ones. Not surprisingly, latency reduction here, as in general, comes at the expense of system 
throughput, in this case unbalanced-ness in the LLC scheduling domain.

The proposal here allows maximum reduction of the search time for specific tasks. Keeping the number small has minimal 
impact (though not zero) on system throughput as the vast majority of tasks are subject to the existing searches.


 > G) Proportionality Analysis:

While the immediate use case suggests that one either cares about the latency of a task or not, maximally do 'ALL' or 0 
searches -- presumably one generally wants maximum latency reduction -- the nature of the problem (see pseudo code) 
allows precise specification of the maximum number of CPUs to search placing an upper limit on search latency.


 > H) Range Analysis:

The knob is a positive integer representing "max number of CPUs to search". The default would be 'ALL' which could be 
translated as INT_MAX. '0 searches' translates to 0. Other values represent a max limit on the search, in this case 
iterations of a for loop.


 > I) System-Wide tuning:

No system-wide tuning required.


 > J) Per-Task tuning:

The proposal is a per-task single positive integer representing the maximum number of CPUs to search. sched_setscheduler 
would allow both 'nice' and this value to be set together which is a reasonably expected use case for latency sensitive 
tasks.


 > K) Task-Group tuning:

As the intention here is to limit this behavior to specific identified tasks, and overall performance can be negatively 
affected if too many or the wrong tasks are selected, this use case does not appear to really need task groupings, 
hierarchical relationships, or child inheritance.


-chrish
