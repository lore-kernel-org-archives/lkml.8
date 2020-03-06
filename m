Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF0AC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5012072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCFRje convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:39:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725922AbgCFRje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:39:34 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026HdTQm001441
        for <linux-kernel@vger.kernel.org>; Fri, 6 Mar 2020 12:39:33 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yjx06gevh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 12:39:31 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Fri, 6 Mar 2020 17:35:35 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Mar 2020 17:35:32 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 026HZUWi30802058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Mar 2020 17:35:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BA48AE04D;
        Fri,  6 Mar 2020 17:35:30 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B650AE045;
        Fri,  6 Mar 2020 17:35:30 +0000 (GMT)
Received: from localhost (unknown [9.199.51.218])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Mar 2020 17:35:30 +0000 (GMT)
Date:   Fri, 06 Mar 2020 23:05:28 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 4/5] powerpc/sysfs: Show idle_purr and idle_spurr for
 every CPU
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     ego@linux.vnet.ibm.com,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
References: <1582262314-8319-1-git-send-email-ego@linux.vnet.ibm.com>
        <1582262314-8319-5-git-send-email-ego@linux.vnet.ibm.com>
        <87eeunubp7.fsf@linux.ibm.com> <20200224051447.GC12846@in.ibm.com>
        <1582625516.nbsanohdks.naveen@linux.ibm.com> <87wo7xju0k.fsf@linux.ibm.com>
In-Reply-To: <87wo7xju0k.fsf@linux.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 20030617-4275-0000-0000-000003A90C04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030617-4276-0000-0000-000038BE1F55
Message-Id: <1583515770.c7z1yvxj3h.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_06:2020-03-06,2020-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>> Gautham R Shenoy wrote:
>>> On Fri, Feb 21, 2020 at 10:50:12AM -0600, Nathan Lynch wrote:
>>>> It's regrettable that we have to wake up potentially idle CPUs in order
>>>> to derive correct idle statistics for them, but I suppose the main user
>>>> (lparstat) of these interfaces already is causing this to happen by
>>>> polling the existing per-cpu purr and spurr attributes.
>>>> 
>>>> So now lparstat will incur at minimum four syscalls and four IPIs per
>>>> CPU per polling interval -- one for each of purr, spurr, idle_purr and
>>>> idle_spurr. Correct?
>>> 
>>> Yes, it is unforunate that we will end up making four syscalls and
>>> generating IPI noise, and this is something that I discussed with
>>> Naveen and Kamalesh. We have the following two constraints:
>>> 
>>> 1) These values of PURR and SPURR required are per-cpu. Hence putting
>>> them in lparcfg is not an option.
>>> 
>>> 2) sysfs semantics encourages a single value per key, the key being
>>> the sysfs-file. Something like the following would have made far more
>>> sense.
>>> 
>>> cat /sys/devices/system/cpu/cpuX/purr_spurr_accounting
>>> purr:A
>>> idle_purr:B
>>> spurr:C
>>> idle_spurr:D
>>> 
>>> There are some sysfs files which allow something like this. Eg: 
>>> /sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state
>>> 
>>> Thoughts on any other alternatives?
>>
>> Umm... procfs?
>> /me ducks
> 
> I had wondered about perf events but I'm not sure that's any more suitable.

Yes, we considered that, but it looks like the event reads are not 
"batched" in any manner. So, the IPI overhead will be similar.

> 
>>>> At some point it's going to make sense to batch sampling of remote CPUs'
>>>> SPRs.
>>
>> How did you mean this? It looks like we first need to provide a separate 
>> user interface, since with the existing sysfs interface providing 
>> separate files, I am not sure if we can batch such reads.
> 
> I mean in order to minimize IPI traffic something like: sample/calculate
> all of a CPU's purr, idle_purr, spurr, idle_spurr in a single IPI upon a
> read of any of the attributes, and cache the result for some time, so
> that the anticipated subsequent reads of the other attributes use the
> cached results instead of generating more IPIs.
> 
> That would keep the current sysfs interface at the cost of imposing a
> certain coarseness in the results.

Thanks for clarifying, that makes sense. Though we need to be careful in 
ensuring the sysfs semantics work as expected.

> 
> Anyway, that's a mitigation that could be considered if the
> implementation in this patch is found to be too expensive in practice.

That's a good point. We can optimize later if this turns out to be a 
problem in practice, if we end up using this approach.


- Naveen

