Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1927C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 05:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C12F1207F7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 05:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFEFJ0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 01:09:26 -0400
Received: from smtp180.sjtu.edu.cn ([202.120.2.180]:42920 "EHLO
        smtp180.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFEFJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 01:09:26 -0400
Received: from proxy01.sjtu.edu.cn (smtp185.sjtu.edu.cn [202.120.2.185])
        by smtp180.sjtu.edu.cn (Postfix) with ESMTPS id 7E3DA1008CA2F;
        Fri,  5 Jun 2020 13:09:22 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by proxy01.sjtu.edu.cn (Postfix) with ESMTP id 6F64220426A48;
        Fri,  5 Jun 2020 13:09:22 +0800 (CST)
X-Virus-Scanned: amavisd-new at proxy01.sjtu.edu.cn
Received: from proxy01.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy01.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dMvMIeiIXkov; Fri,  5 Jun 2020 13:09:22 +0800 (CST)
Received: from fans-air.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
        (Authenticated sender: Fan_Yang@sjtu.edu.cn)
        by proxy01.sjtu.edu.cn (Postfix) with ESMTPSA id 80AD220426998;
        Fri,  5 Jun 2020 13:09:15 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3] mm: Fix mremap not considering huge pmd devmap
From:   Fan Yang <Fan_Yang@sjtu.edu.cn>
In-Reply-To: <1591295025-1080-1-git-send-email-akaher@vmware.com>
Date:   Fri, 5 Jun 2020 13:09:15 +0800
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        gregkh@linuxfoundation.org, srivatsab@vmware.com,
        srivatsa@csail.mit.edu
Content-Transfer-Encoding: 8BIT
Message-Id: <B9824572-C3C0-4D3B-88B8-D3A34D645653@sjtu.edu.cn>
References: <FB4049FE-AC4A-4B13-B39D-B96393EFCCB8@sjtu.edu.cn>
 <1591295025-1080-1-git-send-email-akaher@vmware.com>
To:     Ajay Kaher <akaher@vmware.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ajay,

> On Jun 5, 2020 at 02:23，Ajay Kaher <akaher@vmware.com> wrote：
> 
> So, v4.9.y should be vulnerable, however not able to reproduce on v4.9.y.
> Does any specific scenerio need to test for v4.9.y?
> 
> For v4.9, modified test program as MAP_SHARED_VALIDATE is not available:
> - return mmap(NULL, REGION_PM_SIZE, PROT, MAP_SHARED_VALIDATE|MAP_SYNC,
> + return mmap(NULL, REGION_PM_SIZE, PROT, MAP_SHARED|MAP_SYNC,
> 
> Let me know if I need to test some other way for v4.9.y.
> 

I further looked into this.  In v4.9, fsdax (mount a dax file
system, then open, mmap, mremap) does not suffer this issue
because fsdax does not use huge page (FS_DAX_PMD is marked
BROKEN).

fs/dax.c:dax_pmd_fault:

        if (!IS_ENABLED(CONFIG_FS_DAX_PMD))
                return VM_FAULT_FALLBACK;

fs/Kconfig:

config FS_DAX_PMD
        bool
        default FS_DAX
        depends on FS_DAX
        depends on ZONE_DEVICE
        depends on TRANSPARENT_HUGEPAGE
        depends on BROKEN


However, I can re-produce the issue for the devdax mode.  Here is how
I re-produce it:

1. It seems some interface changed for ndctl.  So I use an old
   commit (4295f1ea614a26e1304ed590fb7209c8c78270ab) in the repo
   https://github.com/pmem/ndctl.
2. sudo ./ndctl/ndctl create-namespace -f -t pmem -m dax -e 'namespace0.0'
3. then use the following program:

#define _GNU_SOURCE
#include <sys/mman.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <stdlib.h>
#include <errno.h>

#define PROT                    PROT_READ|PROT_WRITE

#define REGION_PM_TMP_PATH      "/dev/dax0.0"

#define REGION_MEM_SIZE 1024ULL*1024*1024*2
#define REGION_PM_SIZE  1024ULL*1024*1024*4
#define REMAP_MEM_OFF   1024ULL*1024*1024*1
#define REMAP_PM_OFF    1024ULL*1024*1024*3
#define REMAP_SIZE      1024ULL*1024*1024*1

#define REGION_MEM_PTR  ((void *)0x7fd400000000ULL)
#define REGION_PM_PTR   ((void *)0x4fd300000000ULL)

char * map_tmp_pm_region(void)
{
        int fd;

        fd = open(REGION_PM_TMP_PATH, O_RDWR, 0644);
        if (fd < 0) {
                perror(REGION_PM_TMP_PATH);
                exit(-1);
        }

        return mmap(REGION_PM_PTR, REGION_PM_SIZE, PROT, MAP_SHARED|MAP_SYNC,
                   fd, 0);
}

int main(int argc, char **argv)
{
        char *regm, *regp, *remap;
        int ret;

        regm = mmap(REGION_MEM_PTR, REGION_MEM_SIZE, PROT, MAP_PRIVATE|MAP_ANONYMOUS,
                    -1, 0);
        if (regm == MAP_FAILED) {
                perror("regm");
                return -1;
        }

        regp = map_tmp_pm_region();
        if (regp == MAP_FAILED) {
                perror("regp");
                return -1;
        }

        memset(regm, 'a', REGION_MEM_SIZE);
        memset(regp, 'i', REGION_PM_SIZE);

        remap = mremap(regp + REMAP_PM_OFF, REMAP_SIZE, REMAP_SIZE,
                       MREMAP_MAYMOVE|MREMAP_FIXED, regm + REMAP_MEM_OFF);
        if (remap != regm + REMAP_MEM_OFF) {
                perror("mremap");
                return -1;
        }

        *(regm + REMAP_MEM_OFF) = 0x00;
        return 0;
}

4. Then I was able to see the "Corrupted page table" message in dmesg.

Best regards,
Fan

