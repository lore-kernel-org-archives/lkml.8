Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6370CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B62D2465E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="rtWF6l0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgCBK6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:58:47 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37666 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgCBK6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:58:47 -0500
Received: by mail-yw1-f67.google.com with SMTP id l5so10776843ywd.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 02:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D1WpXxvLtgLRd8DdqXnfuJBxD9FZp35tn7nX9Zv5CJw=;
        b=rtWF6l0kO5gY30PQC5Ev2Z8sWcA0e1fEOm5h5dpgbunwoc/Dmha2sML+71XeVZdPFf
         yctMZ0YqMXlAZ+puBe1/CcNpoizmpNoN9giAOBy2HuN+xtYrqdtmc7fo2rNFaoLVcDC0
         N7IJ3T2NKtixH4KAMCXYQAV7l0rn5m14BtMYhPHUdN9+klg8ebPhvOWUUH711tvrhema
         x3S4bHNKTh/jlv1VNju5xUGQ5Vzt3hb7rryMYe85qwUBEYzkfUlwQ14DL+iRwTjcv7V3
         V1j/6fB/aYiUkHZo+97qkcv7LgpPeFRcdFiRqbEsGQ6ZZKgX+hmWs79Lf8ShDPVYs6HB
         rRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1WpXxvLtgLRd8DdqXnfuJBxD9FZp35tn7nX9Zv5CJw=;
        b=FMcNwCzPDHvaIdk1pzSXVCwYeD73Km2GpaJ1o/Qx+uRCdz/WlySf9ZyUQSZeOwVBHo
         CCT9O1kqdFiyogdnw1X37hnnQyy3+hq3RIXpCm1ZN+s9HJoH9RQeAlDeC9nQkaJaNU5I
         N8bCjB/U6DqqVVyp+vrg5D6RtmhGB34HlbJwKkI1w+Rx8K8lFxe+krNue32YJ9W3py5N
         ag/p3t4ZC+xOpp3BMK/J2jASSn7czSAu8CATqPVfx5Vj8bcfou/UIiFD0hFuMkp8YXg4
         HX0VbO8U2GSJLFlbRmWYi5njDfo/5BfskMF4CaP6dRqp5AV8pUKxNwFVOMQGqiBcvo4F
         4dVA==
X-Gm-Message-State: APjAAAUm1EN+PaciD9WNnzTyISfDeSZMw6zIK6hVVDzsi8NOUKXEUusk
        coDI6Cx0+3gYrZqtn/zcNzWcJMsfFgvMOVLYXHMo/g==
X-Google-Smtp-Source: APXvYqxYfNf7huAl4scN5d/GkPLG8+uYLCVVzkZvIMdS992/9r03USAAehJTt7rV8hKAjGsM9CoLny0rc3+HU1gMgKE=
X-Received: by 2002:a25:e758:: with SMTP id e85mr16058039ybh.173.1583146726231;
 Mon, 02 Mar 2020 02:58:46 -0800 (PST)
MIME-Version: 1.0
References: <20200301143302.8556-1-yuri.benditovich@daynix.com>
 <20200301143302.8556-3-yuri.benditovich@daynix.com> <20200301145811-mutt-send-email-mst@kernel.org>
 <CAOEp5Oc07THyvZghMBjns=aTVEPMxb4w6LFGFtUsS93h4xsSJQ@mail.gmail.com> <20200302055359-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200302055359-mutt-send-email-mst@kernel.org>
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
Date:   Mon, 2 Mar 2020 12:58:34 +0200
Message-ID: <CAOEp5Oc8p6b4eDKOQoNfoER2UKNGwN6HrbVqvY+qgFwHev4qcQ@mail.gmail.com>
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

All the classes of commands are defined without indentation.
All the commands are defined with indentation of 1 space.
Only the last one (VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET at the end of
the file) does not have an indentation.

On Mon, Mar 2, 2020 at 12:54 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Mar 02, 2020 at 10:53:14AM +0200, Yuri Benditovich wrote:
> > On Sun, Mar 1, 2020 at 9:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Sun, Mar 01, 2020 at 04:33:01PM +0200, Yuri Benditovich wrote:
> > > > RSS (Receive-side scaling) defines hash calculation
> > > > rules and decision on receive virtqueue according to
> > > > the calculated hash, provided mask to apply and
> > > > provided indirection table containing indices of
> > > > receive virqueues. The driver sends the control
> > > > command to enable multiqueue and provide parameters
> > > > for receive steering.
> > > >
> > > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > > ---
> > > >  include/uapi/linux/virtio_net.h | 42 +++++++++++++++++++++++++++++++--
> > > >  1 file changed, 40 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> > > > index 19e76b3e3a64..188ad3eecdc8 100644
> > > > --- a/include/uapi/linux/virtio_net.h
> > > > +++ b/include/uapi/linux/virtio_net.h
> > > > @@ -57,6 +57,7 @@
> > > >                                        * Steering */
> > > >  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23        /* Set MAC address */
> > > >
> > > > +#define VIRTIO_NET_F_RSS       60    /* Supports RSS RX steering */
> > > >  #define VIRTIO_NET_F_RSC_EXT   61    /* extended coalescing info */
> > > >  #define VIRTIO_NET_F_STANDBY   62    /* Act as standby for another device
> > > >                                        * with the same MAC.
> > > > @@ -70,6 +71,17 @@
> > > >  #define VIRTIO_NET_S_LINK_UP 1       /* Link is up */
> > > >  #define VIRTIO_NET_S_ANNOUNCE        2       /* Announcement is needed */
> > > >
> > > > +/* supported/enabled hash types */
> > > > +#define VIRTIO_NET_RSS_HASH_TYPE_IPv4          (1 << 0)
> > > > +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4         (1 << 1)
> > > > +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4         (1 << 2)
> > > > +#define VIRTIO_NET_RSS_HASH_TYPE_IPv6          (1 << 3)
> > > > +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6         (1 << 4)
> > > > +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6         (1 << 5)
> > > > +#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX         (1 << 6)
> > > > +#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX        (1 << 7)
> > > > +#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX        (1 << 8)
> > > > +
> > > >  struct virtio_net_config {
> > > >       /* The config defining mac address (if VIRTIO_NET_F_MAC) */
> > > >       __u8 mac[ETH_ALEN];
> > > > @@ -93,6 +105,12 @@ struct virtio_net_config {
> > > >        * Any other value stands for unknown.
> > > >        */
> > > >       __u8 duplex;
> > > > +     /* maximum size of RSS key */
> > > > +     __u8 rss_max_key_size;
> > > > +     /* maximum number of indirection table entries */
> > > > +     __le16 rss_max_indirection_table_length;
> > > > +     /* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
> > > > +     __le32 supported_hash_types;
> > > >  } __attribute__((packed));
> > > >
> > > >  /*
> > > > @@ -246,7 +264,9 @@ struct virtio_net_ctrl_mac {
> > > >
> > > >  /*
> > > >   * Control Receive Flow Steering
> > > > - *
> > > > + */
> > > > +#define VIRTIO_NET_CTRL_MQ   4
> > > > +/*
> > > >   * The command VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
> > > >   * enables Receive Flow Steering, specifying the number of the transmit and
> > > >   * receive queues that will be used. After the command is consumed and acked by
> > > > @@ -259,11 +279,29 @@ struct virtio_net_ctrl_mq {
> > > >       __virtio16 virtqueue_pairs;
> > > >  };
> > > >
> > > > -#define VIRTIO_NET_CTRL_MQ   4
> > > >   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET        0
> > > >   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN        1
> > > >   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX        0x8000
> > > >
> > > > +/*
> > > > + * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG has the same effect as
> > > > + * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and additionally configures
> > > > + * the receive steering to use a hash calculated for incoming packet
> > > > + * to decide on receive virtqueue to place the packet. The command
> > > > + * also provides parameters to calculate a hash and receive virtqueue.
> > > > + */
> > > > +struct virtio_net_rss_config {
> > > > +     __le32 hash_types;
> > > > +     __le16 indirection_table_mask;
> > > > +     __le16 unclassified_queue;
> > > > +     __le16 indirection_table[1/* + indirection_table_mask */];
> > > > +     __le16 max_tx_vq;
> > > > +     __u8 hash_key_length;
> > > > +     __u8 hash_key_data[/* hash_key_length */];
> > > > +};
> > > > +
> > > > + #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
> > > > +
> > >
> > >
> > > Extra space here.
> >
> > Where exactly you want to remove the empty line?
> > The format here is exactly as in other places:
> > comment - structure - space - command - space
>
> + #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
>
> should be
>
> +#define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
>
> >
> > >
> > > >  /*
> > > >   * Control network offloads
> > > >   *
> > > > --
> > > > 2.17.1
> > >
>
