Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD832C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 04:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998F520774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 04:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUDOXhJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgFIExA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 00:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgFIExA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 00:53:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC31C03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 21:52:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x14so19720965wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 21:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yR4+V3PoDw9Zx36raT7sgsJ7wQW9ERMaRt8cfFCsO08=;
        b=GUDOXhJTqi5gm5FMRzm9qJSUOAokyJsHb4NU9EUNdMCGE/pNjph3LFp274vUpxcie+
         tMkd6+k1byrAlXBvnkdzsjvwFMThbLgh6vraK77fu/i/vE3ivtOYtncvX18Ok9IY+MX+
         zxEe7edPhEQ7NB0ztuP/r8nkmLAd+VV0V3kCwxPDX8EuavYNnaUqy49y26gPA0DCM1gi
         5gfqTzZ1YWqAfCyhZlkgOR1mTeu5dn7pfqGo3FAHHwWFjKxcVCu2pqX5dzJszxXNQN1u
         OsDnSievT7o1xk++13iAYDmHE2h5epHH8qGJkaJnMDH6wANkl3EqrDh5FjntQNqmxvEe
         frxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yR4+V3PoDw9Zx36raT7sgsJ7wQW9ERMaRt8cfFCsO08=;
        b=FqlAFRdfa9P5SBHSm8FX720IB+YxMfs381meeg5TGDt2Q1CZKz3/zjOjFaygoL3kPI
         4S/4X6/K4jqwwfHyX3fLfYqHy0z45zIwhI8HZ9e+5cMzzhxMWPK1WsOjSnURzU9idrgS
         cAZu5FT3Z3RzkwGvAqPIH4fFxgCvAHUPoPoJQenP1hzH29o6VAx7UeTka7M700hUu/p4
         vQMuuuy+EJI5prCU2S5MUyR1NCfbXm9PbRFlRrqsTWq3y3samBxLHIA3NO4GGZwA6Z4e
         tn8i6yMCoX24K9IR/LRo1xdscQLxshoX2VNlEGgdomD1J5cQESG0Rl4FegdV2hT1hgQ5
         19xw==
X-Gm-Message-State: AOAM530P2Q3DMTQ94RK4qz5EQ9x95mzUmD4aoi+GkzhHkRc0y12LyYYr
        sxzIzQ7qUKSA5IdFZUZb/E6Z49r4Drrtl8l1Fuk=
X-Google-Smtp-Source: ABdhPJyxusdMwg+vbBQaUql3T+Dk8EsNZpIufW40sNRbZUPRODUASO1kohqqiL9jqR4K9r+RaV3MsY/7VwX+3BZakeY=
X-Received: by 2002:a5d:4282:: with SMTP id k2mr2248976wrq.196.1591678376880;
 Mon, 08 Jun 2020 21:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200608054517.708167-1-mst@redhat.com>
In-Reply-To: <20200608054517.708167-1-mst@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Tue, 9 Jun 2020 06:52:45 +0200
Message-ID: <CAM9Jb+ipp09ZMtT9gZ7EDK94QLOmTM7CgQfHZFpUQWRggmVWKA@mail.gmail.com>
Subject: Re: [PATCH] virtio-mem: drop unnecessary initialization
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> rc is initialized to -ENIVAL but that's never used. Drop it.
>
> Fixes: 5f1f79bbc9e2 ("virtio-mem: Paravirtualized memory hotplug")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index f658fe9149be..2f357142ea5e 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -1768,7 +1768,7 @@ static void virtio_mem_delete_resource(struct virtio_mem *vm)
>  static int virtio_mem_probe(struct virtio_device *vdev)
>  {
>         struct virtio_mem *vm;
> -       int rc = -EINVAL;
> +       int rc;
>
>         BUILD_BUG_ON(sizeof(struct virtio_mem_req) != 24);
>         BUILD_BUG_ON(sizeof(struct virtio_mem_resp) != 10);

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
