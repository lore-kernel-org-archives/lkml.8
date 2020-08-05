Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCC7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C9222D2C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnqUZyJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgHERDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:03:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25185 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728078AbgHERBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596646856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZlNXGeTfp4AaGj7FagUROXadawxdtFtkc3vB/EgDPDU=;
        b=fnqUZyJwBTcglKwRnzavTbc2N9y2EQnUhd3PDLCm5pQeqEPV0W1YEMHS4Y7kgadX6vphRE
        hDzPEnxNOq4DY0db1I8MgajPq2+l14uWlVyzHxG2Mtdi5uDSnkdiugyd15xCv0jDZyX6GF
        AtMQk7tTf6unWHXsNs3t8VJBSWTu9lQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-coVgblsjPW66gkJld0A0fg-1; Wed, 05 Aug 2020 09:29:19 -0400
X-MC-Unique: coVgblsjPW66gkJld0A0fg-1
Received: by mail-wm1-f70.google.com with SMTP id t26so2726561wmn.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZlNXGeTfp4AaGj7FagUROXadawxdtFtkc3vB/EgDPDU=;
        b=oW83QJa+mnHRQZDioUUanU5yI5XKBbFXR3HySoPrhmP3hGplEW2+iu6CcbTZ9twggD
         okyVbx4j5RPMOv242Ak9NJdLMg+4ihI5gfKZzR2repymWk8Rnp6yqNA7Q2/9h1IVbB/K
         9/P3yd3YRW6qE0DU6ud7GLND94h/Ey4Vya5YnsL7lmYTioaZq3cNZfw1RCecrvZZ3Yqn
         xO1mET/wiLD0KhEa8AZ98ByM3LipJptEZnu2ctgyirQnb+/SR80n3pjAOG3I4HQF5JCT
         SNtnTUks78t3Ior+D5dVnyEggdRQfbA5nUvHxgVfO5gro9uJOANZz4NdhpqZi8mz7RSg
         Aclw==
X-Gm-Message-State: AOAM530HnWliDpHKYv6yuBzKAldbN57WIEDLNsps6AoGsQlcqodWGZkW
        LZoa4g7TN29w3hJ4fwRUyG40+JO4XwRl2F5f1C4zVIBG9ZasqoNVTNyvUbCGfA5lYOMHUr2BvM0
        dx2hKPymWIz4tuT4zi0SkX/XO
X-Received: by 2002:a1c:2dc6:: with SMTP id t189mr3492803wmt.26.1596634158283;
        Wed, 05 Aug 2020 06:29:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJbh142iguNxC67bdTgdKSa8fH88cZSGiuSiR54HZcWK+ZPtzZyXH9COzQuExoJPoIfhvlDw==
X-Received: by 2002:a1c:2dc6:: with SMTP id t189mr3492788wmt.26.1596634158107;
        Wed, 05 Aug 2020 06:29:18 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id d14sm2806981wre.44.2020.08.05.06.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:29:17 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:29:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>,
        platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        virtualization@lists.linux-foundation.org,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [PATCH v2 18/24] mlxbf-tmfifo: sparse tags for config access
Message-ID: <20200805092904-mutt-send-email-mst@kernel.org>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-19-mst@redhat.com>
 <20200804165634.4df11c6b.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804165634.4df11c6b.cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 04:56:34PM +0200, Cornelia Huck wrote:
> On Mon, 3 Aug 2020 17:00:01 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > mlxbf-tmfifo accesses config space using native types -
> > which works for it since the legacy virtio native types.
> > 
> > This will break if it ever needs to support modern virtio,
> > so with new tags previously introduced for virtio net config,
> > sparse now warns for this in drivers.
> > 
> > Since this is a legacy only device, fix it up using
> > virtio_legacy_is_little_endian for now.
> 
> I'm wondering if the driver should make this more explicit?


Not sure how though.

> No issues with the patch, though.
> 
> > 
> > No functional changes.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/platform/mellanox/mlxbf-tmfifo.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>

