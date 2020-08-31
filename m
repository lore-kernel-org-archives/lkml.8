Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF0CC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5027C2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYldlu5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgHaIjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:39:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgHaIjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598863151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=avRjm611h0EKFc/MNTXSAgeSYlfF4ysYrjX8e+z/BRg=;
        b=dYldlu5/WQ0Sj/ow+Kw1NKjvd8FOFtTqnjlWB0DY0HJT9CCbht4vIZeeeqc0xA6OogM86d
        K0K1m+KKcpBhjLBCnmqeckx3HXRe74rfRL+hbUJvkRtsTbjRsi6mmNzyy0tJMMlRG7w3SN
        x+bVO/oYd+3iajhyELVKFJJZk6+9NYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-N0n83FllNkSj5RFaVoTyEA-1; Mon, 31 Aug 2020 04:39:09 -0400
X-MC-Unique: N0n83FllNkSj5RFaVoTyEA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8104802B6C;
        Mon, 31 Aug 2020 08:39:07 +0000 (UTC)
Received: from [10.72.12.88] (ovpn-12-88.pek2.redhat.com [10.72.12.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13B795C22B;
        Mon, 31 Aug 2020 08:38:43 +0000 (UTC)
Subject: Re: [PATCH V2 2/3] vhost: vdpa: report iova range
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
References: <20200821092813.8952-1-jasowang@redhat.com>
 <20200821092813.8952-3-jasowang@redhat.com>
 <20200823064035.GB147797@mtl-vdi-166.wap.labs.mlnx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <96f2367e-8b9f-9ee7-a45e-56e9162e92c6@redhat.com>
Date:   Mon, 31 Aug 2020 16:38:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200823064035.GB147797@mtl-vdi-166.wap.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/23 下午2:40, Eli Cohen wrote:
>> +static void vhost_vdpa_set_iova_range(struct vhost_vdpa *v)
>> +{
>> +	struct vdpa_iova_range *range = &v->range;
>> +	struct iommu_domain_geometry geo;
>> +	struct vdpa_device *vdpa = v->vdpa;
>> +	const struct vdpa_config_ops *ops = vdpa->config;
>> +
>> +	if (ops->get_iova_range) {
>> +		*range = ops->get_iova_range(vdpa);
>> +	} else if (v->domain &&
>> +		   !iommu_domain_get_attr(v->domain,
>> +		   DOMAIN_ATTR_GEOMETRY, &geo) &&
>> +		   geo.force_aperture) {
>> +		range->first = geo.aperture_start;
>> +		range->last = geo.aperture_end;
>> +	} else {
>> +		range->first = 0;
>> +		range->last = ULLONG_MAX;
>> +	}
> Shouldn't we require drivers that publish VIRTIO_F_ACCESS_PLATFORM to
> implement get_iova_range?


Probably not, since ACCESS_PLATFORM does not exclude the device that 
depends on the chipset IOMMU to work. So in that case, we should query 
IOMMU driver instead of vDPA device driver.

Thanks


>
>> +}

