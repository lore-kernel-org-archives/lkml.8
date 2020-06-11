Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3583BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C3E2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvBQeXuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgFKLTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:19:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44020 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728015AbgFKLSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591874332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aHs/k82DRtmbgpcekLlfLtqDNjfmaiN8XJYIsbpXYsw=;
        b=CvBQeXuFhPjyEKg+S+0DkKEKZx+hfjycYpJDGQgs3Xq6W3ZwY1YT4vxO9hN2ptXLnDS7lr
        /WhLjNHM4gW0mEj8+uHcFQ1r13/RdKi2DYN1Ipld9jn3nUpB9BKFBZuWEh6iHxt9r5lVrm
        w0wjRJeyqOP4J2JAd0VHgsWF9BXhCMw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-OTVUYN_DOwGH9NzwqypHSg-1; Thu, 11 Jun 2020 07:18:50 -0400
X-MC-Unique: OTVUYN_DOwGH9NzwqypHSg-1
Received: by mail-wr1-f72.google.com with SMTP id j16so2409361wre.22
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 04:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aHs/k82DRtmbgpcekLlfLtqDNjfmaiN8XJYIsbpXYsw=;
        b=TSCkMxv3jQdNwR3zmRABknVr262yUs4v1ZBiyKJE3f/1xs47xuhsUBm/ZC8O5o9NXh
         XhfybNtv3jT2M1T4u8XWVreCHQ06IOBKjYacUxM/fkhQrEAsfMWpaYtZHlPG0cPdO8jn
         Y7AHBm5xcMGN2kIH8iDBP2rKPjdBbkgh2ytS47IaZYsJj1d93tiGgWjCFSW1ZEHl7kDk
         tA0ylE102iphgcbmm6bdfp4U0v30nL2SL8ypGT4XnfZj0P+joooJSl/P1T/B60Q/qIJh
         qEro2v5tFTiJMPd7EY/IkuuSF3SulaiPJT9Mr9D+4UUW+56R8HIR9E51dXxpp0ttkXfj
         1S1w==
X-Gm-Message-State: AOAM533zWjY1Ira0LwO5bGJGHJ+edj6CtSQ8sZ0jnukx+wMHhNGZBjZu
        DAcNNTJhWmG7g87kTyz1+jKexNkwdNtv9pYCTqfC6bzBhe+etjr78xe+0B9LTBPjxFfBoDfsN0y
        9/KJKhZgTePjEbxnYiZhhuR2l
X-Received: by 2002:a5d:4008:: with SMTP id n8mr8881544wrp.82.1591874329748;
        Thu, 11 Jun 2020 04:18:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhY9t8eWTFTFU22DEN3RpHOgBvqdz12LnsClmOERlrFjUovn0BcztQcQ+mkBp5lkPjBXyAsg==
X-Received: by 2002:a5d:4008:: with SMTP id n8mr8881507wrp.82.1591874329286;
        Thu, 11 Jun 2020 04:18:49 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
        by smtp.gmail.com with ESMTPSA id z25sm3678047wmf.10.2020.06.11.04.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 04:18:48 -0700 (PDT)
Date:   Thu, 11 Jun 2020 07:18:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        teawater <teawaterz@linux.alibaba.com>
Subject: Re: [PATCH v1] virtio-mem: add memory via add_memory_driver_managed()
Message-ID: <20200611071744-mutt-send-email-mst@kernel.org>
References: <20200611093518.5737-1-david@redhat.com>
 <20200611060249-mutt-send-email-mst@kernel.org>
 <13ad9edf-31a1-35ee-a0b0-6390c3a0b4d9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13ad9edf-31a1-35ee-a0b0-6390c3a0b4d9@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 01:00:24PM +0200, David Hildenbrand wrote:
> >> I'd like to have this patch in 5.8, with the initial merge of virtio-mem
> >> if possible (so the user space representation of virtio-mem added memory
> >> resources won't change anymore).
> > 
> > So my plan is to rebase on top of -rc1 and merge this for rc2 then.
> > I don't like rebase on top of tip as the results are sometimes kind of
> > random.
> 
> Right, I just wanted to get this out early so we can discuss how to proceed.
> 
> > And let's add a Fixes: tag as well, this way people will remember to
> > pick this.
> > Makes sense?
> 
> Yes, it's somehow a fix (for kexec). So
> 
> Fixes: 5f1f79bbc9e26 ("virtio-mem: Paravirtualized memory hotplug")
> 
> I can respin after -rc1 with the commit id fixed as noted by Pankaj.
> Just let me know what you prefer.
> 
> Thanks!

Some once this commit is in Linus' tree, please ping me.

> -- 
> Thanks,
> 
> David / dhildenb

