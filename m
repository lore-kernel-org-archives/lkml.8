Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10365C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8F2F20774
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgD3LY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:24:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726413AbgD3LY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:24:58 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UB3S6Z178050;
        Thu, 30 Apr 2020 07:24:50 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30q80qsngs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 07:24:50 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03UB44Gc184266;
        Thu, 30 Apr 2020 07:24:49 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30q80qsngg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 07:24:49 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03UBO0bs029241;
        Thu, 30 Apr 2020 11:24:48 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 30mcu805gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 11:24:48 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03UBOlis20316518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 11:24:47 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 876FD13605D;
        Thu, 30 Apr 2020 11:24:47 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 824BB136053;
        Thu, 30 Apr 2020 11:24:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.85.241])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 30 Apr 2020 11:24:43 +0000 (GMT)
Subject: Re: [PATCHv2 0/3] perf tools: Add support for user defined metric
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>
References: <20200421181337.988681-1-jolsa@kernel.org>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <8df4b32b-4abc-7ea9-feaf-a16be6edf64f@linux.ibm.com>
Date:   Thu, 30 Apr 2020 16:54:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200421181337.988681-1-jolsa@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_05:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/20 11:43 PM, Jiri Olsa wrote:
> hi,
> Joe asked for possibility to add user defined metrics. Given that
> we already have metrics support, I added --metrics-file option that
> allows to specify custom metrics.
> 
>   $ cat metrics
>   # IPC
>   mine1 = instructions / cycles;
>   /* DECODED_ICACHE_UOPS% */
>   mine2 = 100 * (idq.dsb_uops / \ (idq.ms_uops + idq.mite_uops + idq.dsb_uops + lsd.uops));
> 
>   $ sudo perf stat --metrics-file ./metrics -M mine1,mine2 --metric-only -a -I 1000
>   #           time       insn per cycle                mine1                mine2
>        1.000536263                0.71                   0.7                 41.4
>        2.002069025                0.31                   0.3                 14.1
>        3.003427684                0.27                   0.3                 14.8
>        4.004807132                0.25                   0.2                 12.1
>   ...
> 
> v2 changes:
>   - add new --metrics-file option
>   - rebased on current perf/core expression bison/flex enhancements
> 
> Also available in:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/metric
> 
> thanks,
> jirka
> 
> 
> ---
> Jiri Olsa (3):
>       perf expr: Add parsing support for multiple expressions
>       perf expr: Allow comments in custom metric file
>       perf stat: Add --metrics-file option

Hi Jiri,
     I try to look into these patches. As far as I understand we are using
syntax "Name: Expression" for user defined events. It will be great if we mention
this format somewhere for users.

Otherwise it works fine for me. Try by testing it for different metric expressions.
But still curious about reason for adding this support. Isn't json file is there for same purpose?

Thanks,
Kajol Jain
> 
>  tools/perf/Documentation/perf-stat.txt |  3 +++
>  tools/perf/builtin-stat.c              |  7 +++++--
>  tools/perf/tests/expr.c                | 13 +++++++++++++
>  tools/perf/util/expr.c                 |  6 ++++++
>  tools/perf/util/expr.h                 | 19 +++++++++++++++++--
>  tools/perf/util/expr.l                 | 24 ++++++++++++++++++++++++
>  tools/perf/util/expr.y                 | 13 ++++++++++++-
>  tools/perf/util/metricgroup.c          | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
>  tools/perf/util/metricgroup.h          |  3 ++-
>  tools/perf/util/stat.h                 |  1 +
>  10 files changed, 142 insertions(+), 13 deletions(-)
> 
