Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92857C35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6646B20714
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgBYKWp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:22:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729952AbgBYKWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:22:45 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PAMW9N069354
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 05:22:43 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yb1qdkp88-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 05:22:36 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Tue, 25 Feb 2020 10:20:35 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Feb 2020 10:20:32 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01PAKVIW52625566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 10:20:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1812052052;
        Tue, 25 Feb 2020 10:20:31 +0000 (GMT)
Received: from localhost (unknown [9.199.61.128])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7018052051;
        Tue, 25 Feb 2020 10:20:30 +0000 (GMT)
Date:   Tue, 25 Feb 2020 15:50:28 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 4/5] powerpc/sysfs: Show idle_purr and idle_spurr for
 every CPU
To:     ego@linux.vnet.ibm.com, Nathan Lynch <nathanl@linux.ibm.com>
Cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
References: <1582262314-8319-1-git-send-email-ego@linux.vnet.ibm.com>
        <1582262314-8319-5-git-send-email-ego@linux.vnet.ibm.com>
        <87eeunubp7.fsf@linux.ibm.com> <20200224051447.GC12846@in.ibm.com>
In-Reply-To: <20200224051447.GC12846@in.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 20022510-4275-0000-0000-000003A5436E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022510-4276-0000-0000-000038B958DB
Message-Id: <1582625516.nbsanohdks.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_02:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gautham R Shenoy wrote:
> On Fri, Feb 21, 2020 at 10:50:12AM -0600, Nathan Lynch wrote:
>> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
>> > diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
>> > index 80a676d..5b4b450 100644
>> > --- a/arch/powerpc/kernel/sysfs.c
>> > +++ b/arch/powerpc/kernel/sysfs.c
>> > @@ -19,6 +19,7 @@
>> >  #include <asm/smp.h>
>> >  #include <asm/pmc.h>
>> >  #include <asm/firmware.h>
>> > +#include <asm/idle.h>
>> >  #include <asm/svm.h>
>> >  
>> >  #include "cacheinfo.h"
>> > @@ -733,6 +734,42 @@ static void create_svm_file(void)
>> >  }
>> >  #endif /* CONFIG_PPC_SVM */
>> >  
>> > +static void read_idle_purr(void *val)
>> > +{
>> > +	u64 *ret = (u64 *)val;
>> 
>> No cast from void* needed.
> 
> Will fix this. Thanks.
> 
>> 
>> 
>> > +
>> > +	*ret = read_this_idle_purr();
>> > +}
>> > +
>> > +static ssize_t idle_purr_show(struct device *dev,
>> > +			      struct device_attribute *attr, char *buf)
>> > +{
>> > +	struct cpu *cpu = container_of(dev, struct cpu, dev);
>> > +	u64 val;
>> > +
>> > +	smp_call_function_single(cpu->dev.id, read_idle_purr, &val, 1);
>> > +	return sprintf(buf, "%llx\n", val);
>> > +}
>> > +static DEVICE_ATTR(idle_purr, 0400, idle_purr_show, NULL);
>> > +
>> > +static void read_idle_spurr(void *val)
>> > +{
>> > +	u64 *ret = (u64 *)val;
>> > +
>> > +	*ret = read_this_idle_spurr();
>> > +}
>> > +
>> > +static ssize_t idle_spurr_show(struct device *dev,
>> > +			       struct device_attribute *attr, char *buf)
>> > +{
>> > +	struct cpu *cpu = container_of(dev, struct cpu, dev);
>> > +	u64 val;
>> > +
>> > +	smp_call_function_single(cpu->dev.id, read_idle_spurr, &val, 1);
>> > +	return sprintf(buf, "%llx\n", val);
>> > +}
>> > +static DEVICE_ATTR(idle_spurr, 0400, idle_spurr_show, NULL);
>> 
>> It's regrettable that we have to wake up potentially idle CPUs in order
>> to derive correct idle statistics for them, but I suppose the main user
>> (lparstat) of these interfaces already is causing this to happen by
>> polling the existing per-cpu purr and spurr attributes.
>> 
>> So now lparstat will incur at minimum four syscalls and four IPIs per
>> CPU per polling interval -- one for each of purr, spurr, idle_purr and
>> idle_spurr. Correct?
> 
> Yes, it is unforunate that we will end up making four syscalls and
> generating IPI noise, and this is something that I discussed with
> Naveen and Kamalesh. We have the following two constraints:
> 
> 1) These values of PURR and SPURR required are per-cpu. Hence putting
> them in lparcfg is not an option.
> 
> 2) sysfs semantics encourages a single value per key, the key being
> the sysfs-file. Something like the following would have made far more
> sense.
> 
> cat /sys/devices/system/cpu/cpuX/purr_spurr_accounting
> purr:A
> idle_purr:B
> spurr:C
> idle_spurr:D
> 
> There are some sysfs files which allow something like this. Eg: 
> /sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state
> 
> Thoughts on any other alternatives?

Umm... procfs?
/me ducks

> 
> 
>> 
>> At some point it's going to make sense to batch sampling of remote CPUs'
>> SPRs.

How did you mean this? It looks like we first need to provide a separate 
user interface, since with the existing sysfs interface providing 
separate files, I am not sure if we can batch such reads.


- Naveen

