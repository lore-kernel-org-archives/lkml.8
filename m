Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045BEC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB04A20757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2fQ6Fhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbgDBOgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:36:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52331 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727412AbgDBOgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585838209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WlR2TRXNoUHH0cejtWwgFkeiMST3WWqkeQGN0pr6VCA=;
        b=D2fQ6Fhy0i1JucsjPDgWcGUGtdVr+qNrpFu6SQtavBiFpqnJzxs1V5VETv5KVAaT6LKLLF
        e1NgMEJUQHT2ggzc4kJbRq54bjn1w40e19kLqr8ICty32I+9gcGPVIbd4wjAbu8dGsEsE6
        DRbAD22UM6/UZXcIQkbcSMWteIjT7Ks=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-IHDIECvPNby4HvmEOQnyfA-1; Thu, 02 Apr 2020 10:36:48 -0400
X-MC-Unique: IHDIECvPNby4HvmEOQnyfA-1
Received: by mail-qk1-f198.google.com with SMTP id d189so903840qkc.15
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 07:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WlR2TRXNoUHH0cejtWwgFkeiMST3WWqkeQGN0pr6VCA=;
        b=gW5HPgrBAb8Bmek7BTyARvAwXtI8ctW58/oN2qhP3DsLqgJoT63vHsJfwumLoZjKhD
         X9RVIerOmo7inKpBvb8UYSZFVwWKeqv6EygKLLqe3lBKVcnYxfoaHCYf8MS5xMmAhEjU
         g4LNFOR3kD5J3G94V4weTXPqrbdk7rlA6rJiehhKQLxkmybU6KSNCJavwhS9CdN/OVay
         6xNB4DXQh5IBQgTrscFl73u9hk7h2jFX5sAc+hmvlJzq+4vzsU3y/wyCLTCYgwxMuD+e
         ygqYVoao88nxpeCGYjPzr/6uQu8cd+xPMLOejRb6jyI6rZtKkxgOAPg+Px9FLLTO2NyX
         4p4g==
X-Gm-Message-State: AGi0PubXUBuQb4XipnnfckKMRk3wywRVku9djap4elA02/QF7OSRqFye
        Q/9xU2Mld0qC6masKtkvsXjEKP5vUwJNm2NPUZaICHjf41xtqUark/GTtlTuJWMM9C0FUKtlEnm
        mzQoDNx43r/Ebzy8PIiz0R5tY
X-Received: by 2002:ac8:1bf5:: with SMTP id m50mr3204223qtk.200.1585838208360;
        Thu, 02 Apr 2020 07:36:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypJIJxmszAzRx8icml77RBvawgNMOKh/hgQNez6YoUnUaICm+K3+fAJ0a9bgYwRVNdObKb/nbw==
X-Received: by 2002:ac8:1bf5:: with SMTP id m50mr3204184qtk.200.1585838207990;
        Thu, 02 Apr 2020 07:36:47 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id u40sm3854770qtc.62.2020.04.02.07.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 07:36:47 -0700 (PDT)
Date:   Thu, 2 Apr 2020 10:36:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] vhost: drop vring dependency on iotlb
Message-ID: <20200402103551-mutt-send-email-mst@kernel.org>
References: <20200402141207.32628-1-mst@redhat.com>
 <afe230b9-708f-02a1-c3af-51e9d4fdd212@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afe230b9-708f-02a1-c3af-51e9d4fdd212@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 10:28:28PM +0800, Jason Wang wrote:
> 
> On 2020/4/2 下午10:12, Michael S. Tsirkin wrote:
> > vringh can now be built without IOTLB.
> > Select IOTLB directly where it's used.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > This is on top of my previous patch (in vhost tree now).
> > 
> >   drivers/vdpa/Kconfig  | 1 +
> >   drivers/vhost/Kconfig | 1 -
> >   2 files changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> > index 7db1460104b7..08b615f2da39 100644
> > --- a/drivers/vdpa/Kconfig
> > +++ b/drivers/vdpa/Kconfig
> > @@ -17,6 +17,7 @@ config VDPA_SIM
> >   	depends on RUNTIME_TESTING_MENU
> >   	select VDPA
> >   	select VHOST_RING
> > +	select VHOST_IOTLB
> >   	default n
> >   	help
> >   	  vDPA networking device simulator which loop TX traffic back
> > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > index 21feea0d69c9..bdd270fede26 100644
> > --- a/drivers/vhost/Kconfig
> > +++ b/drivers/vhost/Kconfig
> > @@ -6,7 +6,6 @@ config VHOST_IOTLB
> >   config VHOST_RING
> >   	tristate
> > -	select VHOST_IOTLB
> >   	help
> >   	  This option is selected by any driver which needs to access
> >   	  the host side of a virtio ring.
> 
> 
> Do we need to mention driver need to select VHOST_IOTLB by itself here?
> 
> Thanks
> 

OK but I guess it's best to do it near where VHOST_IOTLB is defined.
Like this?


diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index bdd270fede26..ce51126f51e7 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -3,6 +3,8 @@ config VHOST_IOTLB
 	tristate
 	help
 	  Generic IOTLB implementation for vhost and vringh.
+	  This option is selected by any driver which needs to support
+	  an IOMMU in software.
 
 config VHOST_RING
 	tristate

