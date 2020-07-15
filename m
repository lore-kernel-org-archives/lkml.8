Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E723CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C22052067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cELMly7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbgGOJrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:47:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41295 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729592AbgGOJrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594806426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fgFwB4sgqMo4IjWK8xGAhUdyzExkJ8Foocx1qbcXFec=;
        b=cELMly7a7cu/U3++mhRx3DvvxB8801E/9dv+HuXSSa8JWwFJ524sGgtRrJECXwElPwMHLD
        Xu0uCOv/gYMEJ3W9rTY6aAkxPsmv7pgqHDugdcVhwgp9j5wFwb745eVoINRjYM0VoOGu8b
        KvWPyELcMtPYj9HK3uutmSk858bEhsM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-gcmcvveNNEOEIZrtVKauMw-1; Wed, 15 Jul 2020 05:47:05 -0400
X-MC-Unique: gcmcvveNNEOEIZrtVKauMw-1
Received: by mail-wm1-f71.google.com with SMTP id t18so439926wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fgFwB4sgqMo4IjWK8xGAhUdyzExkJ8Foocx1qbcXFec=;
        b=IcqJgYA2IyUDHeoGininp+9C56HCVdMf4W3nYgp1yEa6Ck0vGPE/mhzgL7XxuOYrE6
         9w9FAEHNy85iTFxcqFcEeOMM3276934T+ekuRKYFgpgJA3XYNSfIUHI6ZW5b2jw6Kdh7
         mVOnNq8MtRa+y6fZYiJNv0QdRYG6O96PZiPqr28hgDzwlM6HrEO03k1EYsXvlt+8TSlq
         tn/l3KlS11bjIBB59FlFycUdZVvUleb4+ZxqzgPuYWIvPEGh4cBSA3Lj1QKLiQ6lsj7D
         V7CF6WldBwFrCYsfXiNtkM1r8gC8C0RImts1B9JrX49jKS9wQB3CnruV63447fUjFNUE
         XuJw==
X-Gm-Message-State: AOAM532G7SlxYh/c+4RZnG5rtQ79dSkxMRsUGKwJ0Wy76xvU0i5D5SA+
        0nJTvHphK8vUXnX5wszJzLwyVpYodV6y/NfRlKUP1slJfiAsV5Mo1Jmi8oukdmMM0WvHjJyf67A
        /HbirMXImzZH9lk4fEpA8o7PN
X-Received: by 2002:a5d:4bc4:: with SMTP id l4mr9855663wrt.97.1594806423954;
        Wed, 15 Jul 2020 02:47:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHDUVU4AP3hlp5Siz7vKq3EW4crKSR0xnUKkeLjfUiJpc4ShpyJMTGyZWh8XxJyKnOOZ6fMA==
X-Received: by 2002:a5d:4bc4:: with SMTP id l4mr9855634wrt.97.1594806423671;
        Wed, 15 Jul 2020 02:47:03 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
        by smtp.gmail.com with ESMTPSA id j75sm2897436wrj.22.2020.07.15.02.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 02:47:02 -0700 (PDT)
Date:   Wed, 15 Jul 2020 05:46:59 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio_balloon: clear modern features under legacy
Message-ID: <20200715053808-mutt-send-email-mst@kernel.org>
References: <20200710113046.421366-1-mst@redhat.com>
 <CAKgT0UeZN+mOWNhgiT0btZTyki3TPoj7pbqA+__GkCxoifPqeg@mail.gmail.com>
 <20200712105926-mutt-send-email-mst@kernel.org>
 <CAKgT0UdY1xpEH1Hg4HWJEkGwH5s64sm1y4O_XmHe8P_f=tDhpg@mail.gmail.com>
 <20200714044017-mutt-send-email-mst@kernel.org>
 <CAKgT0Ud_AFpB-=uCB_3qY8pFvG9Kj7OFSmFG76LZC9K91oUG2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0Ud_AFpB-=uCB_3qY8pFvG9Kj7OFSmFG76LZC9K91oUG2w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:31:56AM -0700, Alexander Duyck wrote:
> On Tue, Jul 14, 2020 at 1:45 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jul 13, 2020 at 08:10:14AM -0700, Alexander Duyck wrote:
> > > On Sun, Jul 12, 2020 at 8:10 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Fri, Jul 10, 2020 at 09:13:41AM -0700, Alexander Duyck wrote:
> > > > > On Fri, Jul 10, 2020 at 4:31 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> 
> <snip>
> 
> > > > As you say correctly the command id is actually assumed native endian:
> > > >
> > > >
> > > > static u32 virtio_balloon_cmd_id_received(struct virtio_balloon *vb)
> > > > {
> > > >         if (test_and_clear_bit(VIRTIO_BALLOON_CONFIG_READ_CMD_ID,
> > > >                                &vb->config_read_bitmap))
> > > >                 virtio_cread(vb->vdev, struct virtio_balloon_config,
> > > >                              free_page_hint_cmd_id,
> > > >                              &vb->cmd_id_received_cache);
> > > >
> > > >         return vb->cmd_id_received_cache;
> > > > }
> > > >
> > > >
> > > > So guest assumes native, host assumes LE.
> > >
> > > This wasn't even the one I was talking about, but now that you point
> > > it out this is definately bug. The command ID I was talking about was
> > > the one being passed via the descriptor ring. That one I believe is
> > > native on both sides.
> >
> > Well qemu swaps it for modern devices:
> >
> >         virtio_tswap32s(vdev, &id);
> >
> > guest swaps it too:
> >         vb->cmd_id_active = cpu_to_virtio32(vb->vdev,
> >                                         virtio_balloon_cmd_id_received(vb));
> >         sg_init_one(&sg, &vb->cmd_id_active, sizeof(vb->cmd_id_active));
> >         err = virtqueue_add_outbuf(vq, &sg, 1, &vb->cmd_id_active, GFP_KERNEL);
> >
> > So it's native for legacy.
> 
> Okay, that makes sense. I just wasn't familiar with the virtio32 type.
> 
> I guess that just means we need to fix the original issue you found
> where the guest was assuming native for the command ID in the config.
> Do you plan to patch that or should I?

I'll do it.


> > > >
> > > >
> > > >
> > > > > > ---
> > > > > >  drivers/virtio/virtio_balloon.c | 9 +++++++++
> > > > > >  1 file changed, 9 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > > > > > index 5d4b891bf84f..b9bc03345157 100644
> > > > > > --- a/drivers/virtio/virtio_balloon.c
> > > > > > +++ b/drivers/virtio/virtio_balloon.c
> > > > > > @@ -1107,6 +1107,15 @@ static int virtballoon_restore(struct virtio_device *vdev)
> > > > > >
> > > > > >  static int virtballoon_validate(struct virtio_device *vdev)
> > > > > >  {
> > > > > > +       /*
> > > > > > +        * Legacy devices never specified how modern features should behave.
> > > > > > +        * E.g. which endian-ness to use? Better not to assume anything.
> > > > > > +        */
> > > > > > +       if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> > > > > > +               __virtio_clear_bit(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT);
> > > > > > +               __virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
> > > > > > +               __virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
> > > > > > +       }
> > > > > >         /*
> > > > > >          * Inform the hypervisor that our pages are poisoned or
> > > > > >          * initialized. If we cannot do that then we should disable
> > > > >
> > > > > The patch content itself I am fine with since odds are nobody would
> > > > > expect to use these features with a legacy device.
> > > > >
> > > > > Acked-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > >
> > > > Hmm so now you pointed out it's just cmd id, maybe I should just fix it
> > > > instead? what do you say?
> > >
> > > So the config issues are bugs, but I don't think you saw the one I was
> > > talking about. In the function send_cmd_id_start the cmd_id_active
> > > value which is initialized as a virtio32 is added as a sg entry and
> > > then sent as an outbuf to the device. I'm assuming virtio32 is a host
> > > native byte ordering.
> >
> > IIUC it isn't :) virtio32 is guest native if device is legacy, and LE if
> > device is modern.
> 
> Okay. So I should probably document that for the spec I have been
> working on. It looks like there is an example of similar documentation
> for the memory statistics so it should be pretty straight forward.
> 
> Thanks.
> 
> - Alex

"guest native if device is legacy, and LE if device is modern"
is a standard virtio thing. Balloon has special language saying
its config space is always LE.


2.4.3

Legacy Interface: A Note on Device Configuration Space endian-ness
Note that for legacy interfaces, device configuration space is generally the guest’s native endian, rather than
PCI’s little-endian. The correct endian-ness is documented for each device.


This language could use some tweaking: e.g. "PCI" here refers to the time when
PCI was the only transport. And most devices don't document endianness
so just rely on standard one.


Similarly:

2.6.3

Legacy Interfaces: A Note on Virtqueue Endianness

Note that when using the legacy interface, transitional devices and drivers MUST use the native endian of
the guest as the endian of fields and in the virtqueue. This is opposed to little-endian for non-legacy interface
as specified by this standard. It is assumed that the host is already aware of the guest endian.


Could use some love too, e.g. host -> device, guest -> driver.



-- 
MST

