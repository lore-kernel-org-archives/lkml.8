Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD17C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 11:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901A2214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 11:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQm0rw8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgCALcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 06:32:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50752 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725787AbgCALcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 06:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583062355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zR/LdJJnupWbWl+mH1H8twhZv1I1NZI2NpfYhhtSOII=;
        b=dQm0rw8u/fDD6/E1uULWdMzjlq+1WeznPLkrG6wZQJOeKhrWw0NkOLBCZ915DwRHyj5mso
        9ktD8V/QL3imonbtkt5Y+V3/uyHLodyBL4NAj+PPFDqvPyceh5Ou7V2ov1pa9FXRof1UKf
        +jkC815x5IReC2vPLSNZeBSGeHR8VdU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-BfwoqQp7MASZL-SfoU-b7Q-1; Sun, 01 Mar 2020 06:32:31 -0500
X-MC-Unique: BfwoqQp7MASZL-SfoU-b7Q-1
Received: by mail-qv1-f72.google.com with SMTP id cn2so6668165qvb.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 03:32:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zR/LdJJnupWbWl+mH1H8twhZv1I1NZI2NpfYhhtSOII=;
        b=YDJ3t/K9fpmYRzcx7WXLty95TUFrBBJn2u/X/81Mnm6MoYGctStSSkhHZQzZJp4Gis
         49nSDzsda6TbdXbnPF23PrNjg6EuYHKPeR3vyz///gS7gO83pfnyzvMWmISi1uZdRAVL
         HitlswXwjvRw+I8c9roQnSveXVeovN8xCE00RngO+LxQZa9P9BUr5YCjniJ+V2YJJ46t
         ++D5ioS0HKNKI4VxXZRP1v5T+bs2o4qR8o9klHTaJFqSyKVJGx436IRAvkhsNXYQgRLJ
         k1mgH6Don/dSutLookRb6rsKgXAyKIRwBhdHyajhHNDS40yJFLm04QH47uSDAr5LmG+T
         IjmQ==
X-Gm-Message-State: APjAAAV6wKJGRobWvX6eDDP9lHb8Skb3BqdcgQWV/RALjf7U9dbXnNTE
        q22S5xwfqvTg08uQkxu2wIwrPxLj8ZfVO/r6WW/gIjup9XXNpTs2YYZm6lK19HRz0dVz4eThQUn
        THfbhFedaP02z9sUqHQOwpTWH
X-Received: by 2002:a37:a9c3:: with SMTP id s186mr11388264qke.118.1583062350999;
        Sun, 01 Mar 2020 03:32:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqwN2KD8vMG5Oz6ApHiiKMTGkLA+MN8pVictr/ay8FZqU16cVcRdz1BqNJooFZNymjo2uQiuXw==
X-Received: by 2002:a37:a9c3:: with SMTP id s186mr11388257qke.118.1583062350805;
        Sun, 01 Mar 2020 03:32:30 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
        by smtp.gmail.com with ESMTPSA id 17sm5675999qkc.81.2020.03.01.03.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 03:32:30 -0800 (PST)
Date:   Sun, 1 Mar 2020 06:32:25 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yuri Benditovich <yuri.benditovich@daynix.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yan@daynix.com
Subject: Re: [PATCH v2 0/3] virtio-net: introduce features defined in the spec
Message-ID: <20200301063121-mutt-send-email-mst@kernel.org>
References: <20200301110733.20197-1-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301110733.20197-1-yuri.benditovich@daynix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 01:07:30PM +0200, Yuri Benditovich wrote:
> This series introduce virtio-net features VIRTIO_NET_F_RSC_EXT,
> VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT.
> 
> Changes from v1:
> __virtio -> __le
> maximal -> maximum
> minor style fixes


Looks good to me - sent a bit of consmetics.

But as any virtio UAPI change, please CC virtio-dev as virtio TC maintains the
interface. Thanks!

> Yuri Benditovich (3):
>   virtio-net: Introduce extended RSC feature
>   virtio-net: Introduce RSS receive steering feature
>   virtio-net: Introduce hash report feature
> 
>  include/uapi/linux/virtio_net.h | 90 +++++++++++++++++++++++++++++++--
>  1 file changed, 86 insertions(+), 4 deletions(-)
> 
> -- 
> 2.17.1

