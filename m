Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00301C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D5220873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgBMNVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:21:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729557AbgBMNVr (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:21:47 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DDJK26027838
        for <Linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 08:21:45 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y4wuttynp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <Linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 08:21:45 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <Linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 13 Feb 2020 13:21:43 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Feb 2020 13:21:38 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01DDLbK433816730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 13:21:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC74B52051;
        Thu, 13 Feb 2020 13:21:37 +0000 (GMT)
Received: from [9.199.61.192] (unknown [9.199.61.192])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C148D52050;
        Thu, 13 Feb 2020 13:21:01 +0000 (GMT)
Subject: Re: [PATCH v3] perf stat: Show percore counts in per CPU output
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200213071555.17239-1-yao.jin@linux.intel.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Thu, 13 Feb 2020 18:50:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213071555.17239-1-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20021313-0012-0000-0000-000003867CCB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021313-0013-0000-0000-000021C30025
Message-Id: <54bea6fe-26a1-a08c-7a61-ac5f5d43ad8c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_04:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jin,

On 2/13/20 12:45 PM, Jin Yao wrote:
> With this patch, for example,
> 
>   # perf stat -e cpu/event=cpu-cycles,percore/ -a -A --percore-show-thread  -- sleep 1
> 
>    Performance counter stats for 'system wide':
> 
>   CPU0               2,453,061      cpu/event=cpu-cycles,percore/
>   CPU1               1,823,921      cpu/event=cpu-cycles,percore/
>   CPU2               1,383,166      cpu/event=cpu-cycles,percore/
>   CPU3               1,102,652      cpu/event=cpu-cycles,percore/
>   CPU4               2,453,061      cpu/event=cpu-cycles,percore/
>   CPU5               1,823,921      cpu/event=cpu-cycles,percore/
>   CPU6               1,383,166      cpu/event=cpu-cycles,percore/
>   CPU7               1,102,652      cpu/event=cpu-cycles,percore/
> 
> We can see counts are duplicated in CPU pairs
> (CPU0/CPU4, CPU1/CPU5, CPU2/CPU6, CPU3/CPU7).
> 

I was trying this patch and I am getting bit weird results when any cpu
is offline. Ex,

   $ lscpu | grep list
   On-line CPU(s) list:             0-4,6,7
   Off-line CPU(s) list:            5

   $ sudo ./perf stat -e cpu/event=cpu-cycles,percore/ -a -A --percore-show-thread -vv -- sleep 1
     ...
   cpu/event=cpu-cycles,percore/: 0: 23746491 1001189836 1001189836
   cpu/event=cpu-cycles,percore/: 1: 19802666 1001291299 1001291299
   cpu/event=cpu-cycles,percore/: 2: 24211983 1001394318 1001394318
   cpu/event=cpu-cycles,percore/: 3: 54051396 1001516816 1001516816
   cpu/event=cpu-cycles,percore/: 4: 6378825 1001064048 1001064048
   cpu/event=cpu-cycles,percore/: 5: 21299840 1001166297 1001166297
   cpu/event=cpu-cycles,percore/: 6: 13075410 1001274535 1001274535
   
    Performance counter stats for 'system wide':
   
   CPU0              30,125,316      cpu/event=cpu-cycles,percore/
   CPU1              19,802,666      cpu/event=cpu-cycles,percore/
   CPU2              45,511,823      cpu/event=cpu-cycles,percore/
   CPU3              67,126,806      cpu/event=cpu-cycles,percore/
   CPU4              30,125,316      cpu/event=cpu-cycles,percore/
   CPU7              67,126,806      cpu/event=cpu-cycles,percore/
   CPU0              30,125,316      cpu/event=cpu-cycles,percore/
   
          1.001918764 seconds time elapsed

I see proper result without --percore-show-thread:

   $ sudo ./perf stat -e cpu/event=cpu-cycles,percore/ -a -A -vv -- sleep 1
     ...
   cpu/event=cpu-cycles,percore/: 0: 11676414 1001190709 1001190709
   cpu/event=cpu-cycles,percore/: 1: 39119617 1001291459 1001291459
   cpu/event=cpu-cycles,percore/: 2: 41821512 1001391158 1001391158
   cpu/event=cpu-cycles,percore/: 3: 46853730 1001492799 1001492799
   cpu/event=cpu-cycles,percore/: 4: 14448274 1001095948 1001095948
   cpu/event=cpu-cycles,percore/: 5: 42238217 1001191187 1001191187
   cpu/event=cpu-cycles,percore/: 6: 33129641 1001292072 1001292072
   
    Performance counter stats for 'system wide':
   
   S0-D0-C0             26,124,688      cpu/event=cpu-cycles,percore/
   S0-D0-C1             39,119,617      cpu/event=cpu-cycles,percore/
   S0-D0-C2             84,059,729      cpu/event=cpu-cycles,percore/
   S0-D0-C3             79,983,371      cpu/event=cpu-cycles,percore/
   
          1.001961563 seconds time elapsed

[...]

> +--percore-show-thread::
> +The event modifier "percore" has supported to sum up the event counts
> +for all hardware threads in a core and show the counts per core.
> +
> +This option with event modifier "percore" enabled also sums up the event
> +counts for all hardware threads in a core but show the sum counts per
> +hardware thread. This is essentially a replacement for the any bit and
> +convenient for posting process.

s/posting process/post processing/ ? :)

Ravi

