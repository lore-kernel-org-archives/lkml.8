Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B872C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD4522522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgAUFDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 00:03:22 -0500
Received: from mga03.intel.com ([134.134.136.65]:25287 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgAUFDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 00:03:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 21:03:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,344,1574150400"; 
   d="scan'208";a="215417618"
Received: from liujing-mobl1.ccr.corp.intel.com (HELO [10.255.28.166]) ([10.255.28.166])
  by orsmga007.jf.intel.com with ESMTP; 20 Jan 2020 21:03:18 -0800
Subject: Re: [virtio-dev] Re: [PATCH v1 2/2] virtio-mmio: add features for
 virtio-mmio specification version 3
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Zha Bin <zhabin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, gerry@linux.alibaba.com,
        jing2.liu@intel.com, chao.p.peng@intel.com
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <20200105054412-mutt-send-email-mst@kernel.org>
From:   "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <be94a982-69c9-534a-77a1-3026a93bfb63@linux.intel.com>
Date:   Tue, 21 Jan 2020 13:03:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200105054412-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/5/2020 7:04 PM, Michael S. Tsirkin wrote:
>
>>   
>>   struct virtio_mmio_vq_info {
>> @@ -101,6 +107,8 @@ struct virtio_mmio_vq_info {
>>   };
>>   
>>   
>> +static void vm_free_msi_irqs(struct virtio_device *vdev);
>> +static int vm_request_msi_vectors(struct virtio_device *vdev, int nirqs);
>>   
>>   /* Configuration interface */
>>   
>> @@ -273,12 +281,28 @@ static bool vm_notify(struct virtqueue *vq)
>>   {
>>   	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
>>   
>> +	if (vm_dev->version == 3) {
>> +		int offset = vm_dev->doorbell_base +
>> +			     vm_dev->doorbell_scale * vq->index;
>> +		writel(vq->index, vm_dev->base + offset);
>> +	} else
>>   	/* We write the queue's selector into the notification register to
>>   	 * signal the other end */
>> -	writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
>> +		writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
>> +
>>   	return true;
>>   }
> You might want to support VIRTIO_F_NOTIFICATION_DATA too.
>
Yes, the feature is new in virtio1.1 and the kernel has not defined and 
implemented it yet.

To implement it for both PCI and MMIO, maybe it would be good to work a 
separate patch set later?

BTW, we are working on v2 and will send out later.

Thanks,

Jing

