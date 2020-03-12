Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E6DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E79206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hm6Gv9l1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgCLN54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:57:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22824 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727007AbgCLN5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584021474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zN4QMURyGwKx3cAee714OPFc7P9COefkkQIboHHsPiY=;
        b=hm6Gv9l1pi08A0UDjESPx7HeMIZimNrTDTOGWuKcT3W7wnKbSP0VyysV1gR+uI61PAymfD
        DpdawGkUdEEG2M/kxz/2RuZikjkhc7JMXhtQ2K+D04b+1Fxof0mtdkKjFOjB1lu5eYD8qv
        ySKok9pOL0wQkSaQnOI73kIPGXiAV10=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-pecU54h9PLqZM_2sUAaOxg-1; Thu, 12 Mar 2020 09:57:52 -0400
X-MC-Unique: pecU54h9PLqZM_2sUAaOxg-1
Received: by mail-ed1-f71.google.com with SMTP id p21so4835861edr.22
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 06:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zN4QMURyGwKx3cAee714OPFc7P9COefkkQIboHHsPiY=;
        b=LS2liYo9w+py7NbNsxN4OdRsOuBM0FxuGbrfHRG6j3ccmIBQ/ZvwWr/Bdhb6AqdCIo
         oDGhU855fiG9rW6MrPwiA0cmnvJ7Bfe0/5mWS9rbd5JSOytQckpEu9rp/Z0glbECwFUo
         kCNXsSughXl6/tZGw5JZ3N4/jvMWEKWZQZwMO7H5plY/1VIRGV+3vQbj8bqY5KK1cBcA
         c0L6s/k1tK+gAobA2JF9pwA0Z1fjGSHfoQdgVinPDTMSoWpC+iho2npaVVcO7R6eZ/C5
         36yoNoYOOCIqXOtsZRXhDIPUnbhVrHKjjarCiJhw6rO2diWQBAzEaLkBQsUZT2CegsZO
         EWfQ==
X-Gm-Message-State: ANhLgQ1A7+cSZ6WpAqsRfvKKTXZ9UzbwYujhc0EynLyS3Xu6+Htygw47
        0JzLqbWafCKPeQB/dvSuegtWrmDxfka6LQGNfP7hTevO2CRFr1mBUjxqjlLATBzxyfwDbWukFh3
        x7mXOX1ZX1ucAhE/6yBBFkA1ETDkdnpvYpbJ0swMN
X-Received: by 2002:a17:906:5612:: with SMTP id f18mr6523581ejq.69.1584021471326;
        Thu, 12 Mar 2020 06:57:51 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsUtkqlkRV/GlGhEeYx9r/TPkyiRvoHliJiGVUd6Iiw+RSeU1vRnD18gxm/fh7ts3d837ziKCzb6VyrqOkaKx8=
X-Received: by 2002:a17:906:5612:: with SMTP id f18mr6523556ejq.69.1584021470975;
 Thu, 12 Mar 2020 06:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200312135457.6891749e@canb.auug.org.au> <CAGnkfhztbmpP0=KT-iNbkUGKerhX04ENFsexA4_2cP_RUs0Png@mail.gmail.com>
 <baefdc44-d7cb-4e9e-c46c-b37012cfc40d@kernel.dk>
In-Reply-To: <baefdc44-d7cb-4e9e-c46c-b37012cfc40d@kernel.dk>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Thu, 12 Mar 2020 14:57:14 +0100
Message-ID: <CAGnkfhwJR0CTy51o5F_YjgXCn7RK7=X1PcNbjhT-Xpw5zg3REg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the block tree
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Coly Li <colyli@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 2:07 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 3/12/20 4:12 AM, Matteo Croce wrote:
> > On Thu, Mar 12, 2020 at 3:55 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >>
> >> Hi all,
> >>
> >> After merging the block tree, today's linux-next build (x86_64
> >> allmodconfig) failed like this:
> >>
> >> In file included from fs/erofs/xattr.h:10,
> >>                  from fs/erofs/inode.c:7:
> >> fs/erofs/inode.c: In function 'erofs_read_inode':
> >> fs/erofs/internal.h:197:31: error: 'PAGE_SECTORS_SHIFT' undeclared (first use in this function); did you mean 'PA_SECTION_SHIFT'?
> >>   197 | #define LOG_SECTORS_PER_BLOCK PAGE_SECTORS_SHIFT
> >>       |                               ^~~~~~~~~~~~~~~~~~
> >> fs/erofs/inode.c:122:30: note: in expansion of macro 'LOG_SECTORS_PER_BLOCK'
> >>   122 |   inode->i_blocks = nblks << LOG_SECTORS_PER_BLOCK;
> >>       |                              ^~~~~~~~~~~~~~~~~~~~~
> >> fs/erofs/internal.h:197:31: note: each undeclared identifier is reported only once for each function it appears in
> >>   197 | #define LOG_SECTORS_PER_BLOCK PAGE_SECTORS_SHIFT
> >>       |                               ^~~~~~~~~~~~~~~~~~
> >> fs/erofs/inode.c:122:30: note: in expansion of macro 'LOG_SECTORS_PER_BLOCK'
> >>   122 |   inode->i_blocks = nblks << LOG_SECTORS_PER_BLOCK;
> >>       |                              ^~~~~~~~~~~~~~~~~~~~~
> >> In file included from fs/erofs/data.c:7:
> >> fs/erofs/data.c: In function 'erofs_read_raw_page':
> >> fs/erofs/internal.h:197:31: error: 'PAGE_SECTORS_SHIFT' undeclared (first use in this function); did you mean 'PA_SECTION_SHIFT'?
> >>   197 | #define LOG_SECTORS_PER_BLOCK PAGE_SECTORS_SHIFT
> >>       |                               ^~~~~~~~~~~~~~~~~~
> >> fs/erofs/data.c:226:4: note: in expansion of macro 'LOG_SECTORS_PER_BLOCK'
> >>   226 |    LOG_SECTORS_PER_BLOCK;
> >>       |    ^~~~~~~~~~~~~~~~~~~~~
> >> fs/erofs/internal.h:197:31: note: each undeclared identifier is reported only once for each function it appears in
> >>   197 | #define LOG_SECTORS_PER_BLOCK PAGE_SECTORS_SHIFT
> >>       |                               ^~~~~~~~~~~~~~~~~~
> >> fs/erofs/data.c:226:4: note: in expansion of macro 'LOG_SECTORS_PER_BLOCK'
> >>   226 |    LOG_SECTORS_PER_BLOCK;
> >>       |    ^~~~~~~~~~~~~~~~~~~~~
> >> fs/erofs/data.c: In function 'erofs_bmap':
> >> fs/erofs/internal.h:197:31: error: 'PAGE_SECTORS_SHIFT' undeclared (first use in this function); did you mean 'PA_SECTION_SHIFT'?
> >>   197 | #define LOG_SECTORS_PER_BLOCK PAGE_SECTORS_SHIFT
> >>       |                               ^~~~~~~~~~~~~~~~~~
> >> fs/erofs/data.c:351:16: note: in expansion of macro 'LOG_SECTORS_PER_BLOCK'
> >>   351 |   if (block >> LOG_SECTORS_PER_BLOCK >= blks)
> >>       |                ^~~~~~~~~~~~~~~~~~~~~
> >>
> >> Caused by commit
> >>
> >>   61c7d3d5e015 ("block: refactor duplicated macros")
> >>
> >> I have used the block tree from next-20200311 for today.
> >>
> >> --
> >> Cheers,
> >> Stephen Rothwell
> >
> > Hi,
> >
> > I was building a kernel without erofs. Just including
> > include/linux/blkdev.h will fix it, should I amend the
> > patch or send a fix?
>
> I'll drop the patch. I was worried about the patch to begin with,
> something like this really should be done through cocinelle so there's
> less concern of a stupid mistake.
>
> On top of that, somewhat miffed that you'd have a v3 of a patch, yet
> haven't bothered to even _compile_ the parts you touch. That's
> inexcusable.
>
> --
> Jens Axboe
>

I apologize, I was using a config with all in it but erofs, which was
moved from staging in 5.4:

$ grep -e BRD -e ZRAM -e DAX -e MD_RAID -e SDHCI= -e EXT2 -e SWAP -e
DM_RAID -e EROFS .config
CONFIG_SWAP=y
# CONFIG_MEMCG_SWAP is not set
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
# CONFIG_FRONTSWAP is not set
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=y
CONFIG_MD_RAID456=y
CONFIG_DM_RAID=y
CONFIG_MMC_SDHCI=y
CONFIG_DAX=y
CONFIG_DEV_DAX=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_FS_DAX is not set
# CONFIG_EROFS_FS is not set

I'm running coccinelle with this change appended, and also an all allyesconfig

--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -16,6 +16,7 @@
 #include <linux/magic.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/blkdev.h>
 #include "erofs_fs.h"

Regards,
-- 
Matteo Croce
per aspera ad upstream

