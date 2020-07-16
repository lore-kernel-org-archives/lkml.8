Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8555BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56DD82070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DduK803f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgGPILP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:11:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42309 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725934AbgGPILO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594887073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+L2ONyaQijNqMbyzSxVRLO1Pc+Tfqc2nXAiP2fBOrgg=;
        b=DduK803fDT0wOPdlRrq+YdW0oIRXDDoJG3PRLEE0gjjGk7N+TggiBFm8yjPvm6BRU9P++G
        t3geQSNUVsKpSNi2zT3fw01lN48g16CBovpo/fhF2qkvzpZYMjJNIxvFSxCU5E7CYnXwVa
        HuujtbaducsNFIJn5599trUO78bTCXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-8kxbf2VPMoaGa_C4-2-5Cg-1; Thu, 16 Jul 2020 04:11:09 -0400
X-MC-Unique: 8kxbf2VPMoaGa_C4-2-5Cg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F07238015FB;
        Thu, 16 Jul 2020 08:11:07 +0000 (UTC)
Received: from [10.72.12.131] (ovpn-12-131.pek2.redhat.com [10.72.12.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 803B210098A4;
        Thu, 16 Jul 2020 08:11:02 +0000 (UTC)
Subject: Re: [PATCH vhost next 06/10] vdpa: Add means to communicate vq status
 on get_vq_state
To:     Eli Cohen <eli@mellanox.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com,
        Parav Pandit <parav@mellanox.com>
References: <20200716072327.5359-1-eli@mellanox.com>
 <20200716072327.5359-7-eli@mellanox.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <cb9bced7-1a7e-150a-875c-1b75f77ee853@redhat.com>
Date:   Thu, 16 Jul 2020 16:11:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716072327.5359-7-eli@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/7/16 下午3:23, Eli Cohen wrote:
> Currently, get_vq_state() is used only to pass the available index value
> of a vq. Extend the struct to return status on the VQ to the caller.
> For now, define VQ_STATE_NOT_READY. In the future it will be extended to
> include other infomration.
>
> Modify current vdpa driver to update this field.
>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Eli Cohen <eli@mellanox.com>


What's the difference between this and get_vq_ready()?

Thanks


> ---
>   drivers/vdpa/ifcvf/ifcvf_main.c  | 1 +
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 1 +
>   include/linux/vdpa.h             | 9 +++++++++
>   3 files changed, 11 insertions(+)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 69032ee97824..77e3b3d91167 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -240,6 +240,7 @@ static void ifcvf_vdpa_get_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
>   {
>   	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>   
> +	state->state = vf->vring[qid].ready ? 0 : BIT(VQ_STATE_NOT_READY);
>   	state->avail_index = ifcvf_get_vq_state(vf, qid);
>   }
>   
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 599519039f8d..06d974b4bd7b 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -434,6 +434,7 @@ static void vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx,
>   	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>   	struct vringh *vrh = &vq->vring;
>   
> +	state->state = vq->ready ? 0 : BIT(VQ_STATE_NOT_READY);
>   	state->avail_index = vrh->last_avail_idx;
>   }
>   
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 7b088bebffe8..bcefa30a3b2f 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -27,12 +27,21 @@ struct vdpa_notification_area {
>   	resource_size_t size;
>   };
>   
> +/**
> + * Bitmask describing the status of the vq
> + */
> +enum {
> +	VQ_STATE_NOT_READY = 0,
> +};
> +
>   /**
>    * vDPA vq_state definition
>    * @avail_index: available index
> + * @state: returned status from get_vq_state
>    */
>   struct vdpa_vq_state {
>   	u16	avail_index;
> +	u32	state;
>   };
>   
>   /**

