Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B305C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE5C2067C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PusQ538L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgHSM6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:58:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57069 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728524AbgHSM4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597841785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NikvSouUV0hUDKCqhWTIlZU+t6Vx2BaHoXzoDwd88Bw=;
        b=PusQ538LvdaZdMP5eVcJp93zXbCRNM25POG57TFwoJm4H65tCId+N10kNToYBv8EhL1ppN
        pVfYWUKI2t+sl6ExvGgsG22YncAxbD1oNIPi+pQQi9zJjQyYzT/3bJzLrF7oahYYWOZbj+
        j0gjUnC4lKlpXcu2QODOi6EkVrTQYUU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-zkYSEC6cOfSRXQTkWBXCmw-1; Wed, 19 Aug 2020 08:56:21 -0400
X-MC-Unique: zkYSEC6cOfSRXQTkWBXCmw-1
Received: by mail-pf1-f197.google.com with SMTP id b16so11380908pft.18
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 05:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NikvSouUV0hUDKCqhWTIlZU+t6Vx2BaHoXzoDwd88Bw=;
        b=FqS0sVqmBi/fk6i1dZL79jjsyCJKcMRm/aTu33ysI5u/29s6klDzWTDD21eywsXE2y
         JvMRnuLiHsT6+442QndwgmuqrTwXcyV2cwSrHhzLQYKzK38PjwI+UCd4Sxr8JRxlAphB
         SIwxEVmRXlNdASVNdjqmwmTecNIW5/sMfBYGCTfcn4pahiyj4JUmY2ccIuY3/AOvXkEG
         LsoZViXrNSHgYmvr20T6UqbrJgTHRboKrkJBhC6wLDB1hzxnFJ8+fcrd8FDvnnEumEB9
         yXH1wX0wCBzwc1sx7ccYxVe2RNCRCpJdQvgDBcr8YxrKrvqn7MP6qEDwx/CtFxMlW/kw
         akBQ==
X-Gm-Message-State: AOAM533odW/fQ8UxLsFXPTMyIFd19ANfMDX67u7PbCheoWt3FNvS0gEz
        +IrYWFkDHPZnhZT1V4i6VyEog2C77pL5q7Mvbw2BiPTWhlQu0mTd4gKb7mowUI96y2egHebUXJj
        A3P0pjoPW0YQ7dtIP1kx8IIcS
X-Received: by 2002:a62:d10a:: with SMTP id z10mr19729312pfg.7.1597841780726;
        Wed, 19 Aug 2020 05:56:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKMvJu2W6zuenKGKGyYePa2IlXshPfXmDEyEQ0xqmP3T9rQWDHYkR2+7L1tPr4a/TCVvO07g==
X-Received: by 2002:a62:d10a:: with SMTP id z10mr19729289pfg.7.1597841780387;
        Wed, 19 Aug 2020 05:56:20 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a7sm29385606pfd.194.2020.08.19.05.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 05:56:19 -0700 (PDT)
Date:   Wed, 19 Aug 2020 20:56:08 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     hch@infradead.org, darrick.wong@oracle.com, willy@infradead.org,
        david@fromorbit.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [RFC PATCH V3] iomap: add support to track dirty state of sub
 pages
Message-ID: <20200819125608.GA24051@xiangao.remote.csb>
References: <20200819120542.3780727-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819120542.3780727-1-yukuai3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 08:05:42PM +0800, Yu Kuai wrote:

...

> +static void
> +iomap_iop_set_range_dirty(struct page *page, unsigned int off,
> +		unsigned int len)
> +{
> +	struct iomap_page *iop = to_iomap_page(page);
> +	struct inode *inode = page->mapping->host;
> +	unsigned int first = DIRTY_BITS(off >> inode->i_blkbits);
> +	unsigned int last = DIRTY_BITS((off + len - 1) >> inode->i_blkbits);
> +	unsigned long flags;
> +	unsigned int i;
> +
> +	spin_lock_irqsave(&iop->state_lock, flags);
> +	for (i = first; i <= last; i++)
> +		set_bit(i, iop->state);
> +
> +	if (last >= first)
> +		iomap_set_page_dirty(page);

set_page_dirty() in the atomic context?

> +
> +	spin_unlock_irqrestore(&iop->state_lock, flags);
> +}
> +
> +static void
> +iomap_set_range_dirty(struct page *page, unsigned int off,
> +		unsigned int len)
> +{
> +	if (PageError(page))
> +		return;
> +
> +	if (page_has_private(page))
> +		iomap_iop_set_range_dirty(page, off, len);


I vaguely remembered iomap doesn't always set up PagePrivate.


@@ -705,7 +770,7 @@ __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 	if (unlikely(copied < len && !PageUptodate(page)))
 		return 0;
 	iomap_set_range_uptodate(page, offset_in_page(pos), len);
-	iomap_set_page_dirty(page);
+	iomap_set_range_dirty(page, offset_in_page(pos), len);
 	return copied;
 }

so here could be suspectable, but I might be wrong here since
I just take a quick look.

Thanks,
Gao Xiang

