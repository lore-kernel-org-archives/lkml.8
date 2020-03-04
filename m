Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB346C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D6B2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="babkxzab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387806AbgCDK3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:29:05 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:65509 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgCDK2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:28:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 29BA03FDFF;
        Wed,  4 Mar 2020 11:28:51 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=babkxzab;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xs578MhBmdts; Wed,  4 Mar 2020 11:28:50 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 71ABA3F50E;
        Wed,  4 Mar 2020 11:28:47 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 8FDB836013E;
        Wed,  4 Mar 2020 11:28:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1583317727; bh=aLLdrOzhYN34ZYfCzQU9+iu3iv1ilhvBU7nhR1el+MY=;
        h=From:To:Cc:Subject:Date:From;
        b=babkxzabLbjeKujsBBS4LcyDTyUPhV7Lz/RWPrq/Q2bZKAx23WicH5y2j5yWEDaih
         h5K2uJi7pFWq1Cw3U26d0sp8je1yZRmctWBS/NdQA06ZiK12tIGW+4j9Rvwq/nZvym
         iLeG/2Ec5QeOQ2l/BpVeUJJLj3G6Z6RUzevOueB4=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v6 0/9] Huge page-table entries for TTM
Date:   Wed,  4 Mar 2020 11:28:31 +0100
Message-Id: <20200304102840.2801-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to reduce CPU usage [1] and in theory TLB misses this patchset enables
huge- and giant page-table entries for TTM and TTM-enabled graphics drivers.

Patch 1 and 2 introduce a vma_is_special_huge() function to make the mm code
take the same path as DAX when splitting huge- and giant page table entries,
(which currently means zapping the page-table entry and rely on re-faulting).

Patch 3 makes the mm code split existing huge page-table entries
on huge_fault fallbacks. Typically on COW or on buffer-objects that want
write-notify. COW and write-notification is always done on the lowest
page-table level. See the patch log message for additional considerations.

Patch 4 introduces functions to allow the graphics drivers to manipulate
the caching- and encryption flags of huge page-table entries without ugly
hacks.

Patch 5 implements the huge_fault handler in TTM.
This enables huge page-table entries, provided that the kernel is configured
to support transhuge pages, either by default or using madvise().
However, they are unlikely to be inserted unless the kernel buffer object
pfns and user-space addresses align perfectly. There are various options
here, but since buffer objects that reside in system pages typically start
at huge page boundaries if they are backed by huge pages, we try to enforce
buffer object starting pfns and user-space addresses to be huge page-size
aligned if their size exceeds a huge page-size. If pud-size transhuge
("giant") pages are enabled by the arch, the same holds for those.

Patch 6 implements a specialized huge_fault handler for vmwgfx.
The vmwgfx driver may perform dirty-tracking and needs some special code
to handle that correctly.

Patch 7 implements a drm helper to align user-space addresses according
to the above scheme, if possible.

Patch 8 implements a TTM range manager for vmwgfx that does the same for
graphics IO memory. This may later be reused by other graphics drivers
if necessary.

Patch 9 finally hooks up the helpers of patch 7 and 8 to the vmwgfx driver.
A similar change is needed for graphics drivers that want a reasonable
likelyhood of actually using huge page-table entries.

If a buffer object size is not huge-page or giant-page aligned,
its size will NOT be inflated by this patchset. This means that the buffer
object tail will use smaller size page-table entries and thus no memory
overhead occurs. Drivers that want to pay the memory overhead price need to
implement their own scheme to inflate buffer-object sizes.

PMD size huge page-table-entries have been tested with vmwgfx and found to
work well both with system memory backed and IO memory backed buffer objects.

PUD size giant page-table-entries have seen limited (fault and COW) testing
using a modified kernel (to support 1GB page allocations) and a fake vmwgfx
TTM memory type. The vmwgfx driver does otherwise not support 1GB-size IO
memory resources.

Comments and suggestions welcome.
Thomas

Changes since RFC:
* Check for buffer objects present in contigous IO Memory (Christian König)
* Rebased on the vmwgfx emulated coherent memory functionality. That rebase
  adds patch 5.
Changes since v1:
* Make the new TTM range manager vmwgfx-specific. (Christian König)
* Minor fixes for configs that don't support or only partially support
  transhuge pages.
Changes since v2:
* Minor coding style and doc fixes in patch 5/9 (Christian König)
* Patch 5/9 doesn't touch mm. Remove from the patch title.
Changes since v3:
* Added reviews and acks
* Implemented ugly but generic ttm_pgprot_is_wrprotecting() instead of arch
  specific code.
Changes since v4:
* Added timings (Andrew Morton)
* Updated function documentation (Andrew Morton)
Changes since v6:
* Fix drm build error with !CONFIG_MMU

[1]
The below test program generates the following gnu time output when run on a
vmwgfx-enabled kernel without the patch series:

4.78user 6.02system 0:10.91elapsed 99%CPU (0avgtext+0avgdata 1624maxresident)k
0inputs+0outputs (0major+640077minor)pagefaults 0swaps

and with the patch series:

1.71user 3.60system 0:05.40elapsed 98%CPU (0avgtext+0avgdata 1656maxresident)k
0inputs+0outputs (0major+20079minor)pagefaults 0swaps

A consistent number of reduced graphics page-faults can be seen with normal
graphics applications, but due to the aggressive buffer object caching in
vmwgfx user-space drivers the CPU time reduction is within the error marginal.

#include <unistd.h>
#include <string.h>
#include <sys/mman.h>
#include <xf86drm.h>

static void checkerr(int ret, const char *name)
{
  if (ret < 0) {
    perror(name);
    exit(-1);
  }
}

int main(int agc, const char *argv[])
{
    struct drm_mode_create_dumb c_arg = {0};
    struct drm_mode_map_dumb m_arg = {0};
    struct drm_mode_destroy_dumb d_arg = {0};
    int ret, i, fd;
    void *map;

    fd = open("/dev/dri/card0", O_RDWR);
    checkerr(fd, argv[0]);

    for (i = 0; i < 10000; ++i) {
      c_arg.bpp = 32;
      c_arg.width = 1024;
      c_arg.height = 1024;      
      ret = drmIoctl(fd, DRM_IOCTL_MODE_CREATE_DUMB, &c_arg);
      checkerr(fd, argv[0]);

      m_arg.handle = c_arg.handle;
      ret = drmIoctl(fd, DRM_IOCTL_MODE_MAP_DUMB, &m_arg);
      checkerr(fd, argv[0]);
      
      map = mmap(NULL, c_arg.size, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
	       m_arg.offset);
      checkerr(map == MAP_FAILED ? -1 : 0, argv[0]);

      (void) madvise((void *) map, c_arg.size, MADV_HUGEPAGE);
      memset(map, 0x67, c_arg.size);
      munmap(map, c_arg.size);

      d_arg.handle = c_arg.handle;
      ret = drmIoctl(fd, DRM_IOCTL_MODE_DESTROY_DUMB, &d_arg);
      checkerr(ret, argv[0]);
    }
    
    close(fd);
}

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>


