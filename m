Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EFFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 05:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8659D207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 05:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmW4bC8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgGUFeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 01:34:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21263 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726010AbgGUFet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 01:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595309687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A9DeyT/Te+u96c5OpliRfzztbAI2QqHnWn+vnnjCPUw=;
        b=dmW4bC8hzXY/0N+kTYSak7Gh5gnG+NEOOJjKvA3BxUMDwS7Eku6fBqGnY1rx+hFgjETTkI
        VCWW/mrFhF4leuc/F/y3ww1vWkYJtJ/6AVXZtaiNncJuqlILSj5stgvHkMHDdepe+oHmEX
        GhR1xV7960MD7tLFMYTl/F/HuA7epug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-V-w9XEj9OJyWlwaYnSuNOg-1; Tue, 21 Jul 2020 01:34:45 -0400
X-MC-Unique: V-w9XEj9OJyWlwaYnSuNOg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6A208017FB;
        Tue, 21 Jul 2020 05:34:43 +0000 (UTC)
Received: from [10.72.12.202] (ovpn-12-202.pek2.redhat.com [10.72.12.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE86E5D9CA;
        Tue, 21 Jul 2020 05:34:35 +0000 (UTC)
Subject: Re: [PATCH V2 vhost next 06/10] vdpa: Modify get_vq_state() to return
 error code
To:     Eli Cohen <eli@mellanox.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com
References: <20200720071416.32112-1-eli@mellanox.com>
 <20200720071416.32112-7-eli@mellanox.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <2e4a764e-391a-6b4e-26e0-1ccdd5d5e7a3@redhat.com>
Date:   Tue, 21 Jul 2020 13:34:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720071416.32112-7-eli@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/7/20 下午3:14, Eli Cohen wrote:
> Modify get_vq_state() so it returns an error code. In case of hardware
> acceleration, the available index may be retrieved from the device, an
> operation that can possibly fail.
>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Eli Cohen <eli@mellanox.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vdpa/ifcvf/ifcvf_main.c  | 5 +++--
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 5 +++--
>   drivers/vhost/vdpa.c             | 5 ++++-
>   include/linux/vdpa.h             | 4 ++--
>   4 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 69032ee97824..d9b5f465ac81 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -235,12 +235,13 @@ static u16 ifcvf_vdpa_get_vq_num_max(struct vdpa_device *vdpa_dev)
>   	return IFCVF_QUEUE_MAX;
>   }
>   
> -static void ifcvf_vdpa_get_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
> -				    struct vdpa_vq_state *state)
> +static int ifcvf_vdpa_get_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
> +				   struct vdpa_vq_state *state)
>   {
>   	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>   
>   	state->avail_index = ifcvf_get_vq_state(vf, qid);
> +	return 0;
>   }
>   
>   static int ifcvf_vdpa_set_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 599519039f8d..ddf6086d43c2 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -427,14 +427,15 @@ static int vdpasim_set_vq_state(struct vdpa_device *vdpa, u16 idx,
>   	return 0;
>   }
>   
> -static void vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> -				 struct vdpa_vq_state *state)
> +static int vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> +				struct vdpa_vq_state *state)
>   {
>   	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>   	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>   	struct vringh *vrh = &vq->vring;
>   
>   	state->avail_index = vrh->last_avail_idx;
> +	return 0;
>   }
>   
>   static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index af98c11c9d26..fadad74f882e 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -360,7 +360,10 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>   	}
>   
>   	if (cmd == VHOST_GET_VRING_BASE) {
> -		ops->get_vq_state(v->vdpa, idx, &vq_state);
> +		r = ops->get_vq_state(v->vdpa, idx, &vq_state);
> +		if (r)
> +			return r;
> +
>   		vq->last_avail_idx = vq_state.avail_index;
>   	}
>   
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 7b088bebffe8..000d71a9f988 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -185,8 +185,8 @@ struct vdpa_config_ops {
>   	bool (*get_vq_ready)(struct vdpa_device *vdev, u16 idx);
>   	int (*set_vq_state)(struct vdpa_device *vdev, u16 idx,
>   			    const struct vdpa_vq_state *state);
> -	void (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
> -			     struct vdpa_vq_state *state);
> +	int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
> +			    struct vdpa_vq_state *state);
>   	struct vdpa_notification_area
>   	(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>   

