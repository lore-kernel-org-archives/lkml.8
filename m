Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DF8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78EC920663
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgFRL2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 07:28:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727904AbgFRL2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 07:28:02 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05IB3UA7012500;
        Thu, 18 Jun 2020 07:27:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31r6g11hxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 07:27:12 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05IB6rat035172;
        Thu, 18 Jun 2020 07:27:12 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31r6g11hwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 07:27:11 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05IBPpcb031122;
        Thu, 18 Jun 2020 11:27:09 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 31quax8yde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 11:27:09 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05IBR5lH65667518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jun 2020 11:27:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAB21A404D;
        Thu, 18 Jun 2020 11:27:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57F97A4040;
        Thu, 18 Jun 2020 11:27:04 +0000 (GMT)
Received: from osiris (unknown [9.171.90.17])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 18 Jun 2020 11:27:04 +0000 (GMT)
Date:   Thu, 18 Jun 2020 13:27:02 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com, arnd@arndb.de,
        borntraeger@de.ibm.com, catalin.marinas@arm.com,
        christian@brauner.io, cyphar@cyphar.com, dhowells@redhat.com,
        ebiederm@xmission.com, fenghua.yu@intel.com, geert@linux-m68k.org,
        gor@linux.ibm.com, ink@jurassic.park.msu.ru, jolsa@redhat.com,
        linux@armlinux.org.uk, lkp@intel.com, mark.rutland@arm.com,
        mattst88@gmail.com, minchan@kernel.org, mingo@redhat.com,
        monstr@monstr.eu, namhyung@kernel.org, peterz@infradead.org,
        rth@twiddle.net, sargun@sargun.me, sfr@canb.auug.org.au,
        tony.luck@intel.com, will@kernel.org, akpm@linux-foundation.org,
        alex.huangjianhui@huawei.com, zhongjubin@huawei.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] s390: fix build error for sys_call_table_emu
Message-ID: <20200618112702.GB4231@osiris>
References: <20200618110320.104013-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618110320.104013-1-nixiaoming@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_07:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 bulkscore=0 cotscore=-2147483648
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006180080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 07:03:20PM +0800, Xiaoming Ni wrote:
> Build error on s390:
> 	arch/s390/kernel/entry.o: in function `sys_call_table_emu':
> 	>> (.rodata+0x1288): undefined reference to `__s390_'
> 
> In commit ("All arch: remove system call sys_sysctl")
>  148  common	fdatasync		sys_fdatasync			sys_fdatasync
> -149  common	_sysctl			sys_sysctl			compat_sys_sysctl
> +149  common	_sysctl			sys_ni_syscall
>  150  common	mlock			sys_mlock			sys_mlock
> 
> After the patch is integrated, there is a format error in the generated
> arch/s390/include/generated/asm/syscall_table.h:
> 	SYSCALL(sys_fdatasync, sys_fdatasync)
> 	SYSCALL(sys_ni_syscall,) /* cause build error */
> 	SYSCALL(sys_mlock,sys_mlock)
> 
> There are holes in the system call number in
>  arch/s390/kernel/syscalls/syscall.tbl. When generating syscall_table.h,
> these hole numbers will be automatically filled with "NI_SYSCALL".
> Therefore, delete the number 149 to fix the current compilation failure.
>  Similarly, modify tools/perf/arch/s390/entry/syscalls/syscall.tbl.
> 
> Fixes: ("All arch: remove system call sys_sysctl")
> Fixes: https://lore.kernel.org/linuxppc-dev/20200616030734.87257-1-nixiaoming@huawei.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> ---
>  arch/s390/kernel/syscalls/syscall.tbl           | 1 -
>  tools/perf/arch/s390/entry/syscalls/syscall.tbl | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index f17aaf6fe5de..bcaf93994e3c 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -138,7 +138,6 @@
>  146  common	writev			sys_writev			compat_sys_writev
>  147  common	getsid			sys_getsid			sys_getsid
>  148  common	fdatasync		sys_fdatasync			sys_fdatasync
> -149  common	_sysctl			sys_ni_syscall

This is not correct. It should be changed to:

   149  common	_sysctl			-				-

Otherwise the generated __NR__sysctl define will be lost from
unistd.h, which should not happen. Looking at the link above it
_looks_ like a similar mistake was done for arm64.

> diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> index 0193f9b98753..eb77d0d01d8f 100644
> --- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> +++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> @@ -138,7 +138,6 @@
>  146  common	writev			sys_writev			compat_sys_writev
>  147  common	getsid			sys_getsid			sys_getsid
>  148  common	fdatasync		sys_fdatasync			sys_fdatasync
> -149  common	_sysctl			sys_ni_syscall

Same here.
