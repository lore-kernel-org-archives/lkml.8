Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA07BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B0F20855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVmkxO5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgHGDEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:04:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33889 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726038AbgHGDEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 23:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596769486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xdOpBjCOVkquS5JtoOdSjXeW1osIHL7KNsSvy/tC5XQ=;
        b=OVmkxO5tYQye9xvQs1JjLKVg2PGjIBymQqDpPz3qJoIoneGa5fKFzDxgh3GmOtsnyrT0R3
        A4lITw/5xeeFgyr2eKhQohG3Xtvku8B651wN4UY+W8Q2cDAg5oQ1rjdEJIyH39IaDp0M1H
        TBVU7Hvs8DlO2CpdQW4adldABODCujM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-olBv4X8GPxauTGFiSuf8pw-1; Thu, 06 Aug 2020 23:04:42 -0400
X-MC-Unique: olBv4X8GPxauTGFiSuf8pw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D8B0106B242;
        Fri,  7 Aug 2020 03:04:40 +0000 (UTC)
Received: from [10.72.13.215] (ovpn-13-215.pek2.redhat.com [10.72.13.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5C597B927;
        Fri,  7 Aug 2020 03:04:32 +0000 (UTC)
Subject: Re: [PATCH 1/4] vdpa: introduce config op to get valid iova range
To:     Eli Cohen <eli@mellanox.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rob.miller@broadcom.com" <rob.miller@broadcom.com>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        Shahaf Shuler <shahafs@mellanox.com>,
        "hanand@xilinx.com" <hanand@xilinx.com>,
        "mhabets@solarflare.com" <mhabets@solarflare.com>,
        "gdawar@xilinx.com" <gdawar@xilinx.com>,
        "saugatm@xilinx.com" <saugatm@xilinx.com>,
        "vmireyno@marvell.com" <vmireyno@marvell.com>,
        "zhangweining@ruijie.com.cn" <zhangweining@ruijie.com.cn>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-2-jasowang@redhat.com>
 <20200806121002.GA171574@mtl-vdi-166.wap.labs.mlnx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e9730008-0f3f-c986-0055-e83578961896@redhat.com>
Date:   Fri, 7 Aug 2020 11:04:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806121002.GA171574@mtl-vdi-166.wap.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/6 下午8:10, Eli Cohen wrote:
> On Wed, Jun 17, 2020 at 06:29:44AM +0300, Jason Wang wrote:
>> This patch introduce a config op to get valid iova range from the vDPA
>> device.
>>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>> ---
>>   include/linux/vdpa.h | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>> index 239db794357c..b7633ed2500c 100644
>> --- a/include/linux/vdpa.h
>> +++ b/include/linux/vdpa.h
>> @@ -41,6 +41,16 @@ struct vdpa_device {
>>   	unsigned int index;
>>   };
>>   
>> +/**
>> + * vDPA IOVA range - the IOVA range support by the device
>> + * @start: start of the IOVA range
>> + * @end: end of the IOVA range
>> + */
>> +struct vdpa_iova_range {
>> +	u64 start;
>> +	u64 end;
>> +};
>> +
> What do you do with this information? Suppose some device tells you it
> supports some limited range, say, from 0x40000000 to 0x80000000. What
> does qemu do with this information?


For qemu, when qemu will fail the vDPA device creation when:

1) vIOMMU is not enabled and GPA is out of this range
2) vIOMMU is enabled but it can't report such range to guest

For other userspace application, it will know it can only use this range 
as its IOVA.

Thanks

