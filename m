Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4736C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968E3204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULtg1T1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgFJJnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:43:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40947 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727007AbgFJJnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591782228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cqenDkPII+w3N9PhboDRPWmnWtl237duUuxheBtHmo8=;
        b=ULtg1T1/XsVJYYqXJx7SeYp6kHy8AA8Tlp1vLlvDmhy3V3Puy29XCbZNQfHI3dl7WjcluD
        REXOxi/r1oCDajtGwruedwm1dVTrAirDFAHmwuuDKESq9lZIft5SFGRIGv/mO3nSrjIuIM
        rZ40Mst6HSB+CGN1iEUbIare8paf3CI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-FLATmCo3Ng2v1UCOdTyLNw-1; Wed, 10 Jun 2020 05:43:45 -0400
X-MC-Unique: FLATmCo3Ng2v1UCOdTyLNw-1
Received: by mail-wr1-f71.google.com with SMTP id r5so846039wrt.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=cqenDkPII+w3N9PhboDRPWmnWtl237duUuxheBtHmo8=;
        b=Qdt7Xr+bE1DcSmZVWgsLyhpo6H+ogWLWvR8r7x+J0rDpRQwz9OC36WTqy1J/ROX9Rj
         6N7jsxMsXJbo1xSNG0rfFeSRe8Q7K4EoBvp5LqRTE5UiRg6tCkq9a3ANfn+NTrwEZeJ+
         KXl5qoBnmbWGCUmM/h2Pu3sOM3YpqoLLoxK7hKKpuqfeZlfPwHYA5YMpghqXCcRbr2v7
         M0YQVMkTsfuxwK+lXCjnK2DPriqCiL/VzzeRBlL3SLQc893gH9jWHey73a2xw7AWkfuR
         jbVP3/MBbOVXUDvq0hLFjsfEu2lOe7AgpqW7C18Kr3JCvm3H13I3BOQLCR6+hfKPllMx
         Fa2A==
X-Gm-Message-State: AOAM530n/JrUP5YgdILGVxQHYHGUkxBwOhYRp7Yjkyas647NyVnyeS/j
        NWJcLE8J0akX32p3kmr65kbI5eIjISBr4cqDBHDu3pQMpQzZmfHU6AbXCiM1GU61xw4UhtnAEyO
        B9Y5qAoJ5YSrvMkoVVgoESJpd
X-Received: by 2002:adf:ecc2:: with SMTP id s2mr2948664wro.60.1591782224277;
        Wed, 10 Jun 2020 02:43:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVmcr+jf7/ZMdNhZWn5hNRs0ZgnnoTFCWKF9letJebZyLdzd6sY5umcaFiaoilisOKVzp02w==
X-Received: by 2002:adf:ecc2:: with SMTP id s2mr2948642wro.60.1591782224092;
        Wed, 10 Jun 2020 02:43:44 -0700 (PDT)
Received: from [192.168.3.122] (p4ff23dec.dip0.t-ipconnect.de. [79.242.61.236])
        by smtp.gmail.com with ESMTPSA id r5sm7527242wrq.0.2020.06.10.02.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 02:43:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] virtio-mem: silence a static checker warning
Date:   Wed, 10 Jun 2020 11:43:42 +0200
Message-Id: <56B2561B-33AC-40AB-9991-97EC72F9613F@redhat.com>
References: <20200610085911.GC5439@mwanda>
Cc:     David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20200610085911.GC5439@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 10.06.2020 um 10:59 schrieb Dan Carpenter <dan.carpenter@oracle.com>:
>=20
> =EF=BB=BFSmatch complains that "rc" can be uninitialized if we hit the "br=
eak;"
> statement on the first iteration through the loop.  I suspect that this
> can't happen in real life, but returning a zero literal is cleaner and
> silence the static checker warning.
>=20

Right, it=E2=80=98s impossible in real life. Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> drivers/virtio/virtio_mem.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index f658fe9149beb..893ef18060a02 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -1192,7 +1192,7 @@ static int virtio_mem_mb_plug_any_sb(struct virtio_m=
em *vm, unsigned long mb_id,
>                        VIRTIO_MEM_MB_STATE_OFFLINE);
>    }
>=20
> -    return rc;
> +    return 0;
> }
>=20
> /*
> --=20
> 2.26.2
>=20

