Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63799C3F2D5
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2D221775
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCrhk0PL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgCAM7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 07:59:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38069 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726536AbgCAM66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 07:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583067537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=57xE3FiPLk4S1t9miz6Kb+kV2j+1x1OuYAKKZJL7Z6w=;
        b=SCrhk0PLiRtkt0DytoJ96LvgorapvUKEcJl5MViabSKitxuT8A+FuX962KVXP7UDR3a9dF
        ZUxYnXGGqTpkavb6S6RbGe/X1CwFaD2aAoFqpNW55q1/IPHFQN8qu0wjNCz2VMXgLnrZPy
        eUl4mq55BSN5kskuSEiZituu7dQhtoQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-Eh6dwrm6Nt-EdZx97Jdugw-1; Sun, 01 Mar 2020 07:58:56 -0500
X-MC-Unique: Eh6dwrm6Nt-EdZx97Jdugw-1
Received: by mail-qt1-f199.google.com with SMTP id k20so7002187qtm.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 04:58:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=57xE3FiPLk4S1t9miz6Kb+kV2j+1x1OuYAKKZJL7Z6w=;
        b=AyVqxaRz6sTJ3STA8zRddcjOtsIl6bRHjt1L8Otvu/2AsfZ3c9o39nDSEeiL/j5bwE
         Nx2qe5h32338FvKeHRN6e2XMu/k9qrU1ZhTBdv9fnS6EwV1WrXXoNgQ38C6RkAok9sCT
         SxZIOKR95pzyadD5ImBqaq4AOb8SQpXZ1ti8LLA844yVK18VbUcTbad/lXVk10qhgafy
         /GvZaHQ6+4M6XcucP/qDaDhTGEuPd9ir4Y2yu3cHJSATq91ICm0VY7AM3i3/oTv01Sy1
         ekYfyVykzxdhdKqJ60xWzq1BlB07qegktmyL1hIMQDbdo+dLOtOnWa9+rpdsbEOuGb0s
         5kEw==
X-Gm-Message-State: APjAAAVK+BPNdK4ZFIctxrmumw3qgN5gKTTLiZAH8Q+yBUX3kAXza9QT
        t0HlyoRNcwT4O1cVWjO+2bR70qDN5nyG3iUDTjtjRxGJTfQuoFe2VFh6qU3M8mcDEu/2uhLDlB9
        0rYI2JgiDfWujuSSdzdrFcXkG
X-Received: by 2002:ad4:58ef:: with SMTP id di15mr11112955qvb.123.1583067535685;
        Sun, 01 Mar 2020 04:58:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqwfIN9Zu+nhqb4qUcHxjw5mMZnySUcj7h4+knDgayg/5ujQbsXiB6k/JWOJ8enZlXCiJm38GQ==
X-Received: by 2002:ad4:58ef:: with SMTP id di15mr11112943qvb.123.1583067535472;
        Sun, 01 Mar 2020 04:58:55 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
        by smtp.gmail.com with ESMTPSA id d35sm6821648qtc.21.2020.03.01.04.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 04:58:54 -0800 (PST)
Date:   Sun, 1 Mar 2020 07:58:49 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yuri Benditovich <yuri.benditovich@daynix.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Yan Vugenfirer <yan@daynix.com>
Subject: Re: [PATCH v2 0/3] virtio-net: introduce features defined in the spec
Message-ID: <20200301075729-mutt-send-email-mst@kernel.org>
References: <20200301110733.20197-1-yuri.benditovich@daynix.com>
 <20200301063121-mutt-send-email-mst@kernel.org>
 <CAOEp5Ofzz2CrkbBoPsOAGDVdVJZ07nzH0Usv5h6a96p8+YknwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOEp5Ofzz2CrkbBoPsOAGDVdVJZ07nzH0Usv5h6a96p8+YknwA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 02:47:41PM +0200, Yuri Benditovich wrote:
> On Sun, Mar 1, 2020 at 1:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Sun, Mar 01, 2020 at 01:07:30PM +0200, Yuri Benditovich wrote:
> > > This series introduce virtio-net features VIRTIO_NET_F_RSC_EXT,
> > > VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT.
> > >
> > > Changes from v1:
> > > __virtio -> __le
> > > maximal -> maximum
> > > minor style fixes
> >
> >
> > Looks good to me - sent a bit of consmetics.
> >
> > But as any virtio UAPI change, please CC virtio-dev as virtio TC maintains the
> > interface. Thanks!
> 
> Probably 'virtio-dev' should be added to maintainers file.

Doesn't work because it's a subscriber only list.
I've been asking to fix that for years ...

> >
> > > Yuri Benditovich (3):
> > >   virtio-net: Introduce extended RSC feature
> > >   virtio-net: Introduce RSS receive steering feature
> > >   virtio-net: Introduce hash report feature
> > >
> > >  include/uapi/linux/virtio_net.h | 90 +++++++++++++++++++++++++++++++--
> > >  1 file changed, 86 insertions(+), 4 deletions(-)
> > >
> > > --
> > > 2.17.1
> >

