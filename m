Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14435C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA5D4207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgGJN5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:57:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727810AbgGJN53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:57:29 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06ADVx1v007716;
        Fri, 10 Jul 2020 09:57:20 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 326bpbdj3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 09:57:19 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06ADW283008023;
        Fri, 10 Jul 2020 09:57:19 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 326bpbdj2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 09:57:19 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06ADtlv7010600;
        Fri, 10 Jul 2020 13:57:17 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 326bcj8b20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 13:57:17 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06ADvE6h48496888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 13:57:14 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4896A4060;
        Fri, 10 Jul 2020 13:57:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D9CAA405C;
        Fri, 10 Jul 2020 13:57:13 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 10 Jul 2020 13:57:13 +0000 (GMT)
Date:   Fri, 10 Jul 2020 19:27:12 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 4/4] perf-probe: Warn if the target function is GNU
 Indirect function
Message-ID: <20200710135712.GO874@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <159438665389.62703.13848613271334658629.stgit@devnote2>
 <159438669349.62703.5978345670436126948.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <159438669349.62703.5978345670436126948.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_07:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007100093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Masami Hiramatsu <mhiramat@kernel.org> [2020-07-10 22:11:33]:

> Warn if the probe target function is GNU indirect function (GNU_IFUNC)
> because it may not what the user want to probe.
> 
> The GNU indirect function ( https://sourceware.org/glibc/wiki/GNU_IFUNC )
> is the dynamic solved symbol at runtime. IFUNC function is a selector
> which is invoked from the elf loader, but the symbol address of the
> function which will be modified by the IFUNC is same as the IFUNC in
> the symbol table. This can confuse users who is trying to probe on
> such functions.
> 
> For example, the memcpy is one of IFUNC.
> 
> # perf probe -x /lib64/libc-2.30.so -a memcpy
> # perf probe -l
>   probe_libc:memcpy    (on __new_memcpy_ifunc@x86_64/multiarch/memcpy.c in /usr/lib64/libc-2.30.so)
> 
> the probe is put on a IFUNC.
> 
> # perf record -e probe_libc:memcpy --call-graph dwarf -aR ./perf
> 
> Thus, I decided to warn user when the perf probe detects the probe point
> is on the GNU IFUNC symbol. Someone who wants to probe an IFUNC symbol to
> debug the IFUNC function, they can ignore this warning.
> 
> Reported-by: Andi Kleen <andi@firstfloor.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

> ---
>   Changes in v2:
>    - Check GNU_IFUNC only for uprobe
>    - Show function name instead of the address.
>    - Update the warning message according to Andi's comment.
> ---
>  tools/perf/util/probe-event.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 8cd1224e5f4c..679447f13c20 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -375,9 +375,13 @@ static int find_alternative_probe_point(struct debuginfo *dinfo,
> 
>  	/* Find the address of given function */
>  	map__for_each_symbol_by_name(map, pp->function, sym) {
> -		if (uprobes)
> +		if (uprobes) {
>  			address = sym->start;
> -		else
> +			if (sym->type == STT_GNU_IFUNC)
> +				pr_warning("Warning: The probe function (%s) is a GNU indirect function.\n"
> +					   "Consider identifying the final function used at run time and set the probe directly on that.\n",
> +					   pp->function);
> +		} else
>  			address = map->unmap_ip(map, sym->start) - map->reloc;
>  		break;
>  	}
> 

-- 
Thanks and Regards
Srikar Dronamraju
