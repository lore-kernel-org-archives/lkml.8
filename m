Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF93C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 06:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE7F520773
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 06:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g/eCrb+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgHJGOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 02:14:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46344 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725814AbgHJGOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 02:14:51 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07A672hM045033;
        Mon, 10 Aug 2020 02:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=DC9ZVaWbhsVOdNKl7yCJVCGW/U1781tV4/G8ec3wax0=;
 b=g/eCrb+lh+U5FMPudB/mcYbJARjzqCDXIh/45hk0paXe4+/CnTWovHUJiy8MYo3bLJN/
 nniRtTYJ/RgjZS39rfWW0yKuu89ITZs2YJRozXxuf2PszMX9JXr6oIYsu2p+Vb4flKoB
 FCCs0oyDnVBcQQQgxcQ64WiEetzSl3f4J8b51koX+qaVkkxUT1W2KaxqsdP61UZcK/YU
 Ff3GnDz0f3EyVoH3ZIq2X/O/+YWGYWEhENUaaA8Bzuom7pbUdbhTwxIPZBC82lXtx65n
 zZHmc2NcqrrszzOIyfh7D0+fGMabSGXch33vcDP4HRhr3EEDiCiKR531DPzULu9VS1J9 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32sr4qt72p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 02:14:14 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07A6DZJn063941;
        Mon, 10 Aug 2020 02:14:13 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32sr4qt72a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 02:14:13 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07A6AOBg028154;
        Mon, 10 Aug 2020 06:14:11 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 32skp81wu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 06:14:11 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07A6Cgn351642786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 06:12:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7530542047;
        Mon, 10 Aug 2020 06:14:09 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93C0242049;
        Mon, 10 Aug 2020 06:14:07 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 10 Aug 2020 06:14:07 +0000 (GMT)
Date:   Mon, 10 Aug 2020 11:44:06 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/fair: ignore cache hotness for SMT migration
Message-ID: <20200810061406.GA15559@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20200804105619.GE2657@hirez.programming.kicks-ass.net>
 <20200804193413.510651-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200804193413.510651-1-joshdon@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-10_02:2020-08-06,2020-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008100043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Josh Don <joshdon@google.com> [2020-08-04 12:34:13]:

> SMT siblings share caches, so cache hotness should be irrelevant for
> cross-sibling migration.
> 
> Proposed-by: Venkatesh Pallipadi <venki@google.com>
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
>  kernel/sched/fair.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1a68a0536add..abdb54e2339f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7402,6 +7402,10 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>  	if (unlikely(task_has_idle_policy(p)))
>  		return 0;
>  
> +	/* SMT siblings share cache */
> +	if (env->sd->flags & SD_SHARE_CPUCAPACITY)
> +		return 0;
> +

If this for retaining cache hotness, should we look at
SD_SHARE_PKG_RESOURCES instead of SD_SHARE_CPUCAPACITY?

>  	/*
>  	 * Buddy candidates are cache hot:
>  	 */
> -- 
> 2.28.0.163.g6104cc2f0b6-goog
> 

-- 
Thanks and Regards
Srikar Dronamraju
