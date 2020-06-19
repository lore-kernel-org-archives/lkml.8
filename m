Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2F2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D68207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbgFSMrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:47:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728081AbgFSMrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:47:35 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JCXFvO172057;
        Fri, 19 Jun 2020 08:47:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31rkgjrqss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 08:47:30 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05JCXNcJ172905;
        Fri, 19 Jun 2020 08:47:30 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31rkgjrqru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 08:47:29 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05JCjZm0020168;
        Fri, 19 Jun 2020 12:47:27 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 31qyx1h7q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 12:47:27 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05JClOqa58195972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jun 2020 12:47:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4111A406B;
        Fri, 19 Jun 2020 12:47:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69845A405D;
        Fri, 19 Jun 2020 12:47:24 +0000 (GMT)
Received: from laptop2-ibm.local (unknown [9.145.160.229])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Jun 2020 12:47:24 +0000 (GMT)
Date:   Fri, 19 Jun 2020 14:47:23 +0200
From:   Philipp Rudo <prudo@linux.ibm.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Kirill Smelkov <kirr@nexedi.com>,
        Alexander Egorenkov <egorenar@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 1/2] s390/zcore: traverse resources instead of
 memblocks
Message-ID: <20200619144723.01fc99e8@laptop2-ibm.local>
In-Reply-To: <20200610114523.GA5943@osiris>
References: <20200417150151.17239-1-david@redhat.com>
        <20200417150151.17239-2-david@redhat.com>
        <20200610114523.GA5943@osiris>
Organization: IBM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_11:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 cotscore=-2147483648 lowpriorityscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006190089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

zcore/memmap is no longer needed and Alexander is preparing a patch to remove
it. You can drop this patch.

Thanks
Philipp

On Wed, 10 Jun 2020 13:45:23 +0200
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> On Fri, Apr 17, 2020 at 05:01:50PM +0200, David Hildenbrand wrote:
> > The zcore memmap basically contains the first level of all system RAM from
> > /proc/iomem. We want to disable CONFIG_ARCH_KEEP_MEMBLOCK (e.g., to not
> > create memblocks for hotplugged/standby memory and save space), switch to
> > traversing system ram resources instead. During early boot, we create
> > resources for all early memblocks (including the crash kernel area). When
> > adding standby memory, we currently create both, memblocks and resources.
> > 
> > Note: As we don't have memory hotplug after boot (standby memory is added
> > via sclp during boot), we don't have to worry about races.
> > 
> > I am only able to test under KVM (where I hacked up zcore to still
> > create the memmap file)
> > 
> > root@vm0:~# cat /proc/iomem
> > 00000000-2fffffff : System RAM
> >   10424000-10ec6fff : Kernel code
> >   10ec7000-1139a0e3 : Kernel data
> >   1177a000-11850fff : Kernel bss
> > 30000000-3fffffff : Crash kernel
> > 
> > Result without this patch:
> > root@vm0:~# cat /sys/kernel/debug/zcore/memmap
> > 0000000000000000 0000000040000000
> > 
> > Result with this patch:
> > root@vm0:~# cat /sys/kernel/debug/zcore/memmap
> > 0000000000000000 0000000030000000 0000000030000000 0000000010000000
> > 
> > The difference is due to memblocks getting merged, resources (currently)
> > not. So we might have some more entries, but they describe the same
> > memory map.
> > 
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > Cc: Philipp Rudo <prudo@linux.ibm.com>
> > Cc: Kirill Smelkov <kirr@nexedi.com>
> > Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  drivers/s390/char/zcore.c | 61 ++++++++++++++++++++++++++++++---------
> >  1 file changed, 48 insertions(+), 13 deletions(-)  
> 
> I'm having a hard time to find any code that ever made use of this
> file. After all this was only meant for our zfcp dumper, but as far as
> I can tell there was never code out there that read the memmap file.
> 
> So the pragmatic approach would be to just change its contents, or a
> more progressive variant would be to remove the file completely.
> But maybe I'm entirely wrong...
> 
> I'm leaving this up to Philipp and Alexander :)
