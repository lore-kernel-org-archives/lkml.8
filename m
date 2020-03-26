Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C63C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AE82074D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgCZVcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:32:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26658 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbgCZVce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:32:34 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02QL3v7a181169;
        Thu, 26 Mar 2020 17:32:30 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywdr90yjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 17:32:30 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02QLVPni022673;
        Thu, 26 Mar 2020 21:32:29 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 2ywawn4v62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 21:32:29 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02QLWSAf52953524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 21:32:28 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 841BBBE059;
        Thu, 26 Mar 2020 21:32:28 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C85E6BE056;
        Thu, 26 Mar 2020 21:32:27 +0000 (GMT)
Received: from oc3272150783.ibm.com (unknown [9.160.84.73])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 26 Mar 2020 21:32:27 +0000 (GMT)
Subject: Re: [PATCH] perf tools: update docs regarding kernel/user space
 unwinding
To:     Tony Jones <tonyj@suse.de>, linux-perf-users@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200325164053.10177-1-tonyj@suse.de>
From:   Paul Clarke <pc@us.ibm.com>
Message-ID: <38ba2caa-dadd-52c4-c6ea-5e01b7e59ee2@us.ibm.com>
Date:   Thu, 26 Mar 2020 16:32:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200325164053.10177-1-tonyj@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-26_12:2020-03-26,2020-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 mlxlogscore=962 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/20 11:40 AM, Tony Jones wrote:
> The method of unwinding for kernel space is defined by the kernel config, 
> not by the value of --call-graph.   Improve the documentation to reflect 
> this.

> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> index 8ead55593984..88cf35fbedc5 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -405,14 +405,16 @@ ui.*::
>  		This option is only applied to TUI.
> 
>  call-graph.*::
> -	When sub-commands 'top' and 'report' work with -g/—-children
> -	there're options in control of call-graph.
> +	The following controls the handling of call-graphs (obtained via the
> +	-g/--callgraph options).
> 
>  	call-graph.record-mode::
> -		The record-mode can be 'fp' (frame pointer), 'dwarf' and 'lbr'.
> -		The value of 'dwarf' is effective only if perf detect needed library
> -		(libunwind or a recent version of libdw).
> -		'lbr' only work for cpus that support it.
> +		The mode for user space can be 'fp' (frame pointer), 'dwarf'
> +		and 'lbr'.  The value 'dwarf' is effective only if libunwind
> +		(or a recent version of libdw) is present on the system;
> +		the value 'lbr' only works for certain cpus. The method for
> +		kernel space is controlled not by this option but by the
> +		kernel config (CONFIG_UNWINDER_*).

Your changes are just copying the old text, so this isn't a criticism of your patches.

Do we have information to replace "a recent version of libdw", which will quickly get stale?

PC
