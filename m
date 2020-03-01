Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F561C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468632087F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="xkLErztT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgCAMnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 07:43:22 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34389 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgCAMnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 07:43:21 -0500
Received: by mail-yw1-f67.google.com with SMTP id o186so3990654ywc.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 04:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BXhAxcoRt4rzRvvqBlXaNvRsZeRD1Y8Wv8cie5PEOEo=;
        b=xkLErztTX0ZPF9z7LyLGUs6zdYQF9dbx7OngOPfirqVppB7DZEwteVyqJ3UZStPqsg
         znGrl53olatjfpQujMnmUiBzsbWXKi6+YW0WJEHHmiz8XnLaobya3YpF0E8ZmKt7DV5a
         e6w6RHqw+qvz9kWQRRecQuVlqQIWw7kukZLd9hfgDfGbjkR1an6WX25pqaNW+5EZ+6+E
         4Eb4b83w/8EQJbE6J3GuvnrviJc9Ftj9kMJlIfcHOLwK8oal/sK6WoqrIVtcO2cLwM9f
         fM+psyJDnZXtImMICHEEbeaEb/DC8aUILguu3m5kNcWbLOWE94PJx9MZSSUEGUFgBa54
         69+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BXhAxcoRt4rzRvvqBlXaNvRsZeRD1Y8Wv8cie5PEOEo=;
        b=KEjIgQqVBqM2QjFOO092dvuJK1h0sRysQ8kjVy2mVHUX/PK/Yw6L6f2bBjoCO4siBI
         zrKy+7nBzV3aRKwePt6+LFUhKb5jHl+lCVXaMgi6I96n9s5I3n1M4ObaXx69pEFbMQPn
         yZpFp0QQj7ORL3yDJmvvx6u+DZOEzQrCPdil4/ZaHpv9+fJL9jyZhYctCxUy4yB2N6eo
         bFK8FC7kzRQg7aUnLaSRyHlXI6HeSR4qgn303afvvxbvdFzIBeGXWvJ1xbro1k2eZg4T
         3SPV/e4zDjk788hZCj1df/E20uNjoaItpIjrz53RwUOXs64f+1r4v/pNNbNcC20iunZc
         /9YA==
X-Gm-Message-State: APjAAAW4iTmBIejqv1T1R3g/9Zt5HuhmJlujh6wxgQvEppEDkKJNvtOA
        98tj6sFnKkqtA2ci+6Mvh7BZPxhT/xbaBDNtjM+qeQ==
X-Google-Smtp-Source: APXvYqz7r81Ensc6/5OBHveWW0NdX7U7yd/wkXrCzmSEm001sDt3MpuCe3buX0iKkn/2jQ7zqLiJbZfNE7NRFoVFsUM=
X-Received: by 2002:a25:d912:: with SMTP id q18mr11892730ybg.370.1583066599248;
 Sun, 01 Mar 2020 04:43:19 -0800 (PST)
MIME-Version: 1.0
References: <20200301110733.20197-1-yuri.benditovich@daynix.com>
 <20200301110733.20197-2-yuri.benditovich@daynix.com> <20200301061745-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200301061745-mutt-send-email-mst@kernel.org>
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
Date:   Sun, 1 Mar 2020 14:43:08 +0200
Message-ID: <CAOEp5OeNLa=0hJXOSrPvRbkm7XpE-uzq7vQB-GprXsoCgyk7kQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] virtio-net: Introduce extended RSC feature
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Yan Vugenfirer <yan@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No problem, I'll send an update

On Sun, Mar 1, 2020 at 1:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, Mar 01, 2020 at 01:07:31PM +0200, Yuri Benditovich wrote:
> > VIRTIO_NET_F_RSC_EXT feature bit indicates that the device
> > is able to provide extended RSC information. When the feature
> > is negotiatede and 'gso_type' field in received packet is not
> > GSO_NONE, the device reports number of coalesced packets in
> > 'csum_start' field and number of duplicated acks in 'csum_offset'
> > field and sets VIRTIO_NET_HDR_F_RSC_INFO in 'flags' field.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >  include/uapi/linux/virtio_net.h | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> > index a3715a3224c1..536152fad3c4 100644
> > --- a/include/uapi/linux/virtio_net.h
> > +++ b/include/uapi/linux/virtio_net.h
> > @@ -57,6 +57,7 @@
> >                                        * Steering */
> >  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23        /* Set MAC address */
> >
> > +#define VIRTIO_NET_F_RSC_EXT   61    /* extended coalescing info */
> >  #define VIRTIO_NET_F_STANDBY   62    /* Act as standby for another device
> >                                        * with the same MAC.
> >                                        */
> > @@ -104,6 +105,7 @@ struct virtio_net_config {
> >  struct virtio_net_hdr_v1 {
> >  #define VIRTIO_NET_HDR_F_NEEDS_CSUM  1       /* Use csum_start, csum_offset */
> >  #define VIRTIO_NET_HDR_F_DATA_VALID  2       /* Csum is valid */
> > +#define VIRTIO_NET_HDR_F_RSC_INFO    4       /* rsc info in csum_ fields */
> >       __u8 flags;
> >  #define VIRTIO_NET_HDR_GSO_NONE              0       /* Not a GSO frame */
> >  #define VIRTIO_NET_HDR_GSO_TCPV4     1       /* GSO frame, IPv4 TCP (TSO) */
> > @@ -113,8 +115,14 @@ struct virtio_net_hdr_v1 {
> >       __u8 gso_type;
> >       __virtio16 hdr_len;     /* Ethernet + IP + tcp/udp hdrs */
> >       __virtio16 gso_size;    /* Bytes to append to hdr_len per frame */
> > -     __virtio16 csum_start;  /* Position to start checksumming from */
> > -     __virtio16 csum_offset; /* Offset after that to place checksum */
> > +     union {
> > +             __virtio16 csum_start;  /* Position to start checksumming from */
> > +             __le16 rsc_ext_num_packets; /* num of coalesced packets */
> > +     };
> > +     union {
> > +             __virtio16 csum_offset; /* Offset after that to place checksum */
> > +             __le16 rsc_ext_num_dupacks; /* num of duplicated acks */
>
> dupacks -> dup_acks ?
>
> Also wouldn't it be cleaner to have an rsc struct? And "num" is kind of
> extraneous, right?
> So how about we group the fields:
>
> union {
>         /* Unnamed struct for compatiblity. */
>         struct {
>                 csum_start
>                 csum_offset
>         };
>         struct {
>                 virtio16 start;
>                 virtio16 offset;
>         } csum;
>         struct {
>                 le16 packets;
>                 le16 dup_acks;
>         } rsc;
> };
>
>
> what do you think?
>
>
> > +     };
> >       __virtio16 num_buffers; /* Number of merged rx buffers */
> >  };
>
>
>
> > --
> > 2.17.1
>
