Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62F8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF15204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgFJLqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:46:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728481AbgFJLqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:46:53 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05ABX93E097528;
        Wed, 10 Jun 2020 07:46:48 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31jbvjwwsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 07:46:48 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05ABY7J9101982;
        Wed, 10 Jun 2020 07:46:47 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31jbvjww6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 07:46:47 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05ABjMMJ001316;
        Wed, 10 Jun 2020 11:45:28 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 31g2s7u4ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 11:45:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05ABjPtt56623548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 11:45:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51090AE045;
        Wed, 10 Jun 2020 11:45:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF756AE04D;
        Wed, 10 Jun 2020 11:45:24 +0000 (GMT)
Received: from osiris (unknown [9.171.62.218])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 10 Jun 2020 11:45:24 +0000 (GMT)
Date:   Wed, 10 Jun 2020 13:45:23 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Kirill Smelkov <kirr@nexedi.com>,
        Alexander Egorenkov <egorenar@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 1/2] s390/zcore: traverse resources instead of
 memblocks
Message-ID: <20200610114523.GA5943@osiris>
References: <20200417150151.17239-1-david@redhat.com>
 <20200417150151.17239-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417150151.17239-2-david@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_07:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 impostorscore=0
 cotscore=-2147483648 suspectscore=1 mlxscore=0 clxscore=1011 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 05:01:50PM +0200, David Hildenbrand wrote:
> The zcore memmap basically contains the first level of all system RAM from
> /proc/iomem. We want to disable CONFIG_ARCH_KEEP_MEMBLOCK (e.g., to not
> create memblocks for hotplugged/standby memory and save space), switch to
> traversing system ram resources instead. During early boot, we create
> resources for all early memblocks (including the crash kernel area). When
> adding standby memory, we currently create both, memblocks and resources.
> 
> Note: As we don't have memory hotplug after boot (standby memory is added
> via sclp during boot), we don't have to worry about races.
> 
> I am only able to test under KVM (where I hacked up zcore to still
> create the memmap file)
> 
> root@vm0:~# cat /proc/iomem
> 00000000-2fffffff : System RAM
>   10424000-10ec6fff : Kernel code
>   10ec7000-1139a0e3 : Kernel data
>   1177a000-11850fff : Kernel bss
> 30000000-3fffffff : Crash kernel
> 
> Result without this patch:
> root@vm0:~# cat /sys/kernel/debug/zcore/memmap
> 0000000000000000 0000000040000000
> 
> Result with this patch:
> root@vm0:~# cat /sys/kernel/debug/zcore/memmap
> 0000000000000000 0000000030000000 0000000030000000 0000000010000000
> 
> The difference is due to memblocks getting merged, resources (currently)
> not. So we might have some more entries, but they describe the same
> memory map.
> 
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Philipp Rudo <prudo@linux.ibm.com>
> Cc: Kirill Smelkov <kirr@nexedi.com>
> Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/s390/char/zcore.c | 61 ++++++++++++++++++++++++++++++---------
>  1 file changed, 48 insertions(+), 13 deletions(-)

I'm having a hard time to find any code that ever made use of this
file. After all this was only meant for our zfcp dumper, but as far as
I can tell there was never code out there that read the memmap file.

So the pragmatic approach would be to just change its contents, or a
more progressive variant would be to remove the file completely.
But maybe I'm entirely wrong...

I'm leaving this up to Philipp and Alexander :)
