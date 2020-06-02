Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162DAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB0BF2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqF+hkdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgFBFCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:02:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21622 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726589AbgFBFCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591074130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=unNhbaKpoHgJDBrC7Eb3u/ZNlGD55wlBW/mLz0bPcnk=;
        b=RqF+hkdBCz2NBIx4YiYPNT2FHvdUGmCk6cjxHBla32SRN/FYe9jrEWUuX5lrSlhkbsIRd3
        Ng3d/Ri113jXlW9kVda4B8evkZXHIAC2BDMyaSp87GZW5uFnHwT4iDc2tZV2iJLt4FROra
        tYo+w3Bq9FyLYdBPpUaZS9h+3xkG3m8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-8BVDiWdeM7Cm1Gaogckung-1; Tue, 02 Jun 2020 01:02:02 -0400
X-MC-Unique: 8BVDiWdeM7Cm1Gaogckung-1
Received: by mail-wm1-f69.google.com with SMTP id j128so474829wmj.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 22:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=unNhbaKpoHgJDBrC7Eb3u/ZNlGD55wlBW/mLz0bPcnk=;
        b=PJBq9lL+3G09mZ6pOBA09LS56O+PmBTxGSq2W4sTs3hEE5GxM4pw0M49ku3stpidAM
         DsACisgcUcxWQB99Vv/SNAC4gT31vFLOHeaTa/I+wq3o3qY0cSsBe8eBoivB7W0TNELc
         R+OsQxQHou0NdeneCtbqjomQeE2SPq9HIa8lzS73dEWpMWfstimDainzQPyTANqCkqrL
         +aoc2OoUyobs1RbT1dnjo9GRKEDjdnWVguhmSA4YP3ZwyuGTTtCngrr7owHEHw7Uxdod
         dMuew8OFGWUDyC00WdsqtOxM43jT+qag4cwSDhtIKXmmAIq8X6vKAG0NqTfJKShwDJd9
         hPvw==
X-Gm-Message-State: AOAM530C32NOxpg5FCzm1ORS8zVo4dc/AzV+GY1lq4ebe12/jok64Rpd
        YXh7+Vv0+e1Vdv0S1Ii1tn6gL2YazRI3CCUvuXlY99aU/LsS3tB/YKb5KwNFg2MjtCd7nB167VD
        qEkwtYCeyJZmELfkuwGeM83v9
X-Received: by 2002:adf:9b9e:: with SMTP id d30mr25308461wrc.345.1591074121705;
        Mon, 01 Jun 2020 22:02:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3nr1AXCn3Z5SMmVoLwH2lrM47voNMRhlWpVupnJ+5ZSE/pBwVxy8G2I2bBBJ+b49EcSyp0Q==
X-Received: by 2002:adf:9b9e:: with SMTP id d30mr25308453wrc.345.1591074121511;
        Mon, 01 Jun 2020 22:02:01 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id w3sm1759935wmg.44.2020.06.01.22.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 22:02:00 -0700 (PDT)
Date:   Tue, 2 Jun 2020 01:01:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: Re: [PATCH 1/6] vhost: allow device that does not depend on vhost
 worker
Message-ID: <20200602005904-mutt-send-email-mst@kernel.org>
References: <20200529080303.15449-1-jasowang@redhat.com>
 <20200529080303.15449-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529080303.15449-2-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 04:02:58PM +0800, Jason Wang wrote:
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index d450e16c5c25..70105e045768 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -166,11 +166,16 @@ static int vhost_poll_wakeup(wait_queue_entry_t *wait, unsigned mode, int sync,
>  			     void *key)
>  {
>  	struct vhost_poll *poll = container_of(wait, struct vhost_poll, wait);
> +	struct vhost_work *work = &poll->work;
>  
>  	if (!(key_to_poll(key) & poll->mask))
>  		return 0;
>  
> -	vhost_poll_queue(poll);
> +	if (!poll->dev->use_worker)
> +		work->fn(work);
> +	else
> +		vhost_poll_queue(poll);
> +
>  	return 0;
>  }
>

So a wakeup function wakes up eventfd directly.

What if user supplies e.g. the same eventfd as ioeventfd?

Won't this cause infinite loops?

-- 
MST

