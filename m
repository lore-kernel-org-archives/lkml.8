Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CA3C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5F62051A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgDGLY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 07:24:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725883AbgDGLY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 07:24:56 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 037B4eoN021637
        for <linux-kernel@vger.kernel.org>; Tue, 7 Apr 2020 07:24:54 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3082f2bb83-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 07:24:54 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
        Tue, 7 Apr 2020 12:24:50 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 Apr 2020 12:24:48 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 037BOnVY17957108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Apr 2020 11:24:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61C1F4C046;
        Tue,  7 Apr 2020 11:24:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3F374C04A;
        Tue,  7 Apr 2020 11:24:46 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.199.45.45])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  7 Apr 2020 11:24:46 +0000 (GMT)
Subject: Re: [PATCH v5 0/5] Track and expose idle PURR and SPURR ticks
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1586249263-14048-1-git-send-email-ego@linux.vnet.ibm.com>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date:   Tue, 7 Apr 2020 16:54:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1586249263-14048-1-git-send-email-ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20040711-0028-0000-0000-000003F3AE08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040711-0029-0000-0000-000024B94514
Message-Id: <a1feda38-9488-a025-4a38-e4785bf7405d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_03:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1011 malwarescore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/20 2:17 PM, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Hi,
> 
> This is the fifth version of the patches to track and expose idle PURR
> and SPURR ticks. These patches are required by tools such as lparstat
> to compute system utilization for capacity planning purposes.
> 
> The previous versions can be found here:
> v4: https://lkml.org/lkml/2020/3/27/323
> v3: https://lkml.org/lkml/2020/3/11/331
> v2: https://lkml.org/lkml/2020/2/21/21
> v1: https://lore.kernel.org/patchwork/cover/1159341/
> 
> They changes from v4 are:
> 
>    - As suggested by Naveen, moved the functions read_this_idle_purr()
>      and read_this_idle_spurr() from Patch 2 and Patch 3 respectively
>      to Patch 4 where it is invoked.
> 
>    - Dropped Patch 6 which cached the values of purr, spurr,
>      idle_purr, idle_spurr in order to minimize the number of IPIs
>      sent.
> 
>    - Updated the dates for the idle_purr, idle_spurr in the
>      Documentation Patch 5.
> 
> Motivation:
> ===========
> On PSeries LPARs, the data centers planners desire a more accurate
> view of system utilization per resource such as CPU to plan the system
> capacity requirements better. Such accuracy can be obtained by reading
> PURR/SPURR registers for CPU resource utilization.
> 
> Tools such as lparstat which are used to compute the utilization need
> to know [S]PURR ticks when the cpu was busy or idle. The [S]PURR
> counters are already exposed through sysfs.  We already account for
> PURR ticks when we go to idle so that we can update the VPA area. This
> patchset extends support to account for SPURR ticks when idle, and
> expose both via per-cpu sysfs files.
> 
> These patches are required for enhancement to the lparstat utility
> that compute the CPU utilization based on PURR and SPURR which can be
> found here :
> https://groups.google.com/forum/#!topic/powerpc-utils-devel/fYRo69xO9r4
> 
> 
> With the patches, when lparstat is run on a LPAR running CPU-Hogs,
> =========================================================================
> sudo ./src/lparstat -E 1 3
> 
> System Configuration
> type=Dedicated mode=Capped smt=8 lcpu=2 mem=4834112 kB cpus=0 ent=2.00 
> 
> ---Actual---                 -Normalized-
> %busy  %idle   Frequency     %busy  %idle
> ------ ------  ------------- ------ ------
> 1  99.99   0.00  3.35GHz[111%] 110.99   0.00
> 2 100.00   0.00  3.35GHz[111%] 111.01   0.00
> 3 100.00   0.00  3.35GHz[111%] 111.00   0.00
> 
> With patches, when lparstat is run on and idle LPAR
> =========================================================================
> System Configuration
> type=Dedicated mode=Capped smt=8 lcpu=2 mem=4834112 kB cpus=0 ent=2.00 
> ---Actual---                 -Normalized-
> %busy  %idle   Frequency     %busy  %idle
> ------ ------  ------------- ------ ------
> 1   0.15  99.84  2.17GHz[ 72%]   0.11  71.89
> 2   0.24  99.76  2.11GHz[ 70%]   0.18  69.82
> 3   0.24  99.75  2.11GHz[ 70%]   0.18  69.81
> 
> Gautham R. Shenoy (5):
>   powerpc: Move idle_loop_prolog()/epilog() functions to header file
>   powerpc/idle: Store PURR snapshot in a per-cpu global variable
>   powerpc/pseries: Account for SPURR ticks on idle CPUs
>   powerpc/sysfs: Show idle_purr and idle_spurr for every CPU
>   Documentation: Document sysfs interfaces purr, spurr, idle_purr,
>     idle_spurr
> 
>  Documentation/ABI/testing/sysfs-devices-system-cpu | 39 +++++++++
>  arch/powerpc/include/asm/idle.h                    | 93 ++++++++++++++++++++++
>  arch/powerpc/kernel/sysfs.c                        | 82 ++++++++++++++++++-
>  arch/powerpc/platforms/pseries/setup.c             |  8 +-
>  drivers/cpuidle/cpuidle-pseries.c                  | 39 ++-------
>  5 files changed, 224 insertions(+), 37 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/idle.h
> 

Hi Gautham,

Thanks for working on it, I tested it using the lparstat patches posted at:
https://groups.google.com/forum/#!topic/powerpc-utils-devel/_imHP1Guw3c

On idle system:
===============
sudo ./src/lparstat -E 1 3

System Configuration
type=Dedicated mode=Capped smt=8 lcpu=2 mem=4324928 kB cpus=0 ent=2.00 

---Actual---                 -Normalized-
%busy  %idle   Frequency     %busy  %idle
------ ------  ------------- ------ ------
  0.27  99.74  2.11GHz[ 70%]   0.24  69.76
  0.57  99.43  2.17GHz[ 72%]   0.43  71.57
  0.52  99.47  2.11GHz[ 70%]   0.38  69.62


On system running N while(1) (N == online cpus)
===============================================
sudo ./src/lparstat -E 1 3

System Configuration
type=Dedicated mode=Capped smt=8 lcpu=2 mem=4324928 kB cpus=0 ent=2.00 

---Actual---                 -Normalized-
%busy  %idle   Frequency     %busy  %idle
------ ------  ------------- ------ ------
 99.99   0.00  3.35GHz[111%] 110.99   0.00
100.00   0.00  3.35GHz[111%] 111.00   0.00
100.00   0.00  3.35GHz[111%] 111.00   0.00


For the series:
Reviewed-and-Tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

-- 
Kamalesh

