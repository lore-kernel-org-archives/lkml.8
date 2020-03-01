Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3560C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72462087F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="teK5GctH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgCAMrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 07:47:53 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34754 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgCAMrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 07:47:53 -0500
Received: by mail-yw1-f66.google.com with SMTP id o186so3997166ywc.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 04:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIDZBL/JubUTLDASvC33U4QhLhN6MoqjnwZUylwb8cw=;
        b=teK5GctHOQt1X33VEx/tISYvILK02uDfBuM+tRdPVoZ0nFHrzbfpSWAhwv5ruIDMYr
         Q7qIcIvJgjXZGYTbyws4OmTf4fydt2oyePnTHl5P3rL9sKIQiUn5dch4K9lX+2QrMwDU
         /q/rZGNW2kRcwpejBpM9vz7lCKTXnUE4yV72Mh6JfHd9/oafsIhZ7tWgWA68N9bbX8SM
         yaChuzxXAt7ZDVfSqARYTs//u8hHyEfMKjaHDL4jM/Urn/Jbb96S32RV8TxDlH7HjqYU
         b3LZhCTLBVOFem92Qr1NkXztpaTKhyqauR6obNaqMaNtsNVmp8nAW2tJxRoSWNrsRHw1
         3j3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIDZBL/JubUTLDASvC33U4QhLhN6MoqjnwZUylwb8cw=;
        b=gnG7Zwh3vwf+Y1AIcJhSgGgRHE9EXTYptdnvYpAaAvsjN5SxB1wlYT+JkFQX08jpRz
         LK1xGWV6F1UH9tJ5/n9A/hP6cUga9XK2ZQEPuHVk+/doRkzTvmK3S4JlIQg98kq5QSjc
         3sij8UAQVqqhoKew2lUFDj1/4qk3I0v7xms16O1TLq13LDYZgwU6v/cZeyf//PU57JY5
         OwXHwv5ct4InNA9R1KjLCEAcIJMsvQD1TWVCJnCFIIvtIhaTQEmuXBNfWO7Pi5tRJEPv
         ZD3xMDz1QqlYSUKp3GDvlABwo/mRuTtZv+nzLGUXv6104LtQRzkikC1ygloUyRg73T2a
         DRkA==
X-Gm-Message-State: APjAAAX8f4aUCWTalXyE+NKwarZL/vi/1rCT9MnQ1OLI3ZXyAVZn+lpb
        fO/jwGgohtaBwmdjWBbGDUv+7sXBfQy5H1KX6as8fwGr
X-Google-Smtp-Source: APXvYqzI1NW4Tg29e6sknihoF0t+aa9nEhOTzOlawQre1//WHvyJJE/jbcuHKqHl1EsMixJJUTg2mNf05P6HueSGe0Q=
X-Received: by 2002:a0d:fe83:: with SMTP id o125mr7198532ywf.56.1583066872110;
 Sun, 01 Mar 2020 04:47:52 -0800 (PST)
MIME-Version: 1.0
References: <20200301110733.20197-1-yuri.benditovich@daynix.com> <20200301063121-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200301063121-mutt-send-email-mst@kernel.org>
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
Date:   Sun, 1 Mar 2020 14:47:41 +0200
Message-ID: <CAOEp5Ofzz2CrkbBoPsOAGDVdVJZ07nzH0Usv5h6a96p8+YknwA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] virtio-net: introduce features defined in the spec
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Yan Vugenfirer <yan@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 1, 2020 at 1:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, Mar 01, 2020 at 01:07:30PM +0200, Yuri Benditovich wrote:
> > This series introduce virtio-net features VIRTIO_NET_F_RSC_EXT,
> > VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT.
> >
> > Changes from v1:
> > __virtio -> __le
> > maximal -> maximum
> > minor style fixes
>
>
> Looks good to me - sent a bit of consmetics.
>
> But as any virtio UAPI change, please CC virtio-dev as virtio TC maintains the
> interface. Thanks!

Probably 'virtio-dev' should be added to maintainers file.

>
> > Yuri Benditovich (3):
> >   virtio-net: Introduce extended RSC feature
> >   virtio-net: Introduce RSS receive steering feature
> >   virtio-net: Introduce hash report feature
> >
> >  include/uapi/linux/virtio_net.h | 90 +++++++++++++++++++++++++++++++--
> >  1 file changed, 86 insertions(+), 4 deletions(-)
> >
> > --
> > 2.17.1
>
