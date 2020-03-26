Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25207C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF91F20719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wguo4yhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgCZHKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:10:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33559 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgCZHKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585206618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H8Cw3DLh+iXs54zjqQfuZxMBQva4d9GTteg9CmCE+Ho=;
        b=Wguo4yhyvKwELK68RLUfkhcbTYUBRRFOeCMwwgtREfN3LqcX2aUGYlTXrwvhqSSPi8WyIU
        EwI+8IVRMMTlLF9HDWHleYx0lPbCjbblbk6pyRiV6DTh6b1aaVMNPz62DEcE1OPufAdnVg
        PYkFs3lv0529MqMOj0bGNF5ntyWi7SI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-otfINWqYO9CpmEvG1Hr9IQ-1; Thu, 26 Mar 2020 03:10:16 -0400
X-MC-Unique: otfINWqYO9CpmEvG1Hr9IQ-1
Received: by mail-wr1-f72.google.com with SMTP id c8so692386wru.20
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 00:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H8Cw3DLh+iXs54zjqQfuZxMBQva4d9GTteg9CmCE+Ho=;
        b=NF8wgjWNJqmOCbLUUXwFc37L8cARYEYfttUQeY1NbIpZiIpQmNH2jv8flz4wLnea8T
         R4pxmob/qypPeUvYPhVIZKqtyG3N6ycq5UaThOSHso4mVyvGkIAYHobvR8ZcVoeKW8Qu
         Hc4k/533qaZ3dPpU4Yvx+JVGcyoVsYI7tdnFI0W1F56n+Tp4f5JvxRGgytZFgi5BcRbk
         IIdy+VG4ZXBc90y6ji4Qcw47qg5KpA8MfwyTwVm4ZLegIaN0Oz0xpIaNwwCXyj9k6tf5
         teG0NnJoEnRvTPdhqWQF9ZDF1rw1wyVuhpxDS5sWvzDRc6Cdyt7ss23E/LV+ls1yy1cM
         CXMw==
X-Gm-Message-State: ANhLgQ1Em9hWroPezHzGB4Db4XxwNwPKH+ghhZJaJtwun58wP5z/YT8q
        KnaApQdQ9gFu2OYLHq/C5rnjS/zuKDk34GdDEs8VxApebkpSD6yeGN3OQPfESOnMbx1jNRwcwAs
        T2SsthCPLqa3F+S83ho664R52
X-Received: by 2002:a5d:4e03:: with SMTP id p3mr7455129wrt.408.1585206614577;
        Thu, 26 Mar 2020 00:10:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv1gHKjELwCfzDpvvpY8bDWo2p7o6gD/1dLi9S0i1LgXWtQ35bOWK+dgA1kgl5Qn2fUPD9HnQ==
X-Received: by 2002:a5d:4e03:: with SMTP id p3mr7455094wrt.408.1585206614278;
        Thu, 26 Mar 2020 00:10:14 -0700 (PDT)
Received: from redhat.com (bzq-79-182-20-254.red.bezeqint.net. [79.182.20.254])
        by smtp.gmail.com with ESMTPSA id y16sm2272355wrp.78.2020.03.26.00.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 00:10:13 -0700 (PDT)
Date:   Thu, 26 Mar 2020 03:10:10 -0400
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
Message-ID: <20200326030833-mutt-send-email-mst@kernel.org>
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

Well there's still a chance of splitting a big page if one
becomes available meanwhile. But OK.

> -- 
> Thanks,
> 
> David / dhildenb

