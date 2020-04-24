Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C7FC5518A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF3C2076C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDT6IC8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgDXIS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 04:18:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36534 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726324AbgDXISz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 04:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587716332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=PFINnC+BGZGn9sYdlJV9u2+Sx+OXMChLSv8A9wCKC34=;
        b=dDT6IC8vfiuogJcik4rmvLH5Z/wXdg2Y4coIOXbf4Ymzaa6PODyETSr0kGCBGL3mym8srT
        WSQZwW4PrhmbdPUhPnR18pj4J3mbJICtZ6XlJBSluD2+6d2O/PlMMBhZmzConBpVu0RgAO
        0AH2YPmy9OImPp68bQUaloPbSc9d7E8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-zCd0CgxRN3KpX01kuDq-6w-1; Fri, 24 Apr 2020 04:18:50 -0400
X-MC-Unique: zCd0CgxRN3KpX01kuDq-6w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86B99800FC7;
        Fri, 24 Apr 2020 08:18:48 +0000 (UTC)
Received: from [10.36.113.138] (ovpn-113-138.ams2.redhat.com [10.36.113.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4805A100238A;
        Fri, 24 Apr 2020 08:18:46 +0000 (UTC)
Subject: Re: [PATCH v1] s390: drop memory notifier for protecting kdump crash
 kernel area
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20200424081218.6919-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <548f3adb-7569-93a0-ef79-0f5d65f8ef0d@redhat.com>
Date:   Fri, 24 Apr 2020 10:18:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424081218.6919-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.04.20 10:12, David Hildenbrand wrote:
> Assume we have a crashkernel area of 256MB reserved:
> 
> root@vm0:~# cat /proc/iomem
> 00000000-6fffffff : System RAM
>   0f258000-0fcfffff : Kernel code
>   0fd00000-101d10e3 : Kernel data
>   105b3000-1068dfff : Kernel bss
> 70000000-7fffffff : Crash kernel
> 
> This exactly corresponds to memory block 7 (memory block size is 256MB).
> Trying to offline that memory block results in:
> 
> root@vm0:~# echo "offline" > /sys/devices/system/memory/memory7/state
> -bash: echo: write error: Device or resource busy
> 
> [  128.458762] page:000003d081c00000 refcount:1 mapcount:0 mapping:00000000d01cecd4 index:0x0
> [  128.458773] flags: 0x1ffff00000001000(reserved)
> [  128.458781] raw: 1ffff00000001000 000003d081c00008 000003d081c00008 0000000000000000
> [  128.458781] raw: 0000000000000000 0000000000000000 ffffffff00000001 0000000000000000
> [  128.458783] page dumped because: unmovable page
> 
> The craskernel area is marked reserved in the bootmem allocator. This
> results in the memmap getting initialized (refcount=1, PG_reserved), but
> the pages are never freed to the page allocator.
> 
> So these pages look like allocated pages that are unmovable (esp.
> PG_reserved), and therefore, memory offlining fails early, when trying to
> isolate the page range.
> 
> We don't need a special memory notifier and can drop it. Repeating the
> above test with this patch results in the same behavior.
> 
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Philipp Rudo <prudo@linux.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kernel/setup.c | 33 ---------------------------------
>  1 file changed, 33 deletions(-)
> 
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 0f0b140b5558..95d4fba0d811 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -39,7 +39,6 @@
>  #include <linux/kernel_stat.h>
>  #include <linux/dma-contiguous.h>
>  #include <linux/device.h>
> -#include <linux/notifier.h>
>  #include <linux/pfn.h>
>  #include <linux/ctype.h>
>  #include <linux/reboot.h>
> @@ -591,35 +590,6 @@ static void __init setup_memory_end(void)
>  	pr_notice("The maximum memory size is %luMB\n", memory_end >> 20);
>  }
>  
> -#ifdef CONFIG_CRASH_DUMP
> -
> -/*
> - * When kdump is enabled, we have to ensure that no memory from
> - * the area [0 - crashkernel memory size] and
> - * [crashk_res.start - crashk_res.end] is set offline.
> - */

Re-reading that comment, I missed the [0 - crashkernel memory size]
part (for relocation IIRC). So we might want to keep checking for [0 -
crashkernel memory size] - will double check.


-- 
Thanks,

David / dhildenb

