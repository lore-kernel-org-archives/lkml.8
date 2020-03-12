Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88E2C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF3D206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXGd+n5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgCLKNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:13:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43931 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725978AbgCLKNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584008010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ejjCb6q7RFGex98QgUcKFdkFFuRhyJT6HKlrMbk1V7o=;
        b=NXGd+n5FipH+PEq3N9pHJqE9ufgennMjqzYqRvSPUcQcVsAEjMwBh4h2EVxgDwaTr1in6E
        oILGQ5f47lETu7LrHS8fv4O3P8iBOFLbSJtPottSPDLNddAFbu6KvL/26OM4tJRJWs8Dh8
        LqpZ227xH1MiDMZP7zblZE5BVOPjrd8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-8riPDHsBPZ2kGdMZ0nqG3Q-1; Thu, 12 Mar 2020 06:13:28 -0400
X-MC-Unique: 8riPDHsBPZ2kGdMZ0nqG3Q-1
Received: by mail-ed1-f70.google.com with SMTP id ck15so4421482edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 03:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ejjCb6q7RFGex98QgUcKFdkFFuRhyJT6HKlrMbk1V7o=;
        b=fJFfDTYuLHUT8Z47C1oVbXm/Q52pmsHFAtHU6/imUu3vIuGAGfTfbsxpWiyFcieNTO
         kgk6oS72sIUSjh7Mrbk+OA80dXy+RuHYUa84sBgQ+P3M+kBWVE5pYdsIfNfaPJ09XMho
         DwiQ2WPWGGunTD5LhVcXeEllqGTOVhQzY7N3QKvXRlBycm/pTgrf7e2zvNEPa2+ZEOVU
         1fjx5grebefdSR4W8vLwgQ9j5iE9EnWCVLlm/mefGZmVnKpmtOwu35LvUVDnGv02XpJt
         SrrzYOeJieSJQW+ChULJ5V5dQ8bBKphcR1JF1wKH86Kdx3/JevT/wDlnIw7VuRhJQuF0
         ndkA==
X-Gm-Message-State: ANhLgQ32y8JioTSwDK566PnptFpe60OzNEgdEjF9ttLDHkC5qMVWsXqY
        RzdF3zeKSKhRBiMlTCn/JpjeAAkC1L7NToScsz7+SqmGj8eCG1F7eeAGdZ8b0ZGrj7vDtRWdrxF
        GcLx220m/6VTEAN0JqRX2Z1gaGGIpvBX5OI+5XKUW
X-Received: by 2002:a17:906:52c9:: with SMTP id w9mr6171796ejn.70.1584008007539;
        Thu, 12 Mar 2020 03:13:27 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvpEEsl+KDmI2d5YoafqKJXuS1jFr+++rr3fY/v2Mogk34K+lvAjJl+ymSHsNqgBDuc+bVz8D/6j6haGwk/nZA=
X-Received: by 2002:a17:906:52c9:: with SMTP id w9mr6171780ejn.70.1584008007278;
 Thu, 12 Mar 2020 03:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200312135457.6891749e@canb.auug.org.au>
In-Reply-To: <20200312135457.6891749e@canb.auug.org.au>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Thu, 12 Mar 2020 11:12:51 +0100
Message-ID: <CAGnkfhztbmpP0=KT-iNbkUGKerhX04ENFsexA4_2cP_RUs0Png@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Coly Li <colyli@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 3:55 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the block tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> In file included from fs/erofs/xattr.h:10,
>                  from fs/erofs/inode.c:7:
> fs/erofs/inode.c: In function 'erofs_read_inode':
> fs/erofs/internal.h:197:31: error: 'PAGE_SECTORS_SHIFT' undeclared (first use in this function); did you mean 'PA_SECTION_SHIFT'?
>   197 | #define LOG_SECTORS_PER_BLOCK PAGE_SECTORS_SHIFT
>       |                               ^~~~~~~~~~~~~~~~~~
> fs/erofs/inode.c:122:30: note: in expansion of macro 'LOG_SECTORS_PER_BLOCK'
>   122 |   inode->i_blocks = nblks << LOG_SECTORS_PER_BLOCK;
>       |                              ^~~~~~~~~~~~~~~~~~~~~
> fs/erofs/internal.h:197:31: note: each undeclared identifier is reported only once for each function it appears in
>   197 | #define LOG_SECTORS_PER_BLOCK PAGE_SECTORS_SHIFT
>       |                               ^~~~~~~~~~~~~~~~~~
> fs/erofs/inode.c:122:30: note: in expansion of macro 'LOG_SECTORS_PER_BLOCK'
>   122 |   inode->i_blocks = nblks << LOG_SECTORS_PER_BLOCK;
>       |                              ^~~~~~~~~~~~~~~~~~~~~
> In file included from fs/erofs/data.c:7:
> fs/erofs/data.c: In function 'erofs_read_raw_page':
> fs/erofs/internal.h:197:31: error: 'PAGE_SECTORS_SHIFT' undeclared (first use in this function); did you mean 'PA_SECTION_SHIFT'?
>   197 | #define LOG_SECTORS_PER_BLOCK PAGE_SECTORS_SHIFT
>       |                               ^~~~~~~~~~~~~~~~~~
> fs/erofs/data.c:226:4: note: in expansion of macro 'LOG_SECTORS_PER_BLOCK'
>   226 |    LOG_SECTORS_PER_BLOCK;
>       |    ^~~~~~~~~~~~~~~~~~~~~
> fs/erofs/internal.h:197:31: note: each undeclared identifier is reported only once for each function it appears in
>   197 | #define LOG_SECTORS_PER_BLOCK PAGE_SECTORS_SHIFT
>       |                               ^~~~~~~~~~~~~~~~~~
> fs/erofs/data.c:226:4: note: in expansion of macro 'LOG_SECTORS_PER_BLOCK'
>   226 |    LOG_SECTORS_PER_BLOCK;
>       |    ^~~~~~~~~~~~~~~~~~~~~
> fs/erofs/data.c: In function 'erofs_bmap':
> fs/erofs/internal.h:197:31: error: 'PAGE_SECTORS_SHIFT' undeclared (first use in this function); did you mean 'PA_SECTION_SHIFT'?
>   197 | #define LOG_SECTORS_PER_BLOCK PAGE_SECTORS_SHIFT
>       |                               ^~~~~~~~~~~~~~~~~~
> fs/erofs/data.c:351:16: note: in expansion of macro 'LOG_SECTORS_PER_BLOCK'
>   351 |   if (block >> LOG_SECTORS_PER_BLOCK >= blks)
>       |                ^~~~~~~~~~~~~~~~~~~~~
>
> Caused by commit
>
>   61c7d3d5e015 ("block: refactor duplicated macros")
>
> I have used the block tree from next-20200311 for today.
>
> --
> Cheers,
> Stephen Rothwell

Hi,

I was building a kernel without erofs. Just including
include/linux/blkdev.h will fix it, should I amend the
patch or send a fix?

Cheers,


--
Matteo Croce
per aspera ad upstream

