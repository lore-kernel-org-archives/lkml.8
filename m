Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C81DC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC951206F8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbgDAOKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:10:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732856AbgDAOKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:10:24 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031E4Skn118632
        for <linux-kernel@vger.kernel.org>; Wed, 1 Apr 2020 10:10:22 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 304gsscjag-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 10:10:22 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Wed, 1 Apr 2020 15:10:13 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Apr 2020 15:10:09 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 031EAGio47972532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Apr 2020 14:10:16 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 489A952054;
        Wed,  1 Apr 2020 14:10:16 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.206.166.90])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C53A55204E;
        Wed,  1 Apr 2020 14:10:12 +0000 (GMT)
Subject: Re: [PATCH 06/16] perf s390-cpumsf: Implement ->evsel_is_auxtrace()
 callback
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20200401101613.6201-1-adrian.hunter@intel.com>
 <20200401101613.6201-7-adrian.hunter@intel.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Wed, 1 Apr 2020 16:10:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200401101613.6201-7-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040114-0012-0000-0000-0000039C5459
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040114-0013-0000-0000-000021D964A2
Message-Id: <32801161-9e7a-84f9-7d8d-40c17e0b2572@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_01:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 suspectscore=2 priorityscore=1501 lowpriorityscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/20 12:16 PM, Adrian Hunter wrote:
> Implement ->evsel_is_auxtrace() callback.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/util/s390-cpumcf-kernel.h | 1 +
>  tools/perf/util/s390-cpumsf.c        | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/tools/perf/util/s390-cpumcf-kernel.h b/tools/perf/util/s390-cpumcf-kernel.h
> index d4356030b504..f55ca07f3ca1 100644
> --- a/tools/perf/util/s390-cpumcf-kernel.h
> +++ b/tools/perf/util/s390-cpumcf-kernel.h
> @@ -11,6 +11,7 @@
>  
>  #define	S390_CPUMCF_DIAG_DEF	0xfeef	/* Counter diagnostic entry ID */
>  #define	PERF_EVENT_CPUM_CF_DIAG	0xBC000	/* Event: Counter sets */
> +#define PERF_EVENT_CPUM_SF_DIAG	0xBD000 /* Event: Combined-sampling */
>  
>  struct cf_ctrset_entry {	/* CPU-M CF counter set entry (8 byte) */
>  	unsigned int def:16;	/* 0-15  Data Entry Format */
> diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
> index 6785cd87aa4d..d7779e48652f 100644
> --- a/tools/perf/util/s390-cpumsf.c
> +++ b/tools/perf/util/s390-cpumsf.c
> @@ -1047,6 +1047,14 @@ static void s390_cpumsf_free(struct perf_session *session)
>  	free(sf);
>  }
>  
> +static bool
> +s390_cpumsf_evsel_is_auxtrace(struct perf_session *session __maybe_unused,
> +			      struct evsel *evsel)
> +{
> +	return evsel->core.attr.type == PERF_TYPE_RAW &&
> +	       evsel->core.attr.config == PERF_EVENT_CPUM_SF_DIAG;
> +}
> +
>  static int s390_cpumsf_get_type(const char *cpuid)
>  {
>  	int ret, family = 0;
> @@ -1142,6 +1150,7 @@ int s390_cpumsf_process_auxtrace_info(union perf_event *event,
>  	sf->auxtrace.flush_events = s390_cpumsf_flush;
>  	sf->auxtrace.free_events = s390_cpumsf_free_events;
>  	sf->auxtrace.free = s390_cpumsf_free;
> +	sf->auxtrace.evsel_is_auxtrace = s390_cpumsf_evsel_is_auxtrace;
>  	session->auxtrace = &sf->auxtrace;
>  
>  	if (dump_trace)
> 

Acked-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

