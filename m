Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFC9C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 03:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252E9222D9
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 03:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IeRFaV3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgBGDhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 22:37:53 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57429 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727587AbgBGDhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 22:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581046670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/nMtXSXwUKQmIwf5ajaCDX1OBTlUcvNzOolgf7JA/W4=;
        b=IeRFaV3rhVp0GaHUprsePNyE7zG9m/oqhqoKJxH3+BToEtInUyQT6bClg/uSo8ByCmKE5d
        jleZTrDSMS2lLtlrkuDsqmM8m8M9D8ZJIZcpuYQc2StvU2ZU7Ckb8BFfRWr5+7CJqfPCol
        NUhE4p/5ADNO7b2iHmWs/01gJnvXD1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-oT27ycCXPZ-X0TopriGtWQ-1; Thu, 06 Feb 2020 22:37:47 -0500
X-MC-Unique: oT27ycCXPZ-X0TopriGtWQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF7DA18B9FC1;
        Fri,  7 Feb 2020 03:37:45 +0000 (UTC)
Received: from [10.72.13.183] (ovpn-13-183.pek2.redhat.com [10.72.13.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 384A05C3FD;
        Fri,  7 Feb 2020 03:37:38 +0000 (UTC)
Subject: Re: [PATCH] virtio_balloon: prevent pfn array overflow
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
References: <20200206074644.1177551-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <461dc5d5-4635-7b44-49bf-49422295e873@redhat.com>
Date:   Fri, 7 Feb 2020 11:37:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200206074644.1177551-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/2/6 =E4=B8=8B=E5=8D=883:47, Michael S. Tsirkin wrote:
> Make sure, at build time, that pfn array is big enough to hold a single
> page.  It happens to be true since the PAGE_SHIFT value at the moment i=
s
> 20, which is 1M - exactly 256 4K balloon pages.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/virtio/virtio_balloon.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ba=
lloon.c
> index 8e400ece9273..2457c54b6185 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -158,6 +158,8 @@ static void set_page_pfns(struct virtio_balloon *vb=
,
>   {
>   	unsigned int i;
>  =20
> +	BUILD_BUG_ON(VIRTIO_BALLOON_PAGES_PER_PAGE > VIRTIO_BALLOON_ARRAY_PFN=
S_MAX);
> +
>   	/*
>   	 * Set balloon pfns pointing at this page.
>   	 * Note that the first pfn points at start of the page.


Acked-by: Jason Wang <jasowang@redhat.com>


