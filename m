Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1854C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 04:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 930D820734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 04:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1xNMBnn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgFJErd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 00:47:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28360 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725908AbgFJEra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 00:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591764449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NeTlc9sPhZVDG8KcvimBjPS6Un15nH1O93qMq/SgmMI=;
        b=Y1xNMBnnZKDhdEXyF1wuDHKjyyB73RJjQMlIAmVWLR0pU3uoV/N9rBoTbqB9OUfTHjmWD0
        0j87xe9aGbzhyQRPhkwEsR6OQwYOyzFbnjyuDWAt23SekO4CIuMuyt04PvcwapxDf3r9J1
        r+sSGu1/grIOMt6ksv9QP12BWL6OrjQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-RSrHFrIHMG-U_O2cnggCOQ-1; Wed, 10 Jun 2020 00:47:27 -0400
X-MC-Unique: RSrHFrIHMG-U_O2cnggCOQ-1
Received: by mail-wr1-f69.google.com with SMTP id f4so515962wrp.21
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 21:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NeTlc9sPhZVDG8KcvimBjPS6Un15nH1O93qMq/SgmMI=;
        b=N1jAINW4cPzY8ijIvTI1Xs/WUeePt0BVFQso/gi0p+hmJ2liVYB+c1HtZA2uZNjatL
         Vq0EQVLjq4uxwOpqzNR+tMzefYJspp77Hu5MQrySAu19ckabwXVY7T8WvGYcIQMG8TdP
         ssPO3sitjq+j+Ob4TA0X7J2CCt1vgPAgeONX1Ak2IYRdLqovvUeXLaoCgSJR8tLiRFZO
         JklNXvwol2o5cF9T+fNsGE5jNM0qyRleJ+cqkUxWeFezqQRnNyq2Ik8nn8wUolxLcazd
         X5Yf1E0MkI3veOzoZrvMXuKlUxGYFpmK7we48f1E5/rfUsM9x3j2SSKPuWoy3vrEdXDB
         XVjA==
X-Gm-Message-State: AOAM531LWJjG1meRiV7UgvtTdppbxVEh0HZ60o1TUexGqwy8xk/V4ZEo
        rno2ozISuQERnR8F0xmBGJ0gXVivjvqZ6Y8I/e/cS3GozISLHfxHw91gkQ3wAz2EHRF30xDyyb/
        06W+etKvP8ZhqQ7osu2qpZPu2
X-Received: by 2002:a05:6000:d:: with SMTP id h13mr1336233wrx.17.1591764446761;
        Tue, 09 Jun 2020 21:47:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjvknjxW+aJPg3XelEu4wq8+jLzyY8z4CuAMV2ECaX7J8V3IhJFML1oaGO06sxcAfW/4487A==
X-Received: by 2002:a05:6000:d:: with SMTP id h13mr1336207wrx.17.1591764446562;
        Tue, 09 Jun 2020 21:47:26 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
        by smtp.gmail.com with ESMTPSA id a7sm5618888wmh.14.2020.06.09.21.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 21:47:26 -0700 (PDT)
Date:   Wed, 10 Jun 2020 00:47:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: Re: [PATCH V2] vdpa: introduce virtio pci driver
Message-ID: <20200610004641-mutt-send-email-mst@kernel.org>
References: <20200610035920.12078-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610035920.12078-1-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 11:59:20AM +0800, Jason Wang wrote:
> This patch introduce a vDPA driver for virtio-pci device. It bridges
> the virtio-pci control command to the vDPA bus. This will be used for
> developing new features for both software vDPA framework and hardware
> vDPA feature.

The mail headers are mailformed here:

Content-Type: text/plain; charset=a

so git am can't parse it:

error: cannot convert from a to UTF-8
fatal: could not parse patch

-- 
MST

