Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AD9C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D7120775
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgD3PFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:05:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726377AbgD3PFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:05:50 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UF3BnU050380;
        Thu, 30 Apr 2020 11:05:48 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mhqay548-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 11:05:47 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03UF3EKc050719;
        Thu, 30 Apr 2020 11:05:47 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mhqay52e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 11:05:47 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03UEp40h013011;
        Thu, 30 Apr 2020 15:05:44 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 30mcu72tye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 15:05:44 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03UF5g1c65405082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 15:05:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09310A405B;
        Thu, 30 Apr 2020 15:05:42 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E980A4054;
        Thu, 30 Apr 2020 15:05:41 +0000 (GMT)
Received: from thinkpad (unknown [9.145.48.229])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Apr 2020 15:05:41 +0000 (GMT)
Date:   Thu, 30 Apr 2020 17:05:40 +0200
From:   Gerald Schaefer <gerald.schaefer@de.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2] s390: simplify memory notifier for protecting kdump
 crash kernel area
Message-ID: <20200430170540.49e51d9d@thinkpad>
In-Reply-To: <1d79310d-8909-73e7-d2dd-90e8b9edf253@redhat.com>
References: <20200424083904.8587-1-david@redhat.com>
        <1d79310d-8909-73e7-d2dd-90e8b9edf253@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_09:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 16:55:38 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 24.04.20 10:39, David Hildenbrand wrote:
> > Assume we have a crashkernel area of 256MB reserved:
> > 
> > root@vm0:~# cat /proc/iomem
> > 00000000-6fffffff : System RAM
> >   0f258000-0fcfffff : Kernel code
> >   0fd00000-101d10e3 : Kernel data
> >   105b3000-1068dfff : Kernel bss
> > 70000000-7fffffff : Crash kernel
> > 
> > This exactly corresponds to memory block 7 (memory block size is 256MB).
> > Trying to offline that memory block results in:
> > 
> > root@vm0:~# echo "offline" > /sys/devices/system/memory/memory7/state
> > -bash: echo: write error: Device or resource busy
> > 
> > [  128.458762] page:000003d081c00000 refcount:1 mapcount:0 mapping:00000000d01cecd4 index:0x0
> > [  128.458773] flags: 0x1ffff00000001000(reserved)
> > [  128.458781] raw: 1ffff00000001000 000003d081c00008 000003d081c00008 0000000000000000
> > [  128.458781] raw: 0000000000000000 0000000000000000 ffffffff00000001 0000000000000000
> > [  128.458783] page dumped because: unmovable page
> > 
> > The craskernel area is marked reserved in the bootmem allocator. This
> > results in the memmap getting initialized (refcount=1, PG_reserved), but
> > the pages are never freed to the page allocator.
> > 
> > So these pages look like allocated pages that are unmovable (esp.
> > PG_reserved), and therefore, memory offlining fails early, when trying to
> > isolate the page range.
> > 
> > We only have to care about the exchange area, make that clear.
> > 
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Cc: Philipp Rudo <prudo@linux.ibm.com>
> > Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> > 
> > Follow up of:
> > - "[PATCH v1] s390: drop memory notifier for protecting kdump crash kernel
> >    area"
> > 
> > v1 -> v2:
> > - Keep the notifier, check for exchange area only
> > 
> > ---
> >  arch/s390/kernel/setup.c | 13 +++++--------
> >  1 file changed, 5 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> > index 0f0b140b5558..c0881f0a3175 100644
> > --- a/arch/s390/kernel/setup.c
> > +++ b/arch/s390/kernel/setup.c
> > @@ -594,9 +594,10 @@ static void __init setup_memory_end(void)
> >  #ifdef CONFIG_CRASH_DUMP
> >  
> >  /*
> > - * When kdump is enabled, we have to ensure that no memory from
> > - * the area [0 - crashkernel memory size] and
> > - * [crashk_res.start - crashk_res.end] is set offline.
> > + * When kdump is enabled, we have to ensure that no memory from the area
> > + * [0 - crashkernel memory size] is set offline - it will be exchanged with
> > + * the crashkernel memory region when kdump is triggered. The crashkernel
> > + * memory region can never get offlined (pages are unmovable).
> >   */
> >  static int kdump_mem_notifier(struct notifier_block *nb,
> >  			      unsigned long action, void *data)
> > @@ -607,11 +608,7 @@ static int kdump_mem_notifier(struct notifier_block *nb,
> >  		return NOTIFY_OK;
> >  	if (arg->start_pfn < PFN_DOWN(resource_size(&crashk_res)))
> >  		return NOTIFY_BAD;
> > -	if (arg->start_pfn > PFN_DOWN(crashk_res.end))
> > -		return NOTIFY_OK;
> > -	if (arg->start_pfn + arg->nr_pages - 1 < PFN_DOWN(crashk_res.start))
> > -		return NOTIFY_OK;
> > -	return NOTIFY_BAD;
> > +	return NOTIFY_OK;
> >  }
> >  
> >  static struct notifier_block kdump_mem_nb = {
> > 
> 
> Ping.
> 

Looks good, thanks.

Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
