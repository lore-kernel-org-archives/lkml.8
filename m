Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F23FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6986820578
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4M5BGdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgHYOmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:42:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38056 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725893AbgHYOmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598366528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1PxHK07pzXYHK1FypslTBPNlk/QUqT+EnjfLL/+phFE=;
        b=K4M5BGdKZRQzmlt1VXTTstlktQ9uP8dIhLGjOrpySNbLYq0dyiaH9CXEcuBTjEa4GZkZsh
        W71R2ateE/nWhqLKTf56T46WBoE43U6redlemXwTn5gSi2uum4fHDEtXsFHKj/HxCq/e0i
        +dJGn/J1jLB0Mir1PEAYLGIeFnrGKHI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-Al-e6yuoNge5DxynlyBViw-1; Tue, 25 Aug 2020 10:42:06 -0400
X-MC-Unique: Al-e6yuoNge5DxynlyBViw-1
Received: by mail-qv1-f70.google.com with SMTP id j13so8813370qvi.17
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 07:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1PxHK07pzXYHK1FypslTBPNlk/QUqT+EnjfLL/+phFE=;
        b=ADrhQfkUBpF3VkWTYJq1/mUWaOlOEs7kqquZoJ4VT3/L9Hy5IMHJivu3izuqdP5vRt
         qJ6RbIXQJV1M9tFF6StLX/BDudf907hDR48NqCXzBlFirgPLgLWYcUPk8RjuMC+GUiuC
         vwtJLuoMSXDPY3PLDNXn5oSanUZbahtfZJPyx+7uFQCUggM3XXH2FW94okn7VnGZBeNm
         D8VNFlHneoNs7Cn5z/yCS9/uLwgCjU4TLctQa6+gfNKK9bY2nGrtEmc0RdzPoqowlYhL
         awEuAqyiWyFFV887F5kzaXYFSbQRi0M12dP1vgGvR6cYbVexnAtzaLbmAYso/0iGiRsr
         5R/w==
X-Gm-Message-State: AOAM531aIobTudiKsFK8thx8we/SwhNp6GgdzApIPveZ80EMEvQdWDwG
        aKTNGDkP3la0gveYMa/ThrGDlDyrvx9GDw7cvWt9ZH5HUP5hMFYu6i/EKJgbydueBiPJyaUj9j7
        sMYXyuY0+hTinSjIVysVt/Tdc
X-Received: by 2002:a37:4d13:: with SMTP id a19mr7604503qkb.456.1598366525949;
        Tue, 25 Aug 2020 07:42:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6JqBcCZsWXYyvcmaeETW8DHBr1KnBqsO9L4MFzqfTnOnoaLsPJskqCpzvHf6djk6yAKGTSQ==
X-Received: by 2002:a37:4d13:: with SMTP id a19mr7604480qkb.456.1598366525669;
        Tue, 25 Aug 2020 07:42:05 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id q34sm14160230qtk.32.2020.08.25.07.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 07:42:04 -0700 (PDT)
Date:   Tue, 25 Aug 2020 10:42:03 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <alistair@popple.id.au>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/rmap: Fixup copying of soft dirty and uffd ptes
Message-ID: <20200825144203.GA8235@xz-x1>
References: <20200825064232.10023-1-alistair@popple.id.au>
 <20200825064232.10023-2-alistair@popple.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825064232.10023-2-alistair@popple.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 04:42:32PM +1000, Alistair Popple wrote:
> During memory migration a pte is temporarily replaced with a migration
> swap pte. Some pte bits from the existing mapping such as the soft-dirty
> and uffd write-protect bits are preserved by copying these to the
> temporary migration swap pte.
> 
> However these bits are not stored at the same location for swap and
> non-swap ptes. Therefore testing these bits requires using the
> appropriate helper function for the given pte type.
> 
> Unfortunately several code locations were found where the wrong helper
> function is being used to test soft_dirty and uffd_wp bits which leads
> to them getting incorrectly set or cleared during page-migration.
> 
> Fix these by using the correct tests based on pte type.
> 
> Fixes: a5430dda8a3a ("mm/migrate: support un-addressable ZONE_DEVICE page in migration")
> Fixes: 8c3328f1f36a ("mm/migrate: migrate_vma() unmap page from vma while collecting pages")
> Fixes: f45ec5ff16a7 ("userfaultfd: wp: support swap and page migration")
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Cc: stable@vger.kernel.org

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

