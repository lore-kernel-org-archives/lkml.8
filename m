Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0D6C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 13:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B3D207BB
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 13:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rK1Hmsb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgH2NLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 09:11:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728235AbgH2NEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 09:04:48 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07TD1XZa122290;
        Sat, 29 Aug 2020 09:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=7MqhdwTj5lKbX+jh+JmPegmmYZsxZQX9IBMyUrTRHfY=;
 b=rK1Hmsb3jYg7QCmbv2VGYaw4Wm3vtDjGCyCX+qXTxpC54ODVNPDBveNJAHxWu262GYry
 bzLa4ZB8P+l6bjq3sfmmIxT5xyEbc15hau/VdpCVbyVWGsN0Tyc3vllOvRH4l7BaExul
 QZeKBO4cLFCa5Cf+mxPSerfSKxH42t0VyafP/utXIp23NYfMpVWRXrEn6L+Ic1gwqtEg
 VHq/pYm3fAvt/dzs267SnkTPiwG8L2XOi4viZdPcjTzXApVLPDhE0xXXmks/WA97iGCn
 TF8wGkP7v7XjqkQS7ZLE1AqVRjEuRkv27iGF2SJK5GOx18C49k5vGPy5QbTiqorzRmlu BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 337kdpv0ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Aug 2020 09:04:37 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07TD2KRI124347;
        Sat, 29 Aug 2020 09:04:37 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 337kdpv0jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Aug 2020 09:04:36 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07TD3kaH025145;
        Sat, 29 Aug 2020 13:04:34 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 337en8875s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Aug 2020 13:04:34 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07TD4WOm31457540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Aug 2020 13:04:32 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FF8E11C04C;
        Sat, 29 Aug 2020 13:04:32 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02AE411C04A;
        Sat, 29 Aug 2020 13:04:31 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.92.75])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 29 Aug 2020 13:04:30 +0000 (GMT)
Date:   Sat, 29 Aug 2020 16:04:29 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Simek <monstr@monstr.eu>,
        Michal Simek <michal.simek@xilinx.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: Re: [ALTERNATE PATCH] memblock: fix min_low_pfn/max_low_pfn build
 errors
Message-ID: <20200829130429.GG167163@linux.ibm.com>
References: <20200829000139.2513-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829000139.2513-1-rdunlap@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-29_07:2020-08-28,2020-08-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=875 clxscore=1011 lowpriorityscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008290101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 05:01:39PM -0700, Randy Dunlap wrote:
> Export min_low_pfn & max_low_pfn in mm/memblock.c to fix build errors
> on arch/microblaze/ and arch/ia64/: (e.g.)

Please don't. This would give driver developers a wrong impression that
these variables can be used to query memory boundaries, but this is not
the case, at least not on all architectures.

I would prefer fixing it up locally for microblaze and ia64.

>   ERROR: "max_low_pfn" [drivers/rpmsg/virtio_rpmsg_bus.ko] undefined!
>   ERROR: "min_low_pfn" [drivers/rpmsg/virtio_rpmsg_bus.ko] undefined!
>   ERROR: "max_low_pfn" [drivers/mtd/spi-nor/spi-nor.ko] undefined!
>   ERROR: "min_low_pfn" [drivers/mtd/spi-nor/spi-nor.ko] undefined!
>   ERROR: "min_low_pfn" [drivers/mtd/nand/raw/nand.ko] undefined!
>   ERROR: "max_low_pfn" [drivers/mtd/nand/raw/nand.ko] undefined!
>   ERROR: "max_low_pfn" [drivers/rapidio/devices/rio_mport_cdev.ko] undefined!
>   ERROR: "min_low_pfn" [drivers/rapidio/devices/rio_mport_cdev.ko] undefined!
>   ERROR: "min_low_pfn" [drivers/hwtracing/intel_th/intel_th_msu.ko] undefined!
>   ERROR: "max_low_pfn" [drivers/hwtracing/intel_th/intel_th_msu.ko] undefined!
>   ERROR: "min_low_pfn" [drivers/crypto/cavium/nitrox/n5pf.ko] undefined!
>   ERROR: "max_low_pfn" [drivers/crypto/cavium/nitrox/n5pf.ko] undefined!
>   ERROR: "max_low_pfn" [drivers/md/dm-integrity.ko] undefined!
>   ERROR: "min_low_pfn" [drivers/md/dm-integrity.ko] undefined!
>   ERROR: "max_low_pfn" [crypto/tcrypt.ko] undefined!
>   ERROR: "min_low_pfn" [crypto/tcrypt.ko] undefined!
> 
> In both arches, these variables are referenced in
> arch/$ARCH/include/asm/page.h.
> 
> Mike had/has an alternate patch for Microblaze:
> https://lore.kernel.org/lkml/20200630111519.GA1951986@linux.ibm.com/
> 
> David suggested just exporting min_low_pfn & max_low_pfn in
> mm/memblock.c:
> https://lore.kernel.org/lkml/alpine.DEB.2.22.394.2006291911220.1118534@chino.kir.corp.google.com/
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-mm@kvack.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: linux-ia64@vger.kernel.org
> ---
>  mm/memblock.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- linux-next-20200825.orig/mm/memblock.c
> +++ linux-next-20200825/mm/memblock.c
> @@ -99,6 +99,8 @@ EXPORT_SYMBOL(contig_page_data);
>  
>  unsigned long max_low_pfn;
>  unsigned long min_low_pfn;
> +EXPORT_SYMBOL(min_low_pfn);
> +EXPORT_SYMBOL(max_low_pfn);
>  unsigned long max_pfn;
>  unsigned long long max_possible_pfn;
>  

-- 
Sincerely yours,
Mike.
