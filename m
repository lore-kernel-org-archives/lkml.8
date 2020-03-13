Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C61C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 07:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F081A206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 07:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584084090;
	bh=q0cIe6MTJK09dh8sMu1JtSynCN5FdarBVPOa9V6hUXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wfTgvU7OkbZWkTUYRtPQxK6I+KeDqNdJuRp9B1r46WM/bEJs3Y2Cnk1MCar1nAndf
	 aANuF6TU3pqV9R5Vac8h93xjBAhIHAD5v2hF0CGF4BfATiiVuEp3X3RrqPxnBasW3j
	 QDT2RtwK3NK+JCCY844jgqhyp1CoTraWGlkdMRIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCMHV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 03:21:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgCMHV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 03:21:28 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9921206EB;
        Fri, 13 Mar 2020 07:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584084087;
        bh=q0cIe6MTJK09dh8sMu1JtSynCN5FdarBVPOa9V6hUXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=drIFz0tb/SZIMzAcm+iDRPxG/eOY4Vjkn03uAhYebZe1FIXXiweBhWrqEpiqs4iLv
         qDhpIpCEyLBLFS5yeM/GXXVfPomQ8qWJQpYFXVyaIhMmFY90EHvEMIEc7eVX4r8y9P
         DRRU+G/IRgIddCjGBcG2l+F+GM+qnPiyVpm3s6pc=
Date:   Fri, 13 Mar 2020 09:21:22 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com
Subject: Re: [RFC PATCH 0/3] meminfo: introduce extra meminfo
Message-ID: <20200313072122.GD31504@unreal>
References: <CGME20200311034454epcas1p2ef0c0081971dd82282583559398e58b2@epcas1p2.samsung.com>
 <20200311034441.23243-1-jaewon31.kim@samsung.com>
 <20200311072509.GH4215@unreal>
 <5E6B0E72.7010305@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5E6B0E72.7010305@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 01:39:14PM +0900, Jaewon Kim wrote:
>
>
> On 2020년 03월 11일 16:25, Leon Romanovsky wrote:
> > On Wed, Mar 11, 2020 at 12:44:38PM +0900, Jaewon Kim wrote:
> >> /proc/meminfo or show_free_areas does not show full system wide memory
> >> usage status. There seems to be huge hidden memory especially on
> >> embedded Android system. Because it usually have some HW IP which do not
> >> have internal memory and use common DRAM memory.
> >>
> >> In Android system, most of those hidden memory seems to be vmalloc pages
> >> , ion system heap memory, graphics memory, and memory for DRAM based
> >> compressed swap storage. They may be shown in other node but it seems to
> >> useful if /proc/meminfo shows all those extra memory information. And
> >> show_mem also need to print the info in oom situation.
> >>
> >> Fortunately vmalloc pages is alread shown by commit 97105f0ab7b8
> >> ("mm: vmalloc: show number of vmalloc pages in /proc/meminfo"). Swap
> >> memory using zsmalloc can be seen through vmstat by commit 91537fee0013
> >> ("mm: add NR_ZSMALLOC to vmstat") but not on /proc/meminfo.
> >>
> >> Memory usage of specific driver can be various so that showing the usage
> >> through upstream meminfo.c is not easy. To print the extra memory usage
> >> of a driver, introduce following APIs. Each driver needs to count as
> >> atomic_long_t.
> >>
> >> int register_extra_meminfo(atomic_long_t *val, int shift,
> >> 			   const char *name);
> >> int unregister_extra_meminfo(atomic_long_t *val);
> >>
> >> Currently register ION system heap allocator and zsmalloc pages.
> >> Additionally tested on local graphics driver.
> >>
> >> i.e) cat /proc/meminfo | tail -3
> >> IonSystemHeap:    242620 kB
> >> ZsPages:          203860 kB
> >> GraphicDriver:    196576 kB
> >>
> >> i.e.) show_mem on oom
> >> <6>[  420.856428]  Mem-Info:
> >> <6>[  420.856433]  IonSystemHeap:32813kB ZsPages:44114kB GraphicDriver::13091kB
> >> <6>[  420.856450]  active_anon:957205 inactive_anon:159383 isolated_anon:0
> > The idea is nice and helpful, but I'm sure that the interface will be abused
> > almost immediately. I expect that every driver will register to such API.
> >
> > First it will be done by "large" drivers and after that everyone will copy/paste.
> I thought using it is up to driver developers.
> If it is abused, /proc/meminfo will show too much info. for that device.
> What about a new node, /proc/meminfo_extra, to gather those info. and not
> corrupting original /proc/meminfo.

I don't know if it is applicable for all users, but for the drivers
such info is better to be placed in /sys/ as separate file (for example
/sys/class/net/wlp3s0/*) and driver/core will be responsible to
register/unregister.

It will ensure that all drivers get this info without need to register
and make /proc/meminfo and /proc/meminfo_extra too large.

Thanks

>
> Thank you
> > Thanks
> >
> >
>
