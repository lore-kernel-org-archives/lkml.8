Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40F8C2BA1A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 03:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13392084D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 03:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHzU2qIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgDIDTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 23:19:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45540 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726552AbgDIDTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 23:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586402375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7+SzqkDXl2Jmhsnr0y9L6At5X0+bUJC/xN2Tg8J4VyY=;
        b=RHzU2qIAWu9rSJvP6+j1Yo570y0u9KYJQ9ywQPQkr9yiy7C3+4rTC+6Cnt49SufVqa2qr2
        hxg1RJ+10ttIClVTMC+sBOKp6DgELoV0JGIf9ff/0FC924T0iK5QKvFeqS+5bOdPB0A2on
        zKY3N8kXu+bvJGXnIb4fU0zixwfbBUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-z9lXOdvvODmFYx4fo57fBg-1; Wed, 08 Apr 2020 23:19:33 -0400
X-MC-Unique: z9lXOdvvODmFYx4fo57fBg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED6EC1902EAE;
        Thu,  9 Apr 2020 03:19:28 +0000 (UTC)
Received: from [10.72.13.188] (ovpn-13-188.pek2.redhat.com [10.72.13.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53354272CB;
        Thu,  9 Apr 2020 03:19:21 +0000 (UTC)
Subject: Re: [PATCH] virtio-mmio: Delete an error message in vm_find_vqs()
To:     Markus Elfring <Markus.Elfring@web.de>,
        virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
References: <9e27bc4a-cfa1-7818-dc25-8ad308816b30@web.de>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <03b19e72-0021-dc6b-77c4-ed3c4e13d526@redhat.com>
Date:   Thu, 9 Apr 2020 11:19:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9e27bc4a-cfa1-7818-dc25-8ad308816b30@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/4/6 =E4=B8=8A=E5=8D=881:19, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 5 Apr 2020 19:14:10 +0200
>
> The function =E2=80=9Cplatform_get_irq=E2=80=9D can log an error alread=
y.
> Thus omit a redundant message for the exception handling in the
> calling function.


It looks to me that not all error path of platform_get_irq() were loggd.

And git grep told me there're other users of platform_get_irq() that=20
check and log by themselves.

Thanks


>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/virtio/virtio_mmio.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.=
c
> index 97d5725fd9a2..9d16aaffca9d 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -466,10 +466,8 @@ static int vm_find_vqs(struct virtio_device *vdev,=
 unsigned nvqs,
>   	int irq =3D platform_get_irq(vm_dev->pdev, 0);
>   	int i, err, queue_idx =3D 0;
>
> -	if (irq < 0) {
> -		dev_err(&vdev->dev, "Cannot get IRQ resource\n");
> +	if (irq < 0)
>   		return irq;
> -	}
>
>   	err =3D request_irq(irq, vm_interrupt, IRQF_SHARED,
>   			dev_name(&vdev->dev), vm_dev);
> --
> 2.26.0
>

