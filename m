Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D85C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2362076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgGJLTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:19:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726757AbgGJLS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:18:59 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06AB2IYX104440;
        Fri, 10 Jul 2020 07:18:55 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpr01jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 07:18:55 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06AB2qIH106762;
        Fri, 10 Jul 2020 07:18:54 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpr01j2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 07:18:54 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06AB5r79007590;
        Fri, 10 Jul 2020 11:18:51 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 326bch8hjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 11:18:51 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06ABInbH6684990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 11:18:49 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BF63AE051;
        Fri, 10 Jul 2020 11:18:49 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF9C1AE055;
        Fri, 10 Jul 2020 11:18:47 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 10 Jul 2020 11:18:47 +0000 (GMT)
Date:   Fri, 10 Jul 2020 16:48:47 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/4] perf-probe: Avoid setting probes on same address on
 same event
Message-ID: <20200710111847.GN874@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <159428201109.56570.3802208017109058146.stgit@devnote2>
 <159428202173.56570.3555041287477206859.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <159428202173.56570.3555041287477206859.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_03:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007100074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Masami Hiramatsu <mhiramat@kernel.org> [2020-07-09 17:07:01]:

> There is a case that the several same-name symbols points
> same address. In that case, perf probe returns an error.
> 
> E.g.
> 
> With this patch;
> 
>   # perf probe -x /lib64/libc-2.30.so -a "memcpy arg1=%di"
>   Failed to find the location of the '%di' variable at this address.
>    Perhaps it has been optimized out.
>    Use -V with the --range option to show '%di' location range.
>   Added new events:
>     probe_libc:memcpy    (on memcpy in /usr/lib64/libc-2.30.so with arg1=%di)
>     probe_libc:memcpy    (on memcpy in /usr/lib64/libc-2.30.so with arg1=%di)
> 
>   You can now use it in all perf tools, such as:
> 
>   	perf record -e probe_libc:memcpy -aR sleep 1
> 
> 
> Reported-by: Andi Kleen <andi@firstfloor.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

One small nit:

> ---
>  tools/perf/util/probe-event.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index df713a5d1e26..1e95a336862c 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2968,6 +2968,15 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
>  	for (j = 0; j < num_matched_functions; j++) {
>  		sym = syms[j];
> 
> +		/* There can be duplicated symbols in the map */
> +		for (i = 0; i < j; i++)
> +			if (sym->start == syms[i]->start) {
> +				pr_debug("find duplicated symbol %s @ %lx\n", sym->name, sym->start);
	
Would "Found" sound better than "find"?

> +				break;
> +			}
> +		if (i != j)
> +			continue;
> +

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>


>  		tev = (*tevs) + ret;
>  		tp = &tev->point;
>  		if (ret == num_matched_functions) {
> 

-- 
Thanks and Regards
Srikar Dronamraju
