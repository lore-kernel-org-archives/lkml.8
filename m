Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA24C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1ED12074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MejNCIwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgFBTqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBTqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:46:37 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15887C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 12:46:36 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k22so11675989qtm.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cDCbUswdOzWPBxtVOkNTOR8EXwqtruy6d+xYE1G/nrs=;
        b=MejNCIwgWGcd8L2XowGwm3NoBogEtmKYfDuWZoqncV+MARHDUvpzuuHI9oIfOFnoN9
         dxhDF+ZfE6GSaT/0KMRiWYW0kI45FW6Df355Rqa+m5TWa7hDoJm8M7K7wgQBtutzHXiS
         rBy1T40rd4pXrsT7bnff1tVrYHCu3R9x3xXXeIfJJP/cNsh5yyZdOneP1oF26Xw0qjk3
         JSkwyNEpo8k5KkuphfemPhDhMRpY4qdF+UyTE4AIh8UMf4pZ3NJ4lX4p9hrqCAgmILmH
         PTBvt1K9SUIjU9gMAZvkys0PA/VDHMA6wdk/3vtCpQqs14Hs6GbRytOxuG7VtJLq/4CD
         hMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cDCbUswdOzWPBxtVOkNTOR8EXwqtruy6d+xYE1G/nrs=;
        b=ESIbWubp9I17S4ErR4urJg6ympUq5RHnx0D1I3FbXUVc0X54GSU5IGPHJGuhz95r+v
         J8r1/jGw7KN7I12ZY5dd0OliifwPX/AWTXzTlf1djSKdDJoDGld2rrD08aQma+VhwcK8
         uttf5krjAugsUUCgUPM8bS5gSpwr+itV8bK9oCSPg90bYw+Z2+9DtQrjH2jpmFoXyuZI
         nGSD/EQB3NqeIfhEwcyhhmBoYjjfmuKyvDdi5zQr2IGwTISG5cYmWTZfvWBpf7+MAoXw
         S2mJ0KKKjOM6w0Jq4Qb0EkXQSt8JtNlnT7ZCKvdB6aC3c9uW6+uRrSX/LI5pXdvd1rie
         bARA==
X-Gm-Message-State: AOAM532ajV80bkrQ7rLQRkJuvhoV/2Kfglz/fDs8/XKhhebdH47tL/vo
        JNQ0estNgzeBhK2LTcJS5DW2Kw==
X-Google-Smtp-Source: ABdhPJw92gFC8+2YBYL/OOKMyCjSItRlsz1/b9Z/IdkcVVcXUTXpgngzFeDgO6+U+XhQjZjf1zq67Q==
X-Received: by 2002:ac8:6d1b:: with SMTP id o27mr29064704qtt.102.1591127195246;
        Tue, 02 Jun 2020 12:46:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id a1sm2418465qkn.87.2020.06.02.12.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 12:46:34 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jgCrp-000JR5-Qn; Tue, 02 Jun 2020 16:46:33 -0300
Date:   Tue, 2 Jun 2020 16:46:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wang Hai <wanghai38@huawei.com>, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, khlebnikov@yandex-team.ru,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: kobject_init_and_add is easy to misuse
Message-ID: <20200602194633.GC6578@ziepe.ca>
References: <20200602115033.1054-1-wanghai38@huawei.com>
 <20200602121035.GL19604@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602121035.GL19604@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 05:10:35AM -0700, Matthew Wilcox wrote:
> On Tue, Jun 02, 2020 at 07:50:33PM +0800, Wang Hai wrote:
> > syzkaller reports for memory leak when kobject_init_and_add()
> > returns an error in the function sysfs_slab_add() [1]
> > 
> > When this happened, the function kobject_put() is not called for the
> > corresponding kobject, which potentially leads to memory leak.
> > 
> > This patch fixes the issue by calling kobject_put() even if
> > kobject_init_and_add() fails.
> 
> I think this speaks to a deeper problem with kobject_init_and_add()
> to most users.  This same bug appears in the first three users of
> kobject_init_and_add() that I checked --
> arch/ia64/kernel/topology.c
> drivers/firmware/dmi-sysfs.c
> drivers/firmware/efi/esrt.c
> drivers/scsi/iscsi_boot_sysfs.c
> 
> Some do get it right --
> arch/powerpc/kernel/cacheinfo.c
> drivers/gpu/drm/ttm/ttm_bo.c
> drivers/gpu/drm/ttm/ttm_memory.c
> drivers/infiniband/hw/mlx4/sysfs.c
> 
> I'd argue that the current behaviour is wrong, that kobject_init_and_add()
> should call kobject_put() if the add fails.  

There are APIs that auto-free their argument on failure and last times
I checked one, about half the tree had a tricky use-after free bug on
the error path.

> This would need a tree-wide audit.  But somebody needs to do that
> anyway because based on my random sampling, half of the users
> currently get it wrong.

IMHO these functions that hide an 'init' inside (eg the switch from
kfree to refcount in the error unwind) are tricky. The caller must
switch from some kfree goto error unwind to a put goto error unwind,
which is very unnatural and strange.

I think it is better if the init is near the kalloc and the entire
error unwind always uses put. No switching.

Jason
