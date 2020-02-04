Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AE0C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 18:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E65E217BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 18:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="fFAoT2rR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgBDSmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 13:42:05 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46789 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbgBDSmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 13:42:04 -0500
Received: by mail-qk1-f193.google.com with SMTP id g195so18957900qke.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 10:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mfg0cYkHgZDe2FFxz++KqPykseJ0uIwJzVxGUkuCijE=;
        b=fFAoT2rR5Rn5KZxc+7d2KSPwko56kY11XSj0IXIjxYH2FdAWlKx6BkIQeAMGyIYdMb
         zx+UHbXL+4PimrhFPPFjDYh25pEf0yoXwVEpxaPaYSyhkUX/isFem6es6qyHAF/99IOa
         eeHqeNA/sjVFC09c2DrDlEOuztk3LjJu7mKAy9Pdxcp4Rh9u3ekPkjnXx1aWRo4PuLOr
         Mtlq8eZHkmVTXyOi3LHUT7/4qDqvOJ4S2ANHvxKDA96WtDds97vV8/xhxlIQAHi0hXhF
         kmc7YvicymX379ijQS36Afidz/ZlX6WumaNIATMvPO26ksU1u9dBwg3BiKonyfZ1Bjt0
         a4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mfg0cYkHgZDe2FFxz++KqPykseJ0uIwJzVxGUkuCijE=;
        b=SUo73vrz1Cw5gTOQMcOpZiuiHdCgSELOz8eFYarH4orrnFDQwzwytHdrR1V8cLI65s
         isUkq7k7zPHwU67mwaD5lMWFD+uop+GHe/ivWv366CfPbu3mh8Bgi/bTE1fiwoigQdj7
         WaTP0SLuz5RiTDbQtUhh4eDy4EEoHd6mkATZBRulGdGil7bKghT/2i8x6fLaPfOHUOXP
         z7mAlSA9M2BNEpAiQUtQtl20/2QS6rQwjRHyTOy/cU8KAqqTNaIPTLmIhKhew7s9jHwJ
         lBhfnnF1J+c7CmrAfrfvAwRrooVKIM0mwzKBIy78DD6NRNJPipojeqvb3yWLAIEIE08U
         qPpQ==
X-Gm-Message-State: APjAAAXLAlH0sycqxmu0F6S704oObuR0nN7VMf1BjCFcwe8n1GlKwIg8
        7IVRHPFjafZ9OkoFdYMy0l2e0c5Z8+8=
X-Google-Smtp-Source: APXvYqy1X9KKriO2vSopiLEx4VqZKKJ2r4DqT8pqiBLN188jVSlYD1glJvIi+oTH60sOd65eibgKZA==
X-Received: by 2002:ae9:e513:: with SMTP id w19mr29552009qkf.34.1580841721354;
        Tue, 04 Feb 2020 10:42:01 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::bcd8])
        by smtp.gmail.com with ESMTPSA id n25sm11276232qkh.88.2020.02.04.10.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 10:42:00 -0800 (PST)
Date:   Tue, 4 Feb 2020 13:41:59 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 21/28] mm: memcg/slab: use a single set of kmem_caches
 for all memory cgroups
Message-ID: <20200204184159.GB9027@cmpxchg.org>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-22-guro@fb.com>
 <20200203195048.GA4396@cmpxchg.org>
 <20200203205834.GA6781@xps.dhcp.thefacebook.com>
 <20200203221734.GA7345@cmpxchg.org>
 <20200204011505.GA9138@xps.dhcp.thefacebook.com>
 <20200204024704.GA9027@cmpxchg.org>
 <20200204043541.GA12194@xps.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204043541.GA12194@xps.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 08:35:41PM -0800, Roman Gushchin wrote:
> On Mon, Feb 03, 2020 at 09:47:04PM -0500, Johannes Weiner wrote:
> > On Mon, Feb 03, 2020 at 05:15:05PM -0800, Roman Gushchin wrote:
> > > On Mon, Feb 03, 2020 at 05:17:34PM -0500, Johannes Weiner wrote:
> > > > On Mon, Feb 03, 2020 at 12:58:34PM -0800, Roman Gushchin wrote:
> > > > > On Mon, Feb 03, 2020 at 02:50:48PM -0500, Johannes Weiner wrote:
> > > > > > On Mon, Jan 27, 2020 at 09:34:46AM -0800, Roman Gushchin wrote:
> > > > > > > This is fairly big but mostly red patch, which makes all non-root
> > > > > > > slab allocations use a single set of kmem_caches instead of
> > > > > > > creating a separate set for each memory cgroup.
> > > > > > > 
> > > > > > > Because the number of non-root kmem_caches is now capped by the number
> > > > > > > of root kmem_caches, there is no need to shrink or destroy them
> > > > > > > prematurely. They can be perfectly destroyed together with their
> > > > > > > root counterparts. This allows to dramatically simplify the
> > > > > > > management of non-root kmem_caches and delete a ton of code.
> > > > > > 
> > > > > > This is definitely going in the right direction. But it doesn't quite
> > > > > > explain why we still need two sets of kmem_caches?
> > > > > > 
> > > > > > In the old scheme, we had completely separate per-cgroup caches with
> > > > > > separate slab pages. If a cgrouped process wanted to allocate a slab
> > > > > > object, we'd go to the root cache and used the cgroup id to look up
> > > > > > the right cgroup cache. On slab free we'd use page->slab_cache.
> > > > > > 
> > > > > > Now we have slab pages that have a page->objcg array. Why can't all
> > > > > > allocations go through a single set of kmem caches? If an allocation
> > > > > > is coming from a cgroup and the slab page the allocator wants to use
> > > > > > doesn't have an objcg array yet, we can allocate it on the fly, no?
> > > > > 
> > > > > Well, arguably it can be done, but there are few drawbacks:
> > > > > 
> > > > > 1) On the release path you'll need to make some extra work even for
> > > > >    root allocations: calculate the offset only to find the NULL objcg pointer.
> > > > > 
> > > > > 2) There will be a memory overhead for root allocations
> > > > >    (which might or might not be compensated by the increase
> > > > >    of the slab utilization).
> > > > 
> > > > Those two are only true if there is a wild mix of root and cgroup
> > > > allocations inside the same slab, and that doesn't really happen in
> > > > practice. Either the machine is dedicated to one workload and cgroups
> > > > are only enabled due to e.g. a vendor kernel, or you have cgrouped
> > > > systems (like most distro systems now) that cgroup everything.
> > > 
> > > It's actually a questionable statement: we do skip allocations from certain
> > > contexts, and we do merge slab caches.
> > > 
> > > Most likely it's true for certain slab_caches and not true for others.
> > > Think of kmalloc-* caches.
> > 
> > With merging it's actually really hard to say how sparse or dense the
> > resulting objcgroup arrays would be. It could change all the time too.
> 
> So here is some actual data from my dev machine. The first column is the number
> of pages in the root cache, the second - in the corresponding memcg.
> 
>    ext4_groupinfo_4k          1          0
>      rpc_inode_cache          1          0
>         fuse_request         62          0
>           fuse_inode          1       2732
>   btrfs_delayed_node       1192          0
> btrfs_ordered_extent        129          0
>     btrfs_extent_map       8686          0
>  btrfs_extent_buffer       2648          0
>          btrfs_inode         12       6739
>               PINGv6          1         11
>                RAWv6          2          5
>                UDPv6          1         34
>        tw_sock_TCPv6        378          3
>   request_sock_TCPv6         24          0
>                TCPv6         46         74
>   mqueue_inode_cache          1          0
>  jbd2_journal_handle          2          0
>    jbd2_journal_head          2          0
>  jbd2_revoke_table_s          1          0
>     ext4_inode_cache          1          3
> ext4_allocation_context          1          0
>          ext4_io_end          1          0
>   ext4_extent_status          5          0
>              mbcache          1          0
>       dnotify_struct          1          0
>   posix_timers_cache         24          0
>       xfrm_dst_cache        202          0
>                  RAW          3         12
>                  UDP          2         24
>          tw_sock_TCP         25          0
>     request_sock_TCP         24          0
>                  TCP          7         24
> hugetlbfs_inode_cache          2          0
>                dquot          2          0
>        eventpoll_pwq          1        119
>            dax_cache          1          0
>        request_queue          9          0
>           blkdev_ioc        241          0
>           biovec-max        112          0
>           biovec-128          2          0
>            biovec-64          6          0
>   khugepaged_mm_slot        248          0
>  dmaengine-unmap-256          1          0
>  dmaengine-unmap-128          1          0
>   dmaengine-unmap-16         39          0
>     sock_inode_cache          9        219
>     skbuff_ext_cache        249          0
>  skbuff_fclone_cache         83          0
>    skbuff_head_cache        138        141
>      file_lock_cache         24          0
>        net_namespace          1          5
>    shmem_inode_cache         14         56
>      task_delay_info         23        165
>            taskstats         24          0
>       proc_dir_entry         24          0
>           pde_opener         16         24
>     proc_inode_cache         24       1103
>           bdev_cache          4         20
>    kernfs_node_cache       1405          0
>            mnt_cache         54          0
>                 filp         53        460
>          inode_cache        488       2287
>               dentry        367      10576
>          names_cache         24          0
>         ebitmap_node          2          0
>      avc_xperms_data        256          0
>       lsm_file_cache         92          0
>          buffer_head         24          9
>        uts_namespace          1          3
>       vm_area_struct         48        810
>            mm_struct         19         29
>          files_cache         14         26
>         signal_cache         28        143
>        sighand_cache         45         47
>          task_struct         77        430
>             cred_jar         29        424
>       anon_vma_chain         39        492
>             anon_vma         28        467
>                  pid         30        369
>         Acpi-Operand         56          0
>           Acpi-Parse       5587          0
>           Acpi-State       4137          0
>       Acpi-Namespace          8          0
>          numa_policy        137          0
>   ftrace_event_field         68          0
>       pool_workqueue         25          0
>      radix_tree_node       1694       7776
>           task_group         21          0
>            vmap_area        477          0
>      kmalloc-rcl-512        473          0
>      kmalloc-rcl-256        605          0
>      kmalloc-rcl-192         43         16
>      kmalloc-rcl-128          1         47
>       kmalloc-rcl-96          3        229
>       kmalloc-rcl-64          6        611
>           kmalloc-8k         48         24
>           kmalloc-4k        372         59
>           kmalloc-2k        132         50
>           kmalloc-1k        251         82
>          kmalloc-512        360        150
>          kmalloc-256        237          0
>          kmalloc-192        298         24
>          kmalloc-128        203         24
>           kmalloc-96        112         24
>           kmalloc-64        796         24
>           kmalloc-32       1188         26
>           kmalloc-16        555         25
>            kmalloc-8         42         24
>      kmem_cache_node         20          0
>           kmem_cache         24          0

That's interesting, thanks. It does look fairly bimodal, except in
some smaller caches. Which does make sense when you think about it: we
focus on accounting consumers that are driven by userspace activity
and big enough to actually matter in terms of cgroup footprint.

> > > Also, because obj_cgroup vectors will not be freed without underlying pages,
> > > most likely the percentage of pages with obj_cgroups will grow with uptime.
> > > In other words, memcg allocations will fragment root slab pages.
> > 
> > I understand the first part of this paragraph, but not the second. The
> > objcgroup vectors will be freed when the slab pages get freed. But the
> > partially filled slab pages can be reused by any types of allocations,
> > surely? How would this cause the pages to fragment?
> 
> I mean the following: once you allocate a single accounted object
> from the page, obj_cgroup vector is allocated and will be released only
> with the slab page. We really really don't want to count how many accounted
> objects are on the page and release obj_cgroup vector on reaching 0.
> So even if all following allocations are root allocations, the overhead
> will not go away with the uptime.
> 
> In other words, even a small percentage of accounted objects will
> turn the whole cache into "accountable".

Correct. The worst case is where we have a large cache that has N
objects per slab, but only ~1/N objects are accounted to a cgroup.

The question is whether this is common or even realistic. When would a
cache be big, but only a small subset of its allocations would be
attributable to specific cgroups?

On the less extreme overlapping cases, yeah there are fragmented
obj_cgroup arrays, but there is also better slab packing. One is an
array of pointers, the other is an array of larger objects. It would
seem slab fragmentation has the potential to waste much more memory?

> > > > > 3) I'm working on percpu memory accounting that resembles the same scheme,
> > > > >    except that obj_cgroups vector is created for the whole percpu block.
> > > > >    There will be root- and memcg-blocks, and it will be expensive to merge them.
> > > > >    I kinda like using the same scheme here and there.
> > > > 
> > > > It's hard to conclude anything based on this information alone. If
> > > > it's truly expensive to merge them, then it warrants the additional
> > > > complexity. But I don't understand the desire to share a design for
> > > > two systems with sufficiently different constraints.
> > > > 
> > > > > Upsides?
> > > > > 
> > > > > 1) slab utilization might increase a little bit (but I doubt it will have
> > > > >    a huge effect, because both merging sets should be relatively big and well
> > > > >    utilized)
> > > > 
> > > > Right.
> > > > 
> > > > > 2) eliminate memcg kmem_cache dynamic creation/destruction. it's nice,
> > > > >    but there isn't so much code left anyway.
> > > > 
> > > > There is a lot of complexity associated with the cache cloning that
> > > > isn't the lines of code, but the lifetime and synchronization rules.
> > > 
> > > Quite opposite: the patchset removes all the complexity (or 90% of it),
> > > because it makes the kmem_cache lifetime independent from any cgroup stuff.
> > > 
> > > Kmem_caches are created on demand on the first request (most likely during
> > > the system start-up), and destroyed together with their root counterparts
> > > (most likely never or on rmmod). First request means globally first request,
> > > not a first request from a given memcg.
> > > 
> > > Memcg kmem_cache lifecycle has nothing to do with memory/obj_cgroups, and
> > > after creation just matches the lifetime of the root kmem caches.
> > > 
> > > The only reason to keep the async creation is that some kmem_caches
> > > are created very early in the boot process, long before any cgroup
> > > stuff is initialized.
> > 
> > Yes, it's independent of the obj_cgroup and memcg, and yes it's
> > simpler after your patches. But I'm not talking about the delta, I'm
> > trying to understand the end result.
> > 
> > And the truth is there is a decent chunk of code and tentacles spread
> > throughout the slab/cgroup code to clone, destroy, and handle the
> > split caches, as well as the branches/indirections on every cgrouped
> > slab allocation.
> 
> Did you see the final code? It's fairly simple and there is really not
> much of complexity left. If you don't think so, let's go into details,
> because otherwise it's hard to say anything.

I have the patches applied to a local tree and am looking at the final
code. But I can only repeat that "it's not too bad" simply isn't a
good explanation for why the code is the way it is.

> With a such change which basically removes the current implementation
> and replaces it with a new one, it's hard to keep the balance between
> making commits self-contained and small, but also showing the whole picture.
> I'm fully open to questions and generally want to make it simpler.
> 
> I've tried to separate some parts and get them merged before the main
> thing, but they haven't been merged yet, so I have to include them
> to keep the thing building.
> 
> Will a more-detailed design in the cover help?
> Will writing a design doc to put into Documentation/ help?
> Is it better to rearrange patches in a way to eliminate the current
> implementation first and build from scratch?

It would help to have changelogs that actually describe how the new
design is supposed to work, and why you made the decisions you made.

The changelog in this patch here sells the change as a reduction in
complexity, without explaining why it stopped where it stopped. So
naturally, if that's the declared goal, the first question is whether
we can make it simpler.

Both the cover letter and the changelogs should focus less on what was
there and how it was deleted, and more on how the code is supposed to
work after the patches. How the components were designed and how they
all work together.

As I said before, imagine somebody without any historical knowledge
reading the code. They should be able to find out why you chose to
have two sets of kmem caches. There is no explanation for it other
than "there used to be more, so we cut it down to two".

> > > > And these two things are the primary aspects that make my head hurt
> > > > trying to review this patch series.
> > > > 
> > > > > So IMO it's an interesting direction to explore, but not something
> > > > > that necessarily has to be done in the context of this patchset.
> > > > 
> > > > I disagree. Instead of replacing the old coherent model and its
> > > > complexities with a new coherent one, you are mixing the two. And I
> > > > can barely understand the end result.
> > > > 
> > > > Dynamically cloning entire slab caches for the sole purpose of telling
> > > > whether the pages have an obj_cgroup array or not is *completely
> > > > insane*. If the controller had followed the obj_cgroup design from the
> > > > start, nobody would have ever thought about doing it like this.
> > > 
> > > It's just not true. The whole point of having root- and memcg sets is
> > > to be able to not look for a NULL pointer in the obj_cgroup vector on
> > > releasing of the root object. In other words, it allows to keep zero
> > > overhead for root allocations. IMHO it's an important thing, and calling
> > > it *completely insane* isn't the best way to communicate.
> > 
> > But you're trading it for the indirection of going through a separate
> > kmem_cache for every single cgroup-accounted allocation. Why is this a
> > preferable trade-off to make?
> 
> Because it allows to keep zero memory and cpu overhead for root allocations.
> I've no data showing that this overhead is small and acceptable in all cases.
> I think keeping zero overhead for root allocations is more important
> than having a single set of kmem caches.

In the kmem cache breakdown you provided above, there are 35887 pages
allocated to root caches and 37300 pages allocated to cgroup caches.

Why are root allocations supposed to be more important? Aren't some of
the hottest allocations tracked by cgroups? Look at fork():

>       vm_area_struct         48        810
>            mm_struct         19         29
>          files_cache         14         26
>         signal_cache         28        143
>        sighand_cache         45         47
>          task_struct         77        430
>             cred_jar         29        424
>       anon_vma_chain         39        492
>             anon_vma         28        467
>                  pid         30        369

Hard to think of much hotter allocations. They all have to suffer the
additional branch and cache footprint of the auxiliary cgroup caches.

> > > I agree that it's an arguable question if we can tolerate some
> > > additional overhead on root allocations to eliminate these additional
> > > 10%, but I really don't think it's so obvious that even discussing
> > > it is insane.
> > 
> > Well that's exactly my point.
> 
> Ok, what's the acceptable performance penalty?
> Is adding 20% on free path is acceptable, for example?
> Or adding 3% of slab memory?

I find offhand replies like these very jarring.

There is a legitimate design question: Why are you using a separate
set of kmem caches for the cgroup allocations, citing the additional
complexity over having one set? And your reply was mostly handwaving.

So: what's the overhead you're saving by having two sets? What is this
additional stuff buying us?

Pretend the split-cache infra hadn't been there. Would you have added
it? If so, based on what data? Now obviously, you didn't write it - it
was there because that's the way the per-cgroup accounting was done
previously. But you did choose to keep it. And it's a fair question
what (quantifiable) role it plays in your new way of doing things.

> > > Btw, there is another good idea to explore (also suggested by Christopher
> > > Lameter): we can put memcg/objcg pointer into the slab page, avoiding
> > > an extra allocation.
> > 
> > I agree with this idea, but I do think that's a bit more obviously in
> > optimization territory. The objcg is much larger than a pointer to it,
> > and it wouldn't significantly change the alloc/free sequence, right?
> 
> So the idea is that putting the obj_cgroup pointer nearby will eliminate
> some cache misses. But then it's preferable to have two sets, because otherwise
> there is a memory overhead from allocating an extra space for the objcg pointer.

This trade-off is based on two assumptions:

1) Unaccounted allocations are more performance sensitive than
accounted allocations.

2) Fragmented obj_cgroup arrays waste more memory than fragmented
slabs.

You haven't sufficiently shown that either of those are true. (And I
suspect they are both false.)

So my stance is that until you make a more convincing argument for
this, a simpler concept and implementation, as well as balanced CPU
cost for unaccounted and accounted allocations, wins out.

> Stepping a bit back: the new scheme (new slab controller) adds some cpu operations
> on the allocation and release paths. It's unavoidable: more precise
> accounting requires more CPU. But IMO it's worth it because it leads
> to significant memory savings and reduced memory fragmentation.
> Also it reduces the code complexity (which is a bonus but not the primary goal).
> 
> I haven't seen so far any workloads where the difference was noticeable,
> but it doesn't mean they do not exist. That's why I'm very concerned about
> any suggestions which might even in theory increase the cpu overhead.
> Keeping it at zero level for root allocations allows do exclude
> something from the accounting if the performance penalty is not tolerable.

That sounds like a false trade-off to me. We account memory for
functional correctness - consumers that are big enough to
fundamentally alter the picture of cgroup memory footprints, allow
users to disturb other containers, or even cause host-level OOM
situations. Not based on whether they are cheap to track.

In fact, I would make the counter argument. It'd be pretty bad if
everytime we had to make an accounting change to maintain functional
correctness we'd have to worry about a CPU regression that exists in
part because we're trying to keep unaccounted allocations cheaper.
