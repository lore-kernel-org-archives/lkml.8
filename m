Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBB4C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B40206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ag2z6ud+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389812AbgDBQ1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:27:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43220 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731842AbgDBQ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585844838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YiGejvc/Z1PscIO5Y2Td9wzrTW6YFSsKAEAcda9xkVg=;
        b=Ag2z6ud+W6EitAuuH3ul2VNbpjqPg73QNlCogAIaqelZG9W9C03Afpy1VGs1RpxX5YI7fh
        bkA8MXwJSHjerB3n8Fa0cblzmbsSf0rVbMEDu/5COM+1fqeT9TbWo40atenRjGJjZhqea5
        c5uqRtSmTPDHeF4XATvmXIU5t9F1DDA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-5YxRsdsgOaOO0JNA-DjyZA-1; Thu, 02 Apr 2020 12:27:15 -0400
X-MC-Unique: 5YxRsdsgOaOO0JNA-DjyZA-1
Received: by mail-qt1-f197.google.com with SMTP id i36so3673194qtd.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 09:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YiGejvc/Z1PscIO5Y2Td9wzrTW6YFSsKAEAcda9xkVg=;
        b=famgeHy5uU0/GuQJUVaPlq+bm92Xhysm6+gpZiQl0U+E1hQLYWyAZetAVTyjNLvg7N
         svwi19U8JQWHIHW+ax94eIPbDdtz9RVEpzaByRHZAwKAk6uqzRVyMHFGvGrsus78Z7yw
         4Anwc/VXTiOZ4a80PoOlCHhZ4fyWFfNSoVeIMkSYWJrRNp35G4jML/siQII1TnhC8Tti
         2ABunAMgWLoh1ukZsdb4AU4tthB3sKB80PZqlap4r3069tqERlORDNg8rzfTI75EOAXm
         QLqNjAIWa01AHH0ZRR9bGXIAUmNfAp0B84VdL15g1rZDqF0igqigbwgZM6oBBnSB++mu
         FqPQ==
X-Gm-Message-State: AGi0PuZ+APjH2S5aPjsvQ0IJNMM2gJZpWS7U+vM1IiUyjddkMVho6mTw
        7FOtwhIFK9RqoA6uGy4tEu4jG/eplnJW+0PBPnpO9hVgASGwioJ9lwMP0RRkDNNIv0qmu35oJ2A
        VEco2y3QzO06tb5rUYEssRarD
X-Received: by 2002:ac8:4641:: with SMTP id f1mr3595344qto.216.1585844834572;
        Thu, 02 Apr 2020 09:27:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypI9uiNgZebAWGTM/6pTKMcpl2+Pbh6hcnrsxur+SijZm8gBzgmehd7nG3POHrAdyCwNw6XVFw==
X-Received: by 2002:ac8:4641:: with SMTP id f1mr3595317qto.216.1585844834186;
        Thu, 02 Apr 2020 09:27:14 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id v17sm3764796qkf.83.2020.04.02.09.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 09:27:13 -0700 (PDT)
Date:   Thu, 2 Apr 2020 12:27:09 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2] vhost: drop vring dependency on iotlb
Message-ID: <20200402122544-mutt-send-email-mst@kernel.org>
References: <20200402144519.34194-1-mst@redhat.com>
 <44f9b9d3-3da2-fafe-aa45-edd574dc6484@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44f9b9d3-3da2-fafe-aa45-edd574dc6484@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 11:01:13PM +0800, Jason Wang wrote:
> 
> On 2020/4/2 下午10:46, Michael S. Tsirkin wrote:
> > vringh can now be built without IOTLB.
> > Select IOTLB directly where it's used.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > Applies on top of my vhost tree.
> > Changes from v1:
> > 	VDPA_SIM needs VHOST_IOTLB
> 
> 
> It looks to me the patch is identical to v1.
> 
> Thanks


you are right. I squashed the description into
    virtio/test: fix up after IOTLB changes
take a look at it in the vhost tree.

> 
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
> > index f0404ce255d1..cb6b17323eb2 100644
> > --- a/drivers/vhost/Kconfig
> > +++ b/drivers/vhost/Kconfig
> > @@ -8,7 +8,6 @@ config VHOST_IOTLB
> >   config VHOST_RING
> >   	tristate
> > -	select VHOST_IOTLB
> >   	help
> >   	  This option is selected by any driver which needs to access
> >   	  the host side of a virtio ring.

