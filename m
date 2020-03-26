Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DB2C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FD420714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGlLOWQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgCZJuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 05:50:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:38951 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727729AbgCZJuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585216198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NSdLnkX5cWkW77BXDTK3F4eLxqaTUjnvmwt+R66r9DM=;
        b=bGlLOWQe9EZb3oJzmaeQ0fLrlo6SQ99DGosXW2MH96Q7FAuMNmn/LdwABUHPnz/U4YUqUo
        5jTXUBROOmcngExvXPQ85npuZrJTVxMLsOJxKzvxaWD9xNkAsWuW9MFvYpJ+qcIBcyzM4f
        N4v/RH9DcIhAAevkYB3/7yWz4/y2rq4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-opnybUZLPzO9Oc_VD5bFhg-1; Thu, 26 Mar 2020 05:49:57 -0400
X-MC-Unique: opnybUZLPzO9Oc_VD5bFhg-1
Received: by mail-wr1-f72.google.com with SMTP id d1so2756101wru.15
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 02:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NSdLnkX5cWkW77BXDTK3F4eLxqaTUjnvmwt+R66r9DM=;
        b=j7DU6kYTmNFlf0zwruG1IicH4GZS6S6fTeKQHpN+ItDTqE4amcsnOIrjP/qicXcSoK
         NWWKSRxyoxum3gudxzwmyMqTpm0Cbr91nubZ55+uXA7XkY7rFnsEmYd1rxEEirwLhLwG
         XvQnKTEIVHZ2SB8qPryGKF5ErtA0SlFcUjYW2p0pfsqqMj5ESLj2t+bx9xzZmBWmufvA
         vg27STJaVjpahqzMzT1uO8BDFDW5ahMMgm0kR2BzETbXcdAg2ryignEFF6W9RXvYfoAL
         sM9e4l2eKQomxjSCk7j87Q7Mqa6/JbY9Ig6XNvg+allPCL2hV4LQVuBFVkxGMEDZMSLi
         hTmg==
X-Gm-Message-State: ANhLgQ1ys1nsgAEgoH2eyGf7FAnrg1lm/OTQjag9oH6AlMY8njn7Sfye
        TDAihDZf+Npeh5j37yKDMtQ78s9Xw+EQGq9uV2y92j1FRvCr+GIZVqYnAj9VT4492C91kiUL1Dh
        Lp2/03BN+8JYS4vUa6gVCQGa+
X-Received: by 2002:a05:600c:54d:: with SMTP id k13mr2200275wmc.161.1585216195791;
        Thu, 26 Mar 2020 02:49:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vthiOYCqhaQ4ipeqgslIrJP5TXRiX5GolPTyZ0QmSXOrjZV02Xrn9oHBY26s1ICvZAq9CZzAQ==
X-Received: by 2002:a05:600c:54d:: with SMTP id k13mr2200244wmc.161.1585216195492;
        Thu, 26 Mar 2020 02:49:55 -0700 (PDT)
Received: from redhat.com (bzq-79-182-20-254.red.bezeqint.net. [79.182.20.254])
        by smtp.gmail.com with ESMTPSA id 9sm2667566wmm.6.2020.03.26.02.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 02:49:54 -0700 (PDT)
Date:   Thu, 26 Mar 2020 05:49:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Hui Zhu <teawater@gmail.com>, jasowang@redhat.com,
        akpm@linux-foundation.org, pagupta@redhat.com,
        mojha@codeaurora.org, namit@vmware.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        Hui Zhu <teawaterz@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Message-ID: <20200326054554-mutt-send-email-mst@kernel.org>
References: <20200326031817-mutt-send-email-mst@kernel.org>
 <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 08:54:04AM +0100, David Hildenbrand wrote:
> 
> 
> > Am 26.03.2020 um 08:21 schrieb Michael S. Tsirkin <mst@redhat.com>:
> > 
> > ﻿On Thu, Mar 12, 2020 at 09:51:25AM +0100, David Hildenbrand wrote:
> >>> On 12.03.20 09:47, Michael S. Tsirkin wrote:
> >>> On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand wrote:
> >>>> 2. You are essentially stealing THPs in the guest. So the fastest
> >>>> mapping (THP in guest and host) is gone. The guest won't be able to make
> >>>> use of THP where it previously was able to. I can imagine this implies a
> >>>> performance degradation for some workloads. This needs a proper
> >>>> performance evaluation.
> >>> 
> >>> I think the problem is more with the alloc_pages API.
> >>> That gives you exactly the given order, and if there's
> >>> a larger chunk available, it will split it up.
> >>> 
> >>> But for balloon - I suspect lots of other users,
> >>> we do not want to stress the system but if a large
> >>> chunk is available anyway, then we could handle
> >>> that more optimally by getting it all in one go.
> >>> 
> >>> 
> >>> So if we want to address this, IMHO this calls for a new API.
> >>> Along the lines of
> >>> 
> >>>    struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
> >>>                    unsigned int max_order, unsigned int *order)
> >>> 
> >>> the idea would then be to return at a number of pages in the given
> >>> range.
> >>> 
> >>> What do you think? Want to try implementing that?
> >> 
> >> You can just start with the highest order and decrement the order until
> >> your allocation succeeds using alloc_pages(), which would be enough for
> >> a first version. At least I don't see the immediate need for a new
> >> kernel API.
> > 
> > OK I remember now.  The problem is with reclaim. Unless reclaim is
> > completely disabled, any of these calls can sleep. After it wakes up,
> > we would like to get the larger order that has become available
> > meanwhile.
> > 
> 
> Yes, but that‘s a pure optimization IMHO.
> So I think we should do a trivial implementation first and then see what we gain from a new allocator API. Then we might also be able to justify it using real numbers.
> 

Well how do you propose implement the necessary semantics?
I think we are both agreed that alloc_page_range is more or
less what's necessary anyway - so how would you approximate it
on top of existing APIs?


> > 
> >> -- 
> >> Thanks,
> >> 
> >> David / dhildenb
> > 

