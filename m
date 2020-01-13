Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD86C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2A52081E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="Xy+xBFB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgAMMck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:32:40 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46592 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgAMMck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:32:40 -0500
Received: by mail-io1-f65.google.com with SMTP id t26so9568832ioi.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 04:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Km5amB7u+f2nJJaDa/p5PTnfI/jbVGIB1ALdNIZW0xI=;
        b=Xy+xBFB7LHF28j088RfzKlJh4WkEdFUmbBLN907YVDC2kYf3tVqlMwHQyv5InTMDv6
         l0ztlM5MCIhcZzh7wf4s48pSf6T+NAi6RgU8d7gCpe2pqhyTwtBjCX5ek+Co8kHrhbbc
         EtXHLuQr2H813FqGLUaJdFKqls54BHqd23nEb6zXDsZta6GT6MrpSLYJ8PIPcP9oAtcZ
         5RveoHzs3P58Admqbjwc93cAZbzsrsLlxT2uISDkU8Jsz7sCCapaJDirePGjmnBra61C
         5GXovGTwVVTowwUTsYx2iUGYGMvqaUcykr4M2XfZgKowK6bYWpeKP93WNpMXrbtDiGIy
         5oOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Km5amB7u+f2nJJaDa/p5PTnfI/jbVGIB1ALdNIZW0xI=;
        b=TZN5NQdHWu/p4CE0TRD0E7w/+Weock0HRAnYrHO4mCWYc1B5ubtXZ9kVLJGMypymgd
         A4/Z3yh9ehUxAX54MI/xpmAY45lAW+h+hMqBSAaFevqrBWIcIkTln3jQKBKQdt731MkL
         QCvGPQYGvbKUnwgSHSu5zj/KwEWgusAjj/5wn0lhHEwcsXj96DZKWGsmR8otFU2B36sn
         BfFYpfnDfnxQTA1rLGmELIrJaVkes15T88ly6TEv8CuP+B/tjgix1E9TpJTX/a3HwmDJ
         P5Y6m3crJynLzoi4xGSPcWrgdAnI76CaC8RQ/eBpfQfdpZ+t9d99YiAhFeHsfByknNkx
         ptsg==
X-Gm-Message-State: APjAAAUkLxX3deqxMwRd6KALbhFF55ozKT4Qwo3HEbEMZSPgZo/sI5GY
        YlG/PdTXMysNzX56hHhTtbHeVvLApNViU0GE0Luez9xS
X-Google-Smtp-Source: APXvYqzWyOXnjsum8RIdEHYuGqw6fldwu80yL6GUjd12dqkgOxz5rn2euW860M61KP60nEmySnc98iWxnmG9VyTJT4o=
X-Received: by 2002:a02:620c:: with SMTP id d12mr14136503jac.116.1578918759468;
 Mon, 13 Jan 2020 04:32:39 -0800 (PST)
MIME-Version: 1.0
References: <20200113081736.2340-1-yuri.benditovich@daynix.com> <bdc6cb05-30d1-b4fd-512e-740b2550c14e@redhat.com>
In-Reply-To: <bdc6cb05-30d1-b4fd-512e-740b2550c14e@redhat.com>
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
Date:   Mon, 13 Jan 2020 14:32:25 +0200
Message-ID: <CAOEp5OfgSwsa63kgAUJW9E2C7FiWt7AFdPupQCaMb4CLgi4YXg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-net: Introduce extended RSC feature
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Yan Vugenfirer <yan@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 1:08 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/1/13 =E4=B8=8B=E5=8D=884:17, Yuri Benditovich wrote:
> > VIRTIO_NET_F_RSC_EXT feature bit indicates that the device
> > is able to provide extended RSC information. When the feature
> > is negotiatede and 'gso_type' field in received packet is not
> > GSO_NONE, the device reports number of coalesced packets in
> > 'csum_start' field and number of duplicated acks in 'csum_offset'
> > field and sets VIRTIO_NET_HDR_F_RSC_INFO in 'flags' field.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>
>
> Hi Yuri:
>
> Is the feature used by Linux? If yes, it's better to include the real use=
r.
>

It is not used by Linux. Mainly needed for certification under Windows.

>
> > ---
> >   include/uapi/linux/virtio_net.h | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virti=
o_net.h
> > index a3715a3224c1..2bdd26f8a4ed 100644
> > --- a/include/uapi/linux/virtio_net.h
> > +++ b/include/uapi/linux/virtio_net.h
> > @@ -56,7 +56,7 @@
> >   #define VIRTIO_NET_F_MQ     22      /* Device supports Receive Flow
> >                                        * Steering */
> >   #define VIRTIO_NET_F_CTRL_MAC_ADDR 23       /* Set MAC address */
> > -
> > +#define VIRTIO_NET_F_RSC_EXT   61    /* Provides extended RSC info */
>
>
> Is this better to keep the newline around?

No problem, let's wait until the rest is accepted.

>
>
> >   #define VIRTIO_NET_F_STANDBY          62    /* Act as standby for ano=
ther device
> >                                        * with the same MAC.
> >                                        */
> > @@ -104,6 +104,7 @@ struct virtio_net_config {
> >   struct virtio_net_hdr_v1 {
> >   #define VIRTIO_NET_HDR_F_NEEDS_CSUM 1       /* Use csum_start, csum_o=
ffset */
> >   #define VIRTIO_NET_HDR_F_DATA_VALID 2       /* Csum is valid */
> > +#define VIRTIO_NET_HDR_F_RSC_INFO    4       /* rsc_ext data in csum_ =
fields */
> >       __u8 flags;
> >   #define VIRTIO_NET_HDR_GSO_NONE             0       /* Not a GSO fram=
e */
> >   #define VIRTIO_NET_HDR_GSO_TCPV4    1       /* GSO frame, IPv4 TCP (T=
SO) */
> > @@ -118,6 +119,13 @@ struct virtio_net_hdr_v1 {
> >       __virtio16 num_buffers; /* Number of merged rx buffers */
> >   };
> >
> > +/*
> > + * if VIRTIO_NET_F_RSC_EXT feature has been negotiated and
> > + * VIRTIO_NET_HDR_F_RSC_INFO is set in RX packet
> > + */
> > +#define virtio_net_rsc_ext_num_packets       csum_start
> > +#define virtio_net_rsc_ext_num_dupacks       csum_offset
>
>
> This looks sub-optimal, it looks to me union is better?

This was discussed in v1, MST decided the define is better.

>
> Thanks
>
>
> > +
> >   #ifndef VIRTIO_NET_NO_LEGACY
> >   /* This header comes first in the scatter-gather list.
> >    * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it mu=
st
>
