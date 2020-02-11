Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DD9C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29B0214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSrejC4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgBKOHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:07:24 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38810 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728434AbgBKOHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581430043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=INu84orqc9+je081poLUqhp5eUlqzmj/i/n4RyB/kg0=;
        b=DSrejC4qSdxcV95d6dmOECnxKD2UQTgbtGXcJFUvrPNC8BLehCkDu6nBbGoELpaU4q6n+O
        ZvE84g6ARMO9BPsI5C//KAwbTJtW0hHOKLjBPnPoxWX0EBLD1zXYDC1bARcFpvPrRzVero
        YjtChnX+W29aIpIIoH29eeD0OtjEiiw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-zGpnFDm2MsW6sM1JpWLWKQ-1; Tue, 11 Feb 2020 09:07:21 -0500
X-MC-Unique: zGpnFDm2MsW6sM1JpWLWKQ-1
Received: by mail-qt1-f198.google.com with SMTP id k20so5941591qtm.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 06:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=INu84orqc9+je081poLUqhp5eUlqzmj/i/n4RyB/kg0=;
        b=VEu/Mt0FDR7/QPf711Ta0dcKQj+21+oibw0zk9wVC4rHexPUCMrvVPLApLZPcIR+BZ
         NFKpsUvBgkT1BGHTXvZ66+/cW6DkLHNFWb1pY11TV/e+zWMEJzHbwZC8Iyu8px5lgX0p
         cFvEatBjDrPW49pSJF0MCeNkODNctASN+eQ3ZYXPE3YP18/bER3zjnaDEDqPQ3P/mEaM
         sgmTQXg3FCv09Xev+nvLHvMHMwykhv7eVWj2TgowXKa3x3PCDONknXQJy4GCajLoR8z6
         Dj74wB+U9XsoeslGGi8rJs8EFs00xjROLdFUdMitOD8F82uyeUw1AxVZnwdm/NVZVE6o
         nJYA==
X-Gm-Message-State: APjAAAVY44kqDYqHrOO+JVejrpEaQGe+KM8LR1QJEw/elzDqejgfyQXC
        X0EnvEuwDtqF8tce5g60tPATvvV535f2L1Y1mly85ZM/Ssg8qPC3jtybcoYOKCalepHK+Qv0Nr3
        H5E7tyf3rkYF+1eWvuvHkVTLW
X-Received: by 2002:a37:9e09:: with SMTP id h9mr6306052qke.176.1581430041048;
        Tue, 11 Feb 2020 06:07:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqzu8Y9MsH8YO9REysQ9nYFhCJuec8Q3jBv6o6L1bwS7xwhDk3Sc7yQGpQut6djeRWTzM+X5sw==
X-Received: by 2002:a37:9e09:: with SMTP id h9mr6306002qke.176.1581430040713;
        Tue, 11 Feb 2020 06:07:20 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id z1sm2150280qtq.69.2020.02.11.06.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 06:07:19 -0800 (PST)
Date:   Tue, 11 Feb 2020 09:07:12 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        mhocko@kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, vbabka@suse.cz,
        yang.zhang.wz@gmail.com, nitesh@redhat.com, konrad.wilk@oracle.com,
        pagupta@redhat.com, riel@surriel.com, lcapitulino@redhat.com,
        dave.hansen@intel.com, wei.w.wang@intel.com, aarcange@redhat.com,
        pbonzini@redhat.com, dan.j.williams@intel.com,
        alexander.h.duyck@linux.intel.com, osalvador@suse.de
Subject: Re: [PATCH v16.1 6/9] virtio-balloon: Add support for providing free
 page reports to host
Message-ID: <20200211090052-mutt-send-email-mst@kernel.org>
References: <20200122173040.6142.39116.stgit@localhost.localdomain>
 <20200122174347.6142.92803.stgit@localhost.localdomain>
 <b8cbf72d-55a7-4a58-6d08-b0ac5fa86e82@redhat.com>
 <20200211063441-mutt-send-email-mst@kernel.org>
 <ada0ec83-8e7d-abb3-7053-0ec2bf2a9aa5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada0ec83-8e7d-abb3-7053-0ec2bf2a9aa5@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 01:19:31PM +0100, David Hildenbrand wrote:
> >>
> >> Did you see the discussion regarding unifying handling of
> >> inflate/deflate/free_page_hinting_free_page_reporting, requested by
> >> Michael? I think free page reporting is special and shall be left alone.
> > 
> > Not sure what do you mean by "left alone here". Could you clarify?
> 
> Don't try to unify handling like I proposed below, because it's
> semantics are special.
> 
> > 
> >> VIRTIO_BALLOON_F_REPORTING is nothing but a more advanced inflate, right
> >> (sg, inflate based on size - not "virtio pages")?
> > 
> > 
> > Not exactly - it's also initiated by guest as opposed to host, and
> > not guided by the ballon size request set by the host.
> 
> True, but AFAIKS you could use existing INFLATE/DEFLATE in a similar
> way. There is no way for the hypervisor to nack a request. The balloon
> size is not glued to inflate/deflate requests. The guests manually
> updates it.

Hmm how isn't it? num_pages is the only way to inflate/deflate.

Spec also says:
The device is driven either by the receipt of a configuration change notification, or by changing guest memory
needs, such as performing memory compaction or responding to out of memory conditions.

so ignoring compaction/oom (later is under-specified, not a good example
to follow) yes inflate/deflate are tied to host specified configuration.


> > And uses a dedicated queue to avoid blocking other functionality ...
> 
> True, but the other queues also don't allow for an easy extension
> AFAIKS, so that's another reason.
> 
> > 
> > I really think this is more like an inflate immediately followed by deflate.
> 
> Depends on how you look at it. As inflate/deflate is not glued to the
> balloon size (the guest updates the size manually), it's not obvious.
> 
> E.g., in QEMU, a deflate is just a performance improvement
> ("MADV_WILLNEED") - in that regard, it's more like an optional deflation.
> 
> [...]
> 
> > 
> > I'd rather wait until we have a usecase and preferably a POC
> > showing it helps before we add optional deflate ...
> > For now I personally am fine with just making this go ahead as is,
> > and imply SG and OPTIONAL_DEFLATE just for this VQ.
> 
> Also fine with me, you asked about if we can abstract any of this if I
> am not wrong :) So this was my take.
> 
> > 
> > Do you feel strongly we need to bring this up to a TC vote?
> 
> Not really. People have been asking about how to inflate/deflate huge
> pages a long time ago (comes with different challenges - e.g., balloon
> compaction). looked like this interface could have been reused for this
> as well.
> 
> But yeah, I am not a fan of virtio-balloon and the whole inflate/deflate
> thingy. So at least I don't see a need to extend the inflate/deflate
> capability.
> 
> Free page reporting is a different story (and the semantics require no
> inflate/deflate/balloon size) - it could have been moved to
> virtio-whatever without any issues. So I am fine with this.
> 
> -- 
> Thanks,
> 
> David / dhildenb

