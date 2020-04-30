Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58C7C8300B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8474820784
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgD3I7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 04:59:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726453AbgD3I7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 04:59:09 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03U81lLM143892;
        Thu, 30 Apr 2020 04:58:41 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mfhgdwx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 04:58:41 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03U8tf2h005040;
        Thu, 30 Apr 2020 08:58:39 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 30mcu5t5xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 08:58:38 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03U8waux35061774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 08:58:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C623011C050;
        Thu, 30 Apr 2020 08:58:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F4CE11C058;
        Thu, 30 Apr 2020 08:58:35 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.201.165])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 30 Apr 2020 08:58:35 +0000 (GMT)
Date:   Thu, 30 Apr 2020 11:58:33 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Price <steven.price@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initramfs: fix another section mismatch
Message-ID: <20200430085833.GB342687@linux.ibm.com>
References: <20200429190135.66411-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429190135.66411-1-arnd@arndb.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_02:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=5
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 09:01:29PM +0200, Arnd Bergmann wrote:
> Building with gcc-10 causes a harmless warning, similar to the
> gcc-4.6 warning that Geert fixed last year:
> 
> WARNING: modpost: vmlinux.o(.text.unlikely+0xe69): Section mismatch in reference from the function kexec_free_initrd() to the function .init.text:free_initrd_mem()
> The function kexec_free_initrd() references
> the function __init free_initrd_mem().
> This is often because kexec_free_initrd lacks a __init
> annotation or the annotation of free_initrd_mem is wrong.
> 
> Add the missing __init annotations.
> 
> Fixes: 4ada1e810038 ("initramfs: fix populate_initrd_image() section mismatch")
> Fixes: 23091e287355 ("initramfs: cleanup initrd freeing")
>  Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  init/initramfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/init/initramfs.c b/init/initramfs.c
> index 8ec1be4d7d51..bda77a6c8e50 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -542,7 +542,7 @@ void __weak free_initrd_mem(unsigned long start, unsigned long end)
>  }
>  
>  #ifdef CONFIG_KEXEC_CORE
> -static bool kexec_free_initrd(void)
> +static bool __init kexec_free_initrd(void)
>  {
>  	unsigned long crashk_start = (unsigned long)__va(crashk_res.start);
>  	unsigned long crashk_end   = (unsigned long)__va(crashk_res.end);
> @@ -565,7 +565,7 @@ static bool kexec_free_initrd(void)
>  	return true;
>  }
>  #else
> -static inline bool kexec_free_initrd(void)
> +static inline bool __init kexec_free_initrd(void)
>  {
>  	return false;
>  }
> -- 
> 2.26.0
> 

-- 
Sincerely yours,
Mike.
