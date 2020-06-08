Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEDAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 03:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCAD220656
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 03:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3ZjCPXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgFHD6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 23:58:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27333 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728773AbgFHD6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 23:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591588687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=igcFF6sIPo1IwGxhbkOb5ZYxeIEkm6yVF+37+rACCwU=;
        b=A3ZjCPXEEd7xg6i7d6aHZNqn/w0hwi6t3pbpqudGG15aRyvX7+b8cslO9zg0InMkeBLw1+
        mxkESeR/eE9wy9J6537RK+LTNOeadMNgThmoFs1P3d3AVwTd+SEzqhNm7GWV/yacFurcd7
        YLnqMR6tkr9V8ScBkF9WLLv0bgJDTrU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-N3VRj-sbNZikNPTWUwUu5Q-1; Sun, 07 Jun 2020 23:58:03 -0400
X-MC-Unique: N3VRj-sbNZikNPTWUwUu5Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93E9A1005510;
        Mon,  8 Jun 2020 03:58:02 +0000 (UTC)
Received: from [10.72.13.71] (ovpn-13-71.pek2.redhat.com [10.72.13.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2F4A60BE1;
        Mon,  8 Jun 2020 03:57:50 +0000 (UTC)
Subject: Re: [PATCH RFC v5 13/13] vhost: drop head based APIs
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, eperezma@redhat.com
References: <20200607141057.704085-1-mst@redhat.com>
 <20200607141057.704085-14-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <8e3f5b6f-a47b-73cd-e8e3-959d40f6c91c@redhat.com>
Date:   Mon, 8 Jun 2020 11:57:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200607141057.704085-14-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/6/7 下午10:11, Michael S. Tsirkin wrote:
> Everyone's using buf APIs, no need for head based ones anymore.
>
> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> ---
>   drivers/vhost/vhost.c | 36 ++++++++----------------------------
>   drivers/vhost/vhost.h | 12 ------------
>   2 files changed, 8 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 72ee55c810c4..e6931b760b61 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2299,12 +2299,12 @@ static int fetch_buf(struct vhost_virtqueue *vq)
>   	return 1;
>   }
>   
> -/* Reverse the effect of vhost_get_vq_desc. Useful for error handling. */
> +/* Revert the effect of fetch_buf. Useful for error handling. */
> +static
>   void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
>   {
>   	vq->last_avail_idx -= n;
>   }
> -EXPORT_SYMBOL_GPL(vhost_discard_vq_desc);


The same question as previous version.

Do we need to rewind cached descriptor here?

Thanks

