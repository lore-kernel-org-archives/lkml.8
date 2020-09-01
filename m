Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7E6C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBE12078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zh9tUDJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgIAETT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 00:19:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgIAETT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 00:19:19 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 081431xk119262;
        Tue, 1 Sep 2020 00:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Q246u/fQhcgO/yq7KHhZm2ekFkfZRubkGRPgvvC7blU=;
 b=Zh9tUDJHTPb3QXMbh0l4b4TkPFCUsEas+cI5gzTV8VvqwuSi5tP3LsjjY7ok+kbmt50p
 hRJMmcH/fotuOYBVHufFTgSZyDAbiNKBEUc6GPsonV9+hgz8u3A3CGBtI6s3yWmlXbmd
 hoJ8lcw+k0Z9NxXjXL9WKeiF05C2pe7Qkg592CcY+h8z25QdDaiw89VF/KNyOt7wEQT4
 ndH78U6AgAphmKJ5QjaVm+bT9NMkWIodMOWH9aTbmtTlmVVGT64w94j8NFTwNDymMmmR
 WhlUIcvVFSoM9HowyKitjpJMgqnLGOFYoQy3d1ZTHkH8m9td0TBNNyuvch2gX23BgpUx 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 339eg9gvk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 00:19:10 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08143QPN121201;
        Tue, 1 Sep 2020 00:19:10 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 339eg9gvjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 00:19:10 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0814HJEp028925;
        Tue, 1 Sep 2020 04:19:08 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 337e9gty7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 04:19:07 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0814J5o328049904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Sep 2020 04:19:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7172AE053;
        Tue,  1 Sep 2020 04:19:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B524AE04D;
        Tue,  1 Sep 2020 04:19:04 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.157.5])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Sep 2020 04:19:04 +0000 (GMT)
Date:   Tue, 1 Sep 2020 07:19:02 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] ia64: fix min_low_pfn/max_low_pfn build errors
Message-ID: <20200901041902.GC424181@linux.ibm.com>
References: <20200829000126.2463-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829000126.2463-1-rdunlap@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-01_01:2020-08-31,2020-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxscore=0 mlxlogscore=812
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony,

I can take it via the memblock tree, would appreciate an Ack.

On Fri, Aug 28, 2020 at 05:01:26PM -0700, Randy Dunlap wrote:
> Fix min_low_pfn/max_low_pfn build errors for arch/ia64/: (e.g.)
> 
>  ERROR: "max_low_pfn" [drivers/rpmsg/virtio_rpmsg_bus.ko] undefined!
>  ERROR: "min_low_pfn" [drivers/rpmsg/virtio_rpmsg_bus.ko] undefined!
>  ERROR: "min_low_pfn" [drivers/hwtracing/intel_th/intel_th_msu.ko] undefined!
>  ERROR: "max_low_pfn" [drivers/hwtracing/intel_th/intel_th_msu.ko] undefined!
>  ERROR: "min_low_pfn" [drivers/crypto/cavium/nitrox/n5pf.ko] undefined!
>  ERROR: "max_low_pfn" [drivers/crypto/cavium/nitrox/n5pf.ko] undefined!
>  ERROR: "max_low_pfn" [drivers/md/dm-integrity.ko] undefined!
>  ERROR: "min_low_pfn" [drivers/md/dm-integrity.ko] undefined!
>  ERROR: "max_low_pfn" [crypto/tcrypt.ko] undefined!
>  ERROR: "min_low_pfn" [crypto/tcrypt.ko] undefined!
>  ERROR: "min_low_pfn" [security/keys/encrypted-keys/encrypted-keys.ko] undefined!
>  ERROR: "max_low_pfn" [security/keys/encrypted-keys/encrypted-keys.ko] undefined!
>  ERROR: "min_low_pfn" [arch/ia64/kernel/mca_recovery.ko] undefined!
>  ERROR: "max_low_pfn" [arch/ia64/kernel/mca_recovery.ko] undefined!
> 
> David suggested just exporting min_low_pfn & max_low_pfn in
> mm/memblock.c:
> https://lore.kernel.org/lkml/alpine.DEB.2.22.394.2006291911220.1118534@chino.kir.corp.google.com/
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-mm@kvack.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: linux-ia64@vger.kernel.org
> ---
>  arch/ia64/kernel/ia64_ksyms.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200825.orig/arch/ia64/kernel/ia64_ksyms.c
> +++ linux-next-20200825/arch/ia64/kernel/ia64_ksyms.c
> @@ -3,7 +3,7 @@
>   * Architecture-specific kernel symbols
>   */
>  
> -#ifdef CONFIG_VIRTUAL_MEM_MAP
> +#if defined(CONFIG_VIRTUAL_MEM_MAP) || defined(CONFIG_DISCONTIGMEM)
>  #include <linux/compiler.h>
>  #include <linux/export.h>
>  #include <linux/memblock.h>

-- 
Sincerely yours,
Mike.
