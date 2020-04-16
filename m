Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C615EC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A423921D79
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5f1iFpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635642AbgDPMct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:32:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59697 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2635613AbgDPMce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587040352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0VyMwAzowexFZjgtgFRovq2sXpLz94EE6LhxQbSKU6M=;
        b=U5f1iFpLn0zZBHJayBAIjMqOc9t7l73h2+sVS2Tj2UCoFMgzOO+qkbWnEbC5+TR5KtE5nM
        5BpjePYdw+lV/XKEOK7tnIL7qhjSniZ7bU0RoqYbB1dBjH9j7qA53PfjuM2AUV+lpxf+g/
        QaV25XIVkRhwvAK6FWK8eaQLoLNvpBQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-AjUJxw8LM3mQ8KpWvbsusQ-1; Thu, 16 Apr 2020 08:32:29 -0400
X-MC-Unique: AjUJxw8LM3mQ8KpWvbsusQ-1
Received: by mail-wr1-f70.google.com with SMTP id o12so1632416wra.14
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 05:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0VyMwAzowexFZjgtgFRovq2sXpLz94EE6LhxQbSKU6M=;
        b=pPPYYo7tn4A5uM+pjI+XWsVVXL29WOIB8vmevhymxMHFXwt/74a77CkwfS2oUPX/M4
         W1RtARLPjFqw/k0wNKtQZAriMeMhxs+3nvaWL0mWOnQYXr8pG7boZZHxbfAda/ZOY4sa
         uzw3SOchDUW57cfSaALdD0+Dsqdt/ZyOeNsGFLCw3cDt3NiuJf71rJAIJvwxMmM1ZF7e
         BjWhH3pN8XfLFM0a2Q9fM1dTU2DmQQg+IyHhtTBsvGgMXr5r6Gfg1X/YOL8dcpEA2vGH
         VOVT7PDtHEipmyzXUckmrubu6Xt/Yahwr2T7QD/C+AS4vuaJyOdSoy0uSp2c1iEVf2nF
         URMA==
X-Gm-Message-State: AGi0PubY13xGTSC2KWebt1OH8HqMbOh56ErUZhHsBXzPYdTHEDFvyiR4
        u4/Anb5LNC3hC2ybPpKzTY5Et58VD52r18HRhVqsa2AFB0Cvqqj9BIvQ2EEoFg3O+n+qImFig29
        L/ywpOF0PNWKwmPnhZHcQXdCF
X-Received: by 2002:adf:dc06:: with SMTP id t6mr30558901wri.385.1587040348033;
        Thu, 16 Apr 2020 05:32:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypIfoJajvWS7IEEc1sc0ClwIXFD0DzNYfYWsVh5RONPu0C09BwqAJcBPfglPDU6iaP06YIqewA==
X-Received: by 2002:adf:dc06:: with SMTP id t6mr30558886wri.385.1587040347864;
        Thu, 16 Apr 2020 05:32:27 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
        by smtp.gmail.com with ESMTPSA id p10sm26656903wrm.6.2020.04.16.05.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 05:32:27 -0700 (PDT)
Date:   Thu, 16 Apr 2020 08:32:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: linux-next: Tree for Apr 15 (vdpa)
Message-ID: <20200416082248-mutt-send-email-mst@kernel.org>
References: <20200415152240.2422e06c@canb.auug.org.au>
 <620e1646-5899-a077-b9de-95443887364d@infradead.org>
 <33e4922f-d2b5-f3fa-4d32-a5db5a177238@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33e4922f-d2b5-f3fa-4d32-a5db5a177238@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 12:07:06PM +0800, Jason Wang wrote:
> 
> On 2020/4/16 上午12:16, Randy Dunlap wrote:
> > On 4/14/20 10:22 PM, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Changes since 20200414:
> > > 
> > on x86_64:
> > 
> > ERROR: modpost: "vringh_set_iotlb" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
> > ERROR: modpost: "vringh_init_iotlb" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
> > ERROR: modpost: "vringh_iov_push_iotlb" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
> > ERROR: modpost: "vringh_iov_pull_iotlb" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
> > ERROR: modpost: "vringh_complete_iotlb" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
> > ERROR: modpost: "vringh_getdesc_iotlb" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
> > 
> > 
> > Full randconfig file is attached.
> > 
> 
> The config has
> 
> CONFIG_VHOST_IOTLB=m
> CONFIG_VHOST_RING=y
> 
> But we don't select VHOST_IOTLB in VHOST_RING after commit
> e6faeaa128417("vhost: drop vring dependency on iotlb"). Which seems wrong.
> 
> Thanks

Well selecting IOTLB from ring breaks configs which don't need IOTLB.

Legal configurations are:

CONFIG_VHOST_IOTLB=y
CONFIG_VHOST_RING=n

CONFIG_VHOST_IOTLB=m
CONFIG_VHOST_RING=n

CONFIG_VHOST_IOTLB=n
CONFIG_VHOST_RING=n

CONFIG_VHOST_IOTLB=y
CONFIG_VHOST_RING=y

CONFIG_VHOST_IOTLB=n
CONFIG_VHOST_RING=y

CONFIG_VHOST_IOTLB=n
CONFIG_VHOST_RING=m

CONFIG_VHOST_IOTLB=y
CONFIG_VHOST_RING=m

CONFIG_VHOST_IOTLB=m
CONFIG_VHOST_RING=m


So VHOST_RING=y and VHOST_IOTLB=m is the only illegal one.


-- 
MST

