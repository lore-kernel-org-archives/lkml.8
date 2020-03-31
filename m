Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BCFC2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F029020786
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpkWPKW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbgCaODd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:03:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25651 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730728AbgCaODc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585663410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q1HhUZIT2eXWaur2lhwyirTrp2FNrCuPmxOJW0kwlcg=;
        b=HpkWPKW2oN374GKMVB/CClXB0sIvJqeXOwOtCyoGB9qW89FHFnUnHhm/wN+B8B5wIl0qyE
        PiDKFedsctpuuYvSWf9GEcwLYmtZ4tWLb1FvrvgqjkUjsVYHxDcBDCpXdMTMnAYIw8ZItI
        VcM/05XfM0u3bHciDBb8l8vD+TpW5Kw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-JvGR7OoqNTqj3wqyGP3TDQ-1; Tue, 31 Mar 2020 10:03:29 -0400
X-MC-Unique: JvGR7OoqNTqj3wqyGP3TDQ-1
Received: by mail-wr1-f72.google.com with SMTP id m15so13084847wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 07:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q1HhUZIT2eXWaur2lhwyirTrp2FNrCuPmxOJW0kwlcg=;
        b=n+MV5SnfPwd8LPRs+2s7+TDKdGr6R5PFWB8AukgFc4OHFQ1x2eOr2aPTjq0GMSbJfv
         KVV29P8wTjxL7Dx3fG2oO5/07qZHG3v5uZyl/Blat+Myw6epXZLD3RKaMauOzsJbAOjP
         qkpdsY17PU0J4dJSKMaBEDBLEQKSbP+9deQ4QGu0t/9Cftq1N0ejvfNBeEqVhFdCVgH/
         PBYq9uY5w9X0X+boTvfr797alGc5dXiB5g2Eg3QhZdLYTvLbZoqVWAkKe5fHC4U6kAKa
         IK/eRxWDrkJVVYapnaMCLYUJ+y8B67rcPlYtavROAjhn3iJlJg3hz1KmxB6WqYMpy9oU
         ZbFA==
X-Gm-Message-State: ANhLgQ1W4QklYpgq3FVKBiz1tMWmVkD8USt/NhB+56/KRfsTqGJB2cQ9
        Pm/1azadnvVJiqu0n7hZ3tXuyhCF0o2yYCIZokDi6Ut562qeXfJ8XqqiiYK1QzrogoZ5jJ1NmwO
        pLpcWa9zwo0ef40BcsrIexCjT
X-Received: by 2002:a1c:2203:: with SMTP id i3mr3685825wmi.25.1585663408034;
        Tue, 31 Mar 2020 07:03:28 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vulRkkpxXMxZEng5aERNo4jJ/g5cD0Vhw5jYc5ZRlaSa1jWBjmSh3+3XcGa4A4n7qFMJ8cR0g==
X-Received: by 2002:a1c:2203:: with SMTP id i3mr3685803wmi.25.1585663407800;
        Tue, 31 Mar 2020 07:03:27 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id r17sm26682436wrx.46.2020.03.31.07.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 07:03:20 -0700 (PDT)
Date:   Tue, 31 Mar 2020 10:03:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jason Wang <jasowang@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: vdpa: remove unnecessary null check
Message-ID: <20200331100122-mutt-send-email-mst@kernel.org>
References: <20200330235040.GA9997@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330235040.GA9997@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 06:50:40PM -0500, Gustavo A. R. Silva wrote:
> container_of is never null, so this null check is
> unnecessary.
> 
> Addresses-Coverity-ID: 1492006 ("Logically dead code")
> Fixes: 20453a45fb06 ("vhost: introduce vDPA-based backend")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Yes weird. Was the point to test i_cdev? Tiwei?

> ---
>  drivers/vhost/vdpa.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 421f02a8530a..3d2cb811757a 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -678,8 +678,6 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
>  	int nvqs, i, r, opened;
>  
>  	v = container_of(inode->i_cdev, struct vhost_vdpa, cdev);
> -	if (!v)
> -		return -ENODEV;
>  
>  	opened = atomic_cmpxchg(&v->opened, 0, 1);
>  	if (opened)
> -- 
> 2.26.0

