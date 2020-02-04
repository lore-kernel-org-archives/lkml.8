Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1DCC3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5947721582
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgBDHw3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 02:52:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbgBDHw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 02:52:29 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0147pmEm130460
        for <linux-kernel@vger.kernel.org>; Tue, 4 Feb 2020 02:52:28 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xxy9hrxku-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 02:52:28 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Tue, 4 Feb 2020 07:52:26 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Feb 2020 07:52:23 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0147qLFh40960210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Feb 2020 07:52:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E5C242049;
        Tue,  4 Feb 2020 07:52:21 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D45842041;
        Tue,  4 Feb 2020 07:52:21 +0000 (GMT)
Received: from localhost (unknown [9.199.60.222])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Feb 2020 07:52:20 +0000 (GMT)
Date:   Tue, 04 Feb 2020 13:22:19 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] powerpc/sysfs: Show idle_purr and idle_spurr for
 every CPU
To:     ego@linux.vnet.ibm.com
Cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
References: <1574856072-30972-1-git-send-email-ego@linux.vnet.ibm.com>
        <1574856072-30972-3-git-send-email-ego@linux.vnet.ibm.com>
        <1575564547.si4rk0s96p.naveen@linux.ibm.com>
        <20200203045013.GC13468@in.ibm.com>
In-Reply-To: <20200203045013.GC13468@in.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 20020407-0008-0000-0000-0000034F8587
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020407-0009-0000-0000-00004A70116E
Message-Id: <1580802180.jpxk9s8apz.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_01:2020-02-04,2020-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxscore=0 suspectscore=1 phishscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=898 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002040057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gautham R Shenoy wrote:
> Hi Naveen,
> 
> On Thu, Dec 05, 2019 at 10:23:58PM +0530, Naveen N. Rao wrote:
>> >diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
>> >index 80a676d..42ade55 100644
>> >--- a/arch/powerpc/kernel/sysfs.c
>> >+++ b/arch/powerpc/kernel/sysfs.c
>> >@@ -1044,6 +1044,36 @@ static ssize_t show_physical_id(struct device *dev,
>> > }
>> > static DEVICE_ATTR(physical_id, 0444, show_physical_id, NULL);
>> >
>> >+static ssize_t idle_purr_show(struct device *dev,
>> >+			      struct device_attribute *attr, char *buf)
>> >+{
>> >+	struct cpu *cpu = container_of(dev, struct cpu, dev);
>> >+	unsigned int cpuid = cpu->dev.id;
>> >+	struct lppaca *cpu_lppaca_ptr = paca_ptrs[cpuid]->lppaca_ptr;
>> >+	u64 idle_purr_cycles = be64_to_cpu(cpu_lppaca_ptr->wait_state_cycles);
>> >+
>> >+	return sprintf(buf, "%llx\n", idle_purr_cycles);
>> >+}
>> >+static DEVICE_ATTR_RO(idle_purr);
>> >+
>> >+DECLARE_PER_CPU(u64, idle_spurr_cycles);
>> >+static ssize_t idle_spurr_show(struct device *dev,
>> >+			       struct device_attribute *attr, char *buf)
>> >+{
>> >+	struct cpu *cpu = container_of(dev, struct cpu, dev);
>> >+	unsigned int cpuid = cpu->dev.id;
>> >+	u64 *idle_spurr_cycles_ptr = per_cpu_ptr(&idle_spurr_cycles, cpuid);
>> 
>> Is it possible for a user to read stale values if a particular cpu is in an
>> extended cede? Is it possible to use smp_call_function_single() to force the
>> cpu out of idle?
> 
> Yes, if the CPU whose idle_spurr cycle is being read is still in idle,
> then we will miss reporting the delta spurr cycles for this last
> idle-duration. Yes, we can use an smp_call_function_single(), though
> that will introduce IPI noise. How often will idle_[s]purr be read ?

Since it is possible for a cpu to go into extended cede for multiple 
seconds during which time it is possible to mis-report utilization, I 
think it is better to ensure that the sysfs interface for idle_[s]purr 
report the proper values through use of IPI.

With repect to lparstat, the read interval is user-specified and just 
gets passed onto sleep().

- Naveen

