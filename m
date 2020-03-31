Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C01EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 05:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8F320675
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 05:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfIOZhl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCaFaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 01:30:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44214 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgCaFaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 01:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585632607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFqXXNouokcEA1ClxFQy3YMBVLAfkUsYqF77czd6ZxU=;
        b=cfIOZhl3EGKOg4DfodxvqmEkKzKmiG7G9n0J/Fpc20WZ9Bxi7AXWrvgWsuWPy6CNzap8Hb
        uNy6qaDk92++d0ZAXAZ7rFScbqKZHNz7wQH+WiXowrO7u3LBDUDCY7YGiMdp3lnlaHaazf
        554hAMyG9iKZFjXff7mHQSM37HR4OsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-nzdgtpyaMqO2qBGBZY26tQ-1; Tue, 31 Mar 2020 01:30:04 -0400
X-MC-Unique: nzdgtpyaMqO2qBGBZY26tQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96E19800D5C;
        Tue, 31 Mar 2020 05:30:02 +0000 (UTC)
Received: from [10.72.12.115] (ovpn-12-115.pek2.redhat.com [10.72.12.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 669CCD767B;
        Tue, 31 Mar 2020 05:29:57 +0000 (UTC)
Subject: Re: [PATCH -next] vdpasim: Rerun status in vdpasim_get_status
To:     YueHaibing <yuehaibing@huawei.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200331033501.31272-1-yuehaibing@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <096a742b-9387-370e-db22-81f220cf7c70@redhat.com>
Date:   Tue, 31 Mar 2020 13:29:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200331033501.31272-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/3/31 =E4=B8=8A=E5=8D=8811:35, YueHaibing wrote:
> vdpasim->status should acquired under spin lock.
>
> Fixes: 870448c31775 ("vdpasim: vDPA device simulator")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/virtio/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/vdpa/vdpa_sim/vdpa_sim.c b/drivers/virtio/v=
dpa/vdpa_sim/vdpa_sim.c
> index 6e8a0cf2fdeb..72863d01a12a 100644
> --- a/drivers/virtio/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/virtio/vdpa/vdpa_sim/vdpa_sim.c
> @@ -488,7 +488,7 @@ static u8 vdpasim_get_status(struct vdpa_device *vd=
pa)
>   	status =3D vdpasim->status;
>   	spin_unlock(&vdpasim->lock);
>  =20
> -	return vdpasim->status;
> +	return status;
>   }
>  =20
>   static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)


Typo in the title but patch looks good.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


