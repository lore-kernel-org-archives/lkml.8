Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B26C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F5B2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578655904;
	bh=mZ1a6xB7r1gnKbUwwBEEuWnCK6EZuBxFVgXu9uRkIXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WM3gTFwPaUmMvDl5l/+bWxUXr5yUY7hd0G3IweFcYzLCzO+3jk/OrJDGO0PO7RKb0
	 GrVL7ca3p3eCJ1d1khSv7bbQNTs62lToOI8NMtyEgcSYynbZPOWVez4CfeBtTcahEo
	 r4IBm1Gb2RqRo2qNJOMVqgpF3JUNpx2cke1THbsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgAJLbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 06:31:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38419 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbgAJLbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:31:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so1475829wrh.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 03:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2To09vgTYnKpMXzy6m6qVl1xvlUAlJvY27EC8LYs6zM=;
        b=Y1CdTsjHbZQ3gRrW4Gddnc9VdhOMH31g886AyFni0UL0cMRgcNQaCnesQlaJaOEFYB
         d7m4/0Cx13aRqcLY35O3G+iKwMOGIlar0wp5i2DhKvNU85WkMcgwKNQbW8Zu8d8+ggHt
         pG48CSfGfsSMAehaK7YmLvabbRYZpE4t+RnIxSMWEAzkEI5KoFMp8TWSzAY/eVAY4ofp
         K/rvenwaeA8pCwmRU/0a2M7u1Rkxtv2BslAXvYlWRwWZXD8+oa3F1jXZZYyY7brEQdiK
         2YUc9iy9u7+QawI8/dE/2OiUwjDs1pgop0G3YmTeuCDOUuqWsA8FCtN1ALefjr+FjP+E
         AOHQ==
X-Gm-Message-State: APjAAAXZzA68KRWHRm84fc74Q67ow60nRRWkkoeCldfVuVOKYhr3pRR0
        Sa2MosmMtujKauy7tRe9H6sdl+q2
X-Google-Smtp-Source: APXvYqwczGASBTqXYoAqgMeLCtSni/8bJEuoatUyZOHou6ag7ySspk1bdQAwyCt4fT+EqWOmxEmSpQ==
X-Received: by 2002:adf:8b4f:: with SMTP id v15mr3086675wra.231.1578655899881;
        Fri, 10 Jan 2020 03:31:39 -0800 (PST)
Received: from localhost (ip-37-188-146-105.eurotel.cz. [37.188.146.105])
        by smtp.gmail.com with ESMTPSA id b15sm1857297wmj.13.2020.01.10.03.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 03:31:38 -0800 (PST)
Date:   Fri, 10 Jan 2020 12:31:37 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com,
        Scott Cheloha <cheloha@linux.ibm.com>
Subject: Re: [PATCH v4] drivers/base/memory.c: cache blocks in radix tree to
 accelerate lookup
Message-ID: <20200110113137.GE29802@dhcp22.suse.cz>
References: <20200109142758.659c1545cb8df2d05f299a4a@linux-foundation.org>
 <F8AD9915-061E-4829-8670-B35D5F2DFC03@redhat.com>
 <bc21eec6-7251-4c91-2f57-9a0671f8d414@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc21eec6-7251-4c91-2f57-9a0671f8d414@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10-01-20 10:32:01, David Hildenbrand wrote:
> On 09.01.20 23:35, David Hildenbrand wrote:
> >> Am 09.01.2020 um 23:28 schrieb Andrew Morton <akpm@linux-foundation.org>:
> >>
> >> ﻿On Thu, 9 Jan 2020 23:17:09 +0100 David Hildenbrand <david@redhat.com> wrote:
> >>
> >>>
> >>>
> >>>>> Am 09.01.2020 um 23:00 schrieb Andrew Morton <akpm@linux-foundation.org>:
> >>>>
> >>>> ﻿On Thu,  9 Jan 2020 15:25:16 -0600 Scott Cheloha <cheloha@linux.vnet.ibm.com> wrote:
> >>>>
> >>>>> Searching for a particular memory block by id is an O(n) operation
> >>>>> because each memory block's underlying device is kept in an unsorted
> >>>>> linked list on the subsystem bus.
> >>>>>
> >>>>> We can cut the lookup cost to O(log n) if we cache the memory blocks in
> >>>>> a radix tree.  With a radix tree cache in place both memory subsystem
> >>>>> initialization and memory hotplug run palpably faster on systems with a
> >>>>> large number of memory blocks.
> >>>>>
> >>>>> ...
> >>>>>
> >>>>> @@ -56,6 +57,13 @@ static struct bus_type memory_subsys = {
> >>>>>   .offline = memory_subsys_offline,
> >>>>> };
> >>>>>
> >>>>> +/*
> >>>>> + * Memory blocks are cached in a local radix tree to avoid
> >>>>> + * a costly linear search for the corresponding device on
> >>>>> + * the subsystem bus.
> >>>>> + */
> >>>>> +static RADIX_TREE(memory_blocks, GFP_KERNEL);
> >>>>
> >>>> What protects this tree from racy accesses?
> >>>
> >>> I think the device hotplug lock currently (except during boot where no races can happen).
> >>>
> >>
> >> So this?
> >>
> >> --- a/drivers/base/memory.c~drivers-base-memoryc-cache-blocks-in-radix-tree-to-accelerate-lookup-fix
> >> +++ a/drivers/base/memory.c
> >> @@ -61,6 +61,9 @@ static struct bus_type memory_subsys = {
> >>  * Memory blocks are cached in a local radix tree to avoid
> >>  * a costly linear search for the corresponding device on
> >>  * the subsystem bus.
> >> + *
> >> + * Protected by mem_hotplug_lock in mem_hotplug_begin(), and by the guaranteed
> >> + * single-threadness at boot time.
> >>  */
> >> static RADIX_TREE(memory_blocks, GFP_KERNEL);
> >>
> >>
> >> But are we sure this is all true?
> > 
> > I think the device hotplug lock, not the memory hotplug lock. Will double check later.
> 
> So all writers either hold the device_hotplug_lock or run during boot.
> Documented e.g., for memory_dev_init(), create_memory_block_devices(),
> remove_memory_block_devices().
> 
> The readers are mainly
> - find_memory_block()
>  -> called via online_pages()/offline_pages() where we hold the
>     device_hotplug_lock
>  -> called from arch/powerpc/platforms/pseries/hotplug-memory.c,
>     where we always hold the device_hotplug_lock
> - walk_memory_blocks()
>  -> Callers in drivers/acpi/acpi_memhotplug.c either hold the
>     device_hotplug_lock or are called early during boot
>  -> Callers in mm/memory_hotplug.c either hold the
>     device_hotplug_lock or are called early during boot
>  -> link_mem_sections() is called either early during boot or via
>     add_memory_resource() (whereby all callers either hold the
>     device_hotplug_lock or are called early during boot)
>  -> Callers in arch/powerpc/platforms/powernv/memtrace.c hold the
>     device_hotplug_lock
> 
> So we are fine.
> 
> I suggest we document that expected behavior via

Thanks for documenting this! Adding a comment as you suggest makes
sense. Overall the locking expectations would be similar to
subsys_find_device_by_id which doesn't use any internal locking so the
radix tree which follows the lifetime of those objects should be
compatible with the current implementation (so no new races at least).

> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 799b43191dea..8c8dc081597e 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -585,6 +585,8 @@ static struct memory_block
> *find_memory_block_by_id(unsigned long block_id)
>   * tree or something here.
>   *
>   * This could be made generic for all device subsystems.
> + *
> + * Called under device_hotplug_lock.
>   */
>  struct memory_block *find_memory_block(struct mem_section *section)
>  {
> @@ -837,6 +839,8 @@ void __init memory_dev_init(void)
>   *
>   * In case func() returns an error, walking is aborted and the error is
>   * returned.
> + *
> + * Called under device_hotplug_lock.
>   */
>  int walk_memory_blocks(unsigned long start, unsigned long size,
>                        void *arg, walk_memory_blocks_func_t func)
> 
> 
> Please note that the memory hotplug lock is not safe on the reader side.
> But also not on the writer side after
> https://lkml.kernel.org/r/157863061737.2230556.3959730620803366776.stgit@dwillia2-desk3.amr.corp.intel.com
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb

-- 
Michal Hocko
SUSE Labs
