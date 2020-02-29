Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47969C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 09:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2326C246AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 09:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgB2I7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 03:59:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725747AbgB2I7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 03:59:09 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01T8wmnu143009
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 03:59:07 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yepwk13k6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 03:59:07 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <psampat@linux.ibm.com>;
        Sat, 29 Feb 2020 08:59:05 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 29 Feb 2020 08:59:02 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01T8w3S240763844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Feb 2020 08:58:03 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DEEDA405B;
        Sat, 29 Feb 2020 08:59:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E02F3A4054;
        Sat, 29 Feb 2020 08:58:58 +0000 (GMT)
Received: from [9.199.55.146] (unknown [9.199.55.146])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 29 Feb 2020 08:58:58 +0000 (GMT)
Subject: Re: [RFC 0/1] Weighted approach to gather and use history in TEO
 governor
To:     Doug Smythies <dsmythies@telus.net>, ego@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        peterz@infradead.org, daniel.lezcano@linaro.org,
        svaidy@linux.ibm.com, pratik.sampat@in.ibm.com,
        pratik.r.sampat@gmail.com
References: <20200222070002.12897-1-psampat@linux.ibm.com>
 <20200225051306.GG12846@in.ibm.com> <000001d5ed89$0b711340$225339c0$@net>
From:   Pratik Sampat <psampat@linux.ibm.com>
Date:   Sat, 29 Feb 2020 14:28:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <000001d5ed89$0b711340$225339c0$@net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20022908-0020-0000-0000-000003AEB286
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022908-0021-0000-0000-00002206D86E
Message-Id: <204c27ed-9993-2809-3b78-8ac8ea8c1713@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-29_02:2020-02-28,2020-02-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002290068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Doug,

Thanks for running these numbers for me.

On 27/02/20 9:44 pm, Doug Smythies wrote:
> On 2020.02.24 21:13 Gautham R Shenoy wrote:
>
> ...
>
>> Could you also provide power measurements for the duration when the
>> system is completely idle for each of the variants of TEO governor ?
>> Is it the case that the benefits that we are seeing above are only due
>> to Wt. TEO being more conservative than TEO governor by always
>> choosing a shallower state ?

For system idle I see similar power statistics for both the TEO and the wtteo.

> For what it's worth:
>
> CPU: Intel: i7-2600K
> Kernel: 5.6-rc2 (teo) and + this patch set (wtteo)
> Note: in general, "idle" on this system is considerably more "idle" than most systems.
> Sample period: 5 minutes.
> CPU scaling driver: intel_cpufreq
> Governor: performance
> Deepest idle state: 4 (C6)
>
> teo:
> Test duration 740 minutes (12.33 hours).
> Average processor package power: 3.84 watts
> Idle state 0:    4.19 / minute
> Idle state 1:   29.26 / minute
> Idle state 2:   46.71 / minute
> Idle state 3:    7.42 / minute
> Idle state 4: 1124.55 / minute
> Total: 2.525 idle entries per cpu per second
>
> wtteo:
> Test duration 1095 minutes (18.25 hours).
> Average processor package power: 3.84 watts
> Idle state 0:    7.98 / minute
> Idle state 1:   30.49 / minute
> Idle state 2:   52.51 / minute
> Idle state 3:    8.65 / minute
> Idle state 4: 1125.33 / minute
> Total: 2.552 idle entries per cpu per second
>
> The above/below data for this test is incomplete because my program
> doesn't process it if there are not enough state entries per sample period.
> (I need to fix that for this type of test.)
>
> I have done a couple of other tests with this patch set,
> but nothing to report yet, as the differences have been minor so far.
>
> ... Doug
>
>
---

Pratik

