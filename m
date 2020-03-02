Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A27DC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF28424695
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="RvPPIlWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgCBIx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:53:27 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46582 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBIx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:53:27 -0500
Received: by mail-yw1-f65.google.com with SMTP id y62so83452ywd.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 00:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J9M0oBKN1OQnBWGJPk3lWi6DUIW2zQCCN42nNOnH9q4=;
        b=RvPPIlWxEzXPSYQKBCE6Xsn9KoqF0QFiB+UGlVcm/4DyUQV+qKg1uHLIv8wdRGLx2W
         mtulw6HLFDhhKT71chmt13bwWGF48MASKyp2DYbAtI3kC7dYxJ3sCAkfa42MgVzk0Qd0
         3r8NyrKd3IKjTv1uxuCJSNZpuz7mjfuG+iUmDUCIArjpn+lfmrDRzhWonDa0y7kteChi
         uWucQA2YXB9k0aS5YRtUeg+i9P/PDjQDi6EGs+CE5XqQGsygmgyxLQhFOvPeaxjlU6bG
         oLtfU1Qf0+z7hDA9vQpZ3C01jxoKTu1ZQK/RHN15RSqTvn4WAij8LdpRjLh0avyCXo5E
         YKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J9M0oBKN1OQnBWGJPk3lWi6DUIW2zQCCN42nNOnH9q4=;
        b=trAlm3+B7wFzDfcF0RjjOBNwX7KGxJbBMe/00dgsRnBpS9ZdUYfBOXUr9JRROpUv6x
         bxJG+7llNXADL1jXtBEqZOou+dN63rG/VI8vbviins5sTwZBVaW/36wd3KLxwkeNLhX4
         Ku//DyhncaVAkcm2s/+N/umVNlw8CUdQPRuUmSmz9gWptiWjbw2IZJOrzNzl7kUr0pV9
         3zbbkL7bsaWH7JgYgWL7fnTczGgkzI2lkC5o02aUqfyMnsXk8a+xXL2fF4KHJvc1QF1O
         sW89gn9oXzRLwkDfm/uDibxmugQshhGA0DTPHPwFwwRVtrwHwCccyEN7+k6rS773sRl5
         SaIQ==
X-Gm-Message-State: ANhLgQ0bCuFmJV/CLH6a9wkJym8ssXOBqCKrHFLTHcm9kVr9v2MmM2n0
        +8f40QtILdq4MUoj/RZ/g3xc1oiKKygHUwwFyjAnJQ==
X-Google-Smtp-Source: ADFU+vs+98yuAZb/4vcpynxksSVpHYPTpcb4O7pd+ReOP2xeKEezddDfFEqhgHL+gYnnNGGZCg3H0FetvOu/dlBPhzY=
X-Received: by 2002:a0d:ffc2:: with SMTP id p185mr811323ywf.496.1583139205976;
 Mon, 02 Mar 2020 00:53:25 -0800 (PST)
MIME-Version: 1.0
References: <20200301143302.8556-1-yuri.benditovich@daynix.com>
 <20200301143302.8556-3-yuri.benditovich@daynix.com> <20200301145811-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200301145811-mutt-send-email-mst@kernel.org>
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
Date:   Mon, 2 Mar 2020 10:53:14 +0200
Message-ID: <CAOEp5Oc07THyvZghMBjns=aTVEPMxb4w6LFGFtUsS93h4xsSJQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] virtio-net: Introduce RSS receive steering feature
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Yan Vugenfirer <yan@daynix.com>,
        virtio-dev@lists.oasis-open.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 1, 2020 at 9:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, Mar 01, 2020 at 04:33:01PM +0200, Yuri Benditovich wrote:
> > RSS (Receive-side scaling) defines hash calculation
> > rules and decision on receive virtqueue according to
> > the calculated hash, provided mask to apply and
> > provided indirection table containing indices of
> > receive virqueues. The driver sends the control
> > command to enable multiqueue and provide parameters
> > for receive steering.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >  include/uapi/linux/virtio_net.h | 42 +++++++++++++++++++++++++++++++--
> >  1 file changed, 40 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> > index 19e76b3e3a64..188ad3eecdc8 100644
> > --- a/include/uapi/linux/virtio_net.h
> > +++ b/include/uapi/linux/virtio_net.h
> > @@ -57,6 +57,7 @@
> >                                        * Steering */
> >  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23        /* Set MAC address */
> >
> > +#define VIRTIO_NET_F_RSS       60    /* Supports RSS RX steering */
> >  #define VIRTIO_NET_F_RSC_EXT   61    /* extended coalescing info */
> >  #define VIRTIO_NET_F_STANDBY   62    /* Act as standby for another device
> >                                        * with the same MAC.
> > @@ -70,6 +71,17 @@
> >  #define VIRTIO_NET_S_LINK_UP 1       /* Link is up */
> >  #define VIRTIO_NET_S_ANNOUNCE        2       /* Announcement is needed */
> >
> > +/* supported/enabled hash types */
> > +#define VIRTIO_NET_RSS_HASH_TYPE_IPv4          (1 << 0)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4         (1 << 1)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4         (1 << 2)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_IPv6          (1 << 3)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6         (1 << 4)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6         (1 << 5)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX         (1 << 6)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX        (1 << 7)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX        (1 << 8)
> > +
> >  struct virtio_net_config {
> >       /* The config defining mac address (if VIRTIO_NET_F_MAC) */
> >       __u8 mac[ETH_ALEN];
> > @@ -93,6 +105,12 @@ struct virtio_net_config {
> >        * Any other value stands for unknown.
> >        */
> >       __u8 duplex;
> > +     /* maximum size of RSS key */
> > +     __u8 rss_max_key_size;
> > +     /* maximum number of indirection table entries */
> > +     __le16 rss_max_indirection_table_length;
> > +     /* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
> > +     __le32 supported_hash_types;
> >  } __attribute__((packed));
> >
> >  /*
> > @@ -246,7 +264,9 @@ struct virtio_net_ctrl_mac {
> >
> >  /*
> >   * Control Receive Flow Steering
> > - *
> > + */
> > +#define VIRTIO_NET_CTRL_MQ   4
> > +/*
> >   * The command VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
> >   * enables Receive Flow Steering, specifying the number of the transmit and
> >   * receive queues that will be used. After the command is consumed and acked by
> > @@ -259,11 +279,29 @@ struct virtio_net_ctrl_mq {
> >       __virtio16 virtqueue_pairs;
> >  };
> >
> > -#define VIRTIO_NET_CTRL_MQ   4
> >   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET        0
> >   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN        1
> >   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX        0x8000
> >
> > +/*
> > + * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG has the same effect as
> > + * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and additionally configures
> > + * the receive steering to use a hash calculated for incoming packet
> > + * to decide on receive virtqueue to place the packet. The command
> > + * also provides parameters to calculate a hash and receive virtqueue.
> > + */
> > +struct virtio_net_rss_config {
> > +     __le32 hash_types;
> > +     __le16 indirection_table_mask;
> > +     __le16 unclassified_queue;
> > +     __le16 indirection_table[1/* + indirection_table_mask */];
> > +     __le16 max_tx_vq;
> > +     __u8 hash_key_length;
> > +     __u8 hash_key_data[/* hash_key_length */];
> > +};
> > +
> > + #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
> > +
>
>
> Extra space here.

Where exactly you want to remove the empty line?
The format here is exactly as in other places:
comment - structure - space - command - space


>
> >  /*
> >   * Control network offloads
> >   *
> > --
> > 2.17.1
>
