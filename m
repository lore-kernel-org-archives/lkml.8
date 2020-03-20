Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F49C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E90D20739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZgh2uOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgCTKAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 06:00:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56666 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726767AbgCTKAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 06:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584698446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OhGdRDimoydz1fT3CsvYSAlzFLb6nzVVmLyiiWdxzZ4=;
        b=RZgh2uOr8ySD2/Xl6yv3DY0f/Qk8qVQ06L/qYtTGD0GCPJ+zGvxbWYbDI80xDCkGqq/5XH
        mN5o+2EMItjibvdxFTg7gMqPykshyzqrTydGoElyQEHfWKsTsGrXORBakLOlb+tFrFkpy+
        XM1A49RFkkdMLmUPN7+OQG0Qlk/OzhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-aAQ3WwCAO7q_Kx6jn35Ixw-1; Fri, 20 Mar 2020 06:00:42 -0400
X-MC-Unique: aAQ3WwCAO7q_Kx6jn35Ixw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94AE9100DFC0;
        Fri, 20 Mar 2020 10:00:40 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-155.pek2.redhat.com [10.72.12.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 765621001920;
        Fri, 20 Mar 2020 10:00:30 +0000 (UTC)
Date:   Fri, 20 Mar 2020 18:00:26 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com,
        kexec@lists.infradead.org, kasong@redhat.com, bhe@redhat.com
Subject: Re: [RFC PATCH 0/3] meminfo: introduce extra meminfo
Message-ID: <20200320100026.GA36529@dhcp-128-65.nay.redhat.com>
References: <CGME20200311034454epcas1p2ef0c0081971dd82282583559398e58b2@epcas1p2.samsung.com>
 <20200311034441.23243-1-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311034441.23243-1-jaewon31.kim@samsung.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/20 at 12:44pm, Jaewon Kim wrote:
> /proc/meminfo or show_free_areas does not show full system wide memory
> usage status. There seems to be huge hidden memory especially on
> embedded Android system. Because it usually have some HW IP which do not
> have internal memory and use common DRAM memory.
> 
> In Android system, most of those hidden memory seems to be vmalloc pages
> , ion system heap memory, graphics memory, and memory for DRAM based
> compressed swap storage. They may be shown in other node but it seems to
> useful if /proc/meminfo shows all those extra memory information. And
> show_mem also need to print the info in oom situation.
> 
> Fortunately vmalloc pages is alread shown by commit 97105f0ab7b8
> ("mm: vmalloc: show number of vmalloc pages in /proc/meminfo"). Swap
> memory using zsmalloc can be seen through vmstat by commit 91537fee0013
> ("mm: add NR_ZSMALLOC to vmstat") but not on /proc/meminfo.
> 
> Memory usage of specific driver can be various so that showing the usage
> through upstream meminfo.c is not easy. To print the extra memory usage
> of a driver, introduce following APIs. Each driver needs to count as
> atomic_long_t.
> 
> int register_extra_meminfo(atomic_long_t *val, int shift,
> 			   const char *name);
> int unregister_extra_meminfo(atomic_long_t *val);
> 
> Currently register ION system heap allocator and zsmalloc pages.
> Additionally tested on local graphics driver.
> 
> i.e) cat /proc/meminfo | tail -3
> IonSystemHeap:    242620 kB
> ZsPages:          203860 kB
> GraphicDriver:    196576 kB
> 
> i.e.) show_mem on oom
> <6>[  420.856428]  Mem-Info:
> <6>[  420.856433]  IonSystemHeap:32813kB ZsPages:44114kB GraphicDriver::13091kB
> <6>[  420.856450]  active_anon:957205 inactive_anon:159383 isolated_anon:0

Kdump is also a use case for having a better memory use info, it runs
with limited memory, and we see more oom cases from device drivers
instead of userspace processes.

I think this might be helpful if drivers can implement and register the
hook.  But it would be ideal if we can have some tracing code to trace
the memory alloc/free and get the memory use info automatically.

Anyway the proposal is better than none, thumb up!

Let me cc Kairui who is working on kdump oom issues.

Thanks
Dave

