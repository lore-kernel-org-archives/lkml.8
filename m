Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D66C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 20:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E907C246BF
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 20:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpxN5UuG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgCAUGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 15:06:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27539 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725895AbgCAUGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 15:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583093214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q7H4hPNYog/tbA35c9gkSElzqFK/7oYTQGCuX/AtR8g=;
        b=MpxN5UuG+3mKaP8huodK9LqwjNMqAM7d4Jlit+ePvOp0ueLttbmPBwn6s3euelccQY7m7k
        ntJPHBgz8IAHnEdyjoQmfmru9KJQmEYqSnlTdu4gbEPleEV9fvIaEEqFt+87wvrMvZJPp0
        A4jrgZR0bEavSYzxhmE0P/n458fhf/U=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-70XSWzalOsWK_jyOpy4JtA-1; Sun, 01 Mar 2020 15:06:52 -0500
X-MC-Unique: 70XSWzalOsWK_jyOpy4JtA-1
Received: by mail-qt1-f200.google.com with SMTP id p12so7532742qtu.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 12:06:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q7H4hPNYog/tbA35c9gkSElzqFK/7oYTQGCuX/AtR8g=;
        b=H1vt8Nli9g8YJG29lhFT9MuEee3B9cDkndzrr1RfmtAZWGMpxR7xrtc978/KwZBdmT
         HwAgi3G2fff5/QLokiUZs+K/7E9kYAtHV73yK6g6Lh/bNx88fiPG9nRDMRW5PbLyfU7L
         RHoSTR01IaaytTHpjMZE8oSazAq/OgXr1o7QwZYAcG2cmIyIl9EW/2Koo8F+vPzJHmjd
         hIYw6c7YB2MPg9oYc/m+ACoc/peZQga0QRFIsO8K6FXSEr7H/nduAfFTBH2jyUTiWO+i
         qtq5BY2biUj0hkBO4H/rP4pb5iuYXjiHjeA5LJ23UOR46YZq+KEs1nwWHpLCHQ2/dlbf
         AR3A==
X-Gm-Message-State: ANhLgQ3qpLHg1o1wgkhcEwcwbSFdOzSXfEIAGjFXMWUU+svOFn/MW1/q
        Ocuv6jWeMvJdJYgEn25thEfGTX2AAKUVYXmRyR9Ca13Qa3wBDdF1vi+s0CbZHd5xmAfmnfU5s3D
        Xn09aMMfOIwxJ68jgx8zjLV0Y
X-Received: by 2002:ac8:5183:: with SMTP id c3mr5374061qtn.299.1583093212059;
        Sun, 01 Mar 2020 12:06:52 -0800 (PST)
X-Google-Smtp-Source: ADFU+vusETAvYjcJ1HtYXHojlWB1Rd8L85okakt1rmMuxTe8ftDDkfFDjav/Zq5ihrTjqaRXwNuMhw==
X-Received: by 2002:ac8:5183:: with SMTP id c3mr5374047qtn.299.1583093211820;
        Sun, 01 Mar 2020 12:06:51 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
        by smtp.gmail.com with ESMTPSA id e2sm8930835qkb.112.2020.03.01.12.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 12:06:50 -0800 (PST)
Date:   Sun, 1 Mar 2020 15:06:46 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yuri Benditovich <yuri.benditovich@daynix.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yan@daynix.com,
        virtio-dev@lists.oasis-open.org
Subject: Re: [PATCH v3 0/3] virtio-net: introduce features defined in the spec
Message-ID: <20200301150625-mutt-send-email-mst@kernel.org>
References: <20200301143302.8556-1-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301143302.8556-1-yuri.benditovich@daynix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 04:32:59PM +0200, Yuri Benditovich wrote:
> This series introduce virtio-net features VIRTIO_NET_F_RSC_EXT,
> VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT.
> 
> Changes from v2: reformatted structure in patch 1


Looks good but I cound a couple more nits. Sorry I missed them
on the previous read.

> Yuri Benditovich (3):
>   virtio-net: Introduce extended RSC feature
>   virtio-net: Introduce RSS receive steering feature
>   virtio-net: Introduce hash report feature
> 
>  include/uapi/linux/virtio_net.h | 100 ++++++++++++++++++++++++++++++--
>  1 file changed, 96 insertions(+), 4 deletions(-)
> 
> -- 
> 2.17.1

