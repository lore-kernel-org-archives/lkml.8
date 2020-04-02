Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B825BC10F26
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B5520678
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbgDBHev convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:34:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729033AbgDBHev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:34:51 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0327Ydhv122468
        for <linux-kernel@vger.kernel.org>; Thu, 2 Apr 2020 03:34:49 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 304g87556j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 03:34:44 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 2 Apr 2020 08:34:22 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 Apr 2020 08:34:20 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0327XYfx50856230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Apr 2020 07:33:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B990642041;
        Thu,  2 Apr 2020 07:34:37 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 559CF4203F;
        Thu,  2 Apr 2020 07:34:37 +0000 (GMT)
Received: from localhost (unknown [9.85.74.67])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  2 Apr 2020 07:34:37 +0000 (GMT)
Date:   Thu, 02 Apr 2020 13:04:34 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 6/6] pseries/sysfs: Minimise IPI noise while reading
 [idle_][s]purr
To:     ego@linux.vnet.ibm.com, Michael Ellerman <mpe@ellerman.id.au>
Cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
References: <1585308760-28792-1-git-send-email-ego@linux.vnet.ibm.com>
        <1585308760-28792-7-git-send-email-ego@linux.vnet.ibm.com>
        <1585734367.oqwn7dzljo.naveen@linux.ibm.com>
        <20200401120127.GC17237@in.ibm.com>
In-Reply-To: <20200401120127.GC17237@in.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 20040207-0020-0000-0000-000003C00DC9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040207-0021-0000-0000-00002218B769
Message-Id: <1585811157.uig8s95yst.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_04:2020-03-31,2020-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gautham R Shenoy wrote:
> Hello Naveen,
> 
> 
> On Wed, Apr 01, 2020 at 03:28:48PM +0530, Naveen N. Rao wrote:
>> Gautham R. Shenoy wrote:
>> >From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>> >
>  [..snip..]
> 
>> >+
>> >+static ssize_t show_purr(struct device *dev,
>> >+			 struct device_attribute *attr, char *buf)
>> > {
>> >-	u64 *ret = val;
>> >+	struct cpu *cpu = container_of(dev, struct cpu, dev);
>> >+	struct util_acct_stats *stats;
>> >
>> >-	*ret = read_this_idle_purr();
>> >+	stats = get_util_stats_ptr(cpu->dev.id);
>> >+	return sprintf(buf, "%llx\n", stats->latest_purr);
>> 
>> This alters the behavior of the current sysfs purr file. I am not sure if it
>> is reasonable to return the same PURR value across a 10ms window.
> 
> 
> It does reduce it to 10ms window. I am not sure if anyone samples PURR
> etc faster than that rate.
> 
> I measured how much time it takes to read the purr, spurr, idle_purr,
> idle_spurr files back-to-back. It takes not more than 150us.  From
> lparstat will these values be read back-to-back ? If so, we can reduce
> the staleness_tolerance to something like 500us and still avoid extra
> IPIs. If not, what is the maximum delay between the first sysfs file
> read and the last sysfs file read ?

Oh, for lparstat usage, this is perfectly fine.

I meant that there could be other users of [s]purr who might care. I 
don't know of one, but since this is an existing sysfs interface, I 
wanted to point out that the behavior might change.

> 
>>
>> I wonder if we should introduce a sysctl interface to control thresholding.
>> It can default to 0, which disables thresholding so that the existing
>> behavior continues. Applications (lparstat) can optionally set it to suit
>> their use.
> 
> We would be introducing 3 new sysfs interfaces that way instead of
> two.
> 
> /sys/devices/system/cpu/purr_spurr_staleness
> /sys/devices/system/cpu/cpuX/idle_purr
> /sys/devices/system/cpu/cpuX/idle_spurr
> 
> I don't have a problem with this. Nathan, Michael, thoughts on this?
> 
> 
> The alternative is to have a procfs interface, something like
> /proc/powerpc/resource_util_stats
> 
> which gives a listing similar to /proc/stat, i.e
> 
>       CPUX  <purr>  <idle_purr>  <spurr>  <idle_spurr>
> 
> Even in this case, the values can be obtained in one-shot with a
> single IPI and be printed in the row corresponding to the CPU.

Right -- and that would be optimal requiring a single system call, at 
the cost of using a legacy interface.

The other option would be to drop this patch and to just go with patches 
1-5 introducing the new sysfs interfaces for idle_[s]purr. It isn't 
entirely clear how often this would be used, or its actual impact. We 
can perhaps consider this optimization if and when this causes 
problems...


Thanks,
Naveen

