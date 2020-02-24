Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF1EC38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9A32082F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gux9dGHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgBXXIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:08:55 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55322 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbgBXXIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:08:51 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01ON2ZCb038164;
        Mon, 24 Feb 2020 23:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=brSGtrMRAEqE8jsZSHP6UZ54R1yT9YteYXUdJKcFQkA=;
 b=gux9dGHkowSbpOfN5vk9N36R+hONfco1cd1psbJ4nPTbQfr4L4Gzy6yLqfrz/AQvxHBQ
 x3V2Tm+vSwLphlO/Q/71HWaMR9AKU7JuVH+FfaPMk44DrAUuekgxh4aeMmYYXG8SuYLj
 TUgI7eR25teEcb4rOa5bWcXGbzEVbFfX6eFuESnZp9HM65t10b6egk28lwy3UeQY9R5o
 zGUNrj+0Vu1f3Qz3UfDzPc+OOkcloKcZaHGXwJC1i99Dl03mtnnbRjIpmXlPU84v+g/p
 DNe6hO2rROVNZw8Q2qX2LTVHwC5y6p+ksxgXEtLY1BJWsrI9pKH0Kh91IIzaCe0B4CUg 7A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yavxrjjc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 23:08:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01ON8MGl102472;
        Mon, 24 Feb 2020 23:08:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2ybdshufjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 23:08:22 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01ON8Gkt028649;
        Mon, 24 Feb 2020 23:08:16 GMT
Received: from [192.168.0.195] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Feb 2020 15:08:16 -0800
Subject: Re: [PATCH v4 4/4] sched/core: Add permission checks for setting the
 latency_nice value
To:     Parth Shah <parth@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        David.Laight@ACULAB.COM, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
References: <20200224085918.16955-1-parth@linux.ibm.com>
 <20200224085918.16955-5-parth@linux.ibm.com>
From:   chris hyser <chris.hyser@oracle.com>
Message-ID: <6fb7926e-c8bb-e4a0-c527-feb38c948716@oracle.com>
Date:   Mon, 24 Feb 2020 18:08:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200224085918.16955-5-parth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 suspectscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/20 3:59 AM, Parth Shah wrote:
> Since the latency_nice uses the similar infrastructure as NICE, use the
> already existing CAP_SYS_NICE security checks for the latency_nice. This
> should return -EPERM for the non-root user when trying to set the task
> latency_nice value to any lower than the current value.
> 
> Signed-off-by: Parth Shah <parth@linux.ibm.com>

Reviewed-by: Chris Hyser <chris.hyser@oracle.com>

> ---
>   kernel/sched/core.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e1dc536d4ca3..f883e1d3cd10 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4887,6 +4887,10 @@ static int __sched_setscheduler(struct task_struct *p,
>   			return -EINVAL;
>   		if (attr->sched_latency_nice < MIN_LATENCY_NICE)
>   			return -EINVAL;
> +		/* Use the same security checks as NICE */
> +		if (attr->sched_latency_nice < p->latency_nice &&
> +		    !can_nice(p, attr->sched_latency_nice))
> +			return -EPERM;
>   	}
>   
>   	if (pi)
> 
