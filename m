Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678CEC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395B824691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G21bDkcD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgB0OsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:48:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43278 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgB0OsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:48:05 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01REhYxi159994;
        Thu, 27 Feb 2020 14:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=/ZgEk1vSDex02903ZCNH3Bx69liVtQfuXUyTUho4JEk=;
 b=G21bDkcDCDnlevFJQZsO3xO4tKbePX4hRJf0fG7QQPre04ssgGM20v0J5l/DnsPaoLyF
 CiHBIGEQcNXwogWPH7TrcY+0Nd5z1uSfAIllXAWiivo+eqEH4pwwsznaSOaubP+6RHZ7
 pLA8SSMpr1ggU5n2h6vnGSksYl8B+tSVYc5j0iRbi++XB3RXNANjIRP2NC3/NOTHDPUz
 QkVEe4+Yb0uHFYY6qVQhtNGiH+WIf5PsKENBNCP6sWrBm7BlcxbveBVAdA5mefUIXBxM
 FIiEqiy1Fvbm4QWEXVAUKufKdz3ex1N7VIoqL+6q3o+OQuPTuwaX0r0dQrHbjAZsWMoq QQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ydcsnkd6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 14:46:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01REiVe5006071;
        Thu, 27 Feb 2020 14:46:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ydcs5cf81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 14:46:38 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01REkYMN006162;
        Thu, 27 Feb 2020 14:46:34 GMT
Received: from [192.168.0.195] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Feb 2020 06:46:34 -0800
Subject: Re: [PATCH v4 4/4] sched/core: Add permission checks for setting the
 latency_nice value
To:     Qais Yousef <qais.yousef@arm.com>, Parth Shah <parth@linux.ibm.com>
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, David.Laight@ACULAB.COM,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com
References: <20200224085918.16955-1-parth@linux.ibm.com>
 <20200224085918.16955-5-parth@linux.ibm.com>
 <20200224132905.32sdpbydnzypib47@e107158-lin.cambridge.arm.com>
 <9a4132f2-62cc-4132-1c6d-964ed679afc7@linux.ibm.com>
 <20200227114401.uz5p2e7mcomzoo5k@e107158-lin.cambridge.arm.com>
From:   chris hyser <chris.hyser@oracle.com>
Message-ID: <23524cda-f2fb-b2cd-1dcb-93672022c684@oracle.com>
Date:   Thu, 27 Feb 2020 09:46:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200227114401.uz5p2e7mcomzoo5k@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=906 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=962 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 6:44 AM, Qais Yousef wrote:
> On 02/25/20 12:17, Parth Shah wrote:
>>
>>
>> On 2/24/20 6:59 PM, Qais Yousef wrote:
>>> On 02/24/20 14:29, Parth Shah wrote:
>>>> Since the latency_nice uses the similar infrastructure as NICE, use the
>>>> already existing CAP_SYS_NICE security checks for the latency_nice. This
>>>> should return -EPERM for the non-root user when trying to set the task
>>>> latency_nice value to any lower than the current value.
>>>>
>>>> Signed-off-by: Parth Shah <parth@linux.ibm.com>
>>>
>>> I'm not against this, so I'm okay if it goes in as is.
>>>
>>> But IMO the definition of this flag is system dependent and I think it's
>>> prudent to keep it an admin only configuration.
>>>
>>> It'd be hard to predict how normal application could use and depend on this
>>> feature in the future, which could tie our hand in terms of extending it.
>>>
>>
>> I am fine with this going in too. But just to lie down the fact on single
>> page and starting the discussion, here are the pros and cons for including
>> this permission checks:
>>
>> Pros:
>> =====
>> - Having this permission checks will allow only root users to promote the
>> task, meaning lowering the latency_nice of the task. This is required in
>> case when the admin has increased the latency_nice value of a task and
>> non-root user can not lower it.
>> - In absence of this check, the non-root user can decrease the latency_nice
>> value against the admin configured value.
>>
>> Cons:
>> =====
>> - This permission check prevents the non-root user to lower the value. This
>> is a problem when the user itself has increased the latency_nice value in
>> the past but fails to lower it again.
>> - After task fork, non-root user cannot lower the inherited child task's
>> latency_nice value, which might be a problem in the future for extending
>> this latency_nice ideas for different optimizations.
> 
> Worth adding that if we start strict with root (or capable user) only, relaxing
> this to allow lowering the nice would still be possible in the future. But the
> opposite is not true, we can't reverse the users ability to lower its
> latency_nice value once we give it away.
> 
> Beside thinking a bit more about it now. If high latency_nice value means
> cutting short the idle search for instance, does this prevent someone using
> a lower latency nice to be aggressive in some code path to get higher
> throughput?

Short-cutting an idle cpu search reduces latency. There would be a mapping between the latency_nice values -20..-1 and 
the short cut. In that view 0 is the default and performs the full domain search as before and -20 presumably skips the 
entire search. Positive values then presumably indicate a trade-off in preference of throughput. I've not thought any 
about it till now, but maybe indicates that spending extra time (versus less) finding this task the perfect home to just 
sit and crank on throughput would be worth it.

-chrish
