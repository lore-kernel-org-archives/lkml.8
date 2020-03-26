Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029B8C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C992620714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/cK0evN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgCZHVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:21:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:32264 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbgCZHVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585207282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4XWknPyKkYAfbqizFNt1Gd0mfkxXVUcGvQWw0e8F7fs=;
        b=C/cK0evNah8jy7t+Ntri4P6a1gWGIQ8Tj3ChEa1QLjMg3cJOmpXNUdelWaaL5tm1whFHCQ
        0ia6ZzSeB2yAbaNXsBo5whEfqfWMtYZehxjaYV5KjVDWwQeCPL3LKfvhfpg3zw0NbGpjbe
        270oBdvO9uFa2WOOlcw7MaMa2Pnewt0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-tv-zZGRjMw2zAx86MhVdlg-1; Thu, 26 Mar 2020 03:20:39 -0400
X-MC-Unique: tv-zZGRjMw2zAx86MhVdlg-1
Received: by mail-wr1-f70.google.com with SMTP id t25so225919wrb.16
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 00:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4XWknPyKkYAfbqizFNt1Gd0mfkxXVUcGvQWw0e8F7fs=;
        b=eNx0rAsyHcgKcFVPtSiLc8PjnRtvYc5tQ1QUEoAAQ8qyv4FI1y5kmzPs8x+2xtskfj
         Ko4rlUbLxTNwFVxDKXFRku37raEXdxaaIkyo7VXUT4i5VuysqTEWNCzHhpD3Wm/FJ5aP
         hYSr4KsMAVzqveSEojDAHpyNE9X95Aggf9hOEl1ImO2odffegorrJKXW5xUIuO59vYHg
         VdA6aGWdUUHAmOt83XMmCWbIUXf+dvXaKDFXRrJuOKK9deTnFDJU7PRnq3nexDUHy5Zz
         TAeVWmPyk5Tpb5pV62jls6oKm7YIQn4HjfanxTFVBHIsfiLXafFRti2Z4DW5SVfAUGrN
         OWBQ==
X-Gm-Message-State: ANhLgQ2Xp9khmfMfdTtol+lBGnuFGNwQ7fsL0EJ7h12awJhzKp5k45Z7
        K508hANbzMvYQyazh17sLfaCth43gYUTXfW7mGaInkWbpEcMrYSsuE8YQmTBP47+t0UmeMrnDoI
        oTx8Q8KWeghVZAuBqX/RQkIDO
X-Received: by 2002:adf:a348:: with SMTP id d8mr7659492wrb.83.1585207238150;
        Thu, 26 Mar 2020 00:20:38 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vulLKViL6lz98C0rMEOGStoYAVS4PIbCmp8QYl/VaQLfO8diHChBT/rYUPUuQ2COQGUsrv+DA==
X-Received: by 2002:adf:a348:: with SMTP id d8mr7659463wrb.83.1585207237880;
        Thu, 26 Mar 2020 00:20:37 -0700 (PDT)
Received: from redhat.com (bzq-79-182-20-254.red.bezeqint.net. [79.182.20.254])
        by smtp.gmail.com with ESMTPSA id r3sm2300372wrm.35.2020.03.26.00.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 00:20:37 -0700 (PDT)
Date:   Thu, 26 Mar 2020 03:20:34 -0400
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
Message-ID: <20200326031817-mutt-send-email-mst@kernel.org>
References: <1583999395-9131-1-git-send-email-teawater@gmail.com>
 <3e1373f4-6ade-c651-ddde-6f04e78382f9@redhat.com>
 <20200312043859-mutt-send-email-mst@kernel.org>
 <45756694-560d-0276-d39e-cc2fd1c4e3a7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45756694-560d-0276-d39e-cc2fd1c4e3a7@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 09:51:25AM +0100, David Hildenbrand wrote:
> On 12.03.20 09:47, Michael S. Tsirkin wrote:
> > On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand wrote:
> >> 2. You are essentially stealing THPs in the guest. So the fastest
> >> mapping (THP in guest and host) is gone. The guest won't be able to make
> >> use of THP where it previously was able to. I can imagine this implies a
> >> performance degradation for some workloads. This needs a proper
> >> performance evaluation.
> > 
> > I think the problem is more with the alloc_pages API.
> > That gives you exactly the given order, and if there's
> > a larger chunk available, it will split it up.
> > 
> > But for balloon - I suspect lots of other users,
> > we do not want to stress the system but if a large
> > chunk is available anyway, then we could handle
> > that more optimally by getting it all in one go.
> > 
> > 
> > So if we want to address this, IMHO this calls for a new API.
> > Along the lines of
> > 
> > 	struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
> > 					unsigned int max_order, unsigned int *order)
> > 
> > the idea would then be to return at a number of pages in the given
> > range.
> > 
> > What do you think? Want to try implementing that?
> 
> You can just start with the highest order and decrement the order until
> your allocation succeeds using alloc_pages(), which would be enough for
> a first version. At least I don't see the immediate need for a new
> kernel API.

OK I remember now.  The problem is with reclaim. Unless reclaim is
completely disabled, any of these calls can sleep. After it wakes up,
we would like to get the larger order that has become available
meanwhile.


> -- 
> Thanks,
> 
> David / dhildenb

