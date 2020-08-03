Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C26DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C88208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXBqGDnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgHCVYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:24:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40599 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726370AbgHCVYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596489840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dXYb/lLcqMNHaL94ouMomDU8DMTLeQCp1rZbDZouExs=;
        b=ZXBqGDnXr/LhW7uqP8xyI4Kn8UBsiLEAzd2JS4PjZmWCU42F+MiE0f8QlRh89z39HW05fY
        u3DuDZ6qPeBvgoi3CX+wGmuNKpi3FmFqrtS6ciH5lw3LJVQu+WhVQcEtevnusRvB/I3SK2
        NKdTVoyPD3GydaAG8GJwnFhgtfKma9M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-x3L17Wn0NT2noTgt_6uuIw-1; Mon, 03 Aug 2020 17:23:58 -0400
X-MC-Unique: x3L17Wn0NT2noTgt_6uuIw-1
Received: by mail-ej1-f69.google.com with SMTP id e22so9381293ejx.18
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=dXYb/lLcqMNHaL94ouMomDU8DMTLeQCp1rZbDZouExs=;
        b=L8vdmJ+T198rKKiVWzFBK8vNNIH4OOOAgGRNlYhHcYQv/HwP2DSDEmn3wy5WV2JM3e
         rJe3NCFVKXxjpicbA//0GS7+dDkJ+gXml7EwFxXr4QNdRPnfA4/DZLCmoybgTqdFCJFf
         RMN5Hs02F665TutbLJQZWzMnC0iYV3s2s3wE88jMHCLykX/lA7yFFzpU3x37U0RO+XFd
         kWFQeS88oYAjnf5UH75gYcie1QOrUKHCfiUj3ZsfLUZ8GweN7PoeC6dYs0Lq8QVqHn8s
         EBJ6wHS/sqYzPzhPuXtxgI2uU3u7xtz4q7HJyGn1Vnx7kydwLxCLryXjRAet6cEzoxSC
         qVPA==
X-Gm-Message-State: AOAM531+83JHuOt18iagE6zFv6CP9WwD9FwhQ6aFE+KWBLr4OZtVPSUK
        5KjHwR9/A2MG0XRN02byeE0AAfxjn74ixMA+CkJCjSqyLR8Uy0BWA1uX1xWxNX7WeMwt5jbg0gF
        4Vn6szGCbrpSVf5B0MULw9OBc
X-Received: by 2002:a50:d655:: with SMTP id c21mr17128421edj.49.1596489836975;
        Mon, 03 Aug 2020 14:23:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9I1gjkEaXGh8qVzCjl0anLUZO0DuGenZt4s5ea0cJEoQXiT5U/ffATDFfC1PlsKqrxI5U+Q==
X-Received: by 2002:a50:d655:: with SMTP id c21mr17128405edj.49.1596489836766;
        Mon, 03 Aug 2020 14:23:56 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c6449.dip0.t-ipconnect.de. [91.12.100.73])
        by smtp.gmail.com with ESMTPSA id s15sm16948785ejb.16.2020.08.03.14.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 14:23:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 13/24] virtio_mem: correct tags for config space fields
Date:   Mon, 3 Aug 2020 23:23:55 +0200
Message-Id: <CB3AAE22-6BCA-448E-B499-AA4554755518@redhat.com>
References: <20200803205814.540410-14-mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        David Hildenbrand <david@redhat.com>
In-Reply-To: <20200803205814.540410-14-mst@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 03.08.2020 um 22:59 schrieb Michael S. Tsirkin <mst@redhat.com>:
>=20
> =EF=BB=BFSince this is a modern-only device,
> tag config space fields as having little endian-ness.
>=20
> TODO: check other uses of __virtioXX types in this header,
> should probably be __leXX.

Doesn=E2=80=98t matter in practice IIRC, like this change. But we could do i=
t (the spec documents everything as __le) in case it makes things clearer.

Acked-by: David Hildenbrand <david@redhat.com>

>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> include/uapi/linux/virtio_mem.h | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/uapi/linux/virtio_mem.h b/include/uapi/linux/virtio_m=
em.h
> index a9ffe041843c..70e01c687d5e 100644
> --- a/include/uapi/linux/virtio_mem.h
> +++ b/include/uapi/linux/virtio_mem.h
> @@ -185,27 +185,27 @@ struct virtio_mem_resp {
>=20
> struct virtio_mem_config {
>    /* Block size and alignment. Cannot change. */
> -    __u64 block_size;
> +    __le64 block_size;
>    /* Valid with VIRTIO_MEM_F_ACPI_PXM. Cannot change. */
> -    __u16 node_id;
> +    __le16 node_id;
>    __u8 padding[6];
>    /* Start address of the memory region. Cannot change. */
> -    __u64 addr;
> +    __le64 addr;
>    /* Region size (maximum). Cannot change. */
> -    __u64 region_size;
> +    __le64 region_size;
>    /*
>     * Currently usable region size. Can grow up to region_size. Can
>     * shrink due to VIRTIO_MEM_REQ_UNPLUG_ALL (in which case no config
>     * update will be sent).
>     */
> -    __u64 usable_region_size;
> +    __le64 usable_region_size;
>    /*
>     * Currently used size. Changes due to plug/unplug requests, but no
>     * config updates will be sent.
>     */
> -    __u64 plugged_size;
> +    __le64 plugged_size;
>    /* Requested size. New plug requests cannot exceed it. Can change. */
> -    __u64 requested_size;
> +    __le64 requested_size;
> };
>=20
> #endif /* _LINUX_VIRTIO_MEM_H */
> --=20
> MST
>=20

