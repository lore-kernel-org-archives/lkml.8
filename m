Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D75EC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60109206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="1Wyig3H3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgHZHm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:42:56 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:10706 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726442AbgHZHmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 03:42:55 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07Q7fYFm027838;
        Wed, 26 Aug 2020 09:42:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=iMMB81vKFOkSeOwydW9I3L8tM5JTQ3Bi1g6MGR42Q3s=;
 b=1Wyig3H3hCS4pdWa+gAAR4/CfTFUKMFzebCui0W8/4+WPwyTdWx1W9bB1YUbGWqCoOrl
 fPL5SAyvgQVk87ikh4WDqZnG8I9G6VolxdduZl8BTYTxPqcRZ3kjbAj2uWuj5uTEtBoy
 paokbofnTSM+IJXZezxrh3pfOYIZm/LCZOeGlY3D5gwkQGHv+oMNIksNIhYxdz1+brwt
 gGCa51fQ9Y8h7nQpW533LwDFRyFHBpuT+j2onh/+qQPGH//VeLmI5ecDB0VksSJKQf7z
 46+qPXAoONOatPGR+FpN4+pWIhuQmIEllbtaqIqFGgbqoXOGR0ZKLoA8/6wsA0uUc2Nh Tw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 333b3hf476-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 09:42:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6495210002A;
        Wed, 26 Aug 2020 09:42:48 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 571A021263E;
        Wed, 26 Aug 2020 09:42:48 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.48) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 26 Aug
 2020 09:42:47 +0200
Subject: Re: [PATCH 8/9] rpmsg: virtio: use rpmsg_ns driver to manage ns
 announcement
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200731114732.12815-1-arnaud.pouliquen@st.com>
 <20200731114732.12815-9-arnaud.pouliquen@st.com>
 <20200825165433.GA4141387@xps15>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <c1b81b38-c155-3183-ed67-822c4f87ec71@st.com>
Date:   Wed, 26 Aug 2020 09:42:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200825165433.GA4141387@xps15>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_03:2020-08-25,2020-08-26 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi mathieu,

I Sent my V2 few seconds before receiving your comment :)
Please find my answer below

On 8/25/20 6:54 PM, Mathieu Poirier wrote:
> Hi Arnaud,
> 
> On Fri, Jul 31, 2020 at 01:47:31PM +0200, Arnaud Pouliquen wrote:
>> Use the new rpmsg_ns API to send the name service announcements if
>> the VIRTIO_RPMSG_F_NS is set, else just not implement the ops.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> ---
>>  drivers/rpmsg/virtio_rpmsg_bus.c | 94 +++++---------------------------
>>  1 file changed, 13 insertions(+), 81 deletions(-)
>>
>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
>> index f771fdae150e..3c771a6392be 100644
>> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
>> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
>> @@ -91,35 +91,6 @@ struct rpmsg_hdr {
>>  	u8 data[];
>>  } __packed;
>>  
>> -/**
>> - * struct rpmsg_ns_msg - dynamic name service announcement message
>> - * @name: name of remote service that is published
>> - * @addr: address of remote service that is published
>> - * @flags: indicates whether service is created or destroyed
>> - *
>> - * This message is sent across to publish a new service, or announce
>> - * about its removal. When we receive these messages, an appropriate
>> - * rpmsg channel (i.e device) is created/destroyed. In turn, the ->probe()
>> - * or ->remove() handler of the appropriate rpmsg driver will be invoked
>> - * (if/as-soon-as one is registered).
>> - */
>> -struct rpmsg_ns_msg {
>> -	char name[RPMSG_NAME_SIZE];
>> -	__virtio32 addr;
>> -	__virtio32 flags;
>> -} __packed;
>> -
>> -/**
>> - * enum rpmsg_ns_flags - dynamic name service announcement flags
>> - *
>> - * @RPMSG_NS_CREATE: a new remote service was just created
>> - * @RPMSG_NS_DESTROY: a known remote service was just destroyed
>> - */
>> -enum rpmsg_ns_flags {
>> -	RPMSG_NS_CREATE		= 0,
>> -	RPMSG_NS_DESTROY	= 1,
>> -};
>> -
>>  /**
>>   * @vrp: the remote processor this channel belongs to
>>   */
>> @@ -324,60 +295,18 @@ static void virtio_rpmsg_destroy_ept(struct rpmsg_endpoint *ept)
>>  	__rpmsg_destroy_ept(vch->vrp, ept);
>>  }
>>  
>> -static int virtio_rpmsg_announce_create(struct rpmsg_device *rpdev)
>> -{
>> -	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
>> -	struct virtproc_info *vrp = vch->vrp;
>> -	struct device *dev = &rpdev->dev;
>> -	int err = 0;
>> -
>> -	/* need to tell remote processor's name service about this channel ? */
>> -	if (rpdev->announce && rpdev->ept &&
>> -	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
>> -		struct rpmsg_ns_msg nsm;
>> -
>> -		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
>> -		nsm.addr = cpu_to_virtio32(vrp->vdev, rpdev->ept->addr);
>> -		nsm.flags = cpu_to_virtio32(vrp->vdev, RPMSG_NS_CREATE);
>> -
>> -		err = rpmsg_sendto(rpdev->ept, &nsm, sizeof(nsm), RPMSG_NS_ADDR);
>> -		if (err)
>> -			dev_err(dev, "failed to announce service %d\n", err);
>> -	}
>> -
>> -	return err;
>> -}
>> -
>> -static int virtio_rpmsg_announce_destroy(struct rpmsg_device *rpdev)
>> -{
>> -	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
>> -	struct virtproc_info *vrp = vch->vrp;
>> -	struct device *dev = &rpdev->dev;
>> -	int err = 0;
>> -
>> -	/* tell remote processor's name service we're removing this channel */
>> -	if (rpdev->announce && rpdev->ept &&
>> -	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
>> -		struct rpmsg_ns_msg nsm;
>> -
>> -		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
>> -		nsm.addr = cpu_to_virtio32(vrp->vdev, rpdev->ept->addr);
>> -		nsm.flags = cpu_to_virtio32(vrp->vdev, RPMSG_NS_DESTROY);
>> -
>> -		err = rpmsg_sendto(rpdev->ept, &nsm, sizeof(nsm), RPMSG_NS_ADDR);
>> -		if (err)
>> -			dev_err(dev, "failed to announce service %d\n", err);
>> -	}
>> -
>> -	return err;
>> -}
>> -
>>  static const struct rpmsg_device_ops virtio_rpmsg_ops = {
>>  	.create_channel = virtio_rpmsg_create_channel,
>>  	.release_channel = virtio_rpmsg_release_channel,
>>  	.create_ept = virtio_rpmsg_create_ept,
>> -	.announce_create = virtio_rpmsg_announce_create,
>> -	.announce_destroy = virtio_rpmsg_announce_destroy,
>> +};
>> +
>> +static const struct rpmsg_device_ops virtio_rpmsg_w_nsa_ops = {
>> +	.create_channel = virtio_rpmsg_create_channel,
>> +	.release_channel = virtio_rpmsg_release_channel,
>> +	.create_ept = virtio_rpmsg_create_ept,
>> +	.announce_create = rpmsg_ns_announce_create,
>> +	.announce_destroy = rpmsg_ns_announce_destroy,
>>  };
>>  
>>  static void virtio_rpmsg_release_device(struct device *dev)
>> @@ -423,7 +352,10 @@ __rpmsg_create_channel(struct virtproc_info *vrp,
>>  	rpdev = &vch->rpdev;
>>  	rpdev->src = chinfo->src;
>>  	rpdev->dst = chinfo->dst;
>> -	rpdev->ops = &virtio_rpmsg_ops;
>> +	if (virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS))
>> +		rpdev->ops = &virtio_rpmsg_w_nsa_ops;
>> +	else
>> +		rpdev->ops = &virtio_rpmsg_ops;
> 
> Yesterday I struggled with this part and I still do this morning.  Function
> __rpmsg_create_channel() can only be called if VIRTIO_RPMSG_F_NS is set so there
> is no need to check it again.

That's right if rpmsg_create_channel is called by the rpmsg_ns only. But it 
could not be the case in future, for instance with the rpmsg_ctrl series [1]
As the channel creation is decorrelate from the ns annoucement we need to check it.

[1]https://patchwork.kernel.org/patch/11694787/

I would also have expected this patch to be a
> simple replace of the .announce_create/destroy functions.  Adding an ops that
> doesn't have the .announce_create/destroy functions looks like a feature to me,
> and one that I don't quite get.
> 
> Do you think you could expand on the motivation behind this patch?

It was my first implementation. It is more of a phylosophical point than anything else.
With this path i tried to implement the following rule:
  if VIRTIO_RPMSG_F_NS is not set
      no ns announcement support
  else 
      delegate to the ns announcement RPMsg service

Rather, legacy implementation is about to implement the announce ops even if not supported.

If this implementation is confusing i can go back to my first implementation which was
only an update the virtio_rpmsg_announce_xx functions:

@@ -322,15 +304,8 @@ static int virtio_rpmsg_announce_create(struct rpmsg_device *rpdev)
 	int err = 0;
 
 	/* need to tell remote processor's name service about this channel ? */
-	if (rpdev->announce && rpdev->ept &&
-	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
-		struct rpmsg_ns_msg nsm;
-
-		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
-		nsm.addr = rpdev->ept->addr;
-		nsm.flags = RPMSG_NS_CREATE;
-
-		err = rpmsg_sendto(rpdev->ept, &nsm, sizeof(nsm), RPMSG_NS_ADDR);
+	if (virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
+		err = rpmsg_ctrl_channel_announce(rpdev, RPMSG_NS_CREATE);
 		if (err)
 			dev_err(dev, "failed to announce service %d\n", err);
 	}
@@ -346,15 +321,8 @@ static int virtio_rpmsg_announce_destroy(struct rpmsg_device *rpdev)
 	int err = 0;
 
 	/* tell remote processor's name service we're removing this channel */
-	if (rpdev->announce && rpdev->ept &&
-	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
-		struct rpmsg_ns_msg nsm;
-
-		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
-		nsm.addr = rpdev->ept->addr;
-		nsm.flags = RPMSG_NS_DESTROY;
-
-		err = rpmsg_sendto(rpdev->ept, &nsm, sizeof(nsm), RPMSG_NS_ADDR);
+	if (virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
+		err = rpmsg_ctrl_channel_announce(rpdev, RPMSG_NS_DESTROY);
 		if (err)
 			dev_err(dev, "failed to announce service %d\n", err);
 	}

Regards,
Arnaud

> 
> Thanks,
> Mathieu 
> 
>>  
>>  	/*
>>  	 * rpmsg server channels has predefined local address (for now),
>> @@ -933,7 +865,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
>>  
>>  		/* Assign public information to the rpmsg_device */
>>  		rpdev_ns = &vch->rpdev;
>> -		rpdev_ns->ops = &virtio_rpmsg_ops;
>> +		rpdev_ns->ops = &virtio_rpmsg_w_nsa_ops;
>>  
>>  		rpdev_ns->dev.parent = &vrp->vdev->dev;
>>  		rpdev_ns->dev.release = virtio_rpmsg_release_device;
>> -- 
>> 2.17.1
>>
