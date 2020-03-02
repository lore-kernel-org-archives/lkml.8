Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44466C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D48F21775
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JA7Kzeyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgCBLQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 06:16:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44911 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725996AbgCBLQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 06:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583147775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=umbLYwhPWxfWOXkX5gvhj2TCibBswbVscPss66YGx1c=;
        b=JA7KzeyqWl9Mq/C/bAg0yn8P7kXPFayMa/h6CQhNudhxZ1O7ZXuNFxcjCRlcjiI9iegYHA
        5hEz8dQD2I6NeeRjCzhpO0SlpllV7eoO7WEeGgcNIgfzGHtN+SpmkkO/FgwAKZdl99uv5U
        ahTAgMqUrQSXGW3mhgGqET6C6unuz/8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-VDs-_QTmMj6AQhb5ZPBz0w-1; Mon, 02 Mar 2020 06:16:13 -0500
X-MC-Unique: VDs-_QTmMj6AQhb5ZPBz0w-1
Received: by mail-qv1-f69.google.com with SMTP id fc5so8342372qvb.17
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 03:16:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=umbLYwhPWxfWOXkX5gvhj2TCibBswbVscPss66YGx1c=;
        b=KF/TYeCh1tB0aPzS8cBUeyXmZ6lV9giizr2c/AJFw/vkeJKJOWn+BKtV+4RE7TN0jM
         1fmGA00L0P6IfMcy0bI/0DOY16bGzhzwLAIC8gHzTw28IqT/2+Ei1y8VZiq6D/wOPm4a
         qRvfkHqeh8bpbRxQnynb3zGwoEOG1GIOhOd93WmCvelBWStZB+JqDsoKTOmWplXZekOA
         6wuqL0+VF+311LDE2YONmYJtA89K0+JaTk/CIm72GmETPt5HudVJa/dq5N+qQQLkgU66
         cuVssQyJzoaxD2WzAzRse40fkfQRCTDwzOyg1K4I6RSbY449p234Z3/P/mgxfwUkq5bd
         ohWQ==
X-Gm-Message-State: APjAAAXaD+bnmzTV9skve61fDEokeL3da4dnblqwbBtIOG7Bc/Tgcktw
        O0nu0tc74zNWdABZKm8GZJkPQlSSUlSKjuH17shvdunHFD2+TSHVX/oKEUGLHxQN/B2DJApNcWS
        ivjF7nv74bp+q97s2Z8eACslA
X-Received: by 2002:a37:4f93:: with SMTP id d141mr15300001qkb.125.1583147772969;
        Mon, 02 Mar 2020 03:16:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqw37mRm8RQ5OwQWrA3Tw95Zs3ZfsyQXSy1ROgOhIMbb5VGK1q4sALItcgU02yvFe+sfPN8ezA==
X-Received: by 2002:a37:4f93:: with SMTP id d141mr15299986qkb.125.1583147772684;
        Mon, 02 Mar 2020 03:16:12 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
        by smtp.gmail.com with ESMTPSA id w41sm10092944qtj.49.2020.03.02.03.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 03:16:11 -0800 (PST)
Date:   Mon, 2 Mar 2020 06:16:07 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yuri Benditovich <yuri.benditovich@daynix.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Yan Vugenfirer <yan@daynix.com>,
        virtio-dev@lists.oasis-open.org
Subject: Re: [PATCH v3 2/3] virtio-net: Introduce RSS receive steering feature
Message-ID: <20200302061549-mutt-send-email-mst@kernel.org>
References: <20200301143302.8556-1-yuri.benditovich@daynix.com>
 <20200301143302.8556-3-yuri.benditovich@daynix.com>
 <20200301145811-mutt-send-email-mst@kernel.org>
 <CAOEp5Oc07THyvZghMBjns=aTVEPMxb4w6LFGFtUsS93h4xsSJQ@mail.gmail.com>
 <20200302055359-mutt-send-email-mst@kernel.org>
 <CAOEp5Oc8p6b4eDKOQoNfoER2UKNGwN6HrbVqvY+qgFwHev4qcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOEp5Oc8p6b4eDKOQoNfoER2UKNGwN6HrbVqvY+qgFwHev4qcQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 12:58:34PM +0200, Yuri Benditovich wrote:
> All the classes of commands are defined without indentation.
> All the commands are defined with indentation of 1 space.
> Only the last one (VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET at the end of
> the file) does not have an indentation.

OK then, sorry about the noise.

> On Mon, Mar 2, 2020 at 12:54 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Mar 02, 2020 at 10:53:14AM +0200, Yuri Benditovich wrote:
> > > On Sun, Mar 1, 2020 at 9:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Sun, Mar 01, 2020 at 04:33:01PM +0200, Yuri Benditovich wrote:
> > > > > RSS (Receive-side scaling) defines hash calculation
> > > > > rules and decision on receive virtqueue according to
> > > > > the calculated hash, provided mask to apply and
> > > > > provided indirection table containing indices of
> > > > > receive virqueues. The driver sends the control
> > > > > command to enable multiqueue and provide parameters
> > > > > for receive steering.
> > > > >
> > > > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > > > ---
> > > > >  include/uapi/linux/virtio_net.h | 42 +++++++++++++++++++++++++++++++--
> > > > >  1 file changed, 40 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> > > > > index 19e76b3e3a64..188ad3eecdc8 100644
> > > > > --- a/include/uapi/linux/virtio_net.h
> > > > > +++ b/include/uapi/linux/virtio_net.h
> > > > > @@ -57,6 +57,7 @@
> > > > >                                        * Steering */
> > > > >  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23        /* Set MAC address */
> > > > >
> > > > > +#define VIRTIO_NET_F_RSS       60    /* Supports RSS RX steering */
> > > > >  #define VIRTIO_NET_F_RSC_EXT   61    /* extended coalescing info */
> > > > >  #define VIRTIO_NET_F_STANDBY   62    /* Act as standby for another device
> > > > >                                        * with the same MAC.
> > > > > @@ -70,6 +71,17 @@
> > > > >  #define VIRTIO_NET_S_LINK_UP 1       /* Link is up */
> > > > >  #define VIRTIO_NET_S_ANNOUNCE        2       /* Announcement is needed */
> > > > >
> > > > > +/* supported/enabled hash types */
> > > > > +#define VIRTIO_NET_RSS_HASH_TYPE_IPv4          (1 << 0)
> > > > > +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4         (1 << 1)
> > > > > +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4         (1 << 2)
> > > > > +#define VIRTIO_NET_RSS_HASH_TYPE_IPv6          (1 << 3)
> > > > > +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6         (1 << 4)
> > > > > +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6         (1 << 5)
> > > > > +#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX         (1 << 6)
> > > > > +#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX        (1 << 7)
> > > > > +#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX        (1 << 8)
> > > > > +
> > > > >  struct virtio_net_config {
> > > > >       /* The config defining mac address (if VIRTIO_NET_F_MAC) */
> > > > >       __u8 mac[ETH_ALEN];
> > > > > @@ -93,6 +105,12 @@ struct virtio_net_config {
> > > > >        * Any other value stands for unknown.
> > > > >        */
> > > > >       __u8 duplex;
> > > > > +     /* maximum size of RSS key */
> > > > > +     __u8 rss_max_key_size;
> > > > > +     /* maximum number of indirection table entries */
> > > > > +     __le16 rss_max_indirection_table_length;
> > > > > +     /* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
> > > > > +     __le32 supported_hash_types;
> > > > >  } __attribute__((packed));
> > > > >
> > > > >  /*
> > > > > @@ -246,7 +264,9 @@ struct virtio_net_ctrl_mac {
> > > > >
> > > > >  /*
> > > > >   * Control Receive Flow Steering
> > > > > - *
> > > > > + */
> > > > > +#define VIRTIO_NET_CTRL_MQ   4
> > > > > +/*
> > > > >   * The command VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
> > > > >   * enables Receive Flow Steering, specifying the number of the transmit and
> > > > >   * receive queues that will be used. After the command is consumed and acked by
> > > > > @@ -259,11 +279,29 @@ struct virtio_net_ctrl_mq {
> > > > >       __virtio16 virtqueue_pairs;
> > > > >  };
> > > > >
> > > > > -#define VIRTIO_NET_CTRL_MQ   4
> > > > >   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET        0
> > > > >   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN        1
> > > > >   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX        0x8000
> > > > >
> > > > > +/*
> > > > > + * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG has the same effect as
> > > > > + * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and additionally configures
> > > > > + * the receive steering to use a hash calculated for incoming packet
> > > > > + * to decide on receive virtqueue to place the packet. The command
> > > > > + * also provides parameters to calculate a hash and receive virtqueue.
> > > > > + */
> > > > > +struct virtio_net_rss_config {
> > > > > +     __le32 hash_types;
> > > > > +     __le16 indirection_table_mask;
> > > > > +     __le16 unclassified_queue;
> > > > > +     __le16 indirection_table[1/* + indirection_table_mask */];
> > > > > +     __le16 max_tx_vq;
> > > > > +     __u8 hash_key_length;
> > > > > +     __u8 hash_key_data[/* hash_key_length */];
> > > > > +};
> > > > > +
> > > > > + #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
> > > > > +
> > > >
> > > >
> > > > Extra space here.
> > >
> > > Where exactly you want to remove the empty line?
> > > The format here is exactly as in other places:
> > > comment - structure - space - command - space
> >
> > + #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
> >
> > should be
> >
> > +#define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
> >
> > >
> > > >
> > > > >  /*
> > > > >   * Control network offloads
> > > > >   *
> > > > > --
> > > > > 2.17.1
> > > >
> >

