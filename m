Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EDEC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7747920672
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgGQDmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:42:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726489AbgGQDmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:42:14 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06H32aFb179986
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 23:42:13 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32792xuxdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 23:42:12 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06H3fYBK097092
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 23:42:09 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32792xuxcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 23:42:09 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06H3ZuuU017148;
        Fri, 17 Jul 2020 03:42:04 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 327527xdsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 03:42:04 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06H3elc859375746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jul 2020 03:40:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C547A4053;
        Fri, 17 Jul 2020 03:40:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57AA6A404D;
        Fri, 17 Jul 2020 03:40:46 +0000 (GMT)
Received: from [9.199.41.4] (unknown [9.199.41.4])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Jul 2020 03:40:46 +0000 (GMT)
Subject: Re: [PATCH 1/2] libsubcmd: Fix OPT_CALLBACK_SET()
To:     acme@redhat.com
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200619133412.50705-1-ravi.bangoria@linux.ibm.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Message-ID: <3b15af42-bfb2-07dd-8bb2-df9cd6b32a34@linux.ibm.com>
Date:   Fri, 17 Jul 2020 09:10:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200619133412.50705-1-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_11:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

Can you please consider this trivial fix.

Ravi

On 6/19/20 7:04 PM, Ravi Bangoria wrote:
> Any option macro with _SET suffix should set opt->set variable which
> is not happening for OPT_CALLBACK_SET(). This is causing issues with
> perf record --switch-output-event. Fix that.
> 
> Before:
>    # ./perf record --overwrite -e sched:*switch,syscalls:sys_enter_mmap \
>             --switch-output-event syscalls:sys_enter_mmap
>    ^C[ perf record: Woken up 1 times to write data ]
>    [ perf record: Captured and wrote 0.297 MB perf.data (657 samples) ]
> 
> After:
> 
>    $ ./perf record --overwrite -e sched:*switch,syscalls:sys_enter_mmap \
>            --switch-output-event syscalls:sys_enter_mmap
>    [ perf record: dump data: Woken up 1 times ]
>    [ perf record: Dump perf.data.2020061918144542 ]
>    [ perf record: dump data: Woken up 1 times ]
>    [ perf record: Dump perf.data.2020061918144608 ]
>    [ perf record: dump data: Woken up 1 times ]
>    [ perf record: Dump perf.data.2020061918144660 ]
>    ^C[ perf record: dump data: Woken up 1 times ]
>    [ perf record: Dump perf.data.2020061918144784 ]
>    [ perf record: Woken up 0 times to write data ]
>    [ perf record: Dump perf.data.2020061918144803 ]
>    [ perf record: Captured and wrote 0.419 MB perf.data.<timestamp> ]
> 
> Fixes: 636eb4d001b1 ("libsubcmd: Introduce OPT_CALLBACK_SET()")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>   tools/lib/subcmd/parse-options.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
> index dbb9efbf718a..39ebf6192016 100644
> --- a/tools/lib/subcmd/parse-options.c
> +++ b/tools/lib/subcmd/parse-options.c
> @@ -237,6 +237,9 @@ static int get_value(struct parse_opt_ctx_t *p,
>   		return err;
>   
>   	case OPTION_CALLBACK:
> +		if (opt->set)
> +			*(bool *)opt->set = true;
> +
>   		if (unset)
>   			return (*opt->callback)(opt, NULL, 1) ? (-1) : 0;
>   		if (opt->flags & PARSE_OPT_NOARG)
> 
