Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922A6C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 23:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0EC2071B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 23:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePT3ybQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgCJXTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 19:19:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42655 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726402AbgCJXTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 19:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583882342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z5sLqw2q00TFWFE2+/xEamSW6/qGE1IWWYINTtiDzeQ=;
        b=ePT3ybQq7KlGmqxO6iw8fnPh7diSygkqL+zDJkDzSfoSPeRrt0z1uZYL9GJmmcxMWAgUIJ
        bupMJEySk8dAf3qr+64zujsrYvGLpXGQ9rp6XYpGlIe8jtiYzdF5PjXzbscA/f6zq/oXu9
        TuBg8tgx7poj6sxgV2q6pz6Ffz1K80w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-d5Mcj0jsPY6nLI6SLsnx4A-1; Tue, 10 Mar 2020 19:18:58 -0400
X-MC-Unique: d5Mcj0jsPY6nLI6SLsnx4A-1
Received: by mail-ed1-f69.google.com with SMTP id y35so196404ede.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 16:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z5sLqw2q00TFWFE2+/xEamSW6/qGE1IWWYINTtiDzeQ=;
        b=gm/UUwTjllxqKE9Y+UMdxIbDfwIb7rM+EfVnI7yAb44dW0K1VpeTkSgbCCfuq5NDjC
         Af9rJH0ghKhNdhV2Se9siD4/rd7iWxWKer9c/TW9QQiH3/2XUjNyLpnps50PbRx5oK6W
         tEmdkk0oYmkUQ5OIgZEd4VC6a4MDtzKjnY3ThmxRIB2l7OJt1XptY3j+yeiaRLdwChXp
         tjNZrdqBo2dY0w06d0R2IzqNla/aHKi3auxD0C8bmnnpJcAjn0tTKXdufbUOmCN2IFyo
         Se2Xe/B5qfWxVMFsTbsQamhs7sGQzxE5WbEaBdl9SJb48n/IC7gpL+vxM+3HEHtlse7E
         pvzQ==
X-Gm-Message-State: ANhLgQ1F1wqreo4FldhAW/URD+mBbjluBSJuAhbV/N3JwhHBX1znMvKx
        A9c4z3pkBmb+NVCsVJkXQw+y/LjW9jwm/rh3xa6Sv2fOwc0vASf4GqQTXoqYixTaCIh7j+ZigmK
        e+IhLY6H2U9qjDNkhAY9pbnvlKnZzxHPbUnOmoVtL
X-Received: by 2002:a17:907:262a:: with SMTP id aq10mr12415669ejc.377.1583882337422;
        Tue, 10 Mar 2020 16:18:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vstjHqiZOF0xElis+31S7G0gY2aH73JLw/AluJvKeWmdJcJyHfoWoeERc+w0Ht0pyWZgseKXsqtbLAkFkQLxyM=
X-Received: by 2002:a17:907:262a:: with SMTP id aq10mr12415648ejc.377.1583882337100;
 Tue, 10 Mar 2020 16:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200310223516.102758-1-mcroce@redhat.com> <d473061b-688f-f4a6-c0e8-61c22b8a2b10@cloud.ionos.com>
In-Reply-To: <d473061b-688f-f4a6-c0e8-61c22b8a2b10@cloud.ionos.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Wed, 11 Mar 2020 00:18:21 +0100
Message-ID: <CAGnkfhwjXN_T09MsD1e6P95gUqxCbWL7BcOLSy16_QOZsZKbgQ@mail.gmail.com>
Subject: Re: [PATCH v2] block: refactor duplicated macros
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-bcache@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-mmc@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-nfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 12:10 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
>
>
> On 3/10/20 11:35 PM, Matteo Croce wrote:
> > +++ b/drivers/md/raid1.c
> > @@ -2129,7 +2129,7 @@ static void process_checks(struct r1bio *r1_bio)
> >       int vcnt;
> >
> >       /* Fix variable parts of all bios */
> > -     vcnt = (r1_bio->sectors + PAGE_SIZE / 512 - 1) >> (PAGE_SHIFT - 9);
> > +     vcnt = (r1_bio->sectors + PAGE_SECTORS - 1) >> (PAGE_SHIFT - 9);
>
> Maybe replace "PAGE_SHIFT - 9" with "PAGE_SECTORS_SHIFT" too.
>
> Thanks,
> Guoqing
>

Wow, there are a lot of them!

$ git grep -c 'PAGE_SHIFT - 9'
arch/ia64/include/asm/pgtable.h:2
block/blk-settings.c:2
block/partition-generic.c:1
drivers/md/dm-table.c:1
drivers/md/raid1.c:1
drivers/md/raid10.c:1
drivers/md/raid5-cache.c:5
drivers/md/raid5.h:1
drivers/nvme/host/fc.c:1
drivers/nvme/target/loop.c:1
fs/erofs/internal.h:1
fs/ext2/dir.c:1
fs/libfs.c:1
fs/nilfs2/dir.c:1
mm/page_io.c:2
mm/swapfile.c:6

-- 
Matteo Croce
per aspera ad upstream

