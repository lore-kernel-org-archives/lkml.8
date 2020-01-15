Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B7BC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 07:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08852467D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 07:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgAOHGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 02:06:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:17208 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgAOHGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 02:06:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 23:06:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,321,1574150400"; 
   d="scan'208";a="219180633"
Received: from unknown (HELO [10.238.130.246]) ([10.238.130.246])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jan 2020 23:06:40 -0800
Subject: Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Zha Bin <zhabin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, gerry@linux.alibaba.com,
        jing2.liu@intel.com, chao.p.peng@intel.com
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <20200105054412-mutt-send-email-mst@kernel.org>
From:   "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <b0975121-99d4-3b53-50c5-03002d90b28f@linux.intel.com>
Date:   Wed, 15 Jan 2020 15:06:39 +0800
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
> [...]
>> +static int vm_find_vqs_msi(struct virtio_device *vdev, unsigned int nvqs,
>> +			struct virtqueue *vqs[], vq_callback_t *callbacks[],
>> +			const char * const names[], const bool *ctx,
>> +			struct irq_affinity *desc)
>> +{
>> +	int i, err, irq;
>> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
>> +
>> +	/* Allocate nvqs irqs for queues and one irq for configuration */
>> +	err = vm_request_msi_vectors(vdev, nvqs + 1);
>> +	if (err != 0)
>> +		return err;
> Not all devices need high speed.  Some might want to share
> irqs between VQs, or even with config change callback.
> Balloon is a case in point.
> A hint about max # of MSI necessary would be a good
> idea for this case.

This seems being a hint about telling MSI number device supported and 
whether it wants MSI sharing.

For devices with tens of queues at most or need high speed, they choose 
vector per queue, and can simply use fixed mapping.

For others, it can ask for advanced mode, which means MSI sharing and 
dynamic mapping.

What about let device decide the mode it would use, as follows.

MaxVecNum 32bit - The max msi vector number that device supports.

MsiState 32bit

- bit[x]=0 implies vec per queue/config and fixed mapping. In this case, 
MsiVecNum>=num_queue+1

- bit [x]=1 implies the hint of msi sharing and dynamic mapping. In this 
case, MsiVecNum<num_queue+1


Thanks,

Jing

>
> Sharing MSI doesn't necessarily require dedicated registers like PCI has,
> you can just program same vector in multiple VQs.

