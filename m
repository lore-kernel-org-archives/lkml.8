Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D0AC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 15:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E988206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 15:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/vUvPCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgGLPKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 11:10:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24699 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728826AbgGLPKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 11:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594566606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8OGhukfjv0ZT/IXCaPKeBoNY1caG5ABn5f3vkuZHJ7E=;
        b=g/vUvPCccaKVwuaOb2624AtWHUmQdV/B38bDYffs6j3gUUVuxlNHFtYb4OP4qID84Yjog6
        NznMVKqoB4ceVWfy/g0RjudI9shgNP1oQGDv6zUqxOevGpaCwPhCqMXisoF+OwxwRc6SDH
        8j6ncFFY4Zvu6SDFHclb3EFSyaQMUXw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-5tu-XNhwPya9ZbfJImOvLA-1; Sun, 12 Jul 2020 11:10:03 -0400
X-MC-Unique: 5tu-XNhwPya9ZbfJImOvLA-1
Received: by mail-wm1-f70.google.com with SMTP id v6so15192590wmg.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 08:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8OGhukfjv0ZT/IXCaPKeBoNY1caG5ABn5f3vkuZHJ7E=;
        b=SVLbeSnGqkFDs5izvG9g/QuIlcvS0GBenSlGA/dx3X7EETMPPmjIcLcZwJzKPzjIcB
         uMuZnPUpzjawfN6aCsEGoyYmRNAWAfQild52Do+kySZpS39HwfptqkRGHcd/gWru6g3W
         lGKDoCLlQJ5RBJS0zXl77xKDPKJ8ItYLZdzuFqY5JL5MMQYhBsMXPEULDvKfnrO8fiqh
         VCMepq8W+lOG53onNr2Y0p4mnUGXSCY1kA8kZIcQFBgAqc+6LmcXcCdX14nJUnJixroG
         y4/CgwUa2zevoSsN80rOJnSdPGtqQ6fAdh/GzIKhfZjP1PRRi65DcM/dV2/WQJC84Qy3
         q64Q==
X-Gm-Message-State: AOAM532QgR/ejMU0Y4l1yaJjqYO0ye6Js9+Rei8N/PR13sS5xRwg5NSJ
        l6pXGO93WXb+4kGONdj67Ab07zpwXPas1FIOXLepj109t+ElXWVP6TMRU6ZsJk1zR7eLwQRuBH+
        zxmSUSaw5eMY3XBcqABhT911s
X-Received: by 2002:adf:9404:: with SMTP id 4mr73970078wrq.367.1594566601777;
        Sun, 12 Jul 2020 08:10:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsm5CJXrrhFiC8BebofMz/Wct0oboZrATjejrICMcEce7n68CC5UryJkF6nTNDsvN2cKhCKw==
X-Received: by 2002:adf:9404:: with SMTP id 4mr73970062wrq.367.1594566601537;
        Sun, 12 Jul 2020 08:10:01 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id k18sm19676458wrx.34.2020.07.12.08.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 08:10:00 -0700 (PDT)
Date:   Sun, 12 Jul 2020 11:09:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio_balloon: clear modern features under legacy
Message-ID: <20200712105926-mutt-send-email-mst@kernel.org>
References: <20200710113046.421366-1-mst@redhat.com>
 <CAKgT0UeZN+mOWNhgiT0btZTyki3TPoj7pbqA+__GkCxoifPqeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UeZN+mOWNhgiT0btZTyki3TPoj7pbqA+__GkCxoifPqeg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 09:13:41AM -0700, Alexander Duyck wrote:
> On Fri, Jul 10, 2020 at 4:31 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Page reporting features were never supported by legacy hypervisors.
> > Supporting them poses a problem: should we use native endian-ness (like
> > current code assumes)? Or little endian-ness like the virtio spec says?
> > Rather than try to figure out, and since results of
> > incorrect endian-ness are dire, let's just block this configuration.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> So I am not sure about the patch description. In the case of page
> poison and free page reporting I don't think we are defining anything
> that doesn't already have a definition of how to use in legacy.
> Specifically the virtio_balloon_config is already defined as having
> all fields as little endian in legacy mode, and there is a definition
> for all of the fields in a virtqueue and how they behave in legacy
> mode.
> 
> As far as I can see the only item that may be an issue is the command
> ID being supplied via the virtqueue for free page hinting, which
> appears to be in native endian-ness. Otherwise it would have fallen
> into the same category since it is making use of virtio_balloon_config
> and a virtqueue for supplying the page location and length.



So as you point out correctly balloon spec says all fields are little
endian.  Fair enough.
Problem is when virtio 1 is not negotiated, then this is not what the
driver assumes for any except a handlful of fields.

But yes it mostly works out.

For example:


static void update_balloon_size(struct virtio_balloon *vb)
{
        u32 actual = vb->num_pages;

        /* Legacy balloon config space is LE, unlike all other devices. */
        if (!virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1))
                actual = (__force u32)cpu_to_le32(actual);

        virtio_cwrite(vb->vdev, struct virtio_balloon_config, actual,
                      &actual);
}


this is LE even without VIRTIO_F_VERSION_1, so matches spec.

                /* Start with poison val of 0 representing general init */
                __u32 poison_val = 0;

                /*
                 * Let the hypervisor know that we are expecting a
                 * specific value to be written back in balloon pages.
                 */
                if (!want_init_on_free())
                        memset(&poison_val, PAGE_POISON, sizeof(poison_val));

                virtio_cwrite(vb->vdev, struct virtio_balloon_config,
                              poison_val, &poison_val);


actually this writes a native endian-ness value. All bytes happen to be
the same though, and host only cares about 0 or non 0 ATM.

As you say correctly the command id is actually assumed native endian:


static u32 virtio_balloon_cmd_id_received(struct virtio_balloon *vb)
{
        if (test_and_clear_bit(VIRTIO_BALLOON_CONFIG_READ_CMD_ID,
                               &vb->config_read_bitmap))
                virtio_cread(vb->vdev, struct virtio_balloon_config,
                             free_page_hint_cmd_id,
                             &vb->cmd_id_received_cache);

        return vb->cmd_id_received_cache;
}


So guest assumes native, host assumes LE.




> > ---
> >  drivers/virtio/virtio_balloon.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > index 5d4b891bf84f..b9bc03345157 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -1107,6 +1107,15 @@ static int virtballoon_restore(struct virtio_device *vdev)
> >
> >  static int virtballoon_validate(struct virtio_device *vdev)
> >  {
> > +       /*
> > +        * Legacy devices never specified how modern features should behave.
> > +        * E.g. which endian-ness to use? Better not to assume anything.
> > +        */
> > +       if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> > +               __virtio_clear_bit(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT);
> > +               __virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
> > +               __virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
> > +       }
> >         /*
> >          * Inform the hypervisor that our pages are poisoned or
> >          * initialized. If we cannot do that then we should disable
> 
> The patch content itself I am fine with since odds are nobody would
> expect to use these features with a legacy device.
> 
> Acked-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Hmm so now you pointed out it's just cmd id, maybe I should just fix it
instead? what do you say?

-- 
MST

