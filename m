Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E039C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4351F208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583911515;
	bh=yOWm3LimQiKbAgoZ7xZIhu1BJ756nQzeNh5dV5JFLf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UHt+/XP76L7/kW4ELonHC1waBn24qnEvmI5sJvY2Cps+rVolq6LP1eM8JJUWqlM3b
	 6vnCISSUUilTm5CIgBzxguaTdWdpKjA3lzuhKLz2L0oqa80ERzeixU8KEhjAfhhkAN
	 34diXdMC9HTj3SZpkrhO8FCRNQkkjyJUdXoEky4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbgCKHZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbgCKHZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:25:13 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B0D5208C3;
        Wed, 11 Mar 2020 07:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583911513;
        bh=yOWm3LimQiKbAgoZ7xZIhu1BJ756nQzeNh5dV5JFLf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jXgXSJjsaLqE/GJntifBlStLymp6iGkGksOU5blxm2+uS7Ng9+KttNXBU3fR5ZcuD
         VIt48U6qR9rW0+vjwG56wQabTjK6SZo7bFgsEvZvTkQ45n15TifqRRaCTpXOUQ4G4S
         4lhkOh+KETLRQrM7rn9Y779QHi56UZOk+PtPkmgo=
Date:   Wed, 11 Mar 2020 09:25:09 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com
Subject: Re: [RFC PATCH 0/3] meminfo: introduce extra meminfo
Message-ID: <20200311072509.GH4215@unreal>
References: <CGME20200311034454epcas1p2ef0c0081971dd82282583559398e58b2@epcas1p2.samsung.com>
 <20200311034441.23243-1-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311034441.23243-1-jaewon31.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 12:44:38PM +0900, Jaewon Kim wrote:
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

The idea is nice and helpful, but I'm sure that the interface will be abused
almost immediately. I expect that every driver will register to such API.

First it will be done by "large" drivers and after that everyone will copy/paste.

Thanks
