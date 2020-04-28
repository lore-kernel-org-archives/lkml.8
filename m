Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616F7C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 464EC206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgD1Gfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 02:35:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbgD1Gfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:35:39 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03S6W4Lp104832;
        Tue, 28 Apr 2020 02:35:23 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mggu1gp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 02:35:23 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03S6W9rV105188;
        Tue, 28 Apr 2020 02:35:22 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mggu1gnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 02:35:22 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03S6ZGSl005355;
        Tue, 28 Apr 2020 06:35:21 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 30mcu782ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 06:35:21 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03S6ZKTi28770688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 06:35:21 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA355AE063;
        Tue, 28 Apr 2020 06:35:20 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 912A1AE060;
        Tue, 28 Apr 2020 06:35:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.55.78])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 28 Apr 2020 06:35:14 +0000 (GMT)
Subject: Re: [PATCH v2 06/11] perf expr: parse numbers as doubles
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20200422220430.254014-1-irogers@google.com>
 <20200422220430.254014-7-irogers@google.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <503a44a7-85a8-012e-1559-bfd735b61ec0@linux.ibm.com>
Date:   Tue, 28 Apr 2020 12:05:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200422220430.254014-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_02:2020-04-27,2020-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/23/20 3:34 AM, Ian Rogers wrote:
> This is expected in expr.y and metrics use floating point values such as
> x86 broadwell IFetch_Line_Utilization.
> 
> Fixes: 26226a97724d (perf expr: Move expr lexer to flex)
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/expr.l | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index 95bcf3629edf..0efda2ce2766 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -10,12 +10,12 @@
>  char *expr_get_text(yyscan_t yyscanner);
>  YYSTYPE *expr_get_lval(yyscan_t yyscanner);
>  
> -static int __value(YYSTYPE *yylval, char *str, int base, int token)
> +static double __value(YYSTYPE *yylval, char *str, int token)
>  {
> -	u64 num;
> +	double num;
>  
>  	errno = 0;
> -	num = strtoull(str, NULL, base);
> +	num = strtod(str, NULL);
>  	if (errno)
>  		return EXPR_ERROR;
>  
> @@ -23,12 +23,12 @@ static int __value(YYSTYPE *yylval, char *str, int base, int token)
>  	return token;
>  }
>  
> -static int value(yyscan_t scanner, int base)
> +static int value(yyscan_t scanner)
>  {
>  	YYSTYPE *yylval = expr_get_lval(scanner);
>  	char *text = expr_get_text(scanner);
>  
> -	return __value(yylval, text, base, NUMBER);
> +	return __value(yylval, text, NUMBER);
>  }
>  
>  /*
> @@ -68,7 +68,7 @@ static int str(yyscan_t scanner, int token)
>  }
>  %}
>  
> -number		[0-9]+
> +number		[0-9]*\.?[0-9]+
>  
Acked By: Kajol Jain <kjain@linux.ibm.com>

Thanks,
Kajol Jain

>  sch		[-,=]
>  spec		\\{sch}
> @@ -92,7 +92,7 @@ min		{ return MIN; }
>  if		{ return IF; }
>  else		{ return ELSE; }
>  #smt_on		{ return SMT_ON; }
> -{number}	{ return value(yyscanner, 10); }
> +{number}	{ return value(yyscanner); }
>  {symbol}	{ return str(yyscanner, ID); }
>  "|"		{ return '|'; }
>  "^"		{ return '^'; }
> 
