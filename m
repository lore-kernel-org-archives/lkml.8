Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7B0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D3320706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="gVL98WGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgHYMD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:03:58 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:15956 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728910AbgHYMDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:03:15 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PBwmsi000572;
        Tue, 25 Aug 2020 14:02:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=GdD3g5U5A3kPRhQiALz40IBLNDgkSmo6vIq5uM2qDYI=;
 b=gVL98WGa5PApcWTuSxv6qeNBAhMUvLIdfiH3gEQvMjMwY8c0arg4J9VnVTJozGN/c0yN
 afwyTMQk+L2r0/bvB27Y6sj8Mn+hTnxvOBNUVuSDquXnKIl1fMctK6scgq5a0geks+nU
 YPX3IjInHaSlVycU5YxktLqau2cqtpWKPpritdJnF0CptaA2dJlMhDXbv/l+MKI2qrHg
 rR/HxtGo/JvaOT5XhNBPbhgW0jZPiTw81s/PMdP4ktNFUy+q8UE+Cnc4EFMErGRSIYQF
 Ryqn+lN2j11j7Kol2GWjcdG9GDZxFnJ53t7p0cJVUt+9hiCFSOHa5vIjC2/4VBi2CjTL vw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 333b6x2sjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 14:02:30 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D57F210002A;
        Tue, 25 Aug 2020 14:02:29 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C379E2AD2D9;
        Tue, 25 Aug 2020 14:02:29 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.45) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug
 2020 14:02:28 +0200
Subject: Re: [PATCH 6/9] rpmsg: virtio: use rpmsg ns device for the ns
 announcement
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200731114732.12815-1-arnaud.pouliquen@st.com>
 <20200731114732.12815-7-arnaud.pouliquen@st.com>
 <20200824224853.GE3938186@xps15>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <cb82e3e1-b3af-7a8d-4466-3d4261260be6@st.com>
Date:   Tue, 25 Aug 2020 14:02:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824224853.GE3938186@xps15>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_02:2020-08-25,2020-08-25 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/20 12:48 AM, Mathieu Poirier wrote:
> On Fri, Jul 31, 2020 at 01:47:29PM +0200, Arnaud Pouliquen wrote:
>> As generic NS driver is available, rely on it for NS management instead of
>> managing it in RPMsg virtio bus.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> ---
>>  drivers/rpmsg/Kconfig            |  1 +
>>  drivers/rpmsg/virtio_rpmsg_bus.c | 86 ++++++++------------------------
>>  2 files changed, 21 insertions(+), 66 deletions(-)
>>
>> diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
>> index 140faa975ea1..0143c9864c45 100644
>> --- a/drivers/rpmsg/Kconfig
>> +++ b/drivers/rpmsg/Kconfig
>> @@ -71,5 +71,6 @@ config RPMSG_VIRTIO
>>  	depends on HAS_DMA
>>  	select RPMSG
>>  	select VIRTIO
>> +	select RPMSG_NS
>>  
>>  endmenu
>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
>> index b2927661868c..f771fdae150e 100644
>> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
>> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
>> @@ -48,7 +48,6 @@
>>   * @endpoints_lock: lock of the endpoints set
>>   * @sendq:	wait queue of sending contexts waiting for a tx buffers
>>   * @sleepers:	number of senders that are waiting for a tx buffer
>> - * @ns_ept:	the bus's name service endpoint
>>   *
>>   * This structure stores the rpmsg state of a given virtio remote processor
>>   * device (there might be several virtio proc devices for each physical
>> @@ -67,7 +66,6 @@ struct virtproc_info {
>>  	struct mutex endpoints_lock;
>>  	wait_queue_head_t sendq;
>>  	atomic_t sleepers;
>> -	struct rpmsg_endpoint *ns_ept;
>>  };
>>  
>>  /* The feature bitmap for virtio rpmsg */
>> @@ -841,68 +839,14 @@ static void rpmsg_xmit_done(struct virtqueue *svq)
>>  	wake_up_interruptible(&vrp->sendq);
>>  }
>>  
>> -/* invoked when a name service announcement arrives */
>> -static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
>> -		       void *priv, u32 src)
>> -{
>> -	struct rpmsg_ns_msg *msg = data;
>> -	struct rpmsg_device *newch;
>> -	struct rpmsg_channel_info chinfo;
>> -	struct virtproc_info *vrp = priv;
>> -	struct device *dev = &vrp->vdev->dev;
>> -	int ret;
>> -
>> -#if defined(CONFIG_DYNAMIC_DEBUG)
>> -	dynamic_hex_dump("NS announcement: ", DUMP_PREFIX_NONE, 16, 1,
>> -			 data, len, true);
>> -#endif
>> -
>> -	if (len != sizeof(*msg)) {
>> -		dev_err(dev, "malformed ns msg (%d)\n", len);
>> -		return -EINVAL;
>> -	}
>> -
>> -	/*
>> -	 * the name service ept does _not_ belong to a real rpmsg channel,
>> -	 * and is handled by the rpmsg bus itself.
>> -	 * for sanity reasons, make sure a valid rpdev has _not_ sneaked
>> -	 * in somehow.
>> -	 */
>> -	if (rpdev) {
>> -		dev_err(dev, "anomaly: ns ept has an rpdev handle\n");
>> -		return -EINVAL;
>> -	}
>> -
>> -	/* don't trust the remote processor for null terminating the name */
>> -	msg->name[RPMSG_NAME_SIZE - 1] = '\0';
>> -
>> -	strncpy(chinfo.name, msg->name, sizeof(chinfo.name));
>> -	chinfo.src = RPMSG_ADDR_ANY;
>> -	chinfo.dst = virtio32_to_cpu(vrp->vdev, msg->addr);
>> -
>> -	dev_info(dev, "%sing channel %s addr 0x%x\n",
>> -		 virtio32_to_cpu(vrp->vdev, msg->flags) & RPMSG_NS_DESTROY ?
>> -		 "destroy" : "creat", msg->name, chinfo.dst);
>> -
>> -	if (virtio32_to_cpu(vrp->vdev, msg->flags) & RPMSG_NS_DESTROY) {
>> -		ret = rpmsg_unregister_device(&vrp->vdev->dev, &chinfo);
>> -		if (ret)
>> -			dev_err(dev, "rpmsg_destroy_channel failed: %d\n", ret);
>> -	} else {
>> -		newch = __rpmsg_create_channel(vrp, &chinfo);
>> -		if (!newch)
>> -			dev_err(dev, "rpmsg_create_channel failed\n");
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>>  static int rpmsg_probe(struct virtio_device *vdev)
>>  {
>>  	vq_callback_t *vq_cbs[] = { rpmsg_recv_done, rpmsg_xmit_done };
>>  	static const char * const names[] = { "input", "output" };
>>  	struct virtqueue *vqs[2];
>>  	struct virtproc_info *vrp;
>> +	struct virtio_rpmsg_channel *vch;
>> +	struct rpmsg_device *rpdev_ns;
>>  	void *bufs_va;
>>  	int err = 0, i;
>>  	size_t total_buf_space;
>> @@ -978,14 +922,27 @@ static int rpmsg_probe(struct virtio_device *vdev)
>>  
>>  	/* if supported by the remote processor, enable the name service */
>>  	if (virtio_has_feature(vdev, VIRTIO_RPMSG_F_NS)) {
>> -		/* a dedicated endpoint handles the name service msgs */
>> -		vrp->ns_ept = __rpmsg_create_ept(vrp, NULL, rpmsg_ns_cb,
>> -						vrp, RPMSG_NS_ADDR);
>> -		if (!vrp->ns_ept) {
>> -			dev_err(&vdev->dev, "failed to create the ns ept\n");
>> +		vch = kzalloc(sizeof(*vch), GFP_KERNEL);
>> +		if (!vch) {
>>  			err = -ENOMEM;
>>  			goto free_coherent;
>>  		}
>> +
>> +		/* Link the channel to our vrp */
>> +		vch->vrp = vrp;
>> +
>> +		/* Assign public information to the rpmsg_device */
>> +		rpdev_ns = &vch->rpdev;
>> +		rpdev_ns->ops = &virtio_rpmsg_ops;
>> +
>> +		rpdev_ns->dev.parent = &vrp->vdev->dev;
>> +		rpdev_ns->dev.release = virtio_rpmsg_release_device;
>> +
>> +		err = rpmsg_ns_register_device(rpdev_ns);
>> +		if (err) {
>> +			kfree(vch);
>> +			goto free_coherent;
>> +		}
> 
> This patch doesn't apply to Bjorn's rproc-next anymore - would you mind
> rebasing?

I will base my V2 on Bjorn's for-next (ca69dba7f13a293f83b08f003cd935c6abfee249)

Thanks,
Arnaud

> 
>>  	}
>>  
>>  	/*
>> @@ -1038,9 +995,6 @@ static void rpmsg_remove(struct virtio_device *vdev)
>>  	if (ret)
>>  		dev_warn(&vdev->dev, "can't remove rpmsg device: %d\n", ret);
>>  
>> -	if (vrp->ns_ept)
>> -		__rpmsg_destroy_ept(vrp, vrp->ns_ept);
>> -
>>  	idr_destroy(&vrp->endpoints);
>>  
>>  	vdev->config->del_vqs(vrp->vdev);
>> -- 
>> 2.17.1
>>
