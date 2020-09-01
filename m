Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A70C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3DC220FC3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eflOJVhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgIALSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:18:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29448 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726674AbgIALOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598958882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=STUtmyXZIT8KzVqJU5XU2kgQYureljA3Ku1GnLyYimw=;
        b=eflOJVhF4wU+cFqUufWQbmr0ly5UkDL027i6zHChfvAQluBtOVBB4t57Etw0iwiwLuknIz
        C6FLshb30wE32PSSs983xOx0tIM6rykIBvq30gSH9SFKbVc3QUbXjr9TdjJVwszXqM9Emt
        w5CIgpqc5ub7CF0uOXucpuBdge+yn2I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-N_yNyRGVPvSnDDfvYn5UMg-1; Tue, 01 Sep 2020 07:14:41 -0400
X-MC-Unique: N_yNyRGVPvSnDDfvYn5UMg-1
Received: by mail-wm1-f69.google.com with SMTP id a144so276562wme.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 04:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=STUtmyXZIT8KzVqJU5XU2kgQYureljA3Ku1GnLyYimw=;
        b=jNyFmh4NcyEKlkes1oJCZGdVPzmLFxADUmIzFBrVJlVAn2x0QZyJcl+IJG/dAyJBrj
         VkJIDLedpe6TIPc8JLoZwXQWoW0aGup8nThVvq4HKlxcKKa+Inilt30Ug+Iz1Bp3KqZm
         aPYMs+sxmVkOyaCvyZ6+RJZTmYiY25py/HWHkvxzbjetnEot4iaW2heWgr3ar2ytNczS
         ax9KAGx1fnodDvb8/QaC2VdatCD6UgQTGTymDQBB9zEWAYMIC0CEeEwUV0WvLnKtuSAO
         c4oQPNjyRZadZy8VsyVeHBsoJ4g/BuoThgww9R4My21GV1Rm+8YZO5/p0Lfgs1LTPtXS
         aaqw==
X-Gm-Message-State: AOAM533CgWNP2Qd8Vn20O2SDKZ/NodHnFlzgiVWXZjkLXkZkxP83sKJT
        9Z1gF57iENnWIZ2z4cQcVJzC0c8LFx1Gb89fOeXGS4jvITUxJRAopIMSEmDctCmpqnGnP2RRvTD
        0oqZotwGSY5MWqivFtTNnhnVO
X-Received: by 2002:a7b:c925:: with SMTP id h5mr1261021wml.28.1598958879546;
        Tue, 01 Sep 2020 04:14:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhiep0HYoVEPjzoTxNmrDMLvfem8Qoq1Zugr1LpbcVQJKpBDMnkFnDG0mj5yp0i4zCh7HKeg==
X-Received: by 2002:a7b:c925:: with SMTP id h5mr1261007wml.28.1598958879391;
        Tue, 01 Sep 2020 04:14:39 -0700 (PDT)
Received: from redhat.com (bzq-79-181-14-13.red.bezeqint.net. [79.181.14.13])
        by smtp.gmail.com with ESMTPSA id d18sm1614949wrm.10.2020.09.01.04.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 04:14:38 -0700 (PDT)
Date:   Tue, 1 Sep 2020 07:14:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH net-next] vhost: fix typo in error message
Message-ID: <20200901071400-mutt-send-email-mst@kernel.org>
References: <1598927949-201997-1-git-send-email-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598927949-201997-1-git-send-email-linyunsheng@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 10:39:09AM +0800, Yunsheng Lin wrote:
> "enable" should be "disable" when the function name is
> vhost_disable_notify(), which does the disabling work.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Why net-next though? It's a bugfix, can go into net.


> ---
>  drivers/vhost/vhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 5857d4e..b45519c 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2537,7 +2537,7 @@ void vhost_disable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  	if (!vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX)) {
>  		r = vhost_update_used_flags(vq);
>  		if (r)
> -			vq_err(vq, "Failed to enable notification at %p: %d\n",
> +			vq_err(vq, "Failed to disable notification at %p: %d\n",
>  			       &vq->used->flags, r);
>  	}
>  }
> -- 
> 2.8.1

