Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3364C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91893206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbgGOLGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:06:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729699AbgGOLGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:06:06 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FB2SQj006302;
        Wed, 15 Jul 2020 07:05:58 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32991fj332-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 07:05:58 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FB1Z85012919;
        Wed, 15 Jul 2020 11:05:56 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 327527veqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 11:05:55 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06FB4drW65339512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 11:04:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F4233AE053;
        Wed, 15 Jul 2020 11:04:38 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D0A3AE051;
        Wed, 15 Jul 2020 11:04:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.63.15])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Jul 2020 11:04:37 +0000 (GMT)
Subject: Re: [ext4] d3b6f23f71: stress-ng.fiemap.ops_per_sec -60.5% regression
To:     kernel test robot <rong.a.chen@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, kbuild test robot <lkp@intel.com>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200407080036.GA8179@shao2-debian>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 15 Jul 2020 16:34:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200407080036.GA8179@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200715110437.7D0A3AE051@d06av26.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_07:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xing,

On 4/7/20 1:30 PM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -60.5% regression of stress-ng.fiemap.ops_per_sec due to commit:
> 
> 
> commit: d3b6f23f71670007817a5d59f3fbafab2b794e8c ("ext4: move ext4_fiemap to use iomap framework")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: stress-ng
> on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
> with following parameters:
> 
> 	nr_threads: 10%
> 	disk: 1HDD
> 	testtime: 1s
> 	class: os
> 	cpufreq_governor: performance
> 	ucode: 0x500002c
> 	fs: ext4

I started looking into this issue. But with my unit testing, I didn't
find any perf issue with fiemap ioctl call. I haven't yet explored about
how stress-ng take fiemap performance numbers, it could be doing
something differently. But in my testing I just made sure to create a
file with large number of extents and used xfs_io -c "fiemap -v" cmd
to check how much time it takes to read all the entries in 1st
and subsequent iterations.


Setup comprised of qemu machine on x86_64 with latest linux branch.

1. created a file of 10G using fallocate. (this allocated unwritten
extents for this file).

2. Then I punched hole on every alternate block of file. This step took
a long time. And after sufficiently long time, I had to cancel it.
for i in $(seq 1 2 xxxxx); do echo $i; fallocate -p -o $(($i*4096)) -l 
4096; done

3. Then issued fiemap call via xfs_io and took the time measurement.
time xfs_io -c "fiemap -v" bigfile > /dev/null


Perf numbers on latest default kernel build for above cmd.

1st iteration
==============
real    0m31.684s
user    0m1.593s
sys     0m24.174s

2nd and subsequent iteration
============================
real    0m3.379s
user    0m1.300s
sys     0m2.080s


4. Then I reverted all the iomap_fiemap patches and re-tested this.
With this the older ext4_fiemap implementation will be tested:-


1st iteration
==============
real    0m31.591s
user    0m1.400s
sys     0m24.243s


2nd and subsequent iteration (had to cancel it since it was taking more 
time then 15m)
============================
^C^C
real    15m49.884s
user    0m0.032s
sys     15m49.722s

I guess the reason why 2nd iteration with older implementation is taking
too much time is since with previous implementation we never cached
extent entries in extent_status tree. And also in 1st iteration the page
cache may get filled with lot of buffer_head entries. So maybe page
reclaims are taking more time.

While with the latest implementation using iomap_fiemap(), the call to 
query extent blocks is done using ext4_map_blocks(). ext4_map_blocks()
by default will also cache the extent entries into extent_status tree.
Hence during 2nd iteration, we will directly read the entries from 
extent_status tree and will not do any disk I/O.

-ritesh
