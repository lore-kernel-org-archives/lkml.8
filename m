Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563CDC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A192076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgGJLPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:15:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726369AbgGJLP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:15:26 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06AB1vqU160546;
        Fri, 10 Jul 2020 07:15:19 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 326bpb8y8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 07:15:19 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06AB28s0161601;
        Fri, 10 Jul 2020 07:15:19 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 326bpb8y81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 07:15:19 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06AB5Riv015525;
        Fri, 10 Jul 2020 11:15:17 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 326bcf0hxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 11:15:17 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06ABFFmZ50266196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 11:15:15 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5D335205F;
        Fri, 10 Jul 2020 11:15:14 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 7782C5204F;
        Fri, 10 Jul 2020 11:15:13 +0000 (GMT)
Date:   Fri, 10 Jul 2020 16:45:12 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 4/4] perf-probe: Warn if the target function is GNU
 Indirect function
Message-ID: <20200710111512.GK874@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <159428201109.56570.3802208017109058146.stgit@devnote2>
 <159428205174.56570.17588311835868886287.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <159428205174.56570.17588311835868886287.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_03:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 impostorscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007100074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Masami Hiramatsu <mhiramat@kernel.org> [2020-07-09 17:07:31]:

> Reported-by: Andi Kleen <andi@firstfloor.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/perf/util/probe-event.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 1e95a336862c..671176d39569 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -379,6 +379,11 @@ static int find_alternative_probe_point(struct debuginfo *dinfo,
>  			address = sym->start;
>  		else
>  			address = map->unmap_ip(map, sym->start) - map->reloc;
> +		if (sym->type == STT_GNU_IFUNC) {
> +			pr_warning("Warning: The probe address (0x%lx) is in a GNU indirect function.\n"
> +				"This may not work as you expected unless you intend to probe the indirect function.\n",
> +				(unsigned long)address);
> +		}

Are these GNU indirect functions possible in kernel? If not we could move
this warning under if (uprobes)

Also instead of printing the address, can we print the pp->function?

>  		break;
>  	}
>  	if (!address) {
> 

-- 
Thanks and Regards
Srikar Dronamraju
