Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30E3C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F0F2206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qqvMDhzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbgEKOOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 10:14:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51342 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730489AbgEKON7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 10:13:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BDZjdf007101;
        Mon, 11 May 2020 14:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8prh65ahEbXqnO+VBBdG5CKN1+9p3No5FuVaz0SanQY=;
 b=qqvMDhzsqjY+TBfq5ylIDgiuLwKEQY/dLMyH9BE4aJLTbEdXnPjhhj0gBH5OZ+5oqUb3
 mQGOh5povasQMMYG8MUidlFgyZ6mjYlluJZdeBz3J6CGgn+Iyf8dzGALNYqpfwZ6i0Yn
 zXSp3MiKSSdhdk+k4CrYsLJh8h2gpaUCG3o+c+FK/JREEDu9RcLVeKCgxYt8dvckA8IW
 MH9WuUKsgaODHBfO8Rjp9N+qBsKLjFKLONSI99vGuKERFb+ffoDNRSc/7AyI0WgVnabm
 UeOYBlxs/3ROAbGaGtlncCSzgIOiGrBaMw1ffJ90uRI4VcJx399i/OCClEdELpS46UMB nQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30x3mbn9un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 May 2020 14:13:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BDXwLW136961;
        Mon, 11 May 2020 14:11:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 30x6ew3km3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 14:11:32 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04BEBQrr005761;
        Mon, 11 May 2020 14:11:26 GMT
Received: from [10.175.13.248] (/10.175.13.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 May 2020 07:11:26 -0700
Subject: Re: [PATCH RFC] Microcode late loading feature identification
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <1587972479-10971-1-git-send-email-mihai.carabas@oracle.com>
From:   Mihai Carabas <mihai.carabas@oracle.com>
Message-ID: <56ae9070-5960-1498-c021-74ef4451c222@oracle.com>
Date:   Mon, 11 May 2020 17:11:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1587972479-10971-1-git-send-email-mihai.carabas@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ro
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9617 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9617 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

La 27.04.2020 10:27, Mihai Carabas a scris:
> This RFC patch set aims to provide a way to identify the modifications
> brought in by the new microcode updated at runtime (aka microcode late
> loading). This was debated last year and this patch set implements
> point #1 from Thomas Gleixner's idea:
> https://lore.kernel.org/lkml/alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de/
> 

+Ashok and Thomas to get a feedback from vendor side on file 
format/integration in the microcode blob and signature.

Thank you,
Mihai

> This patch set has the following patches:
> 
> - patch 1 is introducing a new metadata file that comes with the microcode
> (provided by the CPU manufacture) that describes what modifications are
> done by loading the new microcode
> 
> - patch 2 parses the metadata file and is verifying it against kernel
> policy. In this patch, as an RFC, as a kernel policy, it was imposed
> the rule of not allowing to remove any feature. If so, it won't be
> loaded a new microcode. The policy can be further extended and describe
> in different ways
> 
> - patch 3 adds the documentation of the metadata file format
> 
> 
> How to test:
> 
> - place metadata file in /lib/firmware/intel-ucode/ together with the
> microcode blob:
> 
> [root@ovs108 ~]# ls -l /lib/firmware/intel-ucode
> total 96
> -rw-r--r--.   1 root root 34816 Mar 11 00:27 06-55-04
> -rw-r--r--.   1 root root    84 Mar 25 03:13 06-55-04.metadata
> 
> The microcode blob can be taken from the microcode_ctl package.
> 
> - after installing the kernel and rebooting the machine run "dracut -f
> --no-early-microcode" to create an initramfs without the microcode (and
> avoid early loading)
> 
> - reboot
> 
> - after rebooting issue: echo 1 > /sys/devices/system/cpu/microcode/reload
> 
> [root@ovs108 ~]# cat /lib/firmware/intel-ucode/06-55-04.metadata
> m - 0x00000122
> c + 0x00000007 0x00 0x00000000 0x021cbfbb 0x00000000 0x00000000
> 
> [root@ovs108 ~]# echo 1 > /sys/devices/system/cpu/microcode/reload
> [root@ovs108 ~]# dmesg | tail -2
> [ 1285.729841] microcode: Kernel policy does not allow to remove MSR: 122
> [ 1285.737144] microcode: kernel does not support the new microcode: intel-ucode/06-55-04
> 
> [root@ovs108 ~]# cat /lib/firmware/intel-ucode/06-55-04.metadata
> m + 0x00000122
> c + 0x00000007 0x00 0x00000000 0x021cbfbb 0x00000000 0x00000000
> [root@ovs108 ~]# echo 1 > /sys/devices/system/cpu/microcode/reload
> [root@ovs108 ~]# dmesg | tail -10
> [ 1220.212415] microcode: updated to revision 0x2000065, date = 2019-09-05
> [ 1220.212645] microcode: Reload completed, microcode revision: 0x2000065
> 
> Mihai Carabas (3):
>    x86: microcode: intel: read microcode metadata file
>    x86: microcode: intel: process microcode metadata
>    Documentation: x86: microcode: add description for metadata file
> 
>   Documentation/x86/microcode.rst       | 36 +++++++++++++
>   arch/x86/kernel/cpu/microcode/intel.c | 97 +++++++++++++++++++++++++++++++++++
>   2 files changed, 133 insertions(+)
> 

