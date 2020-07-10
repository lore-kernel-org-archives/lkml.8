Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB7FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CFF82076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgGJLQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:16:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726757AbgGJLQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:16:38 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06AB1v13160575;
        Fri, 10 Jul 2020 07:16:33 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 326bpb906c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 07:16:33 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06AB3u1C172310;
        Fri, 10 Jul 2020 07:16:33 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 326bpb905m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 07:16:33 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06AB5T3b007199;
        Fri, 10 Jul 2020 11:16:31 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 326bch8hha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 11:16:31 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06ABGTKA63373454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 11:16:29 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 108C842047;
        Fri, 10 Jul 2020 11:16:29 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C09E42042;
        Fri, 10 Jul 2020 11:16:27 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 10 Jul 2020 11:16:27 +0000 (GMT)
Date:   Fri, 10 Jul 2020 16:46:26 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 3/4] perf-probe: Fix memory leakage when the probe point
 is not found
Message-ID: <20200710111626.GM874@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <159428201109.56570.3802208017109058146.stgit@devnote2>
 <159428204201.56570.8191554031198604445.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <159428204201.56570.8191554031198604445.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_03:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007100074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Masami Hiramatsu <mhiramat@kernel.org> [2020-07-09 17:07:22]:

> Fix the memory leakage in debuginfo__find_trace_events() when the probe
> point is not found in the debuginfo. If there is no probe point found in
> the debuginfo, debuginfo__find_probes() will NOT return -ENOENT, but 0.
> Thus the caller of debuginfo__find_probes() must check the tf.ntevs and
> release the allocated memory for the array of struct probe_trace_event.
> 
> The current code releases the memory only if the debuginfo__find_probes()
> hits an error but not checks tf.ntevs. In the result, the memory allocated
> on *tevs are not released if tf.ntevs == 0.
> 
> This fixes the memory leakage by checking tf.ntevs == 0 in addition to
> ret < 0.
> 
> Fixes: ff741783506c ("perf probe: Introduce debuginfo to encapsulate dwarf information")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>


Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

> ---
>  tools/perf/util/probe-finder.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 9963e4e8ea20..659024342e9a 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -1467,7 +1467,7 @@ int debuginfo__find_trace_events(struct debuginfo *dbg,
>  	if (ret >= 0 && tf.pf.skip_empty_arg)
>  		ret = fill_empty_trace_arg(pev, tf.tevs, tf.ntevs);
> 
> -	if (ret < 0) {
> +	if (ret < 0 || tf.ntevs == 0) {
>  		for (i = 0; i < tf.ntevs; i++)
>  			clear_probe_trace_event(&tf.tevs[i]);
>  		zfree(tevs);
> 

-- 
Thanks and Regards
Srikar Dronamraju
