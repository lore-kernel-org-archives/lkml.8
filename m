Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E80C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9200F20714
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvuSTjeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgEFL5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 07:57:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39838 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725985AbgEFL5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 07:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588766238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7sOis2/3Mg9JApCu6b61p44e2yvITngtwxXPAS7QTXw=;
        b=CvuSTjeYh9RN4U4Co+W7qGuwKeVyx+YpK+VuACy+Xu1Plq/Yzc59CwbGl6ruYbn1ZR+HOb
        EUcV4G9yXKtlR86AiFlV9eg05T8jiFbuGzPvagLgP04f9xmwps9D277l0Z82sD7XyO8g/H
        yEhDyID7eSKUt/7OOxTX7aNqn3XSiEs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-WyQekCQsNIm_ldKtMXmKJA-1; Wed, 06 May 2020 07:57:14 -0400
X-MC-Unique: WyQekCQsNIm_ldKtMXmKJA-1
Received: by mail-wr1-f70.google.com with SMTP id o6so1200757wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 04:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7sOis2/3Mg9JApCu6b61p44e2yvITngtwxXPAS7QTXw=;
        b=c5yMSvtzIiK+w63RgPedp6BcJnMSxlDjHf4rzHlffYqUkTy+oA0DIZsV1jOyPfaUg8
         oDAxQ4/aJHWCZK3/Zbq0+4QyASpW3BnjP4lPCDSWb11eF3MRJG58azN1oBw5czJNpNJR
         p78Lxd6/0ch/SueBPMXXi2yj2OCNOVSfTHxySpR5dc9yqvZAF6wzZoixnubGENBXFsw+
         2oFPmAemwhICxTeFIsGwYiOFRcdnwFWSCvyfhlmNonDMLQe8cl/1eCuZ8rVzWwx5ylsn
         34F4kVdHxwuzRmnvKD0PbN+IYyN6Jy/iPBUIGVuMnu5pTK0BLN9gsnkSjZtyLBFiq7yc
         M52g==
X-Gm-Message-State: AGi0PubhokieW/aMQeXQ2L8AW8hdQDAi/zvTeG0EU4YZoI0t0fcvKhue
        9px9Ky7fofFsmxU0IHYyy8GB9j8Lj78DAHHmiMYP0R6K7d1UXGl+JkjWuvEixT5PpRWwDUmDpE9
        G6HYYkAdeTJqTzOX4rGaA1bx5
X-Received: by 2002:adf:8162:: with SMTP id 89mr8736330wrm.387.1588766233796;
        Wed, 06 May 2020 04:57:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypKH40QoEgrQmuxv8rKi91gxvjeAgTSB72BOZzkNW3MxEIsk2JLG9yyMv1mIo8Hc/alFqaSzSg==
X-Received: by 2002:adf:8162:: with SMTP id 89mr8736315wrm.387.1588766233499;
        Wed, 06 May 2020 04:57:13 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id w4sm2398660wro.28.2020.05.06.04.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 04:57:12 -0700 (PDT)
Date:   Wed, 6 May 2020 07:57:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: performance bug in virtio net xdp
Message-ID: <20200506075226-mutt-send-email-mst@kernel.org>
References: <20200506035704-mutt-send-email-mst@kernel.org>
 <20200506103757.4bc78b3a@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506103757.4bc78b3a@carbon>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 10:37:57AM +0200, Jesper Dangaard Brouer wrote:
> On Wed, 6 May 2020 04:08:27 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > So for mergeable bufs, we use ewma machinery to guess the correct buffer
> > size. If we don't guess correctly, XDP has to do aggressive copies.
> > 
> > Problem is, xdp paths do not update the ewma at all, except
> > sometimes with XDP_PASS. So whatever we happen to have
> > before we attach XDP, will mostly stay around.
> > 
> > The fix is probably to update ewma unconditionally.
> 
> I personally find the code hard to follow, and (I admit) that it took
> me some time to understand this code path (so I might still be wrong).
> 
> In patch[1] I tried to explain (my understanding):
> 
>   In receive_mergeable() the frame size is more dynamic. There are two
>   basic cases: (1) buffer size is based on a exponentially weighted
>   moving average (see DECLARE_EWMA) of packet length. Or (2) in case
>   virtnet_get_headroom() have any headroom then buffer size is
>   PAGE_SIZE. The ctx pointer is this time used for encoding two values;
>   the buffer len "truesize" and headroom. In case (1) if the rx buffer
>   size is underestimated, the packet will have been split over more
>   buffers (num_buf info in virtio_net_hdr_mrg_rxbuf placed in top of
>   buffer area). If that happens the XDP path does a xdp_linearize_page
>   operation.
> 
> 
> The EWMA code is not used when headroom is defined, which e.g. gets
> enabled when running XDP.
> 
> 
> [1] https://lore.kernel.org/netdev/158824572816.2172139.1358700000273697123.stgit@firesoul/

You are right.
So I guess the problem is just inconsistency?

When XDP program returns XDP_PASS, and it all fits in one page,
then we trigger
	        ewma_pkt_len_add(&rq->mrg_avg_pkt_len, head_skb->len);

if it does not trigger XDP_PASS, or does not fit in one page,
then we don't.

Given XDP does not use ewma for sizing, let's not update the average
either.


> -- 
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer

