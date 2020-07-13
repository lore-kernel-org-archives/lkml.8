Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADACFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8243D20724
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMbWe6PO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgGMDhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 23:37:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50653 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726261AbgGMDhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594611424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TuBsngu+9JfDAXP7hTevqic2CkVZxKms9S+GM/5BLQ8=;
        b=EMbWe6POIroP5yktEgnzg9HLYyVvpkuiWF96seKBms6+U3vQtfPpGPTSJD1AI2OpIQNgzR
        mVquLE3TDKU82bU3aWM/8++yTmU2ouf/2MWPiuCUmznLaYUk41yr7gOBvc3n8yAO5wXwQj
        h8EAZjQxvq0ZPYBjM5c/gloRyIo88Eo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-x-1Wj2mAP0Op74d-jbzjgg-1; Sun, 12 Jul 2020 23:37:02 -0400
X-MC-Unique: x-1Wj2mAP0Op74d-jbzjgg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB29C1800D42;
        Mon, 13 Jul 2020 03:37:00 +0000 (UTC)
Received: from [10.72.13.177] (ovpn-13-177.pek2.redhat.com [10.72.13.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5105560BE2;
        Mon, 13 Jul 2020 03:36:53 +0000 (UTC)
Subject: Re: [PATCH] virtio_balloon: clear modern features under legacy
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Alexander Duyck <alexander.duyck@gmail.com>
References: <20200710113046.421366-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <c0863b67-bd97-63a8-ff11-4f1b0fb655a3@redhat.com>
Date:   Mon, 13 Jul 2020 11:36:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710113046.421366-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/7/10 下午7:31, Michael S. Tsirkin wrote:
> Page reporting features were never supported by legacy hypervisors.
> Supporting them poses a problem: should we use native endian-ness (like
> current code assumes)? Or little endian-ness like the virtio spec says?
> Rather than try to figure out, and since results of
> incorrect endian-ness are dire, let's just block this configuration.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/virtio/virtio_balloon.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 5d4b891bf84f..b9bc03345157 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -1107,6 +1107,15 @@ static int virtballoon_restore(struct virtio_device *vdev)
>   
>   static int virtballoon_validate(struct virtio_device *vdev)
>   {
> +	/*
> +	 * Legacy devices never specified how modern features should behave.
> +	 * E.g. which endian-ness to use? Better not to assume anything.
> +	 */
> +	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT);
> +		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
> +		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
> +	}
>   	/*
>   	 * Inform the hypervisor that our pages are poisoned or
>   	 * initialized. If we cannot do that then we should disable


Acked-by: Jason Wang <jasowang@redhat.com>


