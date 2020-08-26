Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3693FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 22:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F183E20639
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 22:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWv2EPzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgHZWKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 18:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgHZWKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 18:10:34 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C48C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 15:10:33 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kx11so1533048pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 15:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YM3Nt5xBxOrs0Fg/mqN4OZHiLIz6RmbpZl3Kw/OAf7o=;
        b=UWv2EPzcBFFR2VzVnP0wNtwjU1Q0k4kcWvLEiGnilVzGxM4yKDHjAyVmpf1djDi9TF
         N4JmqXne5ILR+1qEPnxffTzZT2EGPXFI3Pn0fbwFm8tjFMIbGTl41TotT2gb2JhR++jR
         YV3VTbTs6CF8TR1BYvvNo1Eab6ToST2tl+k3Q3a9kPD5s06/x9FQI90fcOgU/4xGaawX
         iapGVEX5NcXPUOrVnX63EaDxVbn3lndK+pxRL3Xu2s4SX1AIWblNSqf2+3LfOXs17ffK
         Kj66kEQXPmSBUNlAeUL+6iRQK/hi2Ukx7wyhVXySAq62/QGSgk6zajSEkzLq6A+wfAXh
         x/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YM3Nt5xBxOrs0Fg/mqN4OZHiLIz6RmbpZl3Kw/OAf7o=;
        b=E5IVK0D3YbmrlBo6Rdqcrgi1wpN09puGL3jXbikCgHT66g/BEutJc4XklGENteqFgI
         NyEs1ExjCLq1itOlbrTQ0SlTQtc+0GnfZXIYu/G+AlFvPxP2Y8wPAxJbBaziYAmzLrqi
         V/jyTUUoOKuSfP2D59eVBRzr4equrv01rKmR96JXGj0dHeR+LhYB0wmFu6b8nmXPYFls
         n4E/QHFGtOws0/5efI3UAzY6yIIa9xCldi+Bape4VhtY1MnbSapBu44dxkRngr7IpN5b
         VcLc3KTXiCHjrZHgpS6/vnQhdzdb1oSAYncxoDjSespE9BF3pV85Nlz+eVJJygShG/FP
         +NeQ==
X-Gm-Message-State: AOAM533Oy3mVH3PLGRpBL0zksaKEmpDWwsv8HLNlrSFw+QZiumlBnFkP
        +duOI6mTDD0dzH3z4a2ToEt67Q==
X-Google-Smtp-Source: ABdhPJwExxwLfCtJWya4v/ptwjvOMiZcO6l9486Wjk15DW3ArXPTsHdCEm5GmRLDVvKWYtY1ILCh7Q==
X-Received: by 2002:a17:90b:3197:: with SMTP id hc23mr7773891pjb.60.1598479833371;
        Wed, 26 Aug 2020 15:10:33 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id h193sm31719pgc.42.2020.08.26.15.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 15:10:32 -0700 (PDT)
Date:   Wed, 26 Aug 2020 16:10:30 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 8/9] rpmsg: virtio: use rpmsg_ns driver to manage ns
 announcement
Message-ID: <20200826221030.GB4141387@xps15>
References: <20200731114732.12815-1-arnaud.pouliquen@st.com>
 <20200731114732.12815-9-arnaud.pouliquen@st.com>
 <20200825165433.GA4141387@xps15>
 <c1b81b38-c155-3183-ed67-822c4f87ec71@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1b81b38-c155-3183-ed67-822c4f87ec71@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 09:42:46AM +0200, Arnaud POULIQUEN wrote:
> Hi mathieu,
> 
> I Sent my V2 few seconds before receiving your comment :)
> Please find my answer below

Seconds!

> 
> On 8/25/20 6:54 PM, Mathieu Poirier wrote:
> > Hi Arnaud,
> > 
> > On Fri, Jul 31, 2020 at 01:47:31PM +0200, Arnaud Pouliquen wrote:
> >> Use the new rpmsg_ns API to send the name service announcements if
> >> the VIRTIO_RPMSG_F_NS is set, else just not implement the ops.
> >>
> >> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> >> ---
> >>  drivers/rpmsg/virtio_rpmsg_bus.c | 94 +++++---------------------------
> >>  1 file changed, 13 insertions(+), 81 deletions(-)
> >>
> >> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> >> index f771fdae150e..3c771a6392be 100644
> >> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> >> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> >> @@ -91,35 +91,6 @@ struct rpmsg_hdr {
> >>  	u8 data[];
> >>  } __packed;
> >>  
> >> -/**
> >> - * struct rpmsg_ns_msg - dynamic name service announcement message
> >> - * @name: name of remote service that is published
> >> - * @addr: address of remote service that is published
> >> - * @flags: indicates whether service is created or destroyed
> >> - *
> >> - * This message is sent across to publish a new service, or announce
> >> - * about its removal. When we receive these messages, an appropriate
> >> - * rpmsg channel (i.e device) is created/destroyed. In turn, the ->probe()
> >> - * or ->remove() handler of the appropriate rpmsg driver will be invoked
> >> - * (if/as-soon-as one is registered).
> >> - */
> >> -struct rpmsg_ns_msg {
> >> -	char name[RPMSG_NAME_SIZE];
> >> -	__virtio32 addr;
> >> -	__virtio32 flags;
> >> -} __packed;
> >> -
> >> -/**
> >> - * enum rpmsg_ns_flags - dynamic name service announcement flags
> >> - *
> >> - * @RPMSG_NS_CREATE: a new remote service was just created
> >> - * @RPMSG_NS_DESTROY: a known remote service was just destroyed
> >> - */
> >> -enum rpmsg_ns_flags {
> >> -	RPMSG_NS_CREATE		= 0,
> >> -	RPMSG_NS_DESTROY	= 1,
> >> -};
> >> -
> >>  /**
> >>   * @vrp: the remote processor this channel belongs to
> >>   */
> >> @@ -324,60 +295,18 @@ static void virtio_rpmsg_destroy_ept(struct rpmsg_endpoint *ept)
> >>  	__rpmsg_destroy_ept(vch->vrp, ept);
> >>  }
> >>  
> >> -static int virtio_rpmsg_announce_create(struct rpmsg_device *rpdev)
> >> -{
> >> -	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
> >> -	struct virtproc_info *vrp = vch->vrp;
> >> -	struct device *dev = &rpdev->dev;
> >> -	int err = 0;
> >> -
> >> -	/* need to tell remote processor's name service about this channel ? */
> >> -	if (rpdev->announce && rpdev->ept &&
> >> -	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
> >> -		struct rpmsg_ns_msg nsm;
> >> -
> >> -		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
> >> -		nsm.addr = cpu_to_virtio32(vrp->vdev, rpdev->ept->addr);
> >> -		nsm.flags = cpu_to_virtio32(vrp->vdev, RPMSG_NS_CREATE);
> >> -
> >> -		err = rpmsg_sendto(rpdev->ept, &nsm, sizeof(nsm), RPMSG_NS_ADDR);
> >> -		if (err)
> >> -			dev_err(dev, "failed to announce service %d\n", err);
> >> -	}
> >> -
> >> -	return err;
> >> -}
> >> -
> >> -static int virtio_rpmsg_announce_destroy(struct rpmsg_device *rpdev)
> >> -{
> >> -	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
> >> -	struct virtproc_info *vrp = vch->vrp;
> >> -	struct device *dev = &rpdev->dev;
> >> -	int err = 0;
> >> -
> >> -	/* tell remote processor's name service we're removing this channel */
> >> -	if (rpdev->announce && rpdev->ept &&
> >> -	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
> >> -		struct rpmsg_ns_msg nsm;
> >> -
> >> -		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
> >> -		nsm.addr = cpu_to_virtio32(vrp->vdev, rpdev->ept->addr);
> >> -		nsm.flags = cpu_to_virtio32(vrp->vdev, RPMSG_NS_DESTROY);
> >> -
> >> -		err = rpmsg_sendto(rpdev->ept, &nsm, sizeof(nsm), RPMSG_NS_ADDR);
> >> -		if (err)
> >> -			dev_err(dev, "failed to announce service %d\n", err);
> >> -	}
> >> -
> >> -	return err;
> >> -}
> >> -
> >>  static const struct rpmsg_device_ops virtio_rpmsg_ops = {
> >>  	.create_channel = virtio_rpmsg_create_channel,
> >>  	.release_channel = virtio_rpmsg_release_channel,
> >>  	.create_ept = virtio_rpmsg_create_ept,
> >> -	.announce_create = virtio_rpmsg_announce_create,
> >> -	.announce_destroy = virtio_rpmsg_announce_destroy,
> >> +};
> >> +
> >> +static const struct rpmsg_device_ops virtio_rpmsg_w_nsa_ops = {
> >> +	.create_channel = virtio_rpmsg_create_channel,
> >> +	.release_channel = virtio_rpmsg_release_channel,
> >> +	.create_ept = virtio_rpmsg_create_ept,
> >> +	.announce_create = rpmsg_ns_announce_create,
> >> +	.announce_destroy = rpmsg_ns_announce_destroy,
> >>  };
> >>  
> >>  static void virtio_rpmsg_release_device(struct device *dev)
> >> @@ -423,7 +352,10 @@ __rpmsg_create_channel(struct virtproc_info *vrp,
> >>  	rpdev = &vch->rpdev;
> >>  	rpdev->src = chinfo->src;
> >>  	rpdev->dst = chinfo->dst;
> >> -	rpdev->ops = &virtio_rpmsg_ops;
> >> +	if (virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS))
> >> +		rpdev->ops = &virtio_rpmsg_w_nsa_ops;
> >> +	else
> >> +		rpdev->ops = &virtio_rpmsg_ops;
> > 
> > Yesterday I struggled with this part and I still do this morning.  Function
> > __rpmsg_create_channel() can only be called if VIRTIO_RPMSG_F_NS is set so there
> > is no need to check it again.
> 
> That's right if rpmsg_create_channel is called by the rpmsg_ns only. But it 
> could not be the case in future, for instance with the rpmsg_ctrl series [1]
> As the channel creation is decorrelate from the ns annoucement we need to check it.
> 
> [1]https://patchwork.kernel.org/patch/11694787/
> 
> I would also have expected this patch to be a
> > simple replace of the .announce_create/destroy functions.  Adding an ops that
> > doesn't have the .announce_create/destroy functions looks like a feature to me,
> > and one that I don't quite get.
> > 
> > Do you think you could expand on the motivation behind this patch?
> 
> It was my first implementation. It is more of a phylosophical point than anything else.
> With this path i tried to implement the following rule:
>   if VIRTIO_RPMSG_F_NS is not set
>       no ns announcement support
>   else 
>       delegate to the ns announcement RPMsg service

I had another very long look at this...  I haven't had the time to look in your
next serie so the end result is not yet clear in my head.  But...

In __rpmsg_create_channel() the new code is testing for VIRTIO_RPMSG_F_NS in
order to allocate the ops, which means that the rpdev that is fed to
virtio_rpmsg_announce_create/destroy() are associated with a virtproc_info.
Moreover there is a test in virtio_rpmsg_announce_create/destroy() that checks 
for VIRTIO_RPMSG_F_NS already.  So if the rpdev was created from another
interface than the name announcement then no message would be sent.  

So it seems to me that the last two patches could be dropped and things would
still work properly.

The good news is that I reviewed V2 today and things look good.  I will wait to
review your next set before adding RB tags.  The down side is that having spent
a fair amount of time on your set, I need to look at other people's work if I
want to be fair to everyone.  As such I have to push back the review of your
other set to next week.

Thanks,
Mathieu

> 
> Rather, legacy implementation is about to implement the announce ops even if not supported.
> 
> If this implementation is confusing i can go back to my first implementation which was
> only an update the virtio_rpmsg_announce_xx functions:
> 
> @@ -322,15 +304,8 @@ static int virtio_rpmsg_announce_create(struct rpmsg_device *rpdev)
>  	int err = 0;
>  
>  	/* need to tell remote processor's name service about this channel ? */
> -	if (rpdev->announce && rpdev->ept &&
> -	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
> -		struct rpmsg_ns_msg nsm;
> -
> -		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
> -		nsm.addr = rpdev->ept->addr;
> -		nsm.flags = RPMSG_NS_CREATE;
> -
> -		err = rpmsg_sendto(rpdev->ept, &nsm, sizeof(nsm), RPMSG_NS_ADDR);
> +	if (virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
> +		err = rpmsg_ctrl_channel_announce(rpdev, RPMSG_NS_CREATE);
>  		if (err)
>  			dev_err(dev, "failed to announce service %d\n", err);
>  	}
> @@ -346,15 +321,8 @@ static int virtio_rpmsg_announce_destroy(struct rpmsg_device *rpdev)
>  	int err = 0;
>  
>  	/* tell remote processor's name service we're removing this channel */
> -	if (rpdev->announce && rpdev->ept &&
> -	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
> -		struct rpmsg_ns_msg nsm;
> -
> -		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
> -		nsm.addr = rpdev->ept->addr;
> -		nsm.flags = RPMSG_NS_DESTROY;
> -
> -		err = rpmsg_sendto(rpdev->ept, &nsm, sizeof(nsm), RPMSG_NS_ADDR);
> +	if (virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
> +		err = rpmsg_ctrl_channel_announce(rpdev, RPMSG_NS_DESTROY);
>  		if (err)
>  			dev_err(dev, "failed to announce service %d\n", err);
>  	}
> 
> Regards,
> Arnaud
> 
> > 
> > Thanks,
> > Mathieu 
> > 
> >>  
> >>  	/*
> >>  	 * rpmsg server channels has predefined local address (for now),
> >> @@ -933,7 +865,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >>  
> >>  		/* Assign public information to the rpmsg_device */
> >>  		rpdev_ns = &vch->rpdev;
> >> -		rpdev_ns->ops = &virtio_rpmsg_ops;
> >> +		rpdev_ns->ops = &virtio_rpmsg_w_nsa_ops;
> >>  
> >>  		rpdev_ns->dev.parent = &vrp->vdev->dev;
> >>  		rpdev_ns->dev.release = virtio_rpmsg_release_device;
> >> -- 
> >> 2.17.1
> >>
