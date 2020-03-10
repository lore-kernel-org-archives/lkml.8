Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C60C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7222465A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGiFzKhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgCJJFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 05:05:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29815 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726557AbgCJJFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583831105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z8M89yh2o8qCh7hRUgk/BdUfIvQzZ4pvg1NsyaqSzVM=;
        b=FGiFzKhdZyRlRsMHOCQhTUwoX1vwDM71by4EGJxAKF80Y+N2IkEFyVHjznzPeJ2kCCshmb
        Yvgr9CVz7DLO9eVPFcL+ghL4kEfRye1w/nqXD7pimjhb/5jeyMWfTn9Nma3VM43JpRMBgM
        X6y5OAU+7rIdWuumBrqdfST4IVTBt1s=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-QU2xv1CYOCeKVYQ_yYPzBQ-1; Tue, 10 Mar 2020 05:05:03 -0400
X-MC-Unique: QU2xv1CYOCeKVYQ_yYPzBQ-1
Received: by mail-qt1-f200.google.com with SMTP id y3so8695346qti.15
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 02:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z8M89yh2o8qCh7hRUgk/BdUfIvQzZ4pvg1NsyaqSzVM=;
        b=TWpkN/XWLca91tdEhPMQ9tkC9ti2F7z9Ld/gDPM4LBWdc3OZHbSFnhT7zA/A+kq17F
         SbWQlKEL6CGjOfZ2pzX//VhkpKcuQXHHWfa1ExgYDwyGR6FW4IuIbT09RUuMYAfsBhZ4
         Fj+RSz/P2JL31AYW+xBGEjZ7kyZ83MmmF8fk3KZH78ewzQ7TnpO8X9lu0sNdpaRIdcX2
         2F3/65gh5yosl9sVOyaNJM0mWc2GhNjyVk0tL8zhmM/3RgMWVmnRl9PBSRs4KCXNzX/I
         djmTATskcfC5HIwkup7aT1uMt5u/ur/UV5dRAYKus+GxyWeJ2apA6H8RGZAnqPK46dxr
         dPKQ==
X-Gm-Message-State: ANhLgQ11ouwYgOymfzhFFtWAcey5tfIXT/jOzlRzrC2b2P+/KK9ZFOTl
        pdqC2+DrPfc3QNV1qaMOC0mRS74fQAAEqJfz7hDYybCeCfM/Eo8CcLfGrfu1F43PUecpsIXBGHc
        PLdiPbRIs98qcFOdAazhjs1y2
X-Received: by 2002:a05:6214:1808:: with SMTP id o8mr2701753qvw.187.1583831102932;
        Tue, 10 Mar 2020 02:05:02 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vunNOR8JXPFd6n8xYppj56UliWV70QigDA7M9ZuBdznJhfA6O4S2PhnHJ9QEf3uXaknJxp3WA==
X-Received: by 2002:a05:6214:1808:: with SMTP id o8mr2701733qvw.187.1583831102613;
        Tue, 10 Mar 2020 02:05:02 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id v21sm20794233qto.97.2020.03.10.02.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 02:05:01 -0700 (PDT)
Date:   Tue, 10 Mar 2020 05:04:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the vhost
 tree
Message-ID: <20200310050017-mutt-send-email-mst@kernel.org>
References: <20200310190205.7c152ef9@canb.auug.org.au>
 <c7a2f5f7-6e30-cfbe-99b8-722be517ed20@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7a2f5f7-6e30-cfbe-99b8-722be517ed20@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 09:39:21AM +0100, David Hildenbrand wrote:
> On 10.03.20 09:02, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the akpm-current tree got a conflict in:
> > 
> >   drivers/virtio/virtio_balloon.c
> > 
> > between commit:
> > 
> >   b5769cdc14fc ("virtio-balloon: Switch back to OOM handler for VIRTIO_BALLOON_F_DEFLATE_ON_OOM")
> > 
> > from the vhost tree and commits:
> > 
> >   b64c4d5bea98 ("virtio-balloon: pull page poisoning config out of free page hinting")
> >   80c03575431c ("virtio-balloon: add support for providing free page reports to host")
> > 
> > from the akpm-current tree.
> > 
> > I looked at the conflict for a while but could not easily see how to
> > reconcile it, so I decided to revert the vhost tree commit for today.
> > Some advice would be appreciated.
> > 
> 
> Yes, the free page reporting features are currently in Andrews tree and
> most probably won't go via the vhost tree due to the core-mm changes.
> Ideally, the VIRTIO_BALLOON_F_DEFLATE_ON_OOM fix would go in unchanged,
> because some people might be interested in backporting it (it's not a
> stable fix, though).
> 
> I think rebasing any way round shouldn't be too hard.
> 
> @Alex, Michael, what's your thought on this?

I propose rebasing on top of the akpm tree and merging through there.
David could you do the rebase pls? I'll review and ack.

While there, keeping virtio_balloon_unregister_shrinker and
virtio_balloon_register_shrinker around might be a good idea to
minimize backporting pain.

> -- 
> Thanks,
> 
> David / dhildenb

