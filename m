Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1025CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E01BD20792
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsSb7UXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbgHFDZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:25:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51205 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730146AbgHFDZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596684324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jWjXO7HLm05C7oJyO5GWR+Ll9CJGwirJV/KI2VEIAUU=;
        b=IsSb7UXt12z6axsyzcJGmr/8N5gx0uzJVta2Ynw5wFHKj5r43VZTPXz58VBOqziOp2mAGx
        Y3WU/UQJE/fH4sZdZdLb1YMBE6M5r3tyN9k6KdQJfhzz9YrbIdLyVCTqXndTjSHK1WMM1i
        c4wIlG8PpM6rG2KghQywHH4vDruY+5M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-dPB3X9flMuegRBT0BUE2jw-1; Wed, 05 Aug 2020 23:25:22 -0400
X-MC-Unique: dPB3X9flMuegRBT0BUE2jw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB0BD106B244;
        Thu,  6 Aug 2020 03:25:20 +0000 (UTC)
Received: from [10.72.13.140] (ovpn-13-140.pek2.redhat.com [10.72.13.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A824219C71;
        Thu,  6 Aug 2020 03:25:12 +0000 (UTC)
Subject: Re: [PATCH 1/4] vdpa: introduce config op to get valid iova range
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-2-jasowang@redhat.com>
 <20200805085035-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <777d6e78-4271-10e9-4546-329f53962429@redhat.com>
Date:   Thu, 6 Aug 2020 11:25:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805085035-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/5 下午8:51, Michael S. Tsirkin wrote:
> On Wed, Jun 17, 2020 at 11:29:44AM +0800, Jason Wang wrote:
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
> This is ambiguous. Is end in the range or just behind it?


In the range.


> How about first/last?


Sure.

Thanks


>
>
>

