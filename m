Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040F0C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8F9248E7
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZ0XCPxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgDFP5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:57:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32368 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728817AbgDFP5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586188669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mYadafEf2dHzsAtvL1A3mRX9tgv7C1wkjybbY7fHUNg=;
        b=TZ0XCPxqEoN3gO6pm0KZABYBbTQ15LFkI8aGCtApnHrdeQxBQF2ZksUWwvsYvesBgNSa6s
        opgdT6xIrGvbSLajTPCcXu8hi4KPNK3zevfMlWYUjKt4gHrch1pRubQf+J4Ktj2WLwIZKd
        BalkfYBCh+eD+2dZe/T619NpcekFX88=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-vUZTD1DIPqqeOx9SQfvZpg-1; Mon, 06 Apr 2020 11:57:47 -0400
X-MC-Unique: vUZTD1DIPqqeOx9SQfvZpg-1
Received: by mail-wr1-f71.google.com with SMTP id o10so29503wrj.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 08:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mYadafEf2dHzsAtvL1A3mRX9tgv7C1wkjybbY7fHUNg=;
        b=gqly5H839XUU6dosAOhNDEKvxlW4+edfh9TOltgNlRk83zyl0J+daA7bNTiedvbQTx
         W0Dfcztju3dflPrx0uocWXptgZgDnB0IVItkwbXwu5Hk2/sUiAn+VR0+wybeQynO6nx5
         Ksqx20YfhmQ5p9YIKl1ThkHI28NEK4ZbLaTbxVm3uMuxcHXanY0bwS1u611+ZnRoqvPt
         YciExPO4zHc63V69EeQAWEekxoTU3m+EMpvvnHsHGpnFda2icba0t0+2u6FmBM6/UdDy
         W0A+YKgWMDgRJMFz7TI0noovl1O/RSeqmQ+D4nYVt+ih/ngF8JqAzHvWd6ZipfH6I7cM
         RX0Q==
X-Gm-Message-State: AGi0PuaDokpS5xTTOAjsUnu3ulT3WJw7hc4H7mj1hMH6x/p8OZoXKbKz
        WLy6H1yb4kFrkwegn88t7x97Wi/owD1iTQkp+O4gTkf6PEWFF5TwTCXTioHtlGFhfgKznwRwfUd
        Zc2oCbaRS7/MR7oSnAQO/L5RE
X-Received: by 2002:adf:fc10:: with SMTP id i16mr8809753wrr.354.1586188666452;
        Mon, 06 Apr 2020 08:57:46 -0700 (PDT)
X-Google-Smtp-Source: APiQypJIgQGlWFOIgWSCeubvPOjYqpvDuQLV4/yUVkI1Zn2LL67ge2cp9C7u+SLHfxdIwD4AcPvUdA==
X-Received: by 2002:adf:fc10:: with SMTP id i16mr8809739wrr.354.1586188666301;
        Mon, 06 Apr 2020 08:57:46 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id f3sm37676wmj.24.2020.04.06.08.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 08:57:45 -0700 (PDT)
Date:   Mon, 6 Apr 2020 11:57:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Jason Wang <jasowang@redhat.com>,
        platform-driver-x86@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 1/2] virtio: stop using legacy struct vring
Message-ID: <20200406115653-mutt-send-email-mst@kernel.org>
References: <20200406153245.127680-1-mst@redhat.com>
 <20200406153245.127680-2-mst@redhat.com>
 <20200406155602.GA160445@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406155602.GA160445@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 05:56:02PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 06, 2020 at 11:35:23AM -0400, Michael S. Tsirkin wrote:
> > struct vring (in the uapi directory) and supporting APIs are kept
> > around to avoid breaking old userspace builds.
> > It's not actually part of the UAPI - it was kept in the UAPI
> > header by mistake, and using it in kernel isn't necessary
> > and prevents us from making changes safely.
> > In particular, the APIs actually assume the legacy layout.
> > 
> > Add struct vring_s (identical ATM) and supporting
> > legacy APIs and switch everyone to use that.
> 
> How are we going to know that "struct vring_s" is what we need/want to
> use?  What does "_s" mean?
> 
> "struct vring_kernel"?
> 
> naming is hard...
> 
> greg k-h

Hmm. I guess I can just add an ifdef so kernel doesn't see the UAPI
version anymore ...

-- 
MST

