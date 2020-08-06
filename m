Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C79CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 139552245C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcQw6mra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbgHFD1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:27:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25628 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730500AbgHFD1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596684454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yj1ihXQO2M1TsL9VeUKDmXbzc/ApdSgHZZHy2dOrKJk=;
        b=bcQw6mraHDsF+rsx9l6d783z9bp7TUCV220sotl2PexpvrFbKLjMCBTf2aqZLhAOblvFLc
        phgvIuZ7S4t2vRO8C84PwetDznfU2L7X89x+c0RVfNlfHgZn+rRsRjBGlbXaxc2eHknoAc
        gVeZKXfNg9p19+agnfR6PE6yLllkiBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-EWkCYCeNMcm4t8G3QDakkQ-1; Wed, 05 Aug 2020 23:27:33 -0400
X-MC-Unique: EWkCYCeNMcm4t8G3QDakkQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C0D1106B242;
        Thu,  6 Aug 2020 03:27:31 +0000 (UTC)
Received: from [10.72.13.140] (ovpn-13-140.pek2.redhat.com [10.72.13.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E19EA19D81;
        Thu,  6 Aug 2020 03:27:17 +0000 (UTC)
Subject: Re: [PATCH 3/4] vdpa: get_iova_range() is mandatory for device
 specific DMA translation
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-4-jasowang@redhat.com>
 <20200805085217-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <d371771e-b17a-8ccb-e185-4762b9ac0914@redhat.com>
Date:   Thu, 6 Aug 2020 11:27:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805085217-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/5 下午8:55, Michael S. Tsirkin wrote:
> On Wed, Jun 17, 2020 at 11:29:46AM +0800, Jason Wang wrote:
>> In order to let userspace work correctly, get_iova_range() is a must
>> for the device that has its own DMA translation logic.
> I guess you mean for a device.
>
> However in absence of ths op, I don't see what is wrong with just
> assuming device can access any address.


It's just for safe, if you want, we can assume any address without this op.


>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/vdpa/vdpa.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>> index de211ef3738c..ab7af978ef70 100644
>> --- a/drivers/vdpa/vdpa.c
>> +++ b/drivers/vdpa/vdpa.c
>> @@ -82,6 +82,10 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>>   	if (!!config->dma_map != !!config->dma_unmap)
>>   		goto err;
>>   
>> +	if ((config->dma_map || config->set_map) &&
>> +	    !config->get_iova_range)
>> +		goto err;
>> +
>>   	err = -ENOMEM;
>>   	vdev = kzalloc(size, GFP_KERNEL);
>>   	if (!vdev)
> What about devices using an IOMMU for translation?
> IOMMUs generally have a limited IOVA range too, right?


See patch 4 which query the IOMMU geometry in this case:

+        iommu_domain_get_attr(v->domain,
+                      DOMAIN_ATTR_GEOMETRY, &geo);
+        range.start = geo.aperture_start;
+        range.end = geo.aperture_end;

Thanks


>
>
>
>> -- 
>> 2.20.1

