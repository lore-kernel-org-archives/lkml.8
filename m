Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B33C2BB54
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3AC22202
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586422150;
	bh=dUJ3sNOyodK6LL8QTLdkYNcWv4koJHO1zyu0ZJ6Wqq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bCHZR+8kbMBQb59yirT9xdSiYytkt01khW2LFj7t/LjKrkxU78Yq90rBlbkm6i3rX
	 7icrDm4LPT/y+MX13eYl9qAmh/Uk6JBq4Y7OsWLmxhBUmE5PRh+5lWPtyPbKfXgOge
	 AmfTtTXVRiEPLGw2pxwHLZ3YSs/kpW6T5eahgQ/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgDIItJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 04:49:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39216 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgDIItJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:49:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id y24so3329628wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 01:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4R4O9Mkhw/Z10RizEohDCqkt7FovGhxpIg1sEVkIfyM=;
        b=IvRR/lNao+6IFKvrcsZE42wY/pwJLhobLI6fKFFx9+soctxDgbQ7gUcRIMKKrIG5q4
         51kIhkiK1b5h9P4d331+CJ+PoofSpHaWc8Vd3WBrE/AhBHdDeEOmP2OZ99uirHI/gy3l
         1PYqs70HDFp04xbX6xBCbSQHtkn52qUz3f108HXT3oeuCs+jola4v13NdJ9aUC2buyTt
         DwgofxGjyLUuKWpaDKT/yVms1ntna13lW/lly9pwBNLc5bSC8rp1stiDw4ZSEz71VdKd
         TG3V8C7i/7kcW87JzfyGaMp8KYClqrqUUmcpn7h9HNXWl7a9yALeFJ9qXs/aYueeBf+0
         13nw==
X-Gm-Message-State: AGi0PuaftBs3ux0P8I8v+GpafY+FmjJ0mF4qkLtCmNv5h8HVKHCs0iDh
        Wq+qu/5d3MpkVd/exDgVMDE=
X-Google-Smtp-Source: APiQypK+OnoBoW3IE7Y1FFhgVv8w8+vOScKrnNyOUHK/KS/1bwzbuAjaycK7cVwiF8cZW0fV5ZDuaQ==
X-Received: by 2002:a1c:2d8b:: with SMTP id t133mr9351094wmt.131.1586422147743;
        Thu, 09 Apr 2020 01:49:07 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id 145sm3063271wma.1.2020.04.09.01.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 01:49:07 -0700 (PDT)
Date:   Thu, 9 Apr 2020 10:49:06 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 1/2] powerpc/pseries/hotplug-memory: stop checking
 is_mem_section_removable()
Message-ID: <20200409084906.GD18386@dhcp22.suse.cz>
References: <20200407135416.24093-1-david@redhat.com>
 <20200407135416.24093-2-david@redhat.com>
 <87sghdjf1y.fsf@mpe.ellerman.id.au>
 <20200409075927.GC18386@dhcp22.suse.cz>
 <0a0ed3ed-f792-f8f7-07f4-cacc2b565a95@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a0ed3ed-f792-f8f7-07f4-cacc2b565a95@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-04-20 10:12:20, David Hildenbrand wrote:
> On 09.04.20 09:59, Michal Hocko wrote:
> > On Thu 09-04-20 17:26:01, Michael Ellerman wrote:
> >> David Hildenbrand <david@redhat.com> writes:
> >>
> >>> In commit 53cdc1cb29e8 ("drivers/base/memory.c: indicate all memory
> >>> blocks as removable"), the user space interface to compute whether a memory
> >>> block can be offlined (exposed via
> >>> /sys/devices/system/memory/memoryX/removable) has effectively been
> >>> deprecated. We want to remove the leftovers of the kernel implementation.
> >>>
> >>> When offlining a memory block (mm/memory_hotplug.c:__offline_pages()),
> >>> we'll start by:
> >>> 1. Testing if it contains any holes, and reject if so
> >>> 2. Testing if pages belong to different zones, and reject if so
> >>> 3. Isolating the page range, checking if it contains any unmovable pages
> >>>
> >>> Using is_mem_section_removable() before trying to offline is not only racy,
> >>> it can easily result in false positives/negatives. Let's stop manually
> >>> checking is_mem_section_removable(), and let device_offline() handle it
> >>> completely instead. We can remove the racy is_mem_section_removable()
> >>> implementation next.
> >>>
> >>> We now take more locks (e.g., memory hotplug lock when offlining and the
> >>> zone lock when isolating), but maybe we should optimize that
> >>> implementation instead if this ever becomes a real problem (after all,
> >>> memory unplug is already an expensive operation). We started using
> >>> is_mem_section_removable() in commit 51925fb3c5c9 ("powerpc/pseries:
> >>> Implement memory hotplug remove in the kernel"), with the initial
> >>> hotremove support of lmbs.
> >>
> >> It's also not very pretty in dmesg.
> >>
> >> Before:
> >>
> >>   pseries-hotplug-mem: Attempting to hot-add 10 LMB(s)
> >>   pseries-hotplug-mem: Memory hot-add failed, removing any added LMBs
> >>   dlpar: Could not handle DLPAR request "memory add count 10"
> > 
> > Yeah, there is more output but isn't that useful? Or put it differently
> > what is the actual problem from having those messages in the kernel log?
> > 
> > From the below you can clearly tell that there are kernel allocations
> > which prevent hot remove from happening.
> > 
> > If the overall size of the debugging output is a concern then we can
> > think of a way to reduce it. E.g. once you have a couple of pages
> > reported then all others from the same block are likely not interesting
> > much.
> > 
> 
> IIRC, we only report one page per block already. (and stop, as we
> detected something unmovable)

You are right.
-- 
Michal Hocko
SUSE Labs
