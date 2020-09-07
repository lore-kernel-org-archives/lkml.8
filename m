Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF363C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D1E20768
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oAUs9hPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgIGHFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:05:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726422AbgIGHFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:05:39 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08773Urj011906;
        Mon, 7 Sep 2020 03:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Llx2jsKGxkqfGTTwKQZgmRtiYpxHLIpBfZGAr2lZ3FU=;
 b=oAUs9hPgFDtnugMP9PFA5HahASLKDVLrh0Z7E6FXaSqAmhddduVdbzReP2vmGSRnUyUm
 MaHZpYBwyEWQHvDG5FXN3DKEz0qV/SUr+XfMCAN1EgjPn0u1m6xspmsl+QvxI5+gZslM
 yO3n6yVoGh4C/05GcUNMCZZrs6Hvvo1Pw1tFU0WP3UCQ8rX+eCuI5cDzVY7cp/mLSjE9
 EvE64g6lfPgGbt1ZiMG6st9YIhnXXMer58ELs4Pt1cvJUT1qvC9WBL6OVLLVP/mtPyST
 IfezNxHc6cAtOYc00O37OoxZ32TEhBlm8NEoF7WZzhGpttM9ehp/ij9Rjpqy/Xp6EC9l Yw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33dd78c9q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 03:05:18 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08773h7K013972;
        Mon, 7 Sep 2020 07:05:16 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 33cm5hgtc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 07:05:16 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08775ESV64749856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Sep 2020 07:05:14 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2952AA4064;
        Mon,  7 Sep 2020 07:05:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C028A406B;
        Mon,  7 Sep 2020 07:05:13 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.189.59])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  7 Sep 2020 07:05:12 +0000 (GMT)
Date:   Mon, 7 Sep 2020 10:05:11 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        Wen Congyang <wency@cn.fujitsu.com>,
        Michal Simek <monstr@monstr.eu>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] <linux/page-isolation.h>: provide stubs for
 MEMORY_ISOLATION not set (for Microblaze)
Message-ID: <20200907070511.GN424181@linux.ibm.com>
References: <1f6b42e6-b6b5-40e3-92b4-77bd610d3e49@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f6b42e6-b6b5-40e3-92b4-77bd610d3e49@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_01:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 bulkscore=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=886 adultscore=0 mlxscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Sun, Sep 06, 2020 at 12:33:08PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build errors in Microblaze when CONFIG_MEMORY_ISOLATION is not
> set/enabled by adding stubs for 3 missing functions.

I've tried to follow Kconfig dependencies to see how could we have both
CONTIG_ALLOC=y and CONFIG_MEMORY_ISOLATION=n and I could not find how
was this possible.

We have 

config CONTIG_ALLOC
	def_bool (MEMORY_ISOLATION && COMPACTION) || CMA

and

config CMA
	bool "Contiguous Memory Allocator"
	depends on MMU
	select MIGRATION
	select MEMORY_ISOLATION

and alloc_contig_range() is hidden behind '#ifdef CONFIG_CONTIG_ALLOC'

In any rate, I think the better fix would be to update Kconfig
dependencies rather than add stubs for these functions.

> Fixes these build errors:
> 
> gcc-9.3.0-nolibc/microblaze-linux/bin/microblaze-linux-ld: mm/page_alloc.o: in function `alloc_contig_range':
> (.text+0xa0c0): undefined reference to `start_isolate_page_range'
> gcc-9.3.0-nolibc/microblaze-linux/bin/microblaze-linux-ld: (.text+0xa2bc): undefined reference to `test_pages_isolated'
> gcc-9.3.0-nolibc/microblaze-linux/bin/microblaze-linux-ld: (.text+0xa378): undefined reference to `undo_isolate_page_range'
> 
> Fixes: 0815f3d81d76 ("mm: page_isolation: MIGRATE_CMA isolation functions added") # v3.10
> Fixes: b023f46813cd ("memory-hotplug: skip HWPoisoned page when offlining pages") # v3.10
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Michal Nazarewicz <mina86@mina86.com>
> Cc: Wen Congyang <wency@cn.fujitsu.com>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: linux-mm@kvack.org
> ---
>  include/linux/page-isolation.h |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> --- linux-next-20200903.orig/include/linux/page-isolation.h
> +++ linux-next-20200903/include/linux/page-isolation.h
> @@ -28,6 +28,22 @@ static inline bool is_migrate_isolate(in
>  {
>  	return false;
>  }
> +static inline int test_pages_isolated(unsigned long start_pfn,
> +				      unsigned long end_pfn, int isol_flags)
> +{
> +	return 0;
> +}
> +static inline int
> +start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
> +			 unsigned migratetype, int flags)
> +{
> +	return 0;
> +}
> +static inline void
> +undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
> +			unsigned migratetype)
> +{
> +}
>  #endif
>  
>  #define MEMORY_OFFLINE	0x1
> 
> 

-- 
Sincerely yours,
Mike.
