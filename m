Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3975FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 138D52070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/i6tISk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHJOfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:35:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33390 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726111AbgHJOfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597070146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dXWSa0571ciFu2t/WYhoCRkUSyhVOHJkVHffG1Nnkws=;
        b=h/i6tISk3Rrf1tQdM4Nl+DA8+WNUEJDPbTNN2pB5UD/LgvSzkpuXTLj6t8ZfANHx3jsq48
        4e9IEYipCPo51GKruM6XHVxtAfsW5EkcRy9oYvY/VIbK80bMh9DziQaTQN7RuLVqWuWSXL
        5jVKIHE55uZvnN+jij6nCdak0GuTuKA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-NBlR9CO7Nr-RoqYMou2UBg-1; Mon, 10 Aug 2020 10:35:44 -0400
X-MC-Unique: NBlR9CO7Nr-RoqYMou2UBg-1
Received: by mail-wm1-f69.google.com with SMTP id h7so2930341wmm.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 07:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dXWSa0571ciFu2t/WYhoCRkUSyhVOHJkVHffG1Nnkws=;
        b=cdlb+Z48KgypYlWu/ldAT+1Sn/W21P3G4eSzJRSTfEP2HtKxPsWYtTq1QaoZlqrcHS
         2v09f2YiTxwBRe8MXURnIPFsfeu+rOyPLa4TYN6dpRx49fyOfsSCp/5btcqtzmzLW8Os
         coRLIYoE5n9LqHMRhgmmw4YlC5hs/w0ic4bpSVcxlpfJnEipTY4ZpmRmEFgDuchbuOzE
         UEVHf7WUQQb7qAoWvBTcvELQKLc4xl/mxSvrLh8SwaMYm1mmdvq5Rs/FzBGbvWKPkjop
         n9UvvECzrpKaOL+lEEOBFbOhrjfKwwRYxGYkJS9L36Qf/IssdqzrtHkKIsnrDFXmO6cK
         nYpQ==
X-Gm-Message-State: AOAM53119Uqe87EzFuGu69FecMB1wg0xcWekgogybjh0+pjr3CDUjf6K
        lqqBhr+JHQXS8Yf78aoj/rZzEUxElcanaHNOILYO8oe3gifKyekMLpO2oqy0rtK5yw5JLpy5r2p
        W8Wi3gT1AXZX/po6qfhe8mYoK
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr23385139wrp.44.1597070143562;
        Mon, 10 Aug 2020 07:35:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsJrwNV1lKdihec0GG/tFTx2Ql3DBf0DtDHWJt9b3Ujf/23hQsf72YgGEndpIM647ySIAQDw==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr23385131wrp.44.1597070143428;
        Mon, 10 Aug 2020 07:35:43 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id k10sm20742786wrm.74.2020.08.10.07.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 07:35:42 -0700 (PDT)
Date:   Mon, 10 Aug 2020 10:35:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Eli Cohen <elic@nvidia.com>, Eli Cohen <eli@mellanox.com>,
        Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] vdpa/mlx5: Fix pointer math in mlx5_vdpa_get_config()
Message-ID: <20200810103522-mutt-send-email-mst@kernel.org>
References: <20200808093241.GB115053@mwanda>
 <BN8PR12MB3425E1FCC3E20A04182640D2AB470@BN8PR12MB3425.namprd12.prod.outlook.com>
 <20200810103147.GJ1793@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810103147.GJ1793@kadam>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 01:31:47PM +0300, Dan Carpenter wrote:
> On Sun, Aug 09, 2020 at 06:34:04AM +0000, Eli Cohen wrote:
> > Acked-by: Eli Cohen <elic@nvidia.com>
> > 
> > BTW, vdpa_sim has the same bug.
> > 
> 
> I sent a patch for that on April 6.
> 
> [PATCH 2/2] vdpa: Fix pointer math bug in vdpasim_get_config()
> 
> Jason acked the patch but it wasn't applied.
> 
> regards,
> dan carpenter

Oh sorry. I'll drop my patch and queue yours then.

