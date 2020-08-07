Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8F6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 204D72086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQP1xJCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgHGDX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:23:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49963 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726038AbgHGDX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 23:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596770605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hsMi9av5b4p35ahtO8uQIDsEdl3GiG9dvjCH9nlwTHQ=;
        b=TQP1xJCZOsofEq4KnGsTgIHI8bzNR1ZX9W1iTE6lXtkTNKede24kU56oDymmeBoVM9V52k
        Op1jF2gVh1zhlBd+ghquxWilWNYC5rqrpnVK8+fL34rRXkpiaUTvuzTbBHV/in4Pdqn0+L
        wLegnthOn3ySALiX7TqPC9vPrkAiCXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-OYrdhSukPp-3tbOlaSTw9w-1; Thu, 06 Aug 2020 23:23:22 -0400
X-MC-Unique: OYrdhSukPp-3tbOlaSTw9w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59B95106B242;
        Fri,  7 Aug 2020 03:23:20 +0000 (UTC)
Received: from [10.72.13.215] (ovpn-13-215.pek2.redhat.com [10.72.13.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A7575F7D8;
        Fri,  7 Aug 2020 03:23:11 +0000 (UTC)
Subject: Re: [PATCH 1/4] vdpa: introduce config op to get valid iova range
To:     "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <eli@mellanox.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-2-jasowang@redhat.com>
 <20200805085035-mutt-send-email-mst@kernel.org>
 <20200806120354.GA171218@mtl-vdi-166.wap.labs.mlnx>
 <20200806082727-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <20debde5-1f59-8bd4-1978-68e59abefaea@redhat.com>
Date:   Fri, 7 Aug 2020 11:23:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806082727-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/6 下午8:29, Michael S. Tsirkin wrote:
> On Thu, Aug 06, 2020 at 03:03:55PM +0300, Eli Cohen wrote:
>> On Wed, Aug 05, 2020 at 08:51:56AM -0400, Michael S. Tsirkin wrote:
>>> On Wed, Jun 17, 2020 at 11:29:44AM +0800, Jason Wang wrote:
>>>> This patch introduce a config op to get valid iova range from the vDPA
>>>> device.
>>>>
>>>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>>>> ---
>>>>   include/linux/vdpa.h | 14 ++++++++++++++
>>>>   1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>>> index 239db794357c..b7633ed2500c 100644
>>>> --- a/include/linux/vdpa.h
>>>> +++ b/include/linux/vdpa.h
>>>> @@ -41,6 +41,16 @@ struct vdpa_device {
>>>>   	unsigned int index;
>>>>   };
>>>>   
>>>> +/**
>>>> + * vDPA IOVA range - the IOVA range support by the device
>>>> + * @start: start of the IOVA range
>>>> + * @end: end of the IOVA range
>>>> + */
>>>> +struct vdpa_iova_range {
>>>> +	u64 start;
>>>> +	u64 end;
>>>> +};
>>>> +
>>> This is ambiguous. Is end in the range or just behind it?
>>> How about first/last?
>> It is customary in the kernel to use start-end where end corresponds to
>> the byte following the last in the range. See struct vm_area_struct
>> vm_start and vm_end fields
> Exactly my point:
>
> include/linux/mm_types.h:       unsigned long vm_end;           /* The first byte after our end address
>
> in this case Jason wants it to be the last byte, not one behind.


Ok, I somehow recall the reason :)

See:

struct iommu_domain_geometry {
     dma_addr_t aperture_start; /* First address that can be mapped    */
     dma_addr_t aperture_end;   /* Last address that can be mapped     */
     bool force_aperture;       /* DMA only allowed in mappable range? */
};


So what I proposed here is to be consistent with it.

Thanks


>
>

