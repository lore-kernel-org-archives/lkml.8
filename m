Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E778C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A29206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="fKVGsSJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbgCPMcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:32:21 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:57070 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730959AbgCPMcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:32:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id DA5B43F58C;
        Mon, 16 Mar 2020 13:32:17 +0100 (CET)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="fKVGsSJ4";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0fZSjgeWs2My; Mon, 16 Mar 2020 13:32:16 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 4CBFA3F57C;
        Mon, 16 Mar 2020 13:32:09 +0100 (CET)
Received: from linlap1.host.shipmail.org (unknown [94.191.152.149])
        by mail1.shipmail.org (Postfix) with ESMTPSA id E1CAE36044C;
        Mon, 16 Mar 2020 13:32:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1584361929; bh=Q0mPn8cn4O4F32gfQXBKeCHhXjCZbWpQMUUrzHQpRXs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fKVGsSJ44ckNJZyG5zVRIZps2Jj6tpleF6qPCpDgqppNwatVwrlF7IsNNdgaXB9V9
         or14c5W0A4QJb6bKH5VrVlWWItm4ITgXjiyyx/uY8MKV5/iBgU+oI+DWErKw4h3Vwq
         b0v7L84nhM9Lmt5tunNUjUFt8i7G1kvM3+L9Yd3o=
Subject: Ack to merge through DRM? WAS [PATCH v6 0/9] Huge page-table entries
 for TTM
To:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, pv-drivers@vmware.com,
        Dan Williams <dan.j.williams@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        linux-graphics-maintainer@vmware.com,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200304102840.2801-1-thomas_os@shipmail.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <9eb1acd3-cded-65f0-ed75-10173dc3a41c@shipmail.org>
Date:   Mon, 16 Mar 2020 13:32:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200304102840.2801-1-thomas_os@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/20 11:28 AM, Thomas Hellström (VMware) wrote:
> In order to reduce CPU usage [1] and in theory TLB misses this patchset enables
> huge- and giant page-table entries for TTM and TTM-enabled graphics drivers.
>
> Patch 1 and 2 introduce a vma_is_special_huge() function to make the mm code
> take the same path as DAX when splitting huge- and giant page table entries,
> (which currently means zapping the page-table entry and rely on re-faulting).
>
> Patch 3 makes the mm code split existing huge page-table entries
> on huge_fault fallbacks. Typically on COW or on buffer-objects that want
> write-notify. COW and write-notification is always done on the lowest
> page-table level. See the patch log message for additional considerations.
>
> Patch 4 introduces functions to allow the graphics drivers to manipulate
> the caching- and encryption flags of huge page-table entries without ugly
> hacks.
>
> Patch 5 implements the huge_fault handler in TTM.
> This enables huge page-table entries, provided that the kernel is configured
> to support transhuge pages, either by default or using madvise().
> However, they are unlikely to be inserted unless the kernel buffer object
> pfns and user-space addresses align perfectly. There are various options
> here, but since buffer objects that reside in system pages typically start
> at huge page boundaries if they are backed by huge pages, we try to enforce
> buffer object starting pfns and user-space addresses to be huge page-size
> aligned if their size exceeds a huge page-size. If pud-size transhuge
> ("giant") pages are enabled by the arch, the same holds for those.
>
> Patch 6 implements a specialized huge_fault handler for vmwgfx.
> The vmwgfx driver may perform dirty-tracking and needs some special code
> to handle that correctly.
>
> Patch 7 implements a drm helper to align user-space addresses according
> to the above scheme, if possible.
>
> Patch 8 implements a TTM range manager for vmwgfx that does the same for
> graphics IO memory. This may later be reused by other graphics drivers
> if necessary.
>
> Patch 9 finally hooks up the helpers of patch 7 and 8 to the vmwgfx driver.
> A similar change is needed for graphics drivers that want a reasonable
> likelyhood of actually using huge page-table entries.
>
> If a buffer object size is not huge-page or giant-page aligned,
> its size will NOT be inflated by this patchset. This means that the buffer
> object tail will use smaller size page-table entries and thus no memory
> overhead occurs. Drivers that want to pay the memory overhead price need to
> implement their own scheme to inflate buffer-object sizes.
>
> PMD size huge page-table-entries have been tested with vmwgfx and found to
> work well both with system memory backed and IO memory backed buffer objects.
>
> PUD size giant page-table-entries have seen limited (fault and COW) testing
> using a modified kernel (to support 1GB page allocations) and a fake vmwgfx
> TTM memory type. The vmwgfx driver does otherwise not support 1GB-size IO
> memory resources.
>
> Comments and suggestions welcome.
> Thomas
>
> Changes since RFC:
> * Check for buffer objects present in contigous IO Memory (Christian König)
> * Rebased on the vmwgfx emulated coherent memory functionality. That rebase
>    adds patch 5.
> Changes since v1:
> * Make the new TTM range manager vmwgfx-specific. (Christian König)
> * Minor fixes for configs that don't support or only partially support
>    transhuge pages.
> Changes since v2:
> * Minor coding style and doc fixes in patch 5/9 (Christian König)
> * Patch 5/9 doesn't touch mm. Remove from the patch title.
> Changes since v3:
> * Added reviews and acks
> * Implemented ugly but generic ttm_pgprot_is_wrprotecting() instead of arch
>    specific code.
> Changes since v4:
> * Added timings (Andrew Morton)
> * Updated function documentation (Andrew Morton)
> Changes since v6:
> * Fix drm build error with !CONFIG_MMU
>
> [1]
> The below test program generates the following gnu time output when run on a
> vmwgfx-enabled kernel without the patch series:
>
> 4.78user 6.02system 0:10.91elapsed 99%CPU (0avgtext+0avgdata 1624maxresident)k
> 0inputs+0outputs (0major+640077minor)pagefaults 0swaps
>
> and with the patch series:
>
> 1.71user 3.60system 0:05.40elapsed 98%CPU (0avgtext+0avgdata 1656maxresident)k
> 0inputs+0outputs (0major+20079minor)pagefaults 0swaps
>
> A consistent number of reduced graphics page-faults can be seen with normal
> graphics applications, but due to the aggressive buffer object caching in
> vmwgfx user-space drivers the CPU time reduction is within the error marginal.
>
> #include <unistd.h>
> #include <string.h>
> #include <sys/mman.h>
> #include <xf86drm.h>
>
> static void checkerr(int ret, const char *name)
> {
>    if (ret < 0) {
>      perror(name);
>      exit(-1);
>    }
> }
>
> int main(int agc, const char *argv[])
> {
>      struct drm_mode_create_dumb c_arg = {0};
>      struct drm_mode_map_dumb m_arg = {0};
>      struct drm_mode_destroy_dumb d_arg = {0};
>      int ret, i, fd;
>      void *map;
>
>      fd = open("/dev/dri/card0", O_RDWR);
>      checkerr(fd, argv[0]);
>
>      for (i = 0; i < 10000; ++i) {
>        c_arg.bpp = 32;
>        c_arg.width = 1024;
>        c_arg.height = 1024;
>        ret = drmIoctl(fd, DRM_IOCTL_MODE_CREATE_DUMB, &c_arg);
>        checkerr(fd, argv[0]);
>
>        m_arg.handle = c_arg.handle;
>        ret = drmIoctl(fd, DRM_IOCTL_MODE_MAP_DUMB, &m_arg);
>        checkerr(fd, argv[0]);
>        
>        map = mmap(NULL, c_arg.size, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
> 	       m_arg.offset);
>        checkerr(map == MAP_FAILED ? -1 : 0, argv[0]);
>
>        (void) madvise((void *) map, c_arg.size, MADV_HUGEPAGE);
>        memset(map, 0x67, c_arg.size);
>        munmap(map, c_arg.size);
>
>        d_arg.handle = c_arg.handle;
>        ret = drmIoctl(fd, DRM_IOCTL_MODE_DESTROY_DUMB, &d_arg);
>        checkerr(ret, argv[0]);
>      }
>      
>      close(fd);
> }
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

Andrew, would it be possible to have an ack for merge using a DRM tree 
for the -mm patches?

Thanks,

Thomas



